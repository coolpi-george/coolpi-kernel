/*++

Copyright (c) 2021 Motor-comm Corporation. 
Confidential and Proprietary. All rights reserved.

This is Motor-comm Corporation NIC driver relevant files. Please don't copy, modify,
distribute without commercial permission.

--*/



#include "fuxi-gmac.h"

#ifdef HAVE_FXGMAC_DEBUG_FS
#include <linux/debugfs.h>
#include <linux/module.h>

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h> 
#include <linux/types.h>
#include <linux/sched.h>
#include <linux/mm.h>
#include <linux/fcntl.h>
#include <linux/socket.h>
#include <linux/in.h>
#include <linux/inet.h>
#include <linux/skbuff.h>
#include <linux/if_arp.h>
#include <linux/netdevice.h> 
#include <linux/etherdevice.h>
#include <linux/netdevice.h> 
#include <linux/etherdevice.h>
#include <linux/ip.h> 
#include <linux/udp.h>

#define TEST_MAC_HEAD               14
#define TEST_TCP_HEAD_LEN_OFFSET    12
#define TEST_TCP_OFFLOAD_LEN_OFFSET 48
#define TEST_TCP_FIX_HEAD_LEN       24
#define TEST_TCP_MSS_OFFSET         56

static struct dentry *fxgmac_dbg_root;
char fxgmac_driver_name[] = "fuxi";

struct sk_buff *fxgmac_test_skb_array[MAX_DBG_TEST_PKT];
volatile u32 fxgmac_test_skb_arr_in_index = 0;
volatile u32 fxgmac_test_skb_arr_out_index = 0;
bool fxgmac_test_tso_flag = false;
u32 fxgmac_test_tso_seg_num = 0;
u32 fxgmac_test_last_tso_len = 0;
u32 fxgmac_test_packet_len = 0;

static char fxgmac_dbg_netdev_ops_buf[256] = "";

/**
 * fxgmac_dbg_netdev_ops_read - read for netdev_ops datum
 * @filp: the opened file
 * @buffer: where to write the data for the user to read
 * @count: the size of the user's buffer
 * @ppos: file position offset
 **/
static ssize_t fxgmac_dbg_netdev_ops_read(struct file *filp,
					 char __user *buffer,
					 size_t count, loff_t *ppos)
{
	struct fxgmac_pdata *pdata = filp->private_data;
	char *buf;
	int len;

	/* don't allow partial reads */
	if (*ppos != 0)
		return 0;

	buf = kasprintf(GFP_KERNEL, "%s: %s\n",
			pdata->netdev->name,
			fxgmac_dbg_netdev_ops_buf);
	if (!buf)
		return -ENOMEM;

	if (count < strlen(buf)) {
		kfree(buf);
		return -ENOSPC;
	}

	len = simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));

	kfree(buf);
	return len;
}

/**
 * fxgmac_dbg_netdev_ops_write - write into netdev_ops datum
 * @filp: the opened file
 * @buffer: where to find the user's data
 * @count: the length of the user's data
 * @ppos: file position offset
 **/
static ssize_t fxgmac_dbg_netdev_ops_write(struct file *filp,
					  const char __user *buffer,
					  size_t count, loff_t *ppos)
{
	//struct fxgmac_pdata *pdata = filp->private_data;
	int len;

	/* don't allow partial writes */
	if (*ppos != 0)
		return 0;
	if (count >= sizeof(fxgmac_dbg_netdev_ops_buf))
		return -ENOSPC;

	len = simple_write_to_buffer(fxgmac_dbg_netdev_ops_buf,
				     sizeof(fxgmac_dbg_netdev_ops_buf)-1,
				     ppos,
				     buffer,
				     count);
	if (len < 0)
		return len;

	fxgmac_dbg_netdev_ops_buf[len] = '\0';

	if (strncmp(fxgmac_dbg_netdev_ops_buf, "tx_timeout", 10) == 0) {
		FXGMAC_PR("tx_timeout called\n");
	} else {
		FXGMAC_PR("Unknown command: %s\n", fxgmac_dbg_netdev_ops_buf);
		FXGMAC_PR("Available commands:\n");
		FXGMAC_PR("    tx_timeout\n");
	}
	return count;
}

static void fxgmac_dbg_tx_pkt(struct fxgmac_pdata *pdata, u8 *pcmd_data)
{
    unsigned int pktLen = 0;
    struct sk_buff *skb;
    pfxgmac_test_packet pPkt;
    u8 * pTx_data = NULL;
    u8 * pSkb_data = NULL;
    u32 offload_len = 0;
    u8 ipHeadLen, tcpHeadLen, headTotalLen;
    static u32 lastGsoSize = 806;//initial default value
    //int i = 0;

    /* get fxgmac_test_packet */
    pPkt = (pfxgmac_test_packet)(pcmd_data + sizeof(struct ext_ioctl_data));
    pktLen = pPkt->length;
    
    /* get pkt data */
    pTx_data = (u8 *)pPkt + sizeof(fxgmac_test_packet);

#if 0 //for debug
    printk("Send packet len is %d, data:\n", pktLen);
#if 1
    for(i = 0; i < 70 ; i++)
    {
        printk("%2x ", pTx_data[i]);
    }
#endif
#endif
 
    /* alloc sk_buff */
    skb = alloc_skb(pktLen, GFP_ATOMIC);
    if (!skb){
        printk("alloc skb fail\n");
        return;
    }

    /* copy data to skb */
    pSkb_data = skb_put(skb, pktLen);
    memset(pSkb_data, 0, pktLen);
    memcpy(pSkb_data, pTx_data, pktLen);
   
    /* set skb parameters */
    skb->dev = pdata->netdev;
    skb->pkt_type = PACKET_OUTGOING;
    skb->protocol = ntohs(ETH_P_IP);
    skb->no_fcs = 1;
    skb->ip_summed = CHECKSUM_PARTIAL; 
    if(skb->len > 1514){
        /* TSO packet */
        /* set tso test flag */
        fxgmac_test_tso_flag = true;

        /* get protocol head length */
        ipHeadLen = (pSkb_data[TEST_MAC_HEAD] & 0xF) * 4;
        tcpHeadLen = (pSkb_data[TEST_MAC_HEAD + ipHeadLen + TEST_TCP_HEAD_LEN_OFFSET] >> 4 & 0xF) * 4;
        headTotalLen = TEST_MAC_HEAD + ipHeadLen + tcpHeadLen;
        offload_len = (pSkb_data[TEST_TCP_OFFLOAD_LEN_OFFSET] << 8 | 
                        pSkb_data[TEST_TCP_OFFLOAD_LEN_OFFSET + 1]) & 0xFFFF;
        /* set tso skb parameters */
        //skb->ip_summed = CHECKSUM_PARTIAL; 
        skb->transport_header = ipHeadLen + TEST_MAC_HEAD;
        skb->network_header = TEST_MAC_HEAD;
        skb->inner_network_header = TEST_MAC_HEAD;
        skb->mac_len = TEST_MAC_HEAD;

        /* set skb_shinfo parameters */
        if(tcpHeadLen > TEST_TCP_FIX_HEAD_LEN){
            skb_shinfo(skb)->gso_size = (pSkb_data[TEST_TCP_MSS_OFFSET] << 8 | 
                pSkb_data[TEST_TCP_MSS_OFFSET + 1]) & 0xFFFF;
        }else{
            skb_shinfo(skb)->gso_size = 0;
        }
        if(skb_shinfo(skb)->gso_size != 0){
            lastGsoSize = skb_shinfo(skb)->gso_size;
        }else{
            skb_shinfo(skb)->gso_size = lastGsoSize;
        }
        //printk("offload_len is %d, skb_shinfo(skb)->gso_size is %d", offload_len, skb_shinfo(skb)->gso_size);
        /* get segment size */
        if(offload_len % skb_shinfo(skb)->gso_size == 0){
            skb_shinfo(skb)->gso_segs = offload_len / skb_shinfo(skb)->gso_size;
            fxgmac_test_last_tso_len = skb_shinfo(skb)->gso_size + headTotalLen;
        }else{
            skb_shinfo(skb)->gso_segs = offload_len / skb_shinfo(skb)->gso_size + 1;
            fxgmac_test_last_tso_len = offload_len % skb_shinfo(skb)->gso_size + headTotalLen;
        }
        fxgmac_test_tso_seg_num = skb_shinfo(skb)->gso_segs;

        skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4 ;
        skb_shinfo(skb)->frag_list = NULL;
        skb->csum_start = skb_headroom(skb) + TEST_MAC_HEAD + ipHeadLen;
        skb->csum_offset = skb->len - TEST_MAC_HEAD - ipHeadLen;

        fxgmac_test_packet_len = skb_shinfo(skb)->gso_size + headTotalLen;
    }else{
        /* set non-TSO packet parameters */
        fxgmac_test_packet_len = skb->len;
    }

    /* send data */
    if(dev_queue_xmit(skb) != NET_XMIT_SUCCESS){
        printk("xmit data fail \n");
    }
}

u8 rx_data[1600] = {0};

static void fxgmac_dbg_rx_pkt(struct fxgmac_pdata *pdata, u8 *pcmd_data)
{
    unsigned int totalLen = 0;
    struct sk_buff *rx_skb;
    struct ext_ioctl_data *pcmd;
    fxgmac_test_packet pkt;

    void* addr = 0;
    //int i;
    
    /* initial dest data region */
    pcmd = (struct ext_ioctl_data *)pcmd_data;
    addr = pcmd->cmd_buf.buf;
    //printk("FXG:fxgmac_test_skb_arr_in_index=%d, fxgmac_test_skb_arr_out_index=%d", fxgmac_test_skb_arr_in_index, fxgmac_test_skb_arr_out_index);
    while(fxgmac_test_skb_arr_in_index != fxgmac_test_skb_arr_out_index){
        /* get received skb data */
        rx_skb = fxgmac_test_skb_array[fxgmac_test_skb_arr_out_index];

        if(rx_skb->len + sizeof(fxgmac_test_packet) + totalLen < 64000){
            pkt.length = rx_skb->len;
            pkt.type = 0x80;
            pkt.buf[0].offset = totalLen + sizeof(fxgmac_test_packet);
            pkt.buf[0].length = rx_skb->len;

            /* get data from skb */
            //FXGMAC_PR("FXG:rx_skb->len=%d", rx_skb->len);
            memcpy(rx_data, rx_skb->data, rx_skb->len);
	    
	        /* update next pointer */
	        if((fxgmac_test_skb_arr_out_index + 1) % MAX_DBG_TEST_PKT == fxgmac_test_skb_arr_in_index)
	        {
		        pkt.next = NULL;
	        }
	        else
	        {
            	pkt.next = (pfxgmac_test_packet)(addr + totalLen + sizeof(fxgmac_test_packet) + pkt.length);
	        }

            /* copy data to user space */
            if(copy_to_user((void *)(addr + totalLen), (void*)(&pkt), sizeof(fxgmac_test_packet)))
            {
                FXGMAC_PR("cppy pkt data to user fail...");
            }
            //FXGMAC_PR("FXG:rx_skb->len=%d", rx_skb->len);
            if(copy_to_user((void *)(addr + totalLen + sizeof(fxgmac_test_packet)), (void*)rx_data, rx_skb->len))
            {
                FXGMAC_PR("cppy data to user fail...");
            }

            /* update total length */
            totalLen += (sizeof(fxgmac_test_packet) + rx_skb->len);

            /* free skb */
            kfree_skb(rx_skb);
            fxgmac_test_skb_array[fxgmac_test_skb_arr_out_index] = NULL;
            
            /* update gCurSkbOutIndex */
            fxgmac_test_skb_arr_out_index = (fxgmac_test_skb_arr_out_index + 1) % MAX_DBG_TEST_PKT;
       }else{
            FXGMAC_PR("receive data more receive buffer... \n");
            break;
       }
        
    }

#if 0
    pPkt = (pfxgmac_test_packet)driverDataBuf;
    printk("FXG: pPkt->Length is %d", pPkt->length);
    FXGMAC_PR("FXG: pPkt->Length is %d", pPkt->length);
    FXGMAC_PR("pPkt: %p, buf is %lx",pPkt, pcmd->cmd_buf.buf);
    for(i = 0; i < 30; i++){
        printk("%x",*(((u8*)pPkt + sizeof(fxgmac_test_packet)) + i));
    }
#endif
}

u8 driverDataBuf[64000];
static long fxgmac_dbg_netdev_ops_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
    //int ret;
    struct fxgmac_pdata *pdata = file->private_data;
    struct ext_ioctl_data * pcmd = NULL;
    int size = 0;
    
    if(copy_from_user((void*)driverDataBuf, (void*)arg, sizeof(struct ext_ioctl_data)))
    {
	    FXGMAC_PR("copy data from user fail... \n");
    }

    //FXGMAC_PR("FXG: [%s], cmd is %x, arg is %lx", __func__, cmd, arg);

    if(!arg){
        FXGMAC_PR("[%s] command arg is %lx !\n", __func__, arg);
        return -ENOTTY; 
    }

    /* check device type */
    if (_IOC_TYPE(cmd) != IOC_MAGIC) {
        FXGMAC_PR("[%s] command type [%c] error!\n", __func__, _IOC_TYPE(cmd));
        return -ENOTTY; 
    }

    /* check command number*/
    if (_IOC_NR(cmd) > IOC_MAXNR) { 
        FXGMAC_PR("[%s] command numer [%d] exceeded!\n", __func__, _IOC_NR(cmd));
        return -ENOTTY;
    }
#if 0
    /* check R/W */
    if (_IOC_DIR(cmd) & _IOC_READ || _IOC_DIR(cmd) & _IOC_WRITE)
        ret= access_ok((void __user *)arg, _IOC_SIZE(cmd));    
    if (!ret)
        return -EFAULT;
#endif
    if(arg != 0){
        pcmd = (struct ext_ioctl_data *) driverDataBuf;  
        switch(pcmd->cmd_type) {
        /* ioctl diag begin */
        case FUXI_DFS_IOCTL_DIAG_BEGIN:
            FXGMAC_PR("Debugfs received diag begin command.\n");
            if (netif_running(pdata->netdev)){
                fxgmac_restart_dev(pdata);
            }
           break;

        /* ioctl diag end */
        case FUXI_DFS_IOCTL_DIAG_END:
            FXGMAC_PR("Debugfs received diag end command.\n");
            if (netif_running(pdata->netdev)){
                fxgmac_restart_dev(pdata);
            }
            break;

        /* ioctl diag tx pkt */
        case FUXI_DFS_IOCTL_DIAG_TX_PKT:
            //FXGMAC_PR("Debugfs received diag tx pkt command.\n");
	        size = pcmd->cmd_buf.size_in;
	        if(copy_from_user((void *)driverDataBuf, (void *)arg, size))
	        {
		        FXGMAC_PR("copy data from user fail... \n");
	        }
            fxgmac_dbg_tx_pkt(pdata, driverDataBuf);
            //fxgmac_dbg_tx_pkt(pdata, (u8 *)arg);
            break;

        /* ioctl diag rx pkt */
        case FUXI_DFS_IOCTL_DIAG_RX_PKT:
            //FXGMAC_PR("Debugfs received diag rx pkt command.\n");
	        size = pcmd->cmd_buf.size_in;
            fxgmac_dbg_rx_pkt(pdata, driverDataBuf);
            //fxgmac_dbg_rx_pkt(pdata, (u8 *)arg);
            break;
        
        /* ioctl device reset */
        case FUXI_DFS_IOCTL_DEVICE_RESET:
            FXGMAC_PR("Debugfs received device reset command.\n");
            if (netif_running(pdata->netdev)){
                fxgmac_restart_dev(pdata);
            }
            break;
        default:
            FXGMAC_PR("Debugfs received invalid command: %x.\n", pcmd->cmd_type);
            return -ENOTTY;
        }   
    }

    return 0;
}

static struct file_operations fxgmac_dbg_netdev_ops_fops = {
	.owner = THIS_MODULE,
	.open = simple_open,
	.read = fxgmac_dbg_netdev_ops_read,
	.write = fxgmac_dbg_netdev_ops_write,
    .unlocked_ioctl = fxgmac_dbg_netdev_ops_ioctl,
};

/**
 * fxgmac_dbg_adapter_init - setup the debugfs directory for the adapter
 * @adapter: the adapter that is starting up
 **/
void fxgmac_dbg_adapter_init(struct fxgmac_pdata *pdata)
{
	const char *name = pdata->drv_name;
	struct dentry *pfile;
	pdata->dbg_adapter = debugfs_create_dir(name, fxgmac_dbg_root);
	if (pdata->dbg_adapter) {
		pfile = debugfs_create_file("netdev_ops", 0600,
					    pdata->dbg_adapter, pdata,
					    &fxgmac_dbg_netdev_ops_fops);
		if (!pfile)
			FXGMAC_PR("debugfs netdev_ops for %s failed\n", name);
	} else {
		FXGMAC_PR("debugfs entry for %s failed\n", name);
	}
}

/**
 * fxgmac_dbg_adapter_exit - clear out the adapter's debugfs entries
 * @adapter: board private structure
 **/
void fxgmac_dbg_adapter_exit(struct fxgmac_pdata *pdata)
{
	if (pdata->dbg_adapter)
		debugfs_remove_recursive(pdata->dbg_adapter);
	pdata->dbg_adapter = NULL;
}

/**
 * fxgmac_dbg_init - start up debugfs for the driver
 **/
void fxgmac_dbg_init(void)
{
	fxgmac_dbg_root = debugfs_create_dir(fxgmac_driver_name, NULL);
	if (fxgmac_dbg_root == NULL)
		FXGMAC_PR("init of debugfs failed\n");
}

/**
 * fxgmac_dbg_exit - clean out the driver's debugfs entries
 **/
void fxgmac_dbg_exit(void)
{
	debugfs_remove_recursive(fxgmac_dbg_root);
}

#endif /* HAVE_XLGMAC_DEBUG_FS */

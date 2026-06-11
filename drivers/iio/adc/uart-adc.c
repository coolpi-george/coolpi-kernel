// SPDX-License-Identifier: GPL-2.0
/* uart-adc.c — direct UART interrupt-driven IIO driver
 *
 * Takes over UART hardware directly. No tty/ldisc layer.
 * Interrupt-driven RX, polled TX. Works on RK3566.
 *
 * DTS properties:
 *   compatible    = "ultraman,uart-adc";
 *   uart-dev      = "ttyUSB0";      串口设备名（仅信息用）
 *   baudrate      = <115200>;       串口波特率
 *   channel-count = <2>;            通道个数
 *
 * Protocol:
 *   Read  (CMD=0x01): AA 55 01 00 → AA 55 AI1L AI1H AI2L AI2H ...
 *   Config(CMD=0x02): AA 55 02 MODE
 *   MODE: bit pairs per channel (0=voltage, 1=current)
 */

#include <linux/module.h>
#include <linux/init.h>
#include <linux/platform_device.h>
#include <linux/of.h>
#include <linux/of_irq.h>
#include <linux/interrupt.h>
#include <linux/io.h>
#include <linux/clk.h>
#include <linux/iio/iio.h>
#include <linux/mutex.h>
#include <linux/completion.h>

#define DRVNAME   "uart-adc"
#define RBR   0x00  /* RX buffer */
#define THR   0x00  /* TX holding */
#define IER   0x04  /* interrupt enable */
#define IIR   0x08  /* interrupt ID */
#define FCR   0x08  /* FIFO control */
#define LCR   0x0C  /* line control */
#define MCR   0x10  /* modem control */
#define LSR   0x14  /* line status */

#define MAX_CHAN 8

struct priv {
    struct device *dev;
    void __iomem  *base;
    int            irq;
    struct clk    *clk_rate, *clk_apb;
    struct iio_dev *indio_dev;

    struct mutex      lock;
    struct completion done;

    int  nchan;         /* from DT channel-count */
    u16 *adc;           /* [nchan] */
    u8  *mode;          /* [nchan] */
    u8  *rbuf;          /* [2 + 2*nchan] response buffer */

    int  ridx;          /* receive index */
    struct iio_chan_spec *chans;    /* [nchan] */
    struct attribute    **attrs;    /* [nchan+1] + NULL */
    struct attribute_group attr_grp;
    struct device_attribute *dev_attrs; /* [nchan] */
    const struct attribute_group *attr_grps[2];
};

static inline u8 u_r(struct priv *p, int r) { return readb(p->base + r); }
static inline void u_w(struct priv *p, int r, u8 v) { writeb(v, p->base + r); }

/* Polled TX */
static void u_tx(struct priv *p, const u8 *d, int n)
{
    int i, t;
    for (i = 0; i < n; i++) {
        t = 100000;
        while (!(u_r(p, LSR) & 0x20) && t--) cpu_relax();
        u_w(p, THR, d[i]);
    }
}

/* Interrupt-driven RX */
static irqreturn_t irq_h(int irq, void *arg)
{
    struct priv *p = arg;
    u8 iir;

    iir = u_r(p, IIR);
    if (iir & 1) return IRQ_NONE;

    while (u_r(p, LSR) & 1) {
        u8 c = u_r(p, RBR);

        if (p->ridx < 2 + 2 * p->nchan) {
            p->rbuf[p->ridx++] = c;
            if (p->ridx == 2 + 2 * p->nchan) {
                int i;
                for (i = 0; i < p->nchan; i++)
                    p->adc[i] = p->rbuf[2 + 2*i]
                              | (p->rbuf[2 + 2*i + 1] << 8);
                p->ridx = 0;
                complete(&p->done);
            }
        }
    }
    return IRQ_HANDLED;
}

static int rd_raw(struct iio_dev *d, struct iio_chan_spec const *c,
                  int *v, int *v2, long m)
{
    struct priv *p = iio_priv(d);
    u8 cmd[4] = {0xAA, 0x55, 0x01, 0};
    /* DT channels are 1-based (in_voltage1_raw = ch1) */
    int idx = c->channel - 1;
    int r;

    if (idx < 0 || idx >= p->nchan)
        return -EINVAL;

    switch (m) {
    case IIO_CHAN_INFO_RAW:
        mutex_lock(&p->lock);
        while (u_r(p, LSR) & 1) u_r(p, RBR);
        reinit_completion(&p->done);
        p->ridx = 0;
        u_tx(p, cmd, 4);
        r = wait_for_completion_timeout(&p->done,
                                        msecs_to_jiffies(200));
        if (!r) { mutex_unlock(&p->lock); return -ETIMEDOUT; }
        *v = p->adc[idx];
        mutex_unlock(&p->lock);
        return IIO_VAL_INT;
    case IIO_CHAN_INFO_SCALE:
        *v = p->mode[idx] ? 20 : 10000;
        *v2 = 1023;
        return IIO_VAL_FRACTIONAL;
    }
    return -EINVAL;
}

/* ---- Dynamic mode sysfs attrs ---- */
static ssize_t mode_show(struct device *d, struct device_attribute *a, char *b)
{
    struct priv *p = iio_priv(dev_to_iio_dev(d));
    int idx = (a - p->dev_attrs);  /* index into dev_attrs array */
    return sysfs_emit(b, "%u\n", p->mode[idx]);
}

static ssize_t mode_store(struct device *d, struct device_attribute *a,
                          const char *b, size_t c)
{
    struct priv *p = iio_priv(dev_to_iio_dev(d));
    int idx = (a - p->dev_attrs);
    unsigned long v;
    int r;
    u8 cfg[4] = {0xAA, 0x55, 0x02, 0};

    if (idx < 0 || idx >= p->nchan)
        return -EINVAL;

    r = kstrtoul(b, 0, &v);
    if (r || v > 1)
        return -EINVAL;

    mutex_lock(&p->lock);
    p->mode[idx] = v;
    /* Build MODE byte: bit0=ch1, bit1=ch2, ... */
    {
        int i;
        cfg[3] = 0;
        for (i = 0; i < p->nchan; i++)
            cfg[3] |= (p->mode[i] << i);
    }
    u_tx(p, cfg, 4);
    mutex_unlock(&p->lock);
    return c;
}

static const struct iio_info iinfo_template = {
    .read_raw = rd_raw,
};

static int uart_adc_probe(struct platform_device *pdev)
{
    struct device *dev = &pdev->dev;
    struct iio_dev *indio_dev;
    struct priv *p;
    struct resource *res;
    u32 baud, div;
    u32 nchan = 2;
    int i;
    char name[16];

    of_property_read_u32(dev->of_node, "channel-count", &nchan);
    if (nchan < 1 || nchan > MAX_CHAN) {
        dev_warn(dev, "channel-count %u out of range [1,%d], using 2\n",
                 nchan, MAX_CHAN);
        nchan = 2;
    }

    indio_dev = devm_iio_device_alloc(dev,
                    sizeof(*p) + nchan * sizeof(u16)     /* adc[] */
                              + nchan * sizeof(u8)       /* mode[] */
                              + (2 + 2*nchan)            /* rbuf[] */
                              + nchan * sizeof(struct iio_chan_spec) /* chans[] */
                              + (nchan + 1) * sizeof(struct attribute *) /* attrs[] */
                              + nchan * sizeof(struct device_attribute)); /* dev_attrs[] */
    if (!indio_dev) return -ENOMEM;

    p = iio_priv(indio_dev);
    p->dev = dev;
    p->indio_dev = indio_dev;
    p->nchan = nchan;

    /* Point to trailing allocations */
    {
        void *buf = (void *)&p[1];
        p->adc  = buf; buf += nchan * sizeof(u16);
        p->mode = buf; buf += nchan * sizeof(u8);
        p->rbuf = buf; buf += 2 + 2 * nchan;
        p->chans = buf; buf += nchan * sizeof(struct iio_chan_spec);
        p->attrs = buf; buf += (nchan + 1) * sizeof(struct attribute *);
        p->dev_attrs = buf;
    }

    /* Default all to current mode (1) */
    memset(p->mode, 1, nchan);
    mutex_init(&p->lock);
    init_completion(&p->done);

    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    p->base = devm_ioremap_resource(dev, res);
    if (IS_ERR(p->base)) return PTR_ERR(p->base);

    p->irq = irq_of_parse_and_map(dev->of_node, 0);
    if (!p->irq) return -ENXIO;

    p->clk_rate = devm_clk_get(dev, "baudclk");
    p->clk_apb  = devm_clk_get(dev, "apb_pclk");
    if (IS_ERR(p->clk_rate) || IS_ERR(p->clk_apb)) return -ENODEV;

    clk_prepare_enable(p->clk_rate);
    clk_prepare_enable(p->clk_apb);

    /* ---- Baud rate from DT ---- */
    baud = 115200;
    of_property_read_u32(dev->of_node, "baudrate", &baud);
    div = clk_get_rate(p->clk_rate) / (16 * baud);

    dev_info(dev, "clk=%lu div=%u baud=%u nchan=%d\n",
             clk_get_rate(p->clk_rate), div, baud, nchan);

    /* Configure UART hw */
    u_w(p, LCR, 0x80);              /* DLAB=1 */
    u_w(p, 0x00, div & 0xFF);       /* DLL */
    u_w(p, 0x04, (div >> 8) & 0xFF); /* DLH */
    u_w(p, LCR, 0x03);              /* 8N1, DLAB=0 */
    u_w(p, FCR, 0x07);              /* enable + clear FIFO, trigger 1 */
    u_w(p, MCR, 0x0B);              /* DTR+RTS+OUT2 */
    u_w(p, IER, 0x01);              /* RX interrupt only */

    if (devm_request_irq(dev, p->irq, irq_h, 0, DRVNAME, p))
        return -EIO;

    /* ---- Build IIO channels ---- */
    for (i = 0; i < nchan; i++) {
        p->chans[i].type = IIO_VOLTAGE;
        p->chans[i].indexed = 1;
        p->chans[i].channel = i + 1;   /* → in_voltage1_raw / in_voltage2_raw ... */
        p->chans[i].info_mask_separate =
            BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);
    }

    /* ---- Build mode sysfs attrs ---- */
    for (i = 0; i < nchan; i++) {
        snprintf(name, sizeof(name), "mode%d", i + 1);
        sysfs_attr_init(&p->dev_attrs[i].attr);
        p->dev_attrs[i].attr.name  = kmemdup(name, strlen(name) + 1, GFP_KERNEL);
        if (!p->dev_attrs[i].attr.name)
            return -ENOMEM;
        p->dev_attrs[i].attr.mode  = 0644;
        p->dev_attrs[i].show       = mode_show;
        p->dev_attrs[i].store      = mode_store;
        p->attrs[i] = &p->dev_attrs[i].attr;
    }
    p->attrs[nchan] = NULL;

    p->attr_grp.name  = NULL;
    p->attr_grp.attrs = p->attrs;
    p->attr_grps[0] = &p->attr_grp;
    p->attr_grps[1] = NULL;

    /* Per-device iio_info copy to avoid sharing const template */
    {
        struct iio_info *info = devm_kmemdup(dev, &iinfo_template,
                                             sizeof(iinfo_template),
                                             GFP_KERNEL);
        if (!info) return -ENOMEM;
        info->attrs = &p->attr_grp;
        indio_dev->info = info;
    }
    indio_dev->name           = DRVNAME;
    indio_dev->modes          = INDIO_DIRECT_MODE;
    indio_dev->channels       = p->chans;
    indio_dev->num_channels   = nchan;

    /* Send initial config to hardware (all current mode) */
    {
        u8 cfg[4] = {0xAA, 0x55, 0x02, 0};
        int i;
        for (i = 0; i < nchan; i++)
            cfg[3] |= (p->mode[i] << i);
        u_tx(p, cfg, 4);
    }

    dev_info(dev, "READY irq=%d nchan=%d\n", p->irq, nchan);
    return devm_iio_device_register(dev, indio_dev);
}

static int uart_adc_remove(struct platform_device *pdev)
{
    struct iio_dev *indio_dev = platform_get_drvdata(pdev);
    struct priv *p = iio_priv(indio_dev);
    int i;

    for (i = 0; i < p->nchan; i++)
        kfree(p->dev_attrs[i].attr.name);

    return 0;
}

static const struct of_device_id ofm[] = {
    {.compatible = "ultraman,uart-adc"},
    {}
};
MODULE_DEVICE_TABLE(of, ofm);

static struct platform_driver pdrv = {
    .probe  = uart_adc_probe,
    .remove = uart_adc_remove,
    .driver = {
        .name           = DRVNAME,
        .of_match_table = ofm,
    },
};

#ifdef MODULE
module_platform_driver(pdrv);
#else
static int __init m_init(void) { return platform_driver_register(&pdrv); }
late_initcall(m_init);
#endif
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("UART-ADC IIO driver — DT-configurable baudrate & channels");

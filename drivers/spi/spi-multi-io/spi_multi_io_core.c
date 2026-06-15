/* SPDX-License-Identifier: GPL-2.0 */
/*
 * spi_multi_io_core.c - SPI通信核心层
 *
 * 负责SPI全双工收发、命令封装、错误处理
 * 所有SPI操作通过此层完成，上层不直接操作SPI总线
 */

#include <linux/kernel.h>
#include <linux/device.h>
#include <linux/spi/spi.h>
#include <linux/delay.h>
#include <linux/errno.h>
#include "spi_multi_io.h"

/**
 * sio_xfer - SPI通信（先发4字节，等待5ms，再读2字节）
 * @sio:    设备结构体
 * @cmd:    命令码
 * @addr:   目标模块地址
 * @tx_data0, tx_data1: 发送数据字节
 * @rx_data0, rx_data1: 接收数据字节（可为NULL）
 *
 * 通信流程：
 *   第1包：CS拉低 → 发4字节(CMD|ADDR|DATA0|DATA1) → CS拉高
 *   等待5ms
 *   第2包：CS拉低 → 读2字节 → CS拉高
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_xfer(struct sio_device *sio, u8 cmd, u8 addr,
             u8 tx_data0, u8 tx_data1,
             u8 *rx_data0, u8 *rx_data1)
{
    struct spi_transfer xfer;
    struct spi_message  msg;
    u8 tx_buf[4];
    u8 rx_buf[2];
    int ret;

    if (!sio || !sio->spi)
        return -ENODEV;

    /* 构造发送帧：CMD | ADDR | DATA0 | DATA1 */
    tx_buf[0] = cmd;
    tx_buf[1] = addr;
    tx_buf[2] = tx_data0;
    tx_buf[3] = tx_data1;

    /* 第1步：发送4字节 */
    memset(&xfer, 0, sizeof(xfer));
    xfer.tx_buf = tx_buf;
    xfer.len    = 4;
    xfer.speed_hz = sio->spi->max_speed_hz;
    xfer.bits_per_word = 8;

    spi_message_init(&msg);
    spi_message_add_tail(&xfer, &msg);

    ret = spi_sync(sio->spi, &msg);
    if (ret < 0) {
        sio->err_count++;
        dev_err(sio->dev, "SPI发送失败: cmd=0x%02x, err=%d\n", cmd, ret);
        return ret;
    }

    /* 等待5ms让模块处理命令 */
    mdelay(1);

    /* 第2步：读取2字节 */
    memset(&xfer, 0, sizeof(xfer));
    xfer.rx_buf = rx_buf;
    xfer.len    = 2;
    xfer.speed_hz = sio->spi->max_speed_hz;
    xfer.bits_per_word = 8;

    spi_message_init(&msg);
    spi_message_add_tail(&xfer, &msg);

    ret = spi_sync(sio->spi, &msg);
    if (ret < 0) {
        sio->err_count++;
        dev_err(sio->dev, "SPI读取失败: cmd=0x%02x, err=%d\n", cmd, ret);
        return ret;
    }

    sio->xfer_count++;

    /* 提取接收数据（读回的2字节） */
    if (rx_data0)
        *rx_data0 = rx_buf[0];
    if (rx_data1)
        *rx_data1 = rx_buf[1];

    /* 打印收发数据，方便调试 */
    dev_info(sio->dev,
             "TX: 0x%02x 0x%02x 0x%02x 0x%02x | "
             "RX: 0x%02x 0x%02x\n",
             tx_buf[0], tx_buf[1], tx_buf[2], tx_buf[3],
             rx_buf[0], rx_buf[1]);

    return 0;
}
EXPORT_SYMBOL_GPL(sio_xfer);

/**
 * sio_xfer_read - SPI通信（先发4字节，等待delay_ms，再读指定字节数）
 * @sio:     设备结构体
 * @cmd:     命令码
 * @addr:    目标模块地址
 * @tx_data0, tx_data1: 发送数据字节
 * @rx_buf:  接收缓冲区
 * @rx_len:  要读取的字节数（最大16）
 * @delay_ms: 发与收之间的等待毫秒数
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_xfer_read(struct sio_device *sio, u8 cmd, u8 addr,
                  u8 tx_data0, u8 tx_data1,
                  u8 *rx_buf, int rx_len, int delay_ms)
{
    struct spi_transfer xfer;
    struct spi_message  msg;
    u8 tx_buf[4];
    int ret;

    if (!sio || !sio->spi || !rx_buf || rx_len < 1 || rx_len > 16)
        return -EINVAL;

    tx_buf[0] = cmd;
    tx_buf[1] = addr;
    tx_buf[2] = tx_data0;
    tx_buf[3] = tx_data1;

    memset(rx_buf, 0, rx_len);

    /* 第1步：发送4字节 */
    memset(&xfer, 0, sizeof(xfer));
    xfer.tx_buf = tx_buf;
    xfer.len    = 4;
    xfer.speed_hz = sio->spi->max_speed_hz;
    xfer.bits_per_word = 8;

    spi_message_init(&msg);
    spi_message_add_tail(&xfer, &msg);

    ret = spi_sync(sio->spi, &msg);
    if (ret < 0) {
        sio->err_count++;
        dev_err(sio->dev, "SPI发送失败: cmd=0x%02x, err=%d\n", cmd, ret);
        return ret;
    }

    /* 等待 delay_ms 让模块处理命令 */
    if (delay_ms > 0)
        mdelay(delay_ms);

    /* 第2步：读取rx_len字节 */
    memset(&xfer, 0, sizeof(xfer));
    xfer.rx_buf = rx_buf;
    xfer.len    = rx_len;
    xfer.speed_hz = sio->spi->max_speed_hz;
    xfer.bits_per_word = 8;

    spi_message_init(&msg);
    spi_message_add_tail(&xfer, &msg);

    ret = spi_sync(sio->spi, &msg);
    if (ret < 0) {
        sio->err_count++;
        dev_err(sio->dev, "SPI读取失败: cmd=0x%02x, err=%d\n", cmd, ret);
        return ret;
    }

    sio->xfer_count++;

    {
        /* 只打实际接收的 rx_len 个字节 */
        char hex[64];
        int pos = 0, i;
        for (i = 0; i < rx_len && i < 16 && pos < (int)sizeof(hex) - 4; i++)
            pos += snprintf(hex + pos, sizeof(hex) - pos,
                            "0x%02x ", rx_buf[i]);
        if (pos > 0) hex[pos - 1] = '\0'; /* 去掉末尾空格 */
        dev_info(sio->dev,
                 "TX: 0x%02x 0x%02x 0x%02x 0x%02x | RX(len=%d): %s\n",
                 tx_buf[0], tx_buf[1], tx_buf[2], tx_buf[3],
                 rx_len, hex);
    }

    return 0;
}
EXPORT_SYMBOL_GPL(sio_xfer_read);

/**
 * sio_write_addr - 给模块分配新地址
 * @sio:       设备结构体
 * @old_addr:  模块当前地址（第一次为ADDR_DEFAULT 0xAA）
 * @new_addr:  要分配的新地址
 * @version:   输出固件版本（从模块返回值解析，可NULL）
 * @type:      输出模块类型（从模块返回值解析，可NULL）
 *
 * 发送：0x99 | old_addr | new_addr | 0x00
 * 接收：ECHO | ECHO | version | type
 * 模块接收后将自己的地址改为new_addr，同时在返回帧中带回版本号和类型
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_write_addr(struct sio_device *sio, u8 old_addr, u8 new_addr,
                   u8 *version, u8 *type)
{
    u8 rx0, rx1;
    int ret;

    if (new_addr == ADDR_DEFAULT || new_addr == ADDR_INVALID)
        return -EINVAL;

    if (new_addr < ADDR_MIN || new_addr > ADDR_MAX)
        return -EINVAL;

    ret = sio_xfer(sio, CMD_WR_ADDR, old_addr, new_addr, 0x00,
                   &rx0, &rx1);
    if (ret < 0)
        return ret;

    /* 返回值：rx0 = 版本号，rx1 = 模块类型 */
    if (version)
        *version = rx0;
    if (type)
        *type = rx1;

    /* 等待模块完成地址切换 */
    udelay(10);

    dev_dbg(sio->dev, "写地址: 0x%02x -> 0x%02x (ver=0x%02x, type=0x%02x)\n",
            old_addr, new_addr, rx0, rx1);

    return 0;
}
EXPORT_SYMBOL_GPL(sio_write_addr);

/**
 * sio_read_info - 读取模块类型和版本信息
 * @sio:     设备结构体
 * @addr:    目标地址
 * @type:    输出模块类型 (MOD_TYPE_DIDO / MOD_TYPE_AIAO)
 * @version: 输出固件版本
 *
 * 发送: 0x5C | addr | 0x02(回复字节数) | 0x00
 * 接收: 2字节: type | version
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_read_info(struct sio_device *sio, u8 addr, u8 *type, u8 *version)
{
    u8 buf[2];
    int ret;

    /* DATA0=0x02: 回复2字节 */
    ret = sio_xfer_read(sio, CMD_RD_INFO, addr, 0x02, 0x00, buf, 2, 1);
    if (ret < 0)
        return ret;

    if (type)
        *type = buf[0];
    if (version)
        *version = buf[1];

    dev_dbg(sio->dev, "读信息: addr=0x%02x, type=0x%02x, ver=0x%02x\n",
            addr, buf[0], buf[1]);

    return 0;
}
EXPORT_SYMBOL_GPL(sio_read_info);

/**
 * sio_read_io - 读取 Type1 模块的DI输入
 * @sio:   设备结构体
 * @addr:  目标地址
 * @data0: 输出DI位图 (bit0-7 = DI0-7)
 * @data1: 保留，固定输出 0x00
 *
 * 发送: 0x3A | addr | 0x01(回复字节数) | 0x00
 * 接收: 1字节: DI[7:0]
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_read_io(struct sio_device *sio, u8 addr, u8 *data0, u8 *data1)
{
    u8 buf;
    int ret;

    /* DATA0=0x01: 回复1字节 */
    ret = sio_xfer_read(sio, CMD_RD_IO, addr, 0x01, 0x00, &buf, 1, 1);
    if (ret < 0)
        return ret;

    if (data0)
        *data0 = buf;
    if (data1)
        *data1 = 0x00;

    return 0;
}
EXPORT_SYMBOL_GPL(sio_read_io);

/**
 * sio_write_io - 写模块IO输出（带读回）
 * @sio:    设备结构体
 * @addr:   目标地址
 * @data0:  第一个数据字节
 * @data1:  第二个数据字节
 * @rx0:    输出接收数据字节0（可为NULL）
 * @rx1:    输出接收数据字节1（可为NULL）
 *
 * 发送: 0x4B | addr | data0 | data1
 *
 * Type 1 (DO): data0 = DO[7:0], data1 = 0
 *   读回: rx0 = 写后DO状态（硬件回读）, rx1 = 0
 * Type 2 (AO): data0 = AO通道号, data1 = AO值
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_write_io(struct sio_device *sio, u8 addr, u8 data0, u8 data1,
                 u8 *rx0, u8 *rx1)
{
    return sio_xfer(sio, CMD_WR_IO, addr, data0, data1, rx0, rx1);
}
EXPORT_SYMBOL_GPL(sio_write_io);

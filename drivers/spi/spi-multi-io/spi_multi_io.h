/* SPDX-License-Identifier: GPL-2.0 */
/*
 * spi_multi_io.h - SPI转多接口（IO/ADC/DAC）驱动 头文件
 *
 * 深圳市海清智元参考设计
 *
 * 协议格式（SPI全双工，1个CS，按地址区分模块）：
 *   发送: CMD(1B) | ADDR(1B) | DATA0(1B) | DATA1(1B)
 *   接收: CMD(1B) | ADDR(1B) | RDATA0(1B) | RDATA1(1B)
 *
 * 命令定义:
 *   0x99 - 写地址（将默认地址0xAA的模块重新分配地址，返回 version|type）
 *   0x4B - 写 Type1（DO输出）
 *   0x43 - 写 Type2（AO输出）
 *   0x3A - 读 Type1（DI数字输入）
 *   0x41 - 读 Type2（单通道AD采样）
 *   0x42 - 读 Type2（一次性读全部4通道）
 *   0x5C - 读模块信息（获取模块类型和版本）
 */

#ifndef _SPI_MULTI_IO_H_
#define _SPI_MULTI_IO_H_

#include <linux/types.h>
#include <linux/gpio/consumer.h>

/* ========== 协议常量 ========== */

/* 命令码 */
#define CMD_WR_ADDR      0x99   /* 写地址命令（返回 version | type） */
#define CMD_WR_IO        0x4B   /* 写 Type1 DO命令 */
#define CMD_WR_AO        0x43   /* 写 Type2 AO命令 */
#define CMD_RD_IO        0x3A   /* 读 Type1 命令（DI输入） */
#define CMD_RD_AD        0x41   /* 读 Type2 命令（单通道AD采样） */
#define CMD_RD_AD_ALL     0x42   /* 读 Type2 命令（一次性读全部4通道） */
#define CMD_RD_INFO      0x5C   /* 读模块信息命令 */
#define CMD_RD_AO        0x44   /* 读AO回读命令 */

/* 默认地址 */
#define ADDR_DEFAULT     0xAA   /* 所有模块上电默认地址 */
#define ADDR_INVALID     0xFF   /* 无效地址 */
#define ADDR_MIN         0x01   /* 有效地址范围 */
#define ADDR_MAX         0xFE

/* 模块类型 */
#define MOD_TYPE_UNKNOWN 0x00
#define MOD_TYPE_DIDO    0x1A   /* Type 1: 8路DI + 8路DO */
#define MOD_TYPE_AIAO    0x1B   /* Type 2: 4路AD + 2路DA */

/* 模块能力掩码 */
#define CAP_DI           BIT(0)
#define CAP_DO           BIT(1)
#define CAP_AI           BIT(2)
#define CAP_AO           BIT(3)

/* 模块数量上限 */
#define MAX_MODULES      16

/* DI/DO通道数 */
#define DI_CHANNELS      8
#define DO_CHANNELS      8

/* AI/AO通道数 */
#define AI_CHANNELS      4
#define AO_CHANNELS      2

/* SPI传输超时 (ms) */
#define SPI_XFER_TIMEOUT_MS    100

/* 模块扫描重试次数 */
#define SCAN_RETRIES      3

/* 通信缓冲大小 */
#define TX_BUF_SIZE       4
#define RX_BUF_SIZE       4

/* ========== 数据结构 ========== */

/**
 * struct sio_module - 单个模块的描述
 * @present:       模块是否在线
 * @addr:          分配的地址 (0x01-0xFE)
 * @type:          模块类型 (MOD_TYPE_DIDO / MOD_TYPE_AIAO)
 * @capabilities:  能力掩码
 * @version:       固件版本
 * @di_cache:      DI输入缓存 (bitmap, Type1)
 * @do_cache:      DO输出缓存 (bitmap, Type1)
 * @ai_cache:      AI输入缓存 [4通道] (Type2)
 * @ao_cache:      AO输出缓存 [2通道] (Type2)
 */
struct sio_module {
    bool            present;
    u8              addr;
    u8              type;
    u8              capabilities;
    u8              version;
    /* Type 1 */
    u8              di_cache;
    u8              do_cache;
    /* Type 2 */
    u16             ai_cache[AI_CHANNELS];
    u16             ao_cache[AO_CHANNELS];
};

/**
 * struct sio_device - 整个SPI设备的数据结构
 * @spi:            SPI设备指针
 * @lock:           并发锁
 * @num_modules:    已发现的模块数量
 * @modules:        模块数组
 * @dev:            内核设备指针
 * @power_gpio:     模块电源控制GPIO
 */
struct sio_device {
    struct spi_device       *spi;
    struct mutex            lock;
    int                     num_modules;
    struct sio_module       modules[MAX_MODULES];
    struct device           *dev;

    /* 模块电源控制GPIO */
    struct gpio_desc       *power_gpio;

    /* sysfs group指针，用于卸载时清理 */
    struct attribute_group *mod_group[MAX_MODULES];

    /* debug */
    unsigned long           xfer_count;
    unsigned long           err_count;
};

/* ========== API函数 ========== */

/* spi_multi_io_core.c */
int sio_xfer(struct sio_device *sio, u8 cmd, u8 addr,
             u8 tx_data0, u8 tx_data1,
             u8 *rx_data0, u8 *rx_data1);
int sio_xfer_read(struct sio_device *sio, u8 cmd, u8 addr,
                  u8 tx_data0, u8 tx_data1,
                  u8 *rx_buf, int rx_len, int delay_ms);
int sio_write_addr(struct sio_device *sio, u8 old_addr, u8 new_addr,
                  u8 *version, u8 *type);
int sio_read_info(struct sio_device *sio, u8 addr, u8 *type, u8 *version);
int sio_read_io(struct sio_device *sio, u8 addr, u8 *data0, u8 *data1);
int sio_write_io(struct sio_device *sio, u8 addr, u8 data0, u8 data1,
                 u8 *rx0, u8 *rx1);

/* spi_multi_io_init.c */
int sio_power_cycle_modules(struct sio_device *sio);
int sio_scan_modules(struct sio_device *sio);
int sio_detect_module_type(struct sio_device *sio, int mod_idx);

/* spi_multi_io_ops.c */
int sio_get_di(struct sio_device *sio, int mod_idx, u8 *di_bits);
int sio_read_do(struct sio_device *sio, int mod_idx, u8 *do_bits);
int sio_set_do(struct sio_device *sio, int mod_idx, u8 do_bits);
int sio_get_ai(struct sio_device *sio, int mod_idx, int ch, u16 *value);
int sio_read_ao(struct sio_device *sio, int mod_idx, int ch, u16 *value);
int sio_set_ao(struct sio_device *sio, int mod_idx, int ch, u16 value);
int sio_bulk_read_di(struct sio_device *sio);
int sio_bulk_read_ai(struct sio_device *sio);
int sio_read_all_ad(struct sio_device *sio, int mod_idx, u16 *values);

/* spi_multi_io_sysfs.c */
int  sio_create_sysfs_interfaces(struct sio_device *sio);
int  sio_create_mod_sysfs(struct sio_device *sio, int mod_idx);
void sio_free_mod_group(struct attribute_group *group);
void sio_remove_sysfs_interfaces(struct sio_device *sio);

#endif /* _SPI_MULTI_IO_H_ */

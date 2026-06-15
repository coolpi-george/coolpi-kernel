/* SPDX-License-Identifier: GPL-2.0 */
/*
 * spi_multi_io_ops.c - IO操作函数层
 *
 * 封装模块类型的差异，向上层提供统一的接口：
 *   - 读取DI、设置DO（Type1）
 *   - 读取AI、设置AO（Type2）
 *
 * 所有函数在调用前已持有 sio->lock 或自行加锁
 */

#include <linux/kernel.h>
#include <linux/device.h>
#include <linux/errno.h>
#include "spi_multi_io.h"

/**
 * sio_get_di - 读取Type1模块的数字输入
 * @sio:     设备结构体
 * @mod_idx: 模块索引
 * @di_bits: DI位图输出 (bit0=DI0, ..., bit7=DI7)
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_get_di(struct sio_device *sio, int mod_idx, u8 *di_bits)
{
    struct sio_module *mod;
    u8 data0, data1;
    int ret;

    if (mod_idx < 0 || mod_idx >= sio->num_modules)
        return -EINVAL;

    mod = &sio->modules[mod_idx];
    if (!mod->present)
        return -ENODEV;
    if (mod->type != MOD_TYPE_DIDO)
        return -ENOTTY;

    ret = sio_read_io(sio, mod->addr, &data0, &data1);
    if (ret < 0)
        return ret;

    mod->di_cache = data0;

    if (di_bits)
        *di_bits = data0;

    return 0;
}
EXPORT_SYMBOL_GPL(sio_get_di);

/**
 * sio_read_do - 读取Type1模块的数字输出回读值
 * @sio:     设备结构体
 * @mod_idx: 模块索引
 * @do_bits: DO位图输出 (bit0=DO0, ..., bit7=DO7)
 *
 * 发送 CMD_RD_IO 读DI/DO状态。某些硬件在 data0 返回DI、
 * data1 返回DO。若硬件不支持回读，则返回缓存值。
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_read_do(struct sio_device *sio, int mod_idx, u8 *do_bits)
{
    struct sio_module *mod;
    u8 data0, data1;
    int ret;

    if (mod_idx < 0 || mod_idx >= sio->num_modules)
        return -EINVAL;

    mod = &sio->modules[mod_idx];
    if (!mod->present)
        return -ENODEV;
    if (mod->type != MOD_TYPE_DIDO)
        return -ENOTTY;

    /*
     * 读DI/DO命令：部分硬件在返回帧 data0=DI, data1=DO。
     * 若data1为0，则说明硬件不支持DO回读，返回缓存值。
     */
    ret = sio_read_io(sio, mod->addr, &data0, &data1);
    if (ret < 0)
        return ret;

    /* 更新DI缓存 */
    mod->di_cache = data0;

    if (data1 != 0x00) {
        /* 硬件支持DO回读 */
        mod->do_cache = data1;
    }
    /* 否则保持已有缓存不变 */

    if (do_bits)
        *do_bits = mod->do_cache;

    return 0;
}
EXPORT_SYMBOL_GPL(sio_read_do);

/**
 * sio_set_do - 设置Type1模块的数字输出（写后回读验证）
 * @sio:     设备结构体
 * @mod_idx: 模块索引
 * @do_bits: DO位图 (bit0=DO0, ..., bit7=DO7)
 *
 * 写DO后捕获硬件返回的实际状态更新缓存，确保缓存与硬件一致。
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_set_do(struct sio_device *sio, int mod_idx, u8 do_bits)
{
    struct sio_module *mod;
    u8 rx0, rx1;
    int ret;

    if (mod_idx < 0 || mod_idx >= sio->num_modules)
        return -EINVAL;

    mod = &sio->modules[mod_idx];
    if (!mod->present)
        return -ENODEV;
    if (mod->type != MOD_TYPE_DIDO)
        return -ENOTTY;

    ret = sio_write_io(sio, mod->addr, do_bits, 0x00, &rx0, &rx1);
    if (ret < 0)
        return ret;

    /*
     * 写DO后硬件可能回读实际状态：
     * - rx0 = 写后的DO状态（硬件回读）
     * - rx1 = 0
     * 若rx0非0xFF(unlikely)且非rx0 == do_bits，优先用硬件回读值
     */
    mod->do_cache = rx0;

    if (rx0 != do_bits)
        dev_dbg(sio->dev,
                "DO写后回读不匹配: 期望0x%02x, 实际0x%02x\n",
                do_bits, rx0);

    return 0;
}
EXPORT_SYMBOL_GPL(sio_set_do);

/**
 * sio_get_ai - 读取Type2模块的模拟输入通道
 * @sio:     设备结构体
 * @mod_idx: 模块索引
 * @ch:      通道号 (0-3)
 * @value:   采样值输出
 *
 * 通过AD命令读取，每次读取一个通道：
 *   发送: 0x41 | addr | ch | 0x00
 *   接收: 0x41 | addr | value_L | value_H
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_get_ai(struct sio_device *sio, int mod_idx, int ch, u16 *value)
{
    struct sio_module *mod;
    u8 data0, data1;
    u16 raw;
    int ret;

    if (mod_idx < 0 || mod_idx >= sio->num_modules)
        return -EINVAL;
    if (ch < 0 || ch >= AI_CHANNELS)
        return -EINVAL;

    mod = &sio->modules[mod_idx];
    if (!mod->present)
        return -ENODEV;
    if (mod->type != MOD_TYPE_AIAO)
        return -ENOTTY;

    /*
     * 用读IO命令，data0选择通道，返回值的低字节+高字节
     * 这里假设模块内部根据data0选择ADC通道并返回12/16位值
     */
    /* 0x41 | addr | byte_count(0x02) | channel */
    ret = sio_xfer(sio, CMD_RD_AD, mod->addr, 0x02, (u8)ch,
                   &data0, &data1);
    if (ret < 0)
        return ret;

    /* 12位ADC值（假设低12位有效） */
    raw = ((u16)data1 << 8) | data0;
    mod->ai_cache[ch] = raw;

    if (value)
        *value = raw;

    return 0;
}
EXPORT_SYMBOL_GPL(sio_get_ai);

/**
 * sio_read_ao - 读取Type2模块的模拟输出回读值
 * @sio:     设备结构体
 * @mod_idx: 模块索引
 * @ch:      通道号 (0-1)
 * @value:   输出回读值 (0-1000)
 *
 * 两阶段SPI：先发命令，再读数据。
 * 发送: 0x44 | addr | 0x02(返回字节数) | ch
 * 返回: 2字节, 高位在前低位在后, 范围0-1000
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_read_ao(struct sio_device *sio, int mod_idx, int ch, u16 *value)
{
    struct sio_module *mod;
    u8 rx_buf[2];
    int ret;

    if (mod_idx < 0 || mod_idx >= sio->num_modules)
        return -EINVAL;
    if (ch < 0 || ch >= AO_CHANNELS)
        return -EINVAL;

    mod = &sio->modules[mod_idx];
    if (!mod->present)
        return -ENODEV;
    if (mod->type != MOD_TYPE_AIAO)
        return -ENOTTY;

    /* 0x44 | addr | 0x02(返回字节数) | ch，等待 1ms */
    ret = sio_xfer_read(sio, CMD_RD_AO, mod->addr,
                        0x02, (u8)ch, rx_buf, 2, 1);
    if (ret < 0)
        return ret;

    /* 高位在前低位在后 */
    {
        u16 raw = ((u16)rx_buf[0] << 8) | rx_buf[1];
        if (raw <= 1000) {
            mod->ao_cache[ch] = raw;
        } else {
            dev_dbg(sio->dev,
                    "AO回读值超范围: %u, 保持缓存\n", raw);
        }
    }

    if (value)
        *value = mod->ao_cache[ch];

    return 0;
}
EXPORT_SYMBOL_GPL(sio_read_ao);

/**
 * sio_set_ao - 设置Type2模块的模拟输出通道
 * @sio:     设备结构体
 * @mod_idx: 模块索引
 * @ch:      通道号 (0-1)
 * @value:   输出值 (0-1000，对应0-10V)
 *
 * 写命令格式：
 *   发送: 0x43 | addr | DATA0 | DATA1
 *   DATA0: 高4位=通道号, 低4位=value的高4位
 *   DATA1: value的低8位
 *   value范围: 0-1000, 对应 0-10V
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_set_ao(struct sio_device *sio, int mod_idx, int ch, u16 value)
{
    struct sio_module *mod;
    u8 data0, data1, rx0, rx1;
    int ret;

    if (mod_idx < 0 || mod_idx >= sio->num_modules)
        return -EINVAL;
    if (ch < 0 || ch >= AO_CHANNELS)
        return -EINVAL;
    if (value > 1000)
        value = 1000;

    mod = &sio->modules[mod_idx];
    if (!mod->present)
        return -ENODEV;
    if (mod->type != MOD_TYPE_AIAO)
        return -ENOTTY;

    /*
     * DATA0 = (ch << 4) | (value >> 8) & 0x0F
     * DATA1 = value & 0xFF
     * 0x43 | addr | (ch<<4 | value>>8) | value
     */
    data0 = ((u8)ch << 4) | ((value >> 8) & 0x0F);
    data1 = value & 0xFF;

    ret = sio_xfer(sio, CMD_WR_AO, mod->addr, data0, data1, &rx0, &rx1);
    if (ret < 0)
        return ret;

    /*
     * 写AO后捕获硬件回读：
     * rx0/rx1 可能包含实际设置值，优先用硬件回读
     */
    if (rx0 != 0xFF && rx1 != 0xFF) {
        u16 hw_val = ((u16)rx1 << 8) | rx0;
        mod->ao_cache[ch] = hw_val;
        if (hw_val != value)
            dev_dbg(sio->dev,
                    "AO写后回读不匹配: 期望%d, 实际%d\n",
                    value, hw_val);
    } else {
        mod->ao_cache[ch] = value;
    }

    dev_dbg(sio->dev, "AO: mod%d ch%d = %d\n",
             mod_idx + 1, ch, mod->ao_cache[ch]);

    return 0;
}
EXPORT_SYMBOL_GPL(sio_set_ao);

/**
 * sio_bulk_read_di - 批量读取所有Type1模块的DI
 * @sio: 设备结构体
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_bulk_read_di(struct sio_device *sio)
{
    int i, ret;

    for (i = 0; i < sio->num_modules; i++) {
        if (sio->modules[i].type == MOD_TYPE_DIDO) {
            ret = sio_get_di(sio, i, NULL);
            if (ret < 0)
                return ret;
        }
    }
    return 0;
}

/**
 * sio_read_all_ad - 一次性读取Type2模块全部4个AD通道
 * @sio:    设备结构体
 * @mod_idx: 模块索引
 * @values: 输出4个通道的采样值
 *
 * 一次性发命令读取所有4个通道，减少SPI通信次数。
 * 协议: TX=0x42|addr|0x08|0x04, RX=8字节(ch0_L|ch0_H|ch1_L|ch1_H|...)
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_read_all_ad(struct sio_device *sio, int mod_idx, u16 *values)
{
    struct sio_module *mod;
    u8 rx_buf[8];
    int ret, i;

    if (mod_idx < 0 || mod_idx >= sio->num_modules)
        return -EINVAL;

    mod = &sio->modules[mod_idx];
    if (!mod->present)
        return -ENODEV;
    if (mod->type != MOD_TYPE_AIAO)
        return -ENOTTY;

    /* 0x42 | addr | 0x08(字节数) | 0x04(通道数)，等待 1ms */
    ret = sio_xfer_read(sio, CMD_RD_AD_ALL, mod->addr,
                        0x08, 0x04, rx_buf, 8, 1);
    if (ret < 0)
        return ret;

    /* 解析8字节：每通道2字节，低字节在前 */
    for (i = 0; i < AI_CHANNELS; i++) {
        u16 val = ((u16)rx_buf[i * 2 + 1] << 8) | rx_buf[i * 2];
        mod->ai_cache[i] = val;
        if (values)
            values[i] = val;
    }

    return 0;
}

/**
 * sio_bulk_read_ai - 批量读取所有Type2模块的AI
 * @sio: 设备结构体
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_bulk_read_ai(struct sio_device *sio)
{
    int i, ch, ret;

    for (i = 0; i < sio->num_modules; i++) {
        if (sio->modules[i].type == MOD_TYPE_AIAO) {
            for (ch = 0; ch < AI_CHANNELS; ch++) {
                ret = sio_get_ai(sio, i, ch, NULL);
                if (ret < 0)
                    return ret;
            }
        }
    }
    return 0;
}

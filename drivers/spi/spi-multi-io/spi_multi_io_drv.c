/* SPDX-License-Identifier: GPL-2.0 */
/*
 * spi_multi_io_drv.c - SPI转多接口（IO/ADC/DAC）主驱动
 *
 * 深圳市海清智元参考设计
 *
 * 功能概述：
 *   通过单CS SPI总线驱动两种模块：
 *     - Type1: 8路DI + 8路DO
 *     - Type2: 4路AI + 2路AO
 *
 * 协议:
 *   发送: CMD(1B) | ADDR(1B) | DATA0(1B) | DATA1(1B)
 *   接收: (CMD) | (ADDR) | RDATA0 | RDATA1
 *
 * 命令:
 *   0x99 = 写地址, 0x4B = 写Type1(DO), 0x43 = 写Type2(AO), 0x3A = 读Type1, 0x41 = 读Type2, 0x42 = 读全部AD, 0x5C = 读模块信息
 *   所有模块默认地址 0xAA
 *
 * 使用方式:
 *   # insmod spi_multi_io.ko
 *   # echo 1 > /sys/.../spi/.../sio/scan     # 触发模块扫描
 *   # cat /sys/.../spi/.../sio/mod0/di       # 读DI
 *   # echo 0xff > /sys/.../spi/.../sio/mod0/do  # 写DO
 *   # cat /sys/.../spi/.../sio/mod1/ai_ch0   # 读AI通道0
 *   # echo 128 > /sys/.../spi/.../sio/mod1/ao_ch0  # 写AO通道0
 *
 * 设备树绑定:
 *   &spi1 {
 *       status = "okay";
 *
 *       sio: sio@0 {
 *           compatible = "hqvt,spi-multi-io";
 *           reg = <0>;            // CS0
 *           spi-max-frequency = <10000000>;
 *           // 可选: 模块预配置
 *           // hqvt,modules = <4>;
 *       };
 *   };
 */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/device.h>
#include <linux/errno.h>
#include <linux/slab.h>
#include <linux/spi/spi.h>
#include <linux/of.h>
#include <linux/delay.h>
#include "spi_multi_io.h"

/**
 * sio_probe - SPI设备探测函数
 * @spi: SPI设备指针
 *
 * 当设备树匹配或SPI board info注册时调用
 */
static int sio_probe(struct spi_device *spi)
{
    struct sio_device *sio;
    int ret;

    dev_info(&spi->dev, "SPI多接口驱动加载: CS=%d, speed=%dHz\n",
             spi->chip_select, spi->max_speed_hz);

    /* 分配主数据结构 */
    sio = devm_kzalloc(&spi->dev, sizeof(*sio), GFP_KERNEL);
    if (!sio)
        return -ENOMEM;

    sio->spi = spi;
    sio->dev = &spi->dev;
    mutex_init(&sio->lock);

    /* 配置SPI参数 */
    spi->mode = SPI_MODE_3;          /* CPOL=1, CPHA=1 */
    spi->bits_per_word = 8;
    ret = spi_setup(spi);
    if (ret < 0) {
        dev_err(&spi->dev, "SPI配置失败: %d\n", ret);
        return ret;
    }

    spi_set_drvdata(spi, sio);

    /* 获取可选的模块电源控制GPIO（power-gpios） */
    sio->power_gpio = devm_gpiod_get_optional(&spi->dev, "power",
                                              GPIOD_OUT_LOW);
    if (IS_ERR(sio->power_gpio)) {
        ret = PTR_ERR(sio->power_gpio);
        if (ret != -EPROBE_DEFER)
            dev_warn(&spi->dev, "获取power-gpio失败: %d\n", ret);
        sio->power_gpio = NULL;
    } else if (sio->power_gpio) {
        dev_info(&spi->dev, "已配置模块电源控制GPIO\n");
        /* 默认关电，等扫描时再上电 */
        gpiod_set_value(sio->power_gpio, 0);
    }

    /* 创建sysfs接口（先创建顶层接口，方便用户手动扫描） */
    ret = sio_create_sysfs_interfaces(sio);
    if (ret < 0) {
        dev_err(&spi->dev, "创建sysfs接口失败: %d\n", ret);
        return ret;
    }

    /* 加载时自动扫描一次，发现并分配地址 */
    mutex_lock(&sio->lock);
    sio_scan_modules(sio);
    mutex_unlock(&sio->lock);

    dev_info(&spi->dev, "SPI多接口驱动加载成功\n");

    return 0;
}

/**
 * sio_remove - SPI设备移除函数
 */
static void sio_remove(struct spi_device *spi)
{
    struct sio_device *sio = spi_get_drvdata(spi);

    if (!sio)
        return;

    sio_remove_sysfs_interfaces(sio);
    mutex_destroy(&sio->lock);

    dev_info(&spi->dev, "SPI多接口驱动卸载\n");
}

#ifdef CONFIG_PM_SLEEP
/**
 * sio_suspend - 系统挂起时保存状态
 */
static int sio_suspend(struct device *dev)
{
    struct sio_device *sio = dev_get_drvdata(dev);
    dev_dbg(dev, "suspend: %d modules active\n", sio->num_modules);
    return 0;
}

/**
 * sio_resume - 系统恢复时恢复状态
 */
static int sio_resume(struct device *dev)
{
    struct sio_device *sio = dev_get_drvdata(dev);
    int i;

    dev_dbg(dev, "resume: 恢复 %d 个模块状态\n", sio->num_modules);

    /* 恢复每个模块的DO/AO输出状态 */
    for (i = 0; i < sio->num_modules; i++) {
        struct sio_module *mod = &sio->modules[i];
        if (!mod->present)
            continue;

        switch (mod->type) {
        case MOD_TYPE_DIDO:
            sio_write_io(sio, mod->addr, mod->do_cache, 0x00,
                     NULL, NULL);
            break;
        case MOD_TYPE_AIAO:
            sio_write_io(sio, mod->addr,
                     mod->ao_cache[0] & 0xFF,
                     mod->ao_cache[1] & 0xFF,
                     NULL, NULL);
            break;
        }
    }

    return 0;
}

static SIMPLE_DEV_PM_OPS(sio_pm_ops, sio_suspend, sio_resume);
#define SIO_PM_OPS (&sio_pm_ops)
#else
#define SIO_PM_OPS NULL
#endif

/* ========== 设备树匹配表 ========== */

static const struct of_device_id sio_of_match[] = {
    { .compatible = "hqvt,spi-multi-io", },
    { .compatible = "spi-multi-io", },
    { /* sentinel */ }
};
MODULE_DEVICE_TABLE(of, sio_of_match);

/* ========== SPI设备ID表（用于非设备树匹配和MODALIAS） ========== */

static const struct spi_device_id sio_spi_ids[] = {
    { "hqvt,spi-multi-io", 0 },
    { "spi-multi-io", 0 },
    { }
};
MODULE_DEVICE_TABLE(spi, sio_spi_ids);

/* ========== SPI驱动结构 ========== */

static struct spi_driver sio_spi_driver = {
    .driver = {
        .name           = "spi_multi_io",
        .owner          = THIS_MODULE,
        .of_match_table = sio_of_match,
        .pm             = SIO_PM_OPS,
    },
    .probe      = sio_probe,
    .remove     = sio_remove,
    .id_table   = sio_spi_ids,
};

module_spi_driver(sio_spi_driver);

MODULE_LICENSE("GPL v2");
MODULE_AUTHOR("HQVT Open Source");
MODULE_DESCRIPTION("SPI to Multi-IO (DI/DO/AI/AO) Driver");
MODULE_VERSION("1.0");

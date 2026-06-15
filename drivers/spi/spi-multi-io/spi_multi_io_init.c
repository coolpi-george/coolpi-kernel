/* SPDX-License-Identifier: GPL-2.0 */
/*
 * spi_multi_io_init.c - 模块发现与初始化
 *
 * 上电时所有模块默认地址为0xAA。本代码负责：
 *   1. 通过0x99命令探测默认地址0xAA上的模块
 *   2. 为每个发现的模块分配唯一地址
 *   3. 从0x99返回值直接获取模块类型和版本
 *   4. 缓存模块信息供上层使用
 *
 * 由于所有模块上电默认地址相同（0xAA），需要在硬件上
 * 实现"逐个使能"机制来避免总线冲突。
 *
 * 扫描模式：
 *   每次写入scan sysfs接口触发一次发现，找到当前使能的模块。
 *   外部每使能一个新模块，用户写入scan一次。
 *
 * 0x99命令返回：data0 = 固件版本, data1 = 模块类型
 * 所以写地址的同时就能拿到类型和版本，无需额外命令。
 */

#include <linux/kernel.h>
#include <linux/device.h>
#include <linux/delay.h>
#include <linux/errno.h>
#include <linux/slab.h>
#include "spi_multi_io.h"

/* 外部函数声明 */
extern int sio_create_mod_sysfs(struct sio_device *sio, int mod_idx);
extern void sio_free_mod_group(struct attribute_group *group);

/**
 * sio_power_cycle_modules - 控制模块电源（GPIO拉低→50ms→拉高）
 * @sio: 设备结构体
 *
 * 如果设备树配置了 power-gpios，扫描前掉电再上电，确保
 * 所有模块复位到默认地址 0xAA。
 */
int sio_power_cycle_modules(struct sio_device *sio)
{
	if (!sio->power_gpio)
		return 0;

	dev_info(sio->dev, "模块电源复位: 关电...\n");

	/* 关电 */
	gpiod_set_value(sio->power_gpio, 0);
	msleep(50);

	/* 开电 */
	gpiod_set_value(sio->power_gpio, 1);
	dev_info(sio->dev, "模块电源已恢复\n");

	/* 等待模块上电稳定 */
	msleep(50);

	return 0;
}
EXPORT_SYMBOL_GPL(sio_power_cycle_modules);

/**
 * sio_scan_modules - 扫描并配置所有在线模块
 * @sio: 设备结构体
 *
 * 每次调用都会清除之前的模块状态，从0x01重新开始扫描。
 * 连续扫描默认地址0xAA，发现一个模块就分配一个地址并创建sysfs节点，
 * 直到没有模块响应为止。
 *
 * 地址从0x01开始顺序分配，sysfs目录从mod1开始：
 *   第1个模块 → mod1/ → 地址0x01
 *   第2个模块 → mod2/ → 地址0x02
 *   ...
 *
 * 返回值: 本次发现的模块数量, 负数为错误码
 */
int sio_scan_modules(struct sio_device *sio)
{
	u8 version, type, new_addr;
	int ret, found = 0;
	int i;

	dev_info(sio->dev, "开始扫描模块...\n");

	/* 电源复位：确保模块回到默认地址 0xAA */
	sio_power_cycle_modules(sio);

	/* 清除旧的模块状态，从0x01重新开始 */
	for (i = 0; i < sio->num_modules; i++) {
		if (sio->mod_group[i]) {
			sysfs_remove_group(&sio->dev->kobj, sio->mod_group[i]);
			sio_free_mod_group(sio->mod_group[i]);
			sio->mod_group[i] = NULL;
		}
	}
	memset(sio->modules, 0, sizeof(sio->modules));
	sio->num_modules = 0;

	while (sio->num_modules < MAX_MODULES) {
		int mod_idx = sio->num_modules;

		/* 地址 = 模块索引 + 1，从 0x01 开始 */
		new_addr = ADDR_MIN + mod_idx;

		if (new_addr >= ADDR_DEFAULT)
			break;

		ret = sio_write_addr(sio, ADDR_DEFAULT, new_addr,
				     &version, &type);
		if (ret < 0) {
			dev_err(sio->dev,
				"写入地址 0xAA->0x%02x 失败: %d\n",
				new_addr, ret);
			break;
		}

		/* 判断是否有模块响应 */
		if (version == 0xFF || version == 0x00 ||
		    type == 0xFF || type == 0x00) {
			dev_dbg(sio->dev,
				"地址 0xAA 无响应 (ver=0x%02x, type=0x%02x)\n",
				version, type);
			break;
		}

		udelay(50);

		/* 填充模块信息 */
		sio->modules[mod_idx].present = true;
		sio->modules[mod_idx].addr    = new_addr;
		sio->modules[mod_idx].type    = type;
		sio->modules[mod_idx].version = version;

		switch (type) {
		case MOD_TYPE_DIDO:
			sio->modules[mod_idx].capabilities = CAP_DI | CAP_DO;
			break;
		case MOD_TYPE_AIAO:
			sio->modules[mod_idx].capabilities = CAP_AI | CAP_AO;
			break;
		default:
			sio->modules[mod_idx].capabilities = 0;
			break;
		}

		/* 创建 sysfs 目录 */
		ret = sio_create_mod_sysfs(sio, mod_idx);
		if (ret < 0)
			dev_warn(sio->dev,
				 "创建 mod%d 的sysfs目录失败: %d\n",
				 mod_idx + 1, ret);

		sio->num_modules = mod_idx + 1;
		found++;

		dev_info(sio->dev,
			 "发现 mod%d: addr=0x%02x, type=0x%02x, ver=0x%02x\n",
			 mod_idx + 1, new_addr, type, version);

		/* 等待模块切换地址稳定 */
		msleep(10);
	}

	dev_info(sio->dev, "扫描完成: 共发现 %d 个模块\n",
		 sio->num_modules);

	return found;
}
EXPORT_SYMBOL_GPL(sio_scan_modules);

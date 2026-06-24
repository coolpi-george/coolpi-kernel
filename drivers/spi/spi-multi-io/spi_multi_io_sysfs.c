/* SPDX-License-Identifier: GPL-2.0 */
/*
 * spi_multi_io_sysfs.c - sysfs接口
 *
 * 用户空间通过sysfs访问和控制模块：
 *
 * /sys/bus/spi/devices/.../sio/
 *   ├── num_modules        - 已发现的模块数量 (RO)
 *   ├── scan               - 触发模块扫描 (WO)
 *   ├── debug_xfer_count   - SPI传输计数 (RO)
 *   ├── debug_err_count    - SPI错误计数 (RO)
 *   ├── mod<N>/            - 模块N的目录
 *   │   ├── addr           - 模块地址 (RO)
 *   │   ├── type           - 模块类型 (RO)
 *   │   ├── version        - 固件版本 (RO)
 *   │   ├── di             - DI输入值 (RO, Type1)
 *   │   ├── do              - DO输出值 (RW, Type1)
 *   │   ├── ai_ch0..3      - AI通道值 (RO, Type2)
 *   │   └── ao_ch0..1      - AO通道值 (RW, Type2)
 */

#include <linux/kernel.h>
#include <linux/device.h>
#include <linux/stat.h>
#include <linux/slab.h>
#include <linux/string.h>
#include <linux/errno.h>
#include <linux/mutex.h>
#include <linux/kobject.h>
#include <linux/delay.h>
#include "spi_multi_io.h"

/* ========== 顶层属性 ========== */

static ssize_t num_modules_show(struct device *dev,
				struct device_attribute *attr, char *buf)
{
	struct sio_device *sio = dev_get_drvdata(dev);
	return snprintf(buf, PAGE_SIZE, "%d\n", sio->num_modules);
}
static DEVICE_ATTR_RO(num_modules);

static ssize_t scan_store(struct device *dev,
			  struct device_attribute *attr,
			  const char *buf, size_t count)
{
	struct sio_device *sio = dev_get_drvdata(dev);
	int ret;

	mutex_lock(&sio->lock);
	ret = sio_scan_modules(sio);
	mutex_unlock(&sio->lock);

	/*
	 * 触发 udev CHANGE 事件，让 udev 规则重新设置
	 * 新创建的 modN/ 目录下文件的 0666 权限。
	 * 等待 50ms 确保 udev 执行完 chmod，避免竞态。
	 */
	kobject_uevent(&dev->kobj, KOBJ_CHANGE);
	msleep(50);

	if (ret < 0)
		return ret;

	return count;
}
static DEVICE_ATTR_WO(scan);

static ssize_t debug_xfer_count_show(struct device *dev,
				     struct device_attribute *attr, char *buf)
{
	struct sio_device *sio = dev_get_drvdata(dev);
	return snprintf(buf, PAGE_SIZE, "%lu\n", sio->xfer_count);
}
static DEVICE_ATTR_RO(debug_xfer_count);

static ssize_t debug_err_count_show(struct device *dev,
				    struct device_attribute *attr, char *buf)
{
	struct sio_device *sio = dev_get_drvdata(dev);
	return snprintf(buf, PAGE_SIZE, "%lu\n", sio->err_count);
}
static DEVICE_ATTR_RO(debug_err_count);

static struct attribute *sio_top_attrs[] = {
	&dev_attr_num_modules.attr,
	&dev_attr_scan.attr,
	&dev_attr_debug_xfer_count.attr,
	&dev_attr_debug_err_count.attr,
	NULL,
};

static const struct attribute_group sio_top_group = {
	.name  = "sio",
	.attrs = sio_top_attrs,
};

/* ========== 模块属性 ========== */

struct sio_mod_attribute {
	struct device_attribute attr;
	int mod_idx;
	int ch;
	bool name_dynamic;	/* name由kstrdup分配，卸载时需要释放 */
};

static ssize_t mod_addr_show(struct device *dev,
			     struct device_attribute *attr, char *buf)
{
	struct sio_device *sio = dev_get_drvdata(dev);
	struct sio_mod_attribute *sma =
		container_of(attr, struct sio_mod_attribute, attr);
	struct sio_module *mod = &sio->modules[sma->mod_idx];

	return snprintf(buf, PAGE_SIZE, "0x%02x\n", mod->addr);
}

static ssize_t mod_type_show(struct device *dev,
			     struct device_attribute *attr, char *buf)
{
	struct sio_device *sio = dev_get_drvdata(dev);
	struct sio_mod_attribute *sma =
		container_of(attr, struct sio_mod_attribute, attr);
	struct sio_module *mod = &sio->modules[sma->mod_idx];

	switch (mod->type) {
	case MOD_TYPE_DIDO:
		return snprintf(buf, PAGE_SIZE, "dido (8DI/8DO)\n");
	case MOD_TYPE_AIAO:
		return snprintf(buf, PAGE_SIZE, "aiao (4AI/2AO)\n");
	default:
		return snprintf(buf, PAGE_SIZE, "unknown (0x%02x)\n", mod->type);
	}
}

static ssize_t mod_version_show(struct device *dev,
				struct device_attribute *attr, char *buf)
{
	struct sio_device *sio = dev_get_drvdata(dev);
	struct sio_mod_attribute *sma =
		container_of(attr, struct sio_mod_attribute, attr);
	struct sio_module *mod = &sio->modules[sma->mod_idx];

	return snprintf(buf, PAGE_SIZE, "0x%02x\n", mod->version);
}

/* DI - 读取数字输入 */
static ssize_t mod_di_show(struct device *dev,
			   struct device_attribute *attr, char *buf)
{
	struct sio_device *sio = dev_get_drvdata(dev);
	struct sio_mod_attribute *sma =
		container_of(attr, struct sio_mod_attribute, attr);
	u8 di_bits;
	int ret;

	mutex_lock(&sio->lock);
	ret = sio_get_di(sio, sma->mod_idx, &di_bits);
	mutex_unlock(&sio->lock);

	if (ret < 0)
		return ret;

	return snprintf(buf, PAGE_SIZE, "0x%02x\n", di_bits);
}

/* DO - 读写数字输出 */
static ssize_t mod_do_show(struct device *dev,
			   struct device_attribute *attr, char *buf)
{
	struct sio_device *sio = dev_get_drvdata(dev);
	struct sio_mod_attribute *sma =
		container_of(attr, struct sio_mod_attribute, attr);
	u8 do_bits;
	int ret;

	/* 从硬件回读DO */
	mutex_lock(&sio->lock);
	ret = sio_read_do(sio, sma->mod_idx, &do_bits);
	mutex_unlock(&sio->lock);

	if (ret < 0)
		return ret;

	return snprintf(buf, PAGE_SIZE, "0x%02x\n", do_bits);
}

static ssize_t mod_do_store(struct device *dev,
			    struct device_attribute *attr,
			    const char *buf, size_t count)
{
	struct sio_device *sio = dev_get_drvdata(dev);
	struct sio_mod_attribute *sma =
		container_of(attr, struct sio_mod_attribute, attr);
	u8 do_bits;
	int ret;

	if (kstrtou8(buf, 0, &do_bits) < 0)
		return -EINVAL;

	mutex_lock(&sio->lock);
	ret = sio_set_do(sio, sma->mod_idx, do_bits);
	mutex_unlock(&sio->lock);

	return ret < 0 ? ret : count;
}

/* AI - 读取模拟输入 */
static ssize_t mod_ai_show(struct device *dev,
			   struct device_attribute *attr, char *buf)
{
	struct sio_device *sio = dev_get_drvdata(dev);
	struct sio_mod_attribute *sma =
		container_of(attr, struct sio_mod_attribute, attr);
	u16 value;
	int ret;

	mutex_lock(&sio->lock);
	ret = sio_get_ai(sio, sma->mod_idx, sma->ch, &value);
	mutex_unlock(&sio->lock);

	if (ret < 0)
		return ret;

	return snprintf(buf, PAGE_SIZE, "%u\n", value);
}

/* AO - 读写模拟输出 */
static ssize_t mod_ao_show(struct device *dev,
			   struct device_attribute *attr, char *buf)
{
	struct sio_device *sio = dev_get_drvdata(dev);
	struct sio_mod_attribute *sma =
		container_of(attr, struct sio_mod_attribute, attr);
	u16 value;
	int ret;

	/* 从硬件回读AO */
	mutex_lock(&sio->lock);
	ret = sio_read_ao(sio, sma->mod_idx, sma->ch, &value);
	mutex_unlock(&sio->lock);

	if (ret < 0)
		return ret;

	return snprintf(buf, PAGE_SIZE, "%u\n", value);
}

static ssize_t mod_ao_store(struct device *dev,
			    struct device_attribute *attr,
			    const char *buf, size_t count)
{
	struct sio_device *sio = dev_get_drvdata(dev);
	struct sio_mod_attribute *sma =
		container_of(attr, struct sio_mod_attribute, attr);
	unsigned long value;
	int ret;

	if (kstrtoul(buf, 0, &value) < 0)
		return -EINVAL;

	mutex_lock(&sio->lock);
	ret = sio_set_ao(sio, sma->mod_idx, sma->ch, (u16)value);
	mutex_unlock(&sio->lock);

	return ret < 0 ? ret : count;
}

/* AI_ALL - 一次性读取全部4个通道 */
static ssize_t mod_ai_all_show(struct device *dev,
			       struct device_attribute *attr, char *buf)
{
	struct sio_device *sio = dev_get_drvdata(dev);
	struct sio_mod_attribute *sma =
		container_of(attr, struct sio_mod_attribute, attr);
	u16 values[AI_CHANNELS];
	int ret;

	mutex_lock(&sio->lock);
	ret = sio_read_all_ad(sio, sma->mod_idx, values);
	mutex_unlock(&sio->lock);

	if (ret < 0)
		return ret;

	return snprintf(buf, PAGE_SIZE,
			"ch0=%u\nch1=%u\nch2=%u\nch3=%u\n",
			values[0], values[1],
			values[2], values[3]);
}

/* ========== 模块sysfs组创建与销毁 ========== */

/*
 * 创建单个模块属性，返回 struct attribute *。
 * _name_dynamic: true 表示 name 是 kstrdup 分配的，卸载时需 kfree
 */
#define SIO_MOD_ATTR(_name, _mode, _show, _store, _mod_idx, _ch, _name_dynamic) \
	({\
		struct sio_mod_attribute *__sma = \
			kzalloc(sizeof(*__sma), GFP_KERNEL); \
		if (__sma) { \
			sysfs_attr_init(&__sma->attr.attr); \
			__sma->attr.attr.name = _name; \
			__sma->attr.attr.mode = _mode; \
			__sma->attr.show = _show; \
			__sma->attr.store = _store; \
			__sma->mod_idx = _mod_idx; \
			__sma->ch = _ch; \
			__sma->name_dynamic = _name_dynamic; \
		} \
		__sma; \
	})

/**
 * sio_create_mod_sysfs - 为单个模块创建sysfs目录和属性
 * @sio:     设备结构体
 * @mod_idx: 模块索引
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_create_mod_sysfs(struct sio_device *sio, int mod_idx)
{
	struct device *dev = sio->dev;
	struct sio_module *mod = &sio->modules[mod_idx];
	struct attribute_group *group;
	struct attribute **attrs;
	char dir_name[16];
	int num_attrs = 0;
	int attr_count = 0;
	int i;

	if (mod_idx < 0 || mod_idx >= MAX_MODULES)
		return -EINVAL;
	if (!mod->present)
		return -ENODEV;

	/* 如果已创建过，先移除旧的 */
	if (sio->mod_group[mod_idx]) {
		sysfs_remove_group(&dev->kobj, sio->mod_group[mod_idx]);
		sio->mod_group[mod_idx] = NULL;
	}

	/* 通用属性: addr, type, version = 3 */
	num_attrs += 3;

	switch (mod->type) {
	case MOD_TYPE_DIDO:
		num_attrs += 2;   /* di, do */
		break;
	case MOD_TYPE_AIAO:
		num_attrs += AI_CHANNELS + AO_CHANNELS + 1;  /* ai_all + ai_ch0-3 + ao_ch0-1 */
		break;
	}

	/* +1 for NULL terminator */
	attrs = kcalloc(num_attrs + 1, sizeof(struct attribute *), GFP_KERNEL);
	if (!attrs)
		return -ENOMEM;

	group = kzalloc(sizeof(*group), GFP_KERNEL);
	if (!group) {
		kfree(attrs);
		return -ENOMEM;
	}

	/* 目录从 mod1 开始，mod1=地址0x01，与地址号对应 */
	snprintf(dir_name, sizeof(dir_name), "mod%d", mod_idx + 1);
	group->name = kstrdup(dir_name, GFP_KERNEL);
	if (!group->name) {
		kfree(attrs);
		kfree(group);
		return -ENOMEM;
	}
	group->attrs = attrs;

	/* 创建通用属性 */
	attrs[attr_count++] = &SIO_MOD_ATTR("addr", 0444,
		mod_addr_show, NULL, mod_idx, 0, false)->attr.attr;
	attrs[attr_count++] = &SIO_MOD_ATTR("type", 0444,
		mod_type_show, NULL, mod_idx, 0, false)->attr.attr;
	attrs[attr_count++] = &SIO_MOD_ATTR("version", 0444,
		mod_version_show, NULL, mod_idx, 0, false)->attr.attr;

	/* 创建模块特定属性 */
	switch (mod->type) {
	case MOD_TYPE_DIDO:
		attrs[attr_count++] = &SIO_MOD_ATTR("di", 0444,
			mod_di_show, NULL, mod_idx, 0, false)->attr.attr;
		attrs[attr_count++] = &SIO_MOD_ATTR("do", 0644,
			mod_do_show, mod_do_store, mod_idx, 0, false)->attr.attr;
		break;

	case MOD_TYPE_AIAO:
		attrs[attr_count++] = &SIO_MOD_ATTR("ai_all", 0444,
			mod_ai_all_show, NULL, mod_idx, 0, false)->attr.attr;
		for (i = 0; i < AI_CHANNELS; i++) {
			char name[16];
			snprintf(name, sizeof(name), "ai_ch%d", i);
			attrs[attr_count++] = &SIO_MOD_ATTR(
				kstrdup(name, GFP_KERNEL), 0444,
				mod_ai_show, NULL, mod_idx, i, true)->attr.attr;
		}
		for (i = 0; i < AO_CHANNELS; i++) {
			char name[16];
			snprintf(name, sizeof(name), "ao_ch%d", i);
			attrs[attr_count++] = &SIO_MOD_ATTR(
				kstrdup(name, GFP_KERNEL), 0644,
				mod_ao_show, mod_ao_store, mod_idx, i, true)->attr.attr;
		}
		break;
	}

	attrs[attr_count] = NULL;

	/* 保存group指针，用于卸载时清理 */
	sio->mod_group[mod_idx] = group;

	return sysfs_create_group(&dev->kobj, group);
}

/**
 * sio_free_mod_group - 释放单个模块的sysfs组内存
 * @group: attribute_group指针
 *
 * 遍历所有属性，释放动态分配的内存
 */
void sio_free_mod_group(struct attribute_group *group)
{
	int i;

	if (!group)
		return;

	/* 遍历attrs数组，释放每个SIO_MOD_ATTR分配的结构 */
	for (i = 0; group->attrs && group->attrs[i]; i++) {
		struct sio_mod_attribute *sma =
			container_of(group->attrs[i],
				     struct sio_mod_attribute, attr.attr);
		if (sma->name_dynamic)
			kfree(group->attrs[i]->name);
		kfree(sma);
	}

	kfree(group->attrs);
	kfree(group->name);
	kfree(group);
}

/**
 * sio_create_sysfs_interfaces - 创建顶层sysfs接口
 * @sio: 设备结构体
 *
 * 创建顶层 sio/ 目录。
 * 模块的 modN/ 子目录由 sio_create_mod_sysfs() 在扫描时动态创建。
 *
 * 返回值: 0成功, 负数为错误码
 */
int sio_create_sysfs_interfaces(struct sio_device *sio)
{
	struct device *dev = sio->dev;
	int ret;

	ret = sysfs_create_group(&dev->kobj, &sio_top_group);
	if (ret < 0) {
		dev_err(dev, "创建sysfs顶层组失败: %d\n", ret);
		return ret;
	}

	return 0;
}

/**
 * sio_remove_sysfs_interfaces - 移除所有sysfs接口并释放内存
 * @sio: 设备结构体
 */
void sio_remove_sysfs_interfaces(struct sio_device *sio)
{
	int i;

	for (i = 0; i < MAX_MODULES; i++) {
		if (sio->mod_group[i]) {
			sysfs_remove_group(&sio->dev->kobj,
					   sio->mod_group[i]);
			sio_free_mod_group(sio->mod_group[i]);
			sio->mod_group[i] = NULL;
		}
	}

	sysfs_remove_group(&sio->dev->kobj, &sio_top_group);
}

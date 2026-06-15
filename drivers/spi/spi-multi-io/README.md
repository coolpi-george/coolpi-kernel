# SPI Multi-IO 驱动 — 设计文档

## 1. 概述

SPI转多接口（IO/ADC/DAC）Linux内核驱动，通过**单CS（片选）**的SPI总线驱动两种模块：

| 模块类型 | 接口          | 通道数 |
|---------|--------------|--------|
| Type1   | DI (数字输入) | 8路    |
| Type1   | DO (数字输出) | 8路    |
| Type2   | AI (模拟输入) | 4路    |
| Type2   | AO (模拟输出) | 2路    |

所有模块共享一条SPI总线和同一个片选信号，通过**地址码**区分不同模块。

---

## 2. 通信协议

### 2.1 帧格式 (4字节全双工)

```
   发送: +------+------+--------+--------+
          | CMD  | ADDR | DATA0  | DATA1  |
          +------+------+--------+--------+
   接收: +------+------+--------+--------+
          | ECHO | ECHO | RDATA0 | RDATA1 |
          +------+------+--------+--------+
```

- **CMD**: 命令码（1字节）
- **ADDR**: 目标模块地址（1字节）
- **DATA0/DATA1**: 发送数据（1字节各）
- **RDATA0/RDATA1**: 接收数据（全双工，与发送同时进行）

### 2.2 命令定义

| 命令码 | 名称       | 功能                                  |
|--------|-----------|---------------------------------------|
| 0x99   | 写地址     | 将默认地址(0xAA)的模块重分配新地址       |
| 0x4B   | 写IO       | 设置DO输出(Type1) 或 AO输出(Type2)      |
| 0x3A   | 读IO       | 读取DI输入(Type1) 或 AI输入(Type2)      |
| 0x5C   | 读模块信息 | 读取模块类型和固件版本（本驱动扩展命令）   |

### 2.3 默认地址

- 所有模块上电/复位后默认地址: **0xAA**
- 有效地址范围: **0x01 ~ 0xFE**
- 地址 0xFF 保留为无效地址

---

## 3. 各模块类型的数据格式

### Type1 (DI/DO)

```
读IO (0x3A):
  发送: 0x3A | ADDR | 0x00 | 0x00
  接收: 0x3A | ADDR | DI_BITS | 0x00

  DI_BITS: bit0=DI0, bit1=DI1, ..., bit7=DI7

写IO (0x4B):
  发送: 0x4B | ADDR | DO_BITS | 0x00

  DO_BITS: bit0=DO0, bit1=DO1, ..., bit7=DO7
```

### Type2 (AI/AO)

```
读AI (0x3A):
  发送: 0x3A | ADDR | CH | 0x00
  接收: 0x3A | ADDR | VALUE_LOW | VALUE_HIGH

  CH:    通道号 (0~3)
  VALUE: 12位ADC值 (低12位有效)

写AO (0x4B):
  发送: 0x4B | ADDR | CH | VALUE

  CH:    通道号 (0~1)
  VALUE: 8位DAC值 (0~255)
```

---

## 4. 模块发现与地址分配

### 上电初始状态

所有模块上电默认地址均为 **0xAA**。

### 扫描流程

```
  1. 硬件逐个使能模块（通过外部GPIO或上电时序控制）
     → 每次只有一个模块处于"可寻址"状态

  2. 发送探测帧到 0xAA:
     发送: 0x3A | 0xAA | 0x00 | 0x00
     接收: 如果不是 0xFF 0xFF → 模块存在

  3. 分配唯一地址:
     发送: 0x99 | 0xAA | NEW_ADDR | 0x00
     模块收到后将自身地址改为 NEW_ADDR

  4. 读取模块类型:
     发送: 0x5C | NEW_ADDR | 0x00 | 0x00
     接收: 0x5C | NEW_ADDR | TYPE | VERSION

  5. 使能下一个模块 → 重复步骤2-4
```

### 模块地址分配策略

| 地址范围 | 用途               |
|---------|-------------------|
| 0xAA    | 默认地址（未分配）    |
| 0x01-0x10 | Type1 模块地址    |
| 0x11-0x20 | Type2 模块地址    |
| 0x21-0xFE | 保留               |
| 0xFF    | 无效/广播不使用      |

---

## 5. 软件架构

```
┌──────────────────────────────────────────────────┐
│                  用户空间                          │
│  test_sio (测试程序)  /  cat / echo 操作sysfs      │
└──────────────────────┬───────────────────────────┘
                       │ sysfs
┌──────────────────────┴───────────────────────────┐
│  spi_multi_io_sysfs.c  ← sysfs接口层              │
│    /sys/.../sio/num_modules                       │
│    /sys/.../sio/scan                              │
│    /sys/.../sio/mod0/di, do                       │
│    /sys/.../sio/mod1/ai_ch0..3, ao_ch0..1          │
└──────────────────────┬───────────────────────────┘
                       │
┌──────────────────────┴───────────────────────────┐
│  spi_multi_io_ops.c  ← IO操作封装层                │
│    sio_get_di(), sio_set_do()                     │
│    sio_get_ai(), sio_set_ao()                     │
│    处理Type1/Type2的差异，缓存管理                 │
└──────────────────────┬───────────────────────────┘
                       │
┌──────────────────────┴───────────────────────────┐
│  spi_multi_io_init.c ← 模块发现与初始化            │
│    sio_scan_modules()                             │
│    sio_detect_module_type()                       │
│    地址分配、类型识别、状态初始化                   │
└──────────────────────┬───────────────────────────┘
                       │
┌──────────────────────┴───────────────────────────┐
│  spi_multi_io_core.c ← SPI通信核心                 │
│    sio_xfer()       - SPI全双工收发               │
│    sio_write_addr() - 地址分配                    │
│    sio_read_info()  - 读模块信息                  │
│    sio_read_io()    - 读IO                       │
│    sio_write_io()   - 写IO                       │
│    互斥锁保护、错误处理、传输计数                   │
└──────────────────────┬───────────────────────────┘
                       │ SPI子系统
┌──────────────────────┴───────────────────────────┐
│  spi_multi_io_drv.c ← SPI驱动主入口                │
│    probe/remove                                   │
│    设备树匹配、电源管理                             │
└──────────────────────────────────────────────────┘
```

---

## 6. 使用指南

### 6.1 编译

```bash
# 本地编译
make KERNEL_DIR=/lib/modules/$(uname -r)/build

# 交叉编译（ARM64）
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
     KERNEL_DIR=/path/to/kernel

# 启用调试输出
make debug KERNEL_DIR=/path/to/kernel
```

### 6.2 设备树配置

```dts
&spi1 {
    status = "okay";
    pinctrl-0 = <&spi1_pins_a>;
    
    sio: sio@0 {
        compatible = "hqvt,spi-multi-io";
        reg = <0>;               /* CS0 */
        spi-max-frequency = <10000000>;  /* 10MHz */
    };
};
```

### 6.3 加载与使用

```bash
# 加载驱动
insmod spi_multi_io.ko

# 查找sysfs路径
find /sys -name num_modules 2>/dev/null
# 输出示例: /sys/bus/spi/devices/spi1.0/sio/num_modules

SIO=/sys/bus/spi/devices/spi1.0/sio

# 扫描模块
echo 1 > $SIO/scan

# 查看发现的模块数量
cat $SIO/num_modules

# === Type1 操作 ===
cat $SIO/mod0/di          # 读DI (0x00-0xFF)
echo 0xFF > $SIO/mod0/do  # 写DO

# === Type2 操作 ===
cat $SIO/mod1/ai_ch0      # 读AI通道0
echo 200 > $SIO/mod1/ao_ch0  # 写AO通道0

# 查看调试信息
cat $SIO/debug_xfer_count  # SPI传输次数
cat $SIO/debug_err_count   # SPI错误次数

# 卸载
rmmod spi_multi_io
```

### 6.4 测试程序

```bash
# 编译
gcc -o test_sio test_sio.c

# 运行（自动扫描+测试）
./test_sio /sys/bus/spi/devices/spi1.0/sio
```

---

## 7. 文件清单

| 文件 | 说明 |
|------|------|
| `spi_multi_io.h` | 头文件（协议常量、数据结构、API声明） |
| `spi_multi_io_core.c` | SPI通信核心层 |
| `spi_multi_io_init.c` | 模块发现与初始化 |
| `spi_multi_io_ops.c` | IO操作函数层 |
| `spi_multi_io_sysfs.c` | sysfs接口层 |
| `spi_multi_io_drv.c` | 主驱动入口（probe/remove） |
| `Makefile` | 编译脚本 |
| `test_sio.c` | 用户空间测试程序 |
| `README.md` | 本文档 |

---

## 8. 扩展与定制

### 添加新命令

1. 在 `spi_multi_io.h` 中添加命令码宏定义
2. 在 `spi_multi_io_core.c` 中实现命令收发函数
3. 在 `spi_multi_io_ops.c` 中封装高层操作
4. 在 `spi_multi_io_sysfs.c` 中添加对应sysfs属性

### 添加新模块类型

1. 在 `spi_multi_io.h` 中添加 `MOD_TYPE_xxx` 定义
2. 在 `spi_multi_io_init.c` 的 `sio_detect_module_type()` 中添加分支
3. 在 `spi_multi_io_sysfs.c` 的 `sio_create_mod_sysfs()` 中添加对应属性

### 性能优化

- 当前SPI单次传输为4字节，可考虑批量传输合并多个命令
- 使用 `spi_async` 替代 `spi_sync` 实现异步非阻塞操作
- 添加DMA支持（需要硬件支持）

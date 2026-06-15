/*
 * test_sio.c - SPI Multi-IO 用户空间测试程序
 *
 * 编译: gcc -o test_sio test_sio.c
 * 使用: ./test_sio <sysfs_path>
 *       示例: ./test_sio /sys/bus/spi/devices/spi1.0/sio
 *
 * 功能:
 *   1. 扫描模块
 *   2. 轮询所有DI/AI
 *   3. 设置DO/AO测试输出
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <dirent.h>
#include <errno.h>
#include <sys/stat.h>

#define SYSFS_PATH_MAX  256
#define BUF_SIZE        64

/* 读取sysfs文件内容 */
static int sysfs_read(const char *path, char *buf, size_t size)
{
    int fd, ret;

    fd = open(path, O_RDONLY);
    if (fd < 0) {
        perror("open");
        return -1;
    }

    ret = read(fd, buf, size - 1);
    if (ret < 0) {
        perror("read");
        close(fd);
        return -1;
    }

    buf[ret] = '\0';
    close(fd);
    return ret;
}

/* 写入sysfs文件 */
static int sysfs_write(const char *path, const char *value)
{
    int fd, ret;

    fd = open(path, O_WRONLY);
    if (fd < 0) {
        perror("open");
        return -1;
    }

    ret = write(fd, value, strlen(value));
    if (ret < 0) {
        perror("write");
        close(fd);
        return -1;
    }

    close(fd);
    return 0;
}

/* 检查目录是否存在 */
static int dir_exists(const char *path)
{
    struct stat st;
    return (stat(path, &st) == 0 && S_ISDIR(st.st_mode));
}

/* 扫描所有模块 */
static int scan_modules(const char *base_path)
{
    char path[SYSFS_PATH_MAX];
    char buf[BUF_SIZE];
    int num_mods;

    /* 触发扫描 */
    snprintf(path, sizeof(path), "%s/scan", base_path);
    if (sysfs_write(path, "1") < 0) {
        printf("  [!] 扫描触发失败（可能需要手动扫描）\n");
        return -1;
    }

    /* 读取模块数量 */
    snprintf(path, sizeof(path), "%s/num_modules", base_path);
    if (sysfs_read(path, buf, sizeof(buf)) < 0)
        return -1;

    num_mods = atoi(buf);
    printf("  已发现 %d 个模块\n", num_mods);
    return num_mods;
}

/* 显示模块详情 */
/* 前向声明 */
static int dir_exists_path(const char *dir, const char *name);

static void show_module(const char *base_path, int mod_idx)
{
    char path[SYSFS_PATH_MAX];
    char buf[BUF_SIZE];
    char dir[SYSFS_PATH_MAX];

    snprintf(dir, sizeof(dir), "%s/mod%d", base_path, mod_idx);
    if (!dir_exists(dir)) {
        printf("  模块 %d: 不存在\n", mod_idx);
        return;
    }

    printf("  ┌─ 模块 %d\n", mod_idx);

    /* 地址 */
    snprintf(path, sizeof(path), "%s/addr", dir);
    if (sysfs_read(path, buf, sizeof(buf)) > 0)
        printf("  ├ addr    : %s", buf);

    /* 类型 */
    snprintf(path, sizeof(path), "%s/type", dir);
    if (sysfs_read(path, buf, sizeof(buf)) > 0)
        printf("  ├ type    : %s", buf);

    /* 版本 */
    snprintf(path, sizeof(path), "%s/version", dir);
    if (sysfs_read(path, buf, sizeof(buf)) > 0)
        printf("  ├ version : %s", buf);

    /* 检查是Type1还是Type2 */
    if (dir_exists_path(dir, "di")) {
        /* Type1: DI/DO */
        snprintf(path, sizeof(path), "%s/di", dir);
        if (sysfs_read(path, buf, sizeof(buf)) > 0)
            printf("  ├ DI      : %s", buf);

        snprintf(path, sizeof(path), "%s/do", dir);
        if (sysfs_read(path, buf, sizeof(buf)) > 0)
            printf("  └ DO      : %s", buf);
    } else {
        /* Type2: AI/AO */
        int ch;
        for (ch = 0; ch < 4; ch++) {
            snprintf(path, sizeof(path), "%s/ai_ch%d", dir, ch);
            if (sysfs_read(path, buf, sizeof(buf)) > 0)
                printf("  ├ AI_CH%d  : %s", ch, buf);
        }
        for (ch = 0; ch < 2; ch++) {
            snprintf(path, sizeof(path), "%s/ao_ch%d", dir, ch);
            if (sysfs_read(path, buf, sizeof(buf)) > 0) {
                char *p = strchr(buf, '\n');
                if (p) *p = '\0';
                printf("  └ AO_CH%d  : %s", ch, ch < 1 ? "\n" : "");
                if (ch < 1) printf("  ├ AO_CH%d  : %s (readback)\n", ch, buf);
                else        printf("            (%s readback)\n", buf);
            }
        }
    }
}

/* 检查子文件是否存在 */
static int dir_exists_path(const char *dir, const char *name) {
    char path[SYSFS_PATH_MAX];
    snprintf(path, sizeof(path), "%s/%s", dir, name);
    return (access(path, F_OK) == 0);
}

/* 简单帮助 */
static void usage(const char *prog)
{
    printf("用法: %s <sysfs_path>\n", prog);
    printf("示例: %s /sys/bus/spi/devices/spi1.0/sio\n", prog);
    printf("\n快速查找:\n");
    printf("  find /sys -name num_modules 2>/dev/null\n");
}

int main(int argc, char *argv[])
{
    const char *base_path;
    int num_mods, i;

    if (argc < 2) {
        usage(argv[0]);
        return 1;
    }

    base_path = argv[1];

    if (!dir_exists(base_path)) {
        fprintf(stderr, "错误: %s 不存在\n", base_path);
        fprintf(stderr, "驱动可能未加载或路径不正确\n");
        return 1;
    }

    printf("╔══════════════════════════════════╗\n");
    printf("║    SPI Multi-IO Test Utility     ║\n");
    printf("╚══════════════════════════════════╝\n");
    printf("sysfs: %s\n\n", base_path);

    /* 1. 扫描模块 */
    printf("[1] 扫描模块...\n");
    num_mods = scan_modules(base_path);
    if (num_mods <= 0) {
        printf("  (没有发现模块，检查硬件连接)\n");
        return 0;
    }

    /* 2. 显示所有模块 */
    printf("\n[2] 模块列表:\n");
    for (i = 0; i < num_mods; i++)
        show_module(base_path, i);

    /* 3. 测试操作 */
    printf("\n[3] 执行测试...\n");

    for (i = 0; i < num_mods; i++) {
        char dir[SYSFS_PATH_MAX];
        char path[SYSFS_PATH_MAX];

        snprintf(dir, sizeof(dir), "%s/mod%d", base_path, i);

        if (dir_exists_path(dir, "do")) {
            /* Type1: 测试DO输出 */
            printf("  模块%d: 设置DO = 0x55\n", i);
            snprintf(path, sizeof(path), "%s/do", dir);
            sysfs_write(path, "0x55");
            sleep(1);

            printf("  模块%d: 设置DO = 0xAA\n", i);
            sysfs_write(path, "0xAA");
            sleep(1);

            printf("  模块%d: 清除所有DO\n", i);
            sysfs_write(path, "0x00");
        }

        if (dir_exists_path(dir, "ao_ch0")) {
            /* Type2: 测试AO输出 */
            int ch;
            for (ch = 0; ch < 2; ch++) {
                printf("  模块%d: 设置AO_CH%d = 128 (50%%)\n", i, ch);
                snprintf(path, sizeof(path), "%s/ao_ch%d", dir, ch);
                sysfs_write(path, "128");
                sleep(1);
            }
        }
    }

    printf("\n[4] 完成! 测试执行成功\n");
    return 0;
}

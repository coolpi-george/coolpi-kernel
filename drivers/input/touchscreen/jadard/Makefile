# Linux driver folder
#ccflags-y += -I$(srctree)/drivers/input/touchscreen/mediatek//* TP 驱动的路径 */
ccflags-y += -DCONFIG_TOUCHSCREEN_JADARD_DEBUG=y
ccflags-y += -DCONFIG_TOUCHSCREEN_JADARD_SORTING=y

ifeq ($(TARGET_BUILD_VARIANT), user)
	ccflags-y += -D__JADARD_GKI__
endif

# Makefile for the Jadard touchscreen drivers.
ifeq ($(CONFIG_TOUCHSCREEN_JADARD_MODULE), y)
	obj-y += jadard_module.o
	obj-y  += jadard_ic_JD9366T.o
	obj-y += jadard_common.o jadard_platform.o
	obj-y += jadard_debug.o
	obj-y += jadard_sorting.o

else ifeq ($(CONFIG_TOUCHSCREEN_JADARD_MODULE), m)
	ccflags-y += -D__JADARD_KMODULE__
	jadard_touch-objs := jadard_module.o
	jadard_touch-objs += jadard_ic_JD9366T.o
	jadard_touch-objs += jadard_common.o jadard_platform.o
	jadard_touch-objs += jadard_debug.o
	jadard_touch-objs += jadard_sorting.o
	obj-m += jadard_touch.o

endif

#!/bin/sh
#
# Copyright 2025 coolpi-george <george@cool-pi.com>
#
# A simple kernel compilation script for generating kernel files for the CoolPi machine.

K_SRC=`pwd`
ARCH_TYPE=$1

CFG="coolpi_linux_defconfig"

case "$ARCH_TYPE" in
arm64|aarch64)
	export ARCH=arm64 
	export CROSS_COMPILE=aarch64-linux-gnu- ;;
arm*)
	export ARCH=arm 
	export CROSS_COMPILE=arm-linux-gnueabihf- ;;
esac


make $CFG
make bindeb-pkg -j16
rm -rf $K_SRC/out/*
mkdir -p $K_SRC/out/extlinux
cp demo-cfgs/extlinux.conf ./out/extlinux/extlinux.conf
case "$ARCH_TYPE" in
arm64|aarch64)
	cp arch/arm64/boot/zImage ./out/Image
	cp arch/arm64/boot/dts/rockchip/*.dtb ./out
	cp demo-cfgs/initrd.img out/initrd.img ;;
arm*)
	cp arch/arm/boot/Image ./out/Image
	cp arch/arm/boot/dts/*.dtb ./out
	cp demo-cfgs/initrd32.img out/initrd.img ;;
esac

cd $K_SRC/debian/linux-image/lib/modules
tar -czf $K_SRC/out/modules.tar.gz *
cd $K_SRC/debian/linux-headers/usr/src
tar -czf $K_SRC/out/headers.tar.gz *

cd $K_SRC



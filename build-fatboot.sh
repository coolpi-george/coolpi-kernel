#!/bin/bash

echo "Create coolpi boot img..."
dd if=/dev/zero of=coolpi-boot.img bs=1M count=500
mkfs.vfat -F 32 coolpi-boot.img
fatlabel coolpi-boot.img system-boot
mkdir -p .temp
mount coolpi-boot.img .temp/
cp -r out/* .temp/
umount .temp
echo "Complete..."

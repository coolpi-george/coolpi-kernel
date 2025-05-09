#!/bin/bash

K_SRC=`pwd`

ARCH=`uname -m`
if [ "$ARCH" == "x86_64" ]; then
    export CROSS_COMPILE=aarch64-linux-gnu-
fi

cfg="coolpi_linux_preempt_rt_defconfig"

rm -rf $K_SRC/out
rm -rf $K_SRC/out_modules
rm -rf $K_SRC/out_headers
mkdir -p $K_SRC/out/extlinux
mkdir -p $K_SRC/out_modules
mkdir -p $K_SRC/out_headers/usr/src/linux-headers-6.1.75-rt23

make ARCH=arm64 LOCALVERSION= $cfg
make ARCH=arm64 LOCALVERSION= -j8
make ARCH=arm64 LOCALVERSION= modules -j8
make ARCH=arm64 LOCALVERSION= modules_install INSTALL_MOD_PATH=out_modules
make ARCH=arm64 LOCALVERSION= headers_install INSTALL_HDR_PATH=out_headers/usr/src/linux-headers-6.1.75
      
cp arch/arm64/boot/Image ./out/Image    
cp arch/arm64/boot/dts/rockchip/*.dtb ./out
cp demo-cfgs/extlinux.conf ./out/extlinux/extlinux.conf
cp demo-cfgs/initrd.img out/initrd.img

cd $K_SRC/out_modules/lib/modules/6.1.75
unlink source
unlink build
ln -sf /usr/src/linux-headers-6.1.75/ build
ln -sf /usr/src/linux-headers-6.1.75/ source
cd $K_SRC/out_modules/lib/
tar -czf ../../out/modules.tar.gz *
cd $K_SRC/out_headers/usr/
tar -czf ../../out/headers.tar.gz *

exit 0

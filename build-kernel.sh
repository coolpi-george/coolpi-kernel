#!/bin/bash

K_SRC=`pwd`

ARCH=`uname -m`
if [ "$ARCH" == "x86_64" ]; then
    export CROSS_COMPILE=aarch64-none-linux-gnu-
    TOOLCHAIN_ARM64=$K_SRC/toolchain/bin
    export PATH=$TOOLCHAIN_ARM64:$PATH
fi
export ARCH=arm64

BOARD=$1

case "$BOARD" in
  cp4b)
    cfg="rk3588s_cp4b_defconfig"
    dtb="rk3588s-cp4.dtb"
    txt_config_file="config_cp4b.txt"
    txt_extconf_file="extlinux_cp4b.conf"
    ;;
  cm5-evb)
    cfg="rk3588_cpcm5_evb_defconfig"
    dtb="rk3588-cpcm5-evb.dtb"
    txt_config_file="config_cpcm5_evb.txt"
    txt_extconf_file="extlinux_cpcm5_evb.conf"
    ;;
  cm5-8uart)
    cfg="rk3588_cpcm5_defconfig"
    dtb="rk3588-cpcm5-8uart.dtb"
    txt_config_file="config_cpcm5_8uart.txt"
    txt_extconf_file="extlinux_cpcm5_8uart.conf"
    ;;
  *)
    echo "Usage: $0 {cp4b|cm5-evb|cm5-8uart}" >&2
    exit 0
    ;;
esac

rm -rf arch/arm64/boot/dts/rockchip/$dtb
make ARCH=arm64 LOCALVERSION= $cfg
make ARCH=arm64 LOCALVERSION= -j8
make ARCH=arm64 LOCALVERSION= modules -j8
cp arch/arm64/boot/Image.gz vmlinuz
cp arch/arm64/boot/Image Image
cp arch/arm64/boot/dts/rockchip/$dtb .

rm -rf out_modules
mkdir -p out_modules

cd $K_SRC
make ARCH=arm64 modules_install INSTALL_MOD_PATH=out_modules

cd $K_SRC/out_modules/lib/modules/5.10.110
unlink source
unlink build
ln -sf /usr/src/5.10.110/ build
ln -sf /usr/src/5.10.110/ source
cd $K_SRC/out_modules/lib/
tar -czf ../../modules.tar.gz *

cd $K_SRC
rm -rf out
mkdir -p out/extlinux
cp vmlinuz out/
cp Image out/
cp $dtb out/
cp modules.tar.gz out/
cp demo-cfgs/$txt_config_file out/config.txt
cp demo-cfgs/$txt_extconf_file out/extlinux/extlinux.conf

exit 0

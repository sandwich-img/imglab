#!/bin/sh

set -xe

wget https://github.com/yangxuan8282/phicomm-n1/releases/download/150balbes_kernel/kernel_4.18.7_20180922.tar.gz
tar xf *.tar.gz
cp -R --no-preserve=mode,ownership kernel_*/boot/* /boot/
cp -a kernel_*/lib/* /lib/
sed -i "s|root=LABEL=ROOTFS|root=UUID=${ROOT_UUID}|" /boot/uEnv.ini
rm -rf kernel_*

wget https://github.com/yangxuan8282/phicomm-n1/releases/download/dtb/meson-gxl-s905d-phicomm-n1.dtb
mv *.dtb /boot/dtb.img

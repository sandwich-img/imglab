#!/bin/sh

set -e

wget -q https://github.com/yangxuan8282/img_host/raw/master/files/kernel/s905/kernel_4.18.7.tar.gz
tar xf *.tar.gz --strip=1 -C /
sed -i "s|ROOTFS|rootfs|" /boot/uEnv.ini
rm -rf kernel_*

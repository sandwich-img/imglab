#!/bin/sh

set -xe

pacman -S --noconfirm wget firmware-raspberrypi

wget https://github.com/yangxuan8282/phicomm-n1/releases/download/arch_kernel/linux-amlogic-4.19.2-0-aarch64.pkg.tar.xz
pacman -U --noconfirm *.pkg.tar.xz
rm -f *.pkg.tar.xz

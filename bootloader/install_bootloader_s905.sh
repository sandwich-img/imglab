#!/bin/sh

set -e

cd "$(dirname "$0")"

DEST=../target/mnt

cp files/$DEVICE/$DISTRO/* $DEST/boot/

cd $DEST/boot

mkimage -C none -A arm -T script -d aml_autoscript.cmd aml_autoscript
mkimage -C none -A arm -T script -d s905_autoscript.cmd s905_autoscript
mkimage -C none -A arm -T script -d emmc_autoscript.cmd emmc_autoscript
mkimage -A arm64 -O linux -T ramdisk -C gzip -n uInitrd -d initramfs-amlogic uInitrd

sleep 6 

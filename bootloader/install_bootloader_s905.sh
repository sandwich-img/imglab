#!/bin/sh

set -e

cd "$(dirname "$0")"

DEST=../target/mnt

rm -f $DEST/boot/*autoscript* $DEST/boot/uInitrd || true

cp files/$DEVICE/$DISTRO/* $DEST/boot/

cd $DEST/boot

case $DISTRO in
	alpine) INITRD=initramfs-amlogic;;
	archlinux) INITRD=initramfs-linux.img;;
	debian | ubuntu) INITRD=initrd.img-4.18.7-aml-s9xxx;;
esac

mkimage -C none -A arm -T script -d aml_autoscript.cmd aml_autoscript
mkimage -C none -A arm -T script -d s905_autoscript.cmd s905_autoscript
mkimage -C none -A arm -T script -d emmc_autoscript.cmd emmc_autoscript
mkimage -A arm64 -O linux -T ramdisk -C gzip -n uInitrd -d $INITRD uInitrd

sleep 6

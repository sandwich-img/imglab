#!/bin/sh

set -xe

ARCH=$(uname -m)

case "$ARCH" in
	aarch64) kernel_flavors="linux-aarch64 uboot-raspberrypi firmware-raspberrypi";;
	* ) kernel_flavors="linux-raspberrypi firmware-raspberrypi";;
esac

pacman -S --noconfirm $kernel_flavors

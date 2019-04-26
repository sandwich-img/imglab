#!/bin/sh

set -e

case $ARCH in
	x86_64) pacman -S --noconfirm grub efibootmgr ;;
esac

#!/bin/sh

set -e

case $ARCH in
	i386 | amd64) EXTRAS="systemd-sysv grub2-common grub-pc grub-efi-amd64-bin efibootmgr" ;;
esac

apt-get update && apt-get install -y linux-image-generic $EXTRAS

rm -rf /var/lib/apt/lists/* /tmp/*

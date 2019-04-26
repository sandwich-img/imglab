#!/bin/sh

set -e

get_kernel_suffix() {
	case "$1" in
		i386) echo '686-pae';;
		amd64) echo 'amd64';;
		*) echo "$1";;
	esac
}

_ARCH="$(get_kernel_suffix $ARCH)"

case $ARCH in
	i386 | amd64) EXTRAS="systemd-sysv grub2-common grub-pc grub-efi-amd64-bin efibootmgr" ;;
esac

apt-get update && apt-get install -y linux-image-"$_ARCH" $EXTRAS

rm -rf /var/lib/apt/lists/* /tmp/*

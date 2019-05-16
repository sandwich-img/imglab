#!/bin/sh

set -xe

mkdir -p pxe-$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE/boot/pxelinux.cfg

cp /usr/share/syslinux/pxelinux.0 /usr/share/syslinux/ldlinux.c32 \
        /usr/share/syslinux/efi64/syslinux.efi pxe-$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE/boot/pxelinux.cfg

setup_debian() {
	KERNEL_NAME=$(find pxe-$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE/boot/vmlinuz* -printf "%f\n")
	INITRD_NAME=$(find pxe-$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE/boot/initrd.img* -printf "%f\n")
	sed "s|vmlinuz|$KERNEL_NAME|; s|initrd.img|$INITRD_NAME|" ../pxe/files/$DEVICE/$DISTRO/default > \
		pxe-$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE/boot/pxelinux.cfg/default
}

case $DISTRO in
	debian | ubuntu | deepin) setup_debian;;
esac

sed -i "s|SERVER_IP|$SERVER_IP|g" pxe-$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE/boot/pxelinux.cfg/default

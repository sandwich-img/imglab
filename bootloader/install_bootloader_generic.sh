#!/bin/sh

set -e

cd "$(dirname "$0")"

DEST=../target/mnt

cp files/$DEVICE/syslinux.cfg.$DISTRO $DEST/boot/syslinux.cfg

cd $DEST
ls boot

install_syslinux (){
	dd bs=440 count=1 conv=fsync,notrunc if=/usr/share/syslinux/mbr.bin of=../$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE.img
	extlinux --install boot

	mkdir -p boot/EFI/BOOT
	cp /usr/share/syslinux/efi64/* boot/EFI/BOOT/
	mv boot/EFI/BOOT/syslinux.efi boot/EFI/BOOT/bootx64.efi
}

setup_debian() {
	KERNEL_NAME=$(find boot/vmlinuz* -printf "%f\n")
	INITRD_NAME=$(find boot/initrd.img* -printf "%f\n")
	sed -i "s|vmlinuz|$KERNEL_NAME|" boot/syslinux.cfg
	sed -i "s|initrd.img|$INITRD_NAME|" boot/syslinux.cfg

	echo "RESUME=LABEL=rootfs" > etc/initramfs-tools/conf.d/resume
}

case $DISTRO in
	debian | ubuntu | deepin) setup_debian;;
esac

install_syslinux

sleep 6 

#!/bin/sh

set -xe

cd "$(dirname "$0")"

guestfish -a ../target/"$OUTPUT_IMG" -- \
	run : \
	mount /dev/sda2 / : \
	mount /dev/sda1 /boot : \
	copy-in /usr/lib/syslinux/mbr/mbr.bin /boot : \
	copy-file-to-device /boot/mbr.bin /dev/sda size:440 : \
	syslinux /dev/sda1 : \
	upload files/$DEVICE/syslinux.cfg.$DISTRO /boot/syslinux.cfg : \
	mkdir-p /boot/EFI : \
	copy-in /usr/lib/syslinux/modules/efi64 /boot/EFI : \
	mv /boot/EFI/efi64 /boot/EFI/BOOT : \
	upload /usr/lib/SYSLINUX.EFI/efi64/syslinux.efi /boot/EFI/BOOT/bootx64.efi

case $DISTRO in
	debian | ubuntu | deepin) guestfish -a ../target/"$OUTPUT_IMG" -- \
	run : \
	mount /dev/sda2 / : \
	mount /dev/sda1 /boot : \
	sh "sed -i \"s|vmlinuz|\$(find /boot/vmlinuz* -printf "%f")|\" /boot/syslinux.cfg" : \
	sh "sed -i \"s|initrd.img|\$(find /boot/initrd.img* -printf "%f")|\" /boot/syslinux.cfg"
	;;
esac

#!/bin/sh

set -xe

cd "$(dirname "$0")"

if [ $DISTRO = "alpine" ]; then
	case $ARCH in
		x86) GRUB_EFI_TARGET=i386-efi ;;
		x86_64) GRUB_EFI_TARGET=x86_64-efi ;;
	esac
else
	GRUB_EFI_TARGET=x86_64-efi
fi

guestfish -a ../target/"$OUTPUT_IMG" -- \
	run : \
	mount /dev/sda2 / : \
	mount /dev/sda1 /boot : \
	command "grub-install --target=i386-pc --recheck --boot-directory /boot /dev/sda" : \
	command "grub-install --target=$GRUB_EFI_TARGET --efi-directory=/boot --boot-directory=/boot --removable" : \
	mkdir-p /boot/grub : \
	upload files/$DEVICE/grub.cfg.$DISTRO /boot/grub/grub.cfg : \
	command "sed -i s|BOOT_UUID|${BOOT_UUID}|g /boot/grub/grub.cfg"

case $DISTRO in
	debian | ubuntu | deepin) guestfish -a ../target/"$OUTPUT_IMG" -- \
	run : \
	mount /dev/sda2 / : \
	mount /dev/sda1 /boot : \
	sh "sed -i \"s|vmlinuz|\$(find /boot/vmlinuz* -printf "%f")|\" /boot/grub/grub.cfg" : \
	sh "sed -i \"s|initrd.img|\$(find /boot/initrd.img* -printf "%f")|\" /boot/grub/grub.cfg"
	;;
esac

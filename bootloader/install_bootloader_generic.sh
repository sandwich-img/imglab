#!/bin/sh

set -e

#case $ARCH in
#	 x86| i[3456]86 ) ARCH=x86 GRUB_EFI_TARGET=i386-efi;; 
#	   x64 | x86_64 ) ARCH=X86_64 GRUB_EFI_TARGET=x86_64-efi;; 
#	               *) die 'not supported arch';;
#esac
GRUB_EFI_TARGET=x86_64-efi

cd "$(dirname "$0")"

DEST=../target/mnt

cp files/$DEVICE/grub.cfg.$DISTRO $DEST/boot/

cd $DEST
ls boot
grub-install --target=i386-pc --recheck --boot-directory boot ${LOOP_DEV}
grub-install --target=${GRUB_EFI_TARGET} --efi-directory=boot --boot-directory=boot --bootloader-id=grub --removable

mv boot/grub.cfg.$DISTRO boot/grub/grub.cfg

replace_debian_kernel_name() {
	KERNEL_NAME=$(find boot/vmlinuz* -printf "%f\n")
	INITRD_NAME=$(find boot/initrd.img* -printf "%f\n")
	sed -i "s|vmlinuz|$KERNEL_NAME|" boot/grub/grub.cfg
	sed -i "s|initrd.img|$INITRD_NAME|" boot/grub/grub.cfg
}

case $DISTRO in
	debian) replace_debian_kernel_name && echo "RESUME=LABEL=rootfs" > etc/initramfs-tools/conf.d/resume;;
esac

sleep 6 

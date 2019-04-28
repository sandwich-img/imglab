#!/bin/sh

set -xe

cd "$(dirname "$0")"

mkdir -p tmp

for blobs in bootcode.bin fixup.dat start.elf ; do
	wget -q -P tmp https://github.com/raspberrypi/firmware/raw/master/boot/${blobs}
done

guestfish -a ../target/"$OUTPUT_IMG" -- \
	run : \
	mount /dev/sda2 / : \
	mount /dev/sda1 /boot : \
	copy-in tmp/bootcode.bin /boot : \
	copy-in tmp/fixup.dat /boot : \
	copy-in tmp/start.elf /boot : \
	upload files/rpi/$DISTRO/config_$ARCH.txt /boot/config.txt : \
	upload files/rpi/$DISTRO/cmdline.txt /boot/cmdline.txt

virt-edit -a ../target/"$OUTPUT_IMG" \
	-m /dev/sda2:/ -m /dev/sda1:/boot /boot/cmdline.txt -e "s|ROOT_PARTUUID|${ROOT_PARTUUID}|"

rm -rf tmp

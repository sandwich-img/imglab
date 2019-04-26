#!/bin/sh

set -xe

cd "$(dirname "$0")"

#DEST=../target/mnt

mkdir -p tmp

for blobs in bootcode.bin fixup.dat start.elf ; do
	wget -q -P tmp https://github.com/raspberrypi/firmware/raw/master/boot/${blobs}
done

#cp files/rpi/$DISTRO/config_$ARCH.txt $DEST/boot/config.txt
#cp files/rpi/$DISTRO/cmdline.txt $DEST/boot/

guestfish -a ../target/"$OUTPUT_IMG" -- \
	run : \
	mount /dev/sda2 / : \
	mount /dev/sda1 /boot : \
	copy-in tmp/bootcode.bin /boot : \
	copy-in tmp/fixup.dat /boot : \
	copy-in tmp/start.elf /boot : \
	upload files/rpi/$DISTRO/config_$ARCH.txt /boot/config.txt : \
	upload files/rpi/$DISTRO/cmdline.txt /boot/cmdline.txt

rm -rf tmp

#sed -i "s|ROOT_PARTUUID|${ROOT_PARTUUID}|" $DEST/boot/cmdline.txt

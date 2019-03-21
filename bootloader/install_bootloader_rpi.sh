#!/bin/sh

set -e

cd "$(dirname "$0")"

DEST=../target/mnt

for blobs in bootcode.bin fixup.dat start.elf ; do
	wget -q -P $DEST/boot https://github.com/raspberrypi/firmware/raw/master/boot/${blobs}
done

cp files/rpi/$DISTRO/config_$ARCH.txt $DEST/boot/config.txt
cp files/rpi/$DISTRO/cmdline.txt $DEST/boot/

sed -i "s|ROOT_PARTUUID|${ROOT_PARTUUID}|" $DEST/boot/cmdline.txt

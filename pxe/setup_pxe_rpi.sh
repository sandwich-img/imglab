#!/bin/sh

set -e

for blobs in bootcode.bin fixup.dat start.elf ; do
        wget -q -P pxe-$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE/boot \
		https://github.com/raspberrypi/firmware/raw/master/boot/${blobs}
done

sed "s|SERVER_IP|$SERVER_IP|g" ../pxe/files/$DEVICE/$DISTRO/cmdline.txt \
	> pxe-$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE/boot/cmdline.txt

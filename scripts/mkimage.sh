#!/bin/sh

set -e

OUTPUT_IMG=target/$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE.img
IMG_SIZE=$(( `du target/$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE.tar | awk '{print $1}'` * 2 * 1200 ))

case "$ARCH" in
	arm* | aarch64 ) BOOT_SIZE=100MB;;
	* )BOOT_SIZE=500MB;;
esac

gen_image() {
	fallocate -l $IMG_SIZE "$OUTPUT_IMG"
cat > fdisk.cmd <<-EOF
	o
	n
	p
	1
	
	+${BOOT_SIZE}
	t
	c
	a
	n
	p
	2
	
	
	w
EOF
fdisk "$OUTPUT_IMG" < fdisk.cmd
rm -f fdisk.cmd
}

do_format() {
	mkfs.vfat -n boot -v "$BOOT_DEV" > /dev/null
	mkfs.ext4 -L rootfs -O "$ROOT_FEATURES" "$ROOT_DEV" > /dev/null
	mkdir -p target/mnt
	mount "$ROOT_DEV" target/mnt
	mkdir -p target/mnt/boot
	mount "$BOOT_DEV" target/mnt/boot
}

umounts() {
	umount target/mnt/boot
	umount target/mnt
	losetup -d "$LOOP_DEV"
}

gen_image

LOOP_DEV=$(losetup --partscan --show --find "${OUTPUT_IMG}")
BOOT_DEV="$LOOP_DEV"p1
ROOT_DEV="$LOOP_DEV"p2

BOOT_UUID=$(blkid ${BOOT_DEV} | cut -f 2 -d '"')
ROOT_UUID=$(blkid ${ROOT_DEV} | cut -f 2 -d '"')

ROOT_FEATURES="^huge_file"
for FEATURE in metadata_csum 64bit; do
	if grep -q "$FEATURE" /etc/mke2fs.conf; then
	    ROOT_FEATURES="^$FEATURE,$ROOT_FEATURES"
	fi
done

do_format

tar xf target/$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE.tar -C target/mnt || true > /dev/null

LOOP_DEV=${LOOP_DEV} ./bootloader/install_bootloader_$DEVICE.sh

rm -rf target/mnt/Dockerfile* target/mnt/.docker* target/mnt/usr/bin/qemu* target/mnt/scripts target/mnt/configs

sync

umounts

zip -r -j target/$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE.zip target/$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE.img

rm -f target/$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE.tar target/$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE.img

cat >&2 <<-EOF
	---
	The img was placed in target/$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE.zip
	Flash to storage with Etcher or dd
	
EOF

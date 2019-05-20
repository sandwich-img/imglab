#!/bin/sh

set -xe

normalize_qemu_arch() {
	case "$1" in
		x86_64 | amd64 ) echo 'x86_64';;
		x86 | i[3456]86) echo 'x86';;
		arm64 | aarch64) echo 'aarch64';;
		armhf | armv7*]) echo 'armv7l';;
	esac
}

HOST_ARCH=$(uname -m)

TARGET_ARCH=$(normalize_qemu_arch $ARCH)

QEMU_OPTS=

if [ -e "/dev/kvm" ] && [ "$HOST_ARCH" = "$TARGET_ARCH" ]; then
	QEMU_OPTS="--enable-kvm"
else
	echo '"kvm" accelerator not found'
fi

qemu-system-x86_64 \
  -m 512M \
  -drive file=$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE.img,format=raw \
  $QEMU_OPTS \
  -nographic -vnc :1

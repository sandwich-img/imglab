#!/bin/sh

set -xe

normalize_arch() {
	case "$1" in
		armv7l ) echo 'armhf' ;;
		x86_64 ) echo 'x86_64';;
		*) echo "$1";;
	esac
}

HOST_ARCH="$(uname -m)"

BL_ARCH="$(normalize_arch $HOST_ARCH)"

mkdir -p target

docker run --rm -i --privileged -v $(pwd)/target:/target \
		-v /boot:/boot -v /lib/modules:/lib/modules \
		-v $(pwd)/bootloader:/bootloader \
		-v $(pwd)/tools/mkimage/mkimage:/mkimage \
		--env DISTRO=$DISTRO \
		--env DESKTOP=$DESKTOP \
		--env ARCH=$ARCH \
		--env BRANCH=$BRANCH \
		--env DEVICE=$DEVICE \
		sandwichimg/mkimage:guestfs-$BL_ARCH /mkimage

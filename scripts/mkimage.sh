#!/bin/sh

set -e

normalize_arch() {
	case "$1" in
		x86_64 ) echo 'x86_64';;
		*) echo "$1";;
	esac
}

HOST_ARCH=$(uname -m)

BL_ARCH="$(normalize_arch $HOST_ARCH)"

mkdir -p target
#ls
#pwd
docker run --rm -ti --privileged -v $(pwd)/target:/target -v $(pwd)/bootloader:/bootloader \
		-v $(pwd)/tools/mkimage/mkimage:/mkimage \
		--env DISTRO=$DISTRO \
		--env DESKTOP=$DESKTOP \
		--env ARCH=$ARCH \
		--env BRANCH=$BRANCH \
		--env DEVICE=$DEVICE \
		sandwichimg/mkimage:$BL_ARCH

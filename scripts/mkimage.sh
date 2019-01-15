#!/bin/sh

set -xe

normalize_arch() {
	case "$1" in
		x86 | i386 | amd64 | x86_64 ) echo 'x86_64';;
		*) echo "$1";;
	esac
}

BL_ARCH="$(normalize_arch $ARCH)"

#cd ../../

mkdir -p target
#ls
#pwd
docker run -ti --privileged -v $(pwd)/target:/target -v $(pwd)/bootloader:/bootloader \
		--env DISTRO=$DISTRO \
		--env DESKTOP=$DESKTOP \
		--env ARCH=$ARCH \
		--env BRANCH=$BRANCH \
		--env DEVICE=$DEVICE \
		sandwichimg/mkimage:$BL_ARCH /bin/sh

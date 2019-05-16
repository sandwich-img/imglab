#!/bin/sh

set -e

normalize_arch() {
	case "$1" in
		arm* ) echo 'armhf' ;;
		x86_64 ) echo 'x86_64';;
		*) echo "$1";;
	esac
}

HOST_ARCH="$(uname -m)"

BL_ARCH="$(normalize_arch $HOST_ARCH)"

mkdir -p target

docker run --rm -i --privileged --network="host" -v $(pwd)/target:/target -v $(pwd)/pxe:/pxe \
	--env DISTRO=$DISTRO \
	--env DESKTOP=$DESKTOP \
	--env ARCH=$ARCH \
	--env BRANCH=$BRANCH \
	--env DEVICE=$DEVICE \
	sandwichimg/mkimage:$BL_ARCH /pxe/setuppxe

normalize_arch() {
	case "$1" in
		x86_64 ) echo 'amd64';;
		arm* | aarch64) echo "armhf";;
	esac
}

_ARCH="$(normalize_arch $HOST_ARCH)"

docker run -d --name pxe-dnsmasq \
	--privileged --network="host" \
	--restart=unless-stopped \
	-v $(pwd)/target/pxe-$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE/boot:/tftpboot \
	-v $(pwd)/target/dnsmasq.conf:/etc/dnsmasq.conf \
	yangxuan8282/dnsmasq:${_ARCH}

docker run -d --name pxe-nfs \
	--privileged --network="host" \
	--restart=unless-stopped \
	-v $(pwd)/target/pxe-$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE:/nfsshare \
	yangxuan8282/nfs-server-vers3:${_ARCH}

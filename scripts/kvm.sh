#!/bin/sh

set -xe

mkdir -p target

docker run -d --name kvm --privileged \
	-p 8080:6080 \
	-v $(pwd)/target:/target \
	-v $(pwd)/kvm:/kvm \
	--env DISTRO=$DISTRO \
	--env DESKTOP=$DESKTOP \
	--env ARCH=$ARCH \
	--env BRANCH=$BRANCH \
	--env DEVICE=$DEVICE \
	sandwichimg/qemu-system:$ARCH

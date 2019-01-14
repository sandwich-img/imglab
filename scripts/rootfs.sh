#!/bin/sh

set -e 

docker build -t local/$DISTRO-$DESKTOP-$ARCH-$BRANCH \
		--build-arg BASE_IMG=sandwichimg/$DISTRO:$ARCH-$BRANCH \
		--build-arg BRANCH=$BRANCH \
		--build-arg DESKTOP=$DESKTOP \
		rootfs/$DISTRO


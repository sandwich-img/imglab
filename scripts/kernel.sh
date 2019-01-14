#!/bin/sh

set -e

docker build -t local/$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE \
		--build-arg ROOTFS=local/$DISTRO-$DESKTOP-$ARCH-$BRANCH \
		--build-arg DISTRO=$DISTRO \
		kernel/$DEVICE

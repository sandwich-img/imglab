#!/bin/sh

set -e

mkdir -p target
docker run --name $DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE-export -i local/$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE sh -c 'cat /etc/*release'
docker export -o ./target/$DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE.tar $DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE-export
docker rm $DISTRO-$DESKTOP-$ARCH-$BRANCH-$DEVICE-export

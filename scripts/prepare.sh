#!/bin/sh

set -e

HOST_ARCH=$(uname -m)

normalize_arch() {
	case "$1" in
		x86_64 | amd64) echo 'x86_64';;
		arm* | aarch64) echo 'arm';;
	esac
}

if [ "$HOST_ARCH" = "x86_64" ] && [ $(normalize_arch $ARCH) != $(normalize_arch $HOST_ARCH) ]; then
	docker run --rm --privileged multiarch/qemu-user-static:register --reset --credential yes
fi

touch prepare

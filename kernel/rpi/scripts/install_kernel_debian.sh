#!/bin/sh

set -e

install_kernel_armhf() {
	if [ ! -f /etc/apt/sources.list.d/raspi.list ]; then
		apt-get update && apt-get install -y dirmngr
		echo "deb http://archive.raspberrypi.org/debian/ stretch main ui" | tee /etc/apt/sources.list.d/raspi.list
		wget -qO - http://archive.raspberrypi.org/debian/raspberrypi.gpg.key | apt-key add -
		apt-get update && apt-get upgrade -y
	fi

	apt-get update && apt-get install -y raspberrypi-kernel
	rm -rf /var/lib/apt/lists/* /tmp/*
}

install_kernel_arm64() {
	apt-get update && apt-get install -y ca-certificates xz-utils
	KERVER=4.14.93.20190115
	wget https://github.com/sakaki-/bcmrpi3-kernel/releases/download/$KERVER/bcmrpi3-kernel-$KERVER.tar.xz -O- | tar -C / -xJf -
	rm -rf /var/lib/apt/lists/* /tmp/*
}

case "$ARCH" in
	armhf ) install_kernel_armhf;;
	arm64 ) install_kernel_arm64;;
esac

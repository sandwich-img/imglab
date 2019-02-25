#!/bin/sh

set -e

get_rpi_firmware() {
	mkdir -p /lib/firmware/brcm

	for wifi_fw in 43430-sdio.bin 43430-sdio.txt 43455-sdio.bin 43455-sdio.clm_blob 43455-sdio.txt ; do
		wget -q -P /lib/firmware/brcm https://github.com/RPi-Distro/firmware-nonfree/raw/master/brcm/brcmfmac${wifi_fw} 
	done

	#for bt_fw in BCM43430A1.hcd BCM4345C0.hcd ; do
	#	wget -q -P /lib/firmware/brcm https://github.com/RPi-Distro/bluez-firmware/raw/master/broadcom/${bt_fw}
	#done
}

install_kernel_armhf() {
	if [ ! -f /etc/apt/sources.list.d/raspi.list ]; then
		apt-get update && apt-get install -y dirmngr
		echo "deb http://archive.raspberrypi.org/debian/ "$DEBIAN_BRANCH" main ui" | tee /etc/apt/sources.list.d/raspi.list
		wget -qO - http://archive.raspberrypi.org/debian/raspberrypi.gpg.key | apt-key add -
		apt-get update && apt-get upgrade -y
	fi

	apt-get update && apt-get install -y raspberrypi-kernel
	rm -rf /var/lib/apt/lists/* /tmp/*
}

install_kernel_arm64() {
	apt-get update && apt-get install -y ca-certificates xz-utils
	KERVER=4.19.23.20190223
	wget https://github.com/sakaki-/bcmrpi3-kernel/releases/download/$KERVER/bcmrpi3-kernel-$KERVER.tar.xz -qO- | tar -C / -xJf -
	rm -rf /var/lib/apt/lists/* /tmp/*
}

get_rpi_firmware

case "$ARCH" in
	armhf ) install_kernel_armhf;;
	arm64 ) install_kernel_arm64;;
esac

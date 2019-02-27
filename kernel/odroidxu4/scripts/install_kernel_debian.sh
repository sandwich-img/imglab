#!/bin/sh

set -e

install_kernel() {
	apt-get update && apt-get install -y dirmngr
	echo "deb http://deb.odroid.in/5422-s bionic main" > /etc/apt/sources.list.d/odroid.list
	apt-key adv --keyserver keyserver.ubuntu.com --recv 2DD567ECD986B59D
	apt-get update && apt-get upgrade -y
	mkdir -p /media/boot
	sed -i 's|/boot|/media/boot|g' /etc/fstab
	cat /etc/fstab
	apt-get install -y linux-odroid-5422
}

install_driver() {
	apt-get install -y xserver-xorg-video-armsoc mali-x11 odroid-platform-5422
}

case DESKTOP in
	base | weston) install_kernel;;
	*) install_kernel&&install_driver;;
esac

rm -rf /var/lib/apt/lists/* /tmp/*

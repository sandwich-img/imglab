#!/bin/sh

set -e

add_user_groups() {
	for USER_GROUP in input spi i2c gpio; do
		groupadd -f -r $USER_GROUP
	done
	for USER_GROUP in adm dialout cdrom audio users sudo video games plugdev input gpio spi i2c netdev; do
		adduser $USER $USER_GROUP
	done
}

add_user_groups

apt-get install -y network-manager

mv /configs/etc/fstab /etc/fstab

#!/bin/sh

set -e

add_user_groups() {
        for USER_GROUP in spi i2c gpio; do
                groupadd -f -r $USER_GROUP
        done
        for USER_GROUP in adm dialout cdrom audio users wheel video games plugdev input gpio spi i2c netdev; do
                adduser $USER $USER_GROUP
        done
}

# take from postmarketOS

setup_openrc_service() {
	setup-udev -n

	for service in devfs dmesg; do
		rc-update -q add $service sysinit
	done

	for service in modules sysctl hostname bootmisc swclock syslog; do
		rc-update -q add $service boot
	done

	for service in dbus haveged sshd wpa_supplicant ntpd local networkmanager; do
		rc-update -q add $service default
	done

	for service in mount-ro killprocs savecache; do
		rc-update -q add $service shutdown
	done

	mkdir -p /run/openrc
	touch /run/openrc/shutdowntime
}

gen_wpa_supplicant_config() {
	sed -i 's/wpa_supplicant_args=\"/wpa_supplicant_args=\" -u -Dnl80211/' /etc/conf.d/wpa_supplicant
	touch /etc/wpa_supplicant/wpa_supplicant.conf
}

gen_syslog_config() {
	sed s/=\"/=\""-C4048 "/  -i /etc/conf.d/syslog
}

apk --no-cache add dbus eudev haveged openssh util-linux coreutils e2fsprogs e2fsprogs-extra shadow

network_groups="iw wireless-tools wpa_supplicant networkmanager"
ARCH=$(apk --print)
case "$ARCH" in
	armv7) network_groups="$network_groups";;
	*) network_groups="$network_groups crda@testing";;
esac

apk --no-cache add $network_groups

setup_openrc_service
add_user_groups
cp /configs/etc/NetworkManager/conf.d/networkmanager.conf /etc/NetworkManager/conf.d/networkmanager.conf
gen_wpa_supplicant_config
gen_syslog_config
cp /configs/etc/fstab /etc/fstab

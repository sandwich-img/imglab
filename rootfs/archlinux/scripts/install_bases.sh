#!/bin/sh

set -e

gen_initcpio() {
	sed -i 's|MODULES=()|MODULES=(ext4)|' /etc/mkinitcpio.conf
	sed -i "/[^HOOKS]/s/HOOKS=.*/HOOKS=(base udev block autodetect modconf filesystems keyboard fsck)/g" /etc/mkinitcpio.conf
	sed -i "/lz4/s/^#//" /etc/mkinitcpio.conf
	mkinitcpio -p linux || true
}

enable_systemd_timesyncd() {
	systemctl enable systemd-timesyncd.service
}

ARCH=$(uname -m)

case $ARCH in
	x86_64) gen_initcpio;;
	arm*| aarch64) enable_systemd_timesyncd;;
esac

pacman -S --noconfirm networkmanager
systemctl enable NetworkManager.service

pacman -S --noconfirm openssh
systemctl enable sshd

mv /configs/etc/fstab /etc/fstab

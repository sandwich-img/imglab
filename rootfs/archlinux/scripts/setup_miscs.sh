#!/bin/sh

set -e

setup_arch_mirrors() {
	echo "Server = ${ARCH_MIRROR}/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
}

setup_alarm_mirrors() {
	echo "Server = ${ALARM_MIRROR}/\$arch/\$repo" > /etc/pacman.d/mirrorlist
}

ARCH=$(uname -m)
case "$ARCH" in
	x86_64) setup_arch_mirrors;;
	arm* | aarch64) setup_alarm_mirrors;;
esac

pacman -Syu --noconfirm
pacman-key --init

case "$ARCH" in
        x86_64) _distro=archlinux;;
        arm* | aarch64) _distro=archlinuxarm;;
esac

pacman-key --populate $_distro

echo "en_US.UTF-8 UTF-8" | tee --append /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf

#setup root password
echo "root:$ROOT_PASSWD" | chpasswd

#add sudo user
useradd -m -G wheel -s /bin/bash "$USER"
echo "${USER}:${PASSWD}" | chpasswd
echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
pacman -S --noconfirm polkit

#setup hostname
echo "$HOSTNAME" > /etc/hostname.new

#setup timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

mv /configs/etc/systemd/system/resize2fs-once.service /etc/systemd/system/resize2fs-once.service
mv /configs/usr/local/bin/resize2fs_once /usr/local/bin/resize2fs_once
systemctl enable resize2fs-once

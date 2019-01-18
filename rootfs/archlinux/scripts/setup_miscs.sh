#!/bin/sh

set -xe

setup_arch_mirrors() {
	sed -i "6i Server = ${ARCH_MIRROR}/\$repo/os/\$arch" /etc/pacman.d/mirrorlist
}

setup_alarm_mirrors() {
	sed -i "6i Server = ${ALARM_MIRROR}/\$repo/os/\$arch" /etc/pacman.d/mirrorlist
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
echo "127.0.0.1	localhost
127.0.1.1 $HOSTNAME.localdomain $HOSTNAME
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters" > /etc/hosts.new

#setup timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime



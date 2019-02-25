#!/bin/sh

set -e

setup_ubuntu_mirrors() {
	cat > /etc/apt/sources.list <<EOF
deb ${UBUNTU_MIRROR} ${DEBIAN_BRANCH} main restricted universe multiverse
deb ${UBUNTU_MIRROR} ${DEBIAN_BRANCH}-updates main restricted universe multiverse
deb ${UBUNTU_MIRROR} ${DEBIAN_BRANCH}-backports main restricted universe multiverse
deb ${UBUNTU_MIRROR} ${DEBIAN_BRANCH}-security main restricted universe multiverse
#deb-src ${UBUNTU_MIRROR} ${DEBIAN_BRANCH} main restricted universe multiverse
#deb-src ${UBUNTU_MIRROR} ${DEBIAN_BRANCH}-updates main restricted universe multiverse
#deb-src ${UBUNTU_MIRROR} ${DEBIAN_BRANCH}-backports main restricted universe multiverse
#deb-src ${UBUNTU_MIRROR} ${DEBIAN_BRANCH}-security main restricted universe multiverse
EOF
}

setup_ports_mirrors() {
	cat > /etc/apt/sources.list <<EOF
deb ${PORTS_MIRROR} ${DEBIAN_BRANCH} main restricted universe multiverse
deb ${PORTS_MIRROR} ${DEBIAN_BRANCH}-updates main restricted universe multiverse
deb ${PORTS_MIRROR} ${DEBIAN_BRANCH}-backports main restricted universe multiverse
deb ${PORTS_MIRROR} ${DEBIAN_BRANCH}-security main restricted universe multiverse
#deb-src ${PORTS_MIRROR} ${DEBIAN_BRANCH} main restricted universe multiverse
#deb-src ${PORTS_MIRROR} ${DEBIAN_BRANCH}-updates main restricted universe multiverse
#deb-src ${PORTS_MIRROR} ${DEBIAN_BRANCH}-backports main restricted universe multiverse
#deb-src ${PORTS_MIRROR} ${DEBIAN_BRANCH}-security main restricted universe multiverse
EOF
}

ARCH=$(dpkg --print-architecture)
case "$ARCH" in
	armhf | arm64) setup_ports_mirrors;;
	*) setup_ubuntu_mirrors;;
esac

apt-get update && apt-get upgrade -y

apt-get install -y locales
echo "en_US.UTF-8 UTF-8" | tee --append /etc/locale.gen
locale-gen

#setup root password
echo "root:$ROOT_PASSWD" | chpasswd

#add sudo user
apt-get install -y sudo
useradd -g sudo -ms /bin/bash $USER
echo "$USER:$PASSWD" | chpasswd
echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
sed -i '7s|^.*$|  PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games"|' /etc/profile

sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' /home/$USER/.bashrc 

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

mv /configs/etc/rc.local /etc/rc.local
mv /configs/firstboot /firstboot

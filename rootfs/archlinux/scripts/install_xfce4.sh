#!/bin/sh

set -xe

aur_install_packages() {
	su ${USER} <<-EOF
	packer -S --noconfirm $@
	EOF
}

ARCH=$(uname -m)
case $ARCH in
	x86_64) . /scripts/install_drivers.sh && install_drivers_x86_64 && config_touchpad;;
	*) . /scripts/install_drivers.sh && install_drivers_arm;;
esac

pacman -S --noconfirm xorg-server xorg-xrefresh xfce4 xfce4-goodies \
				xarchiver gvfs gvfs-smb sshfs \
				ttf-roboto arc-gtk-theme \
				blueman pulseaudio-bluetooth pavucontrol \
				network-manager-applet gnome-keyring

systemctl disable dhcpcd

pacman -S --noconfirm sddm

case $ARCH in
	x86_64) strip --remove-section=.note.ABI-tag /usr/lib64/libQt5Core.so.5;;
	*) strip --remove-section=.note.ABI-tag /usr/lib/libQt5Core.so.5;;
esac

sddm --example-config > /etc/sddm.conf
sed -i "s/^User=/User=${USER}/" /etc/sddm.conf
sed -i "s/^Session=/Session=xfce.desktop/" /etc/sddm.conf
systemctl enable sddm.service

aur_install_packages ttf-roboto-mono
pacman -S --noconfirm curl
wget https://github.com/yangxuan8282/PKGBUILDs/raw/master/pkgs/paper-icon-theme-1.5.0-2-any.pkg.tar.xz
pacman -U --noconfirm paper-icon-theme-1.5.0-2-any.pkg.tar.xz && rm -f paper-icon-theme-1.5.0-2-any.pkg.tar.xz

mkdir -p /usr/share/wallpapers
curl https://img2.goodfon.com/original/2048x1820/3/b6/android-5-0-lollipop-material-5355.jpg \
				--output /usr/share/wallpapers/android-5-0-lollipop-material-5355.jpg
su $USER sh -c "mkdir -p /home/${USER}/.config && \
wget https://github.com/yangxuan8282/dotfiles/archive/master.tar.gz -O- | \
	tar -C /home/${USER}/.config -xzf - --strip=2 dotfiles-master/config"

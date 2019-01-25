#!/bin/sh

set -e

ARCH=$(uname -m)
case $ARCH in
        x86_64) . /scripts/install_drivers.sh && install_drivers_x86_64 && config_touchpad;;
esac

pacman -S --noconfirm xorg xorg-server deepin deepin-terminal chromium htop
sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-deepin-greeter/' /etc/lightdm/lightdm.conf
systemctl enable lightdm.service

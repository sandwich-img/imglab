#!/bin/sh

set -e

ARCH=$(uname -m)
case $ARCH in
        x86_64) . /scripts/install_drivers.sh && install_drivers_x86_64 && config_touchpad;;
esac

pacman -S --noconfirm mate mate-extra network-manager-applet gnome-keyring
pacman -S --noconfirm sddm
systemctl enable sddm.service

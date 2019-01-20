#!/bin/sh

set -xe

pacman -S --noconfirm mate mate-extra network-manager-applet gnome-keyring
pacman -S --noconfirm sddm
systemctl enable sddm.service

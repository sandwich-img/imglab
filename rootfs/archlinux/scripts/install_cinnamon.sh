#!/bin/sh

set -xe

pacman -S --noconfirm cinnamon gnome-keyring
pacman -S --noconfirm sddm
systemctl enable sddm.service

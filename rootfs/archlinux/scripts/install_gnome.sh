#!/bin/sh

set -xe

pacman -S --noconfirm gnome
pacman -S --noconfirm sddm
systemctl enable sddm.service

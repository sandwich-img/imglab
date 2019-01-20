#!/bin/sh

set -xe

pacman -S --noconfirm xorg-server xorg-xrefresh \
		plasma-meta plasma-wayland-session konsole chromium
pacman -S --noconfirm sddm
systemctl enable sddm.service

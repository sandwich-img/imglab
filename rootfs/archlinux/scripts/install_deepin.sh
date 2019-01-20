#!/bin/sh

set -xe

pacman -S --noconfirm xorg xorg-server deepin deepin-terminal chromium htop
sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-deepin-greeter/' /etc/lightdm/lightdm.conf
systemctl enable lightdm.service

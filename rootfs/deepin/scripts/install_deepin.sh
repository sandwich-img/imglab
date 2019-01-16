#!/bin/sh

set -e

apt-get install -y xserver-xorg-video-all

apt-get install -y --no-install-recommends dde
apt-get install -y --no-install-recommends at-spi2-core dconf-cli dconf-editor \
		gnome-themes-standard gtk2-engines-murrine gtk2-engines-pixbuf

apt-get install -y deepin-calculator deepin-image-viewer deepin-screenshot \
		deepin-system-monitor deepin-terminal deepin-movie deepin-music \
		gedit sudo lightdm

apt-get install -y fonts-arphic-uming plymouth-themes kbd busybox

rm -rf /var/lib/apt/lists/* /tmp/*

#!/bin/sh

set -xe

echo "deb http://archive.raspberrypi.org/debian/ stretch main ui" | tee /etc/apt/sources.list.d/raspi.list
apt-key adv --keyserver keyserver.ubuntu.com --recv 82B129927FA3303E 
apt-get update && apt-get upgrade -y

mv /configs/etc/default/keyboard /etc/default/keyboard

apt-get install -y dhcpcd5 wpasupplicant net-tools wireless-tools
mv /configs/etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
apt-get install -y raspberrypi-ui-mods accountsservice lxsession lxterminal screen geany fonts-droid-fallback

systemctl set-default graphical.target
sed -i "s/pi/$USER/" /etc/systemd/system/autologin@.service
ln -fs /etc/systemd/system/autologin@.service /etc/systemd/system/getty.target.wants/getty@tty1.service
sed /etc/lightdm/lightdm.conf -i -e "s/^\(#\|\)autologin-user=.*/autologin-user=$USER/"
systemctl enable dhcpcd.service

rm -rf /var/lib/apt/lists/* /tmp/*

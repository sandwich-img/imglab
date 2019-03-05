#!/bin/sh

set -e

apk add --no-cache xorg-server xf86-video-fbdev xf86-input-libinput

apk add --no-cache mate-desktop-environment dbus-x11 lxdm

sed -i "s/^# autologin=dgod/autologin=$USER/" /etc/lxdm/lxdm.conf
sed -i 's|^# session=/usr/bin/startlxde|session=/usr/bin/mate-session|' /etc/lxdm/lxdm.conf

rc-update add lxdm default

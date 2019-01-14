#!/bin/sh

set -e

apk add --no-cache xorg-server xf86-video-fbdev xf86-input-libinput

apk add --no-cache xfce4 xfce4-mixer xfce4-wavelan-plugin lxdm paper-icon-theme arc-theme@testing \
	gvfs gvfs-smb sshfs \
       	network-manager-applet gnome-keyring

mkdir -p /usr/share/wallpapers &&
curl https://img2.goodfon.com/original/2048x1820/3/b6/android-5-0-lollipop-material-5355.jpg \
	--output /usr/share/wallpapers/android-5-0-lollipop-material-5355.jpg

su $USER sh -c "mkdir -p /home/${USER}/.config && \
wget https://github.com/yangxuan8282/dotfiles/archive/master.tar.gz -O- | \
	tar -C /home/${USER}/.config -xzf - --strip=2 dotfiles-master/alpine-config"

sed -i "s|/home/pi|/home/$USER|" /home/${USER}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
sed -i "s/^# autologin=dgod/autologin=$USER/" /etc/lxdm/lxdm.conf
sed -i 's|^# session=/usr/bin/startlxde|session=/usr/bin/startxfce4|' /etc/lxdm/lxdm.conf

rc-update add lxdm default

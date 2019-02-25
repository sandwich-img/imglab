#!/bin/sh

set -xe

ARCH=$(uname -m)

case $ARCH in
	i[3456]86 | x86_64 ) DRI_DRIVER="mesa-dri-intel";;
	arm* | aarch64 ) DRI_DRIVER="mesa-dri-vc4@testing";;
esac

apk add --no-cache weston-xwayland@testing xorg-server-xwayland \
	weston-backend-drm@testing weston-clients@testing weston@testing \
	weston-shell-desktop@testing weston-terminal@testing "$DRI_DRIVER"

gpasswd -a $USER weston-launch

mv /configs/etc/profile.d/xdg_runtime_dir.sh /etc/profile.d/xdg_runtime_dir.sh
su $USER sh -c "mkdir -p /home/${USER}/.config && cp /configs/dotfiles/weston.ini /home/${USER}/.config/weston.ini"

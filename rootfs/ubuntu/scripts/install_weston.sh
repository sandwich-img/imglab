#!/bin/sh

set -e

apt-get install -y weston xwayland

apt-get install -y network-manager
# dirty fix for wired interface
mv /usr/lib/NetworkManager/conf.d/10-globally-managed-devices.conf /usr/lib/NetworkManager/conf.d/10-globally-managed-devices.conf.orig

su $USER sh -c "mkdir -p /home/${USER}/.config && cp /configs/dotfiles/weston.ini /home/${USER}/.config/weston.ini"

rm -rf /var/lib/apt/lists/* /tmp/*

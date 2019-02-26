#!/bin/sh

set -e

apt-get install -y weston xwayland

apt-get install -y network-manager

su $USER sh -c "mkdir -p /home/${USER}/.config && cp /configs/dotfiles/weston.ini /home/${USER}/.config/weston.ini"

rm -rf /var/lib/apt/lists/* /tmp/*

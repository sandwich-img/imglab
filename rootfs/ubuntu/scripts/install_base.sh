#!/bin/sh

set -e

apt-get install -y network-manager
# dirty fix for wired interface
mv /usr/lib/NetworkManager/conf.d/10-globally-managed-devices.conf /usr/lib/NetworkManager/conf.d/10-globally-managed-devices.conf.orig

rm -rf /var/lib/apt/lists/* /tmp/*

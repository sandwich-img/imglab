#!/bin/sh

set -e

/etc/init.d/dbus start

apt-get install -y dirmngr
echo "deb http://repo.ubports.com/ $DEBIAN_BRANCH main" | tee /etc/apt/sources.list.d/ubports.list
wget -qO - http://repo.ubports.com/keyring.gpg | apt-key add -
apt-get update && apt-get upgrade -y --allow-downgrades
apt-get install -y unity8-desktop-session
# dirty fix for wired interface
mv /usr/lib/NetworkManager/conf.d/10-globally-managed-devices.conf /usr/lib/NetworkManager/conf.d/10-globally-managed-devices.conf.orig

rm -rf /var/lib/apt/lists/* /tmp/*

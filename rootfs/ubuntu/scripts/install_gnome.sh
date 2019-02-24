#!/bin/sh

set -e

/etc/init.d/dbus start
apt-get install -y gnome-core
#fix gnome-terminal unable to open, https://bbs.archlinux.org/viewtopic.php?id=180103
echo "LANG=en_US.UTF-8" >> /etc/default/locale

rm -rf /var/lib/apt/lists/* /tmp/*

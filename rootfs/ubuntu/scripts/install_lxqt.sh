#!/bin/sh

set -e

/etc/init.d/dbus start
apt-get install -y --no-install-recommends lubuntu-desktop

rm -rf /var/lib/apt/lists/* /tmp/*

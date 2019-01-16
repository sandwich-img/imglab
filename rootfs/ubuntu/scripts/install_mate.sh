#!/bin/sh

set -e

/etc/init.d/dbus start
apt-get install -y ubuntu-mate-core

rm -rf /var/lib/apt/lists/* /tmp/*

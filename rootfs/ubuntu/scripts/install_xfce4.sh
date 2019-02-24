#!/bin/sh

set -e

/etc/init.d/dbus start
apt-get install -y xubuntu-core

rm -rf /var/lib/apt/lists/* /tmp/*

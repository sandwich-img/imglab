#!/bin/sh

set -e

apt-get install -y network-manager

rm -rf /var/lib/apt/lists/* /tmp/*

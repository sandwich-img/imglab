#!/bin/sh

set -e

apt-get install -y weston xwayland

rm -rf /var/lib/apt/lists/* /tmp/*

#!/bin/sh

set -e

apt-get update && apt-get install -y linux-image-generic

rm -rf /var/lib/apt/lists/* /tmp/*

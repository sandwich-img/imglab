#!/bin/sh

set -e

ARCH=$(apk --print)

kernel_flavors="linux-rpi"

case "$ARCH" in
	arm* ) kernel_flavors="$kernel_flavors linux-rpi2";;
esac

apk --update --no-cache add $kernel_flavors

cd /usr/lib/linux-*/
find . -type f -regex ".*\.dtbo\?$" -exec install -Dm644 {} /boot/{} \;

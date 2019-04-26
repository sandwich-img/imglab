#!/bin/sh

set -e

case $ARCH in
	x86 | x86_64) EXTRAS="grub grub-bios grub-efi efibootmgr@testing" ;;
esac

apk --update --no-cache add linux-vanilla $EXTRAS

#!/bin/sh

set -e

apk add --no-cache xorg-server xf86-video-fbdev xf86-input-libinput

apk add --no-cache mate-desktop-environment dbus-x11 lxdm



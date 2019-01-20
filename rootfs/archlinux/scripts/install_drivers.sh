#!/bin/sh

set -e

install_drivers_x86_64() {
	pacman -S --noconfirm xf86-video-ati xf86-video-intel xf86-video-nouveau xf86-video-vesa
	pacman -S --noconfirm acpi xf86-input-libinput
}

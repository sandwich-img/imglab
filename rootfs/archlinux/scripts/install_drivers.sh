#!/bin/sh

set -e

install_drivers_x86_64() {
	pacman -S --noconfirm xf86-video-ati xf86-video-intel xf86-video-nouveau xf86-video-vesa
	pacman -S --noconfirm linux-headers broadcom-wl-dkms
	pacman -S --noconfirm acpi xf86-input-libinput
}

install_drivers_arm() {
	pacman -S --noconfirm xf86-video-fbdev
}

config_touchpad() {
	mkdir -p /etc/X11/xorg.conf.d
	cat > /etc/X11/xorg.conf.d/40-libinput.conf <<'EOF'
Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
        Option "Tapping" "on"
        Option "ClickMethod" "clickfinger"
        Option "NaturalScrolling" "true"
EndSection
EOF
}

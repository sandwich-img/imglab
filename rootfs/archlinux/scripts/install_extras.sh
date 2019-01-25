#!/bin/sh

set -e

install_packer() {
        pacman -S --noconfirm wget

        su ${USER} sh -c 'cd /tmp && \
        wget https://github.com/archlinuxarm/PKGBUILDs/raw/a1ad4045699093b1cf4911b93cbf8830ee972639/aur/packer/PKGBUILD && \
        makepkg -si --noconfirm'
}

install_packer

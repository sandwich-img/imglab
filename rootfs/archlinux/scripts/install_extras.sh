#!/bin/sh

set -e

pacman -S --noconfirm openssh
systemctl enable sshd

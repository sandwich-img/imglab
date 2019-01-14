#!/bin/sh

set -e

apk add --no-cache nano htop bash bash-completion curl tar
apk add --no-cache ca-certificates wget && update-ca-certificates

su $USER sh -c 'cp -r /configs/dotfiles/. $HOME'

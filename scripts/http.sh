#!/bin/sh

set -e

normalize_arch() {
        case "$1" in
                x86_64 ) echo 'x64';;
                arm| aarch64) echo 'armhf';;
        esac
}

HOST_ARCH=$(uname -m)

_ARCH="$(normalize_arch $HOST_ARCH)"

mkdir -p target

docker run -d --name http -p 8080:80 -v $(pwd)/target:/www yangxuan8282/darkhttpd:${_ARCH}

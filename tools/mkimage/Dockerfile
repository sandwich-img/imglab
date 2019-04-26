FROM debian:stretch-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN set -xe \
  && apt-get update \
  && apt-get install --no-install-recommends -y syslinux-common syslinux-efi libguestfs-tools zip wget xxd u-boot-tools \
  && rm -rf /var/lib/apt/lists/*

ARG ROOTFS=local/$DISTRO-$DESKTOP-$ARCH-$BRANCH
FROM $ROOTFS

COPY scripts /scripts

ARG DISTRO=alpine

ENV DISTRO=$DISTRO

RUN chmod +x /scripts/*

RUN /scripts/install_kernel_$DISTRO.sh

ARG ROOTFS=local/$DISTRO-$DESKTOP-$ARCH-$BRANCH
FROM $ROOTFS

COPY scripts /scripts

ARG DISTRO=ubuntu
ARG ARCH=armhf
ARG DESKTOP=base

ENV DISTRO=$DISTRO \
    ARCH=$ARCH \
    DESKTOP=$DESKTOP

RUN chmod +x /scripts/*

RUN /scripts/install_kernel_$DISTRO.sh

ARG ROOTFS=local/$DISTRO-$DESKTOP-$ARCH-$BRANCH
FROM $ROOTFS

COPY scripts /scripts

ARG DISTRO=alpine
ARG ARCH=x86

ENV DISTRO=$DISTRO \
    ARCH=$ARCH

RUN chmod +x /scripts/*

RUN /scripts/install_kernel_$DISTRO.sh

ARG BASE_IMG=sandwichimg/$DISTRO:$ARCH-$BRANCH
FROM $BASE_IMG

COPY scripts /scripts
COPY configs /configs

ARG BRANCH=edge
ARG DESKTOP=base

ENV USER=alpine \
    PASSWD=alpine \
    ROOT_PASSWD=toor \
    HOME=/home/alpine \
    HOSTNAME=alpine \
    TIMEZONE=Asia/Shanghai \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8" \
    ALPINE_MIRROR=http://dl.alpinelinux.org/alpine \
    ALPINE_BRANCH=$BRANCH \
    DESKTOP=$DESKTOP

RUN find /scripts -name '*.sh' -exec chmod a+x {} +

RUN /scripts/setup_miscs.sh

RUN /scripts/install_bases.sh

RUN /scripts/install_drivers.sh

RUN /scripts/install_extras.sh

RUN /scripts/install_$DESKTOP.sh

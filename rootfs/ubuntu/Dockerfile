ARG BASE_IMG=sandwichimg/$DISTRO:$ARCH-$BRANCH
FROM $BASE_IMG

COPY scripts /scripts
COPY configs /configs

ARG BRANCH=bionic
ARG DESKTOP=base

ENV USER=ubuntu \
    PASSWD=ubuntu \
    ROOT_PASSWD=toor \
    HOME=/home/ubuntu \
    HOSTNAME=ubuntu \
    TIMEZONE=Asia/Shanghai \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8" \
    UBUNTU_MIRROR=http://archive.ubuntu.com/ubuntu/ \
    PORTS_MIRROR=http://ports.ubuntu.com/ \
    DEBIAN_BRANCH=$BRANCH \
    DEBIAN_FRONTEND=noninteractive \
    DESKTOP=$DESKTOP

RUN find /scripts -name '*.sh' -exec chmod a+x {} +

RUN /scripts/setup_miscs.sh

RUN /scripts/install_bases.sh

RUN /scripts/install_drivers.sh

RUN /scripts/install_extras.sh

RUN /scripts/install_$DESKTOP.sh

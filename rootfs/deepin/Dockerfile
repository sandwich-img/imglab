ARG BASE_IMG=sandwichimg/$DISTRO:$ARCH-$BRANCH
FROM $BASE_IMG

COPY scripts /scripts
COPY configs /configs

ARG BRANCH=stretch
ARG DESKTOP=base

ENV USER=deepin \
    PASSWD=deepin \
    ROOT_PASSWD=toor \
    HOME=/home/deepin \
    HOSTNAME=deepin \
    TIMEZONE=Asia/Shanghai \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8" \
    DEEPIN_MIRROR=http://packages.deepin.com/deepin/ \
    DEEPIN_BRANCH=$BRANCH \
    DEBIAN_FRONTEND=noninteractive \
    DESKTOP=$DESKTOP

RUN find /scripts -name '*.sh' -exec chmod a+x {} +

RUN /scripts/setup_miscs.sh

RUN /scripts/install_bases.sh

RUN /scripts/install_drivers.sh

RUN /scripts/install_extras.sh

RUN /scripts/install_$DESKTOP.sh

ARG BASE_IMG=sandwichimg/$DISTRO:$ARCH-$BRANCH
FROM $BASE_IMG

COPY scripts /scripts
COPY configs /configs

ARG DESKTOP=base

ENV USER=arch \
    PASSWD=arch \
    ROOT_PASSWD=toor \
    HOME=/home/arch \
    HOSTNAME=archlinux \
    TIMEZONE=Asia/Shanghai \
    ARCH_MIRROR=https://mirrors.edge.kernel.org/archlinux \
    ALARM_MIRROR=http://ca.us.mirror.archlinuxarm.org \
    DESKTOP=$DESKTOP

RUN find /scripts -name '*.sh' -exec chmod a+x {} +

RUN /scripts/setup_miscs.sh

RUN /scripts/install_bases.sh

RUN /scripts/install_drivers.sh

RUN /scripts/install_extras.sh

RUN /scripts/install_$DESKTOP.sh

FROM sandwichimg/alpine:x86_64-edge

COPY mkimage /mkimage
COPY repositories /etc/apk/repositories

ENV DISTRO=alpine \
    DESKTOP=base \
    ARCH=x86_64 \
    BRANCH=edge \
    DEVICE=generic

RUN apk --update --no-cache add syslinux uboot-tools dosfstools e2fsprogs parted findutils util-linux tar zip vim
RUN apk add --no-cache ca-certificates wget && update-ca-certificates

CMD ["/mkimage"]

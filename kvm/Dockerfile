ARG BASE_IMG=multiarch/alpine:$ARCH-edge
FROM $BASE_IMG

COPY runqemu /

RUN set -xe \
  && echo "http://dl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk --update --no-cache add qemu-img qemu-system-x86_64 qemu-system-i386 qemu-system-arm qemu-system-aarch64 novnc bash unzip \
  && ln -s /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html

EXPOSE 6080

CMD ["/runqemu"]

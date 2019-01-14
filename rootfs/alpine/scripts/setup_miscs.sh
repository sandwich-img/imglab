#!/bin/sh

set -e

setup_mirrors() {
        for ALPINE_REPOS in main community ; do
                echo ${ALPINE_MIRROR}/${ALPINE_BRANCH}/${ALPINE_REPOS} >> /etc/apk/repositories
        done

        echo "@testing ${ALPINE_MIRROR}/edge/testing" >> /etc/apk/repositories
}

setup_mirrors

#setup root password
echo "root:$ROOT_PASSWD" | chpasswd

#add sudo user
apk --update --no-cache add sudo
addgroup $USER
adduser -G $USER -s /bin/bash -D $USER
echo "$USER:$PASSWD" | chpasswd
echo "$USER ALL=NOPASSWD: ALL" >> /etc/sudoers

#setup hostname
echo "$HOSTNAME" > /etc/hostname.new
echo "127.0.0.1	$HOSTNAME $HOSTNAME.localdomain
::1		$HOSTNAME $HOSTNAME.localdomain" > /etc/hosts.new

#setup timezone
apk --update --no-cache add tzdata
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

mv /configs/etc/local.d/firstboot.start /etc/local.d/firstboot.start
mv /configs/etc/motd /etc/motd

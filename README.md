imglab, build linux img in docker way
===

this project build raspbian style img with docker

the img contain two partitions

- one FAT for /boot
- one EXT4 for /

> for arm boot size is 100MB, for x86/x86_64 is 500MB

flash with dd and auto resize when firstboot


```

+---------------------------+
|         bootloader        |
|                           |
+---------------------------+
+---------------------------+
|           kernel          |
|                           |
+---------------------------+
+---------------------------+
|           rootfs          |
|                           |
+---------------------------+
```

deps: `make`, `docker`

> support build host: x86_64 and arm, not support x86

> support target: arm, x86, x86_64

run:

```
DISTRO=alpine DESKTOP=base ARCH=aarch64 BRANCH=edge DEVICE=rpi make image
```

support matrix

|Distros  |arch                               |desktop     |branch           |devices                     |login|
|---------|-----------------------------------|------------|-----------------|----------------------------|-----|
|alpine   |armhf, armv7, aarch64, x86, x86_64 |base, xfce4,weston |v3.8, v3.9, edge |rpi, s905, generic          |alpine:alpine|
|archlinux|aarch64, x86_64                    |base, budgie, cinnamon, deepin, gnome, kde, mate, xfce4|rolling          |rpi, s905, generic          |arch:arch|
|debian   |armhf, arm64, i386, amd64          |base, pixel, weston |stretch          |rpi, s905, generic          |debian:debian|
|deepin   |i386, amd64                        |base, deepin|panda            |generic                     |deepin:deepin|
|ubuntu   |armhf, arm64, i386, amd64          |base, gnome, mate, xfce4  |bionic           |rpi, s905, generic          |ubuntu:ubuntu|


> ⚠ deepin desktop only support amd64 


> ⚠ alpine xfce4 only work on v3.8 branch


> ⛔ rpi archlinux xfce4 is broken

> ubuntu disco rootfs need fix

more distros will add later


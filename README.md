imghub, build linux img in docker way
===

this project build raspbian style img with docker, for different devices build same arch and distros can share rootfs
( the img contain two partitions, one fat for /boot, another one is ext4 for /, for arm boot size is 100MB, for x86/x86_64 is 500MB, flash with dd and auto resize when firstboot )


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

|Distros  |arch                               |desktop     |branch           |devices                     |
|---------|-----------------------------------|------------|-----------------|----------------------------|
|alpine   |armhf, armv7, aarch64, x86, x86_64 |base, xfce4 |v3.8, v3.9, edge |rpi, s905, generic          |
|archlinux|aarch64, x86_64                    |base, xfce4 |rolling          |rpi, s905, generic                     |
|debian   |armhf, arm64, i386, amd64          |base, pixel |stretch          |WIP(s905 not add kernel yet)|
|deepin   |i386, amd64                        |base, deepin|panda            |generic                     |
|ubuntu   |armhf, arm64, i386, amd64          |base, mate  |bionic           |generic                     |


> deepin desktop only support amd64 

> rpi archlinux xfce4 is broken

> alpine xfce4 only work on v3.8 branch

more distros will add later


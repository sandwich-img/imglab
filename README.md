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

> support build on x86_64 and arm, not support x86

run(as root):

```
DISTRO=alpine DESKTOP=base ARCH=aarch64 BRANCH=edge DEVICE=rpi make image
```

to build arm img on x86_64, need configure binfmt-support on the host

```
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

support matrix

|Distros|arch                               |desktop    |branch           |devices                     |
|-------|-----------------------------------|-----------|-----------------|----------------------------|
|alpine |armhf, armv7, aarch64, x86, x86_64 |base, xfce4|v3.8, v3.9, edge |rpi, s905, generic          |
|debian |armhf, arm64, i386, amd64          |base, pixel|stretch          |WIP(s905 not add kernel yet)|

more distros will add later


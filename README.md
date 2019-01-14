deps(alpine x86_64):

```
docker grub grub-bios grub-efi efibootmgr dosfstools e2fsprogs findutils util-linux make tar zip
```

run(as root):

```
DISTRO=alpine DESKTOP=base ARCH=aarch64 BRANCH=edge DEVICE=rpi make image
```

to build arm img on amd64, need configure binfmt-support on the host

```
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

support matrix

|Distros|arch                               |desktop    |devices                   |
|-------|-----------------------------------|-----------|--------------------------|
|alpine |armhf, armv7, aarch64, x86, x86_64 |base, xfce4|rpi, s905, generic        |
|debian |armhf, arm64, i386, amd64          |base, pixel|WIP(pixel not add arm yet)|

more distros will add later


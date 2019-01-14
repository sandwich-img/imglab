.PHONY: rootfs
rootfs:
	./scripts/rootfs.sh

.PHONY: kernel
kernel: rootfs
	./scripts/kernel.sh

export:
	./scripts/export.sh

image: kernel export
	./scripts/mkimage.sh	

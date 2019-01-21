.PHONY: rootfs
rootfs:
	./scripts/rootfs.sh

.PHONY: kernel
kernel: rootfs
	./scripts/kernel.sh

export: kernel
	./scripts/export.sh

image: export
	./scripts/mkimage.sh

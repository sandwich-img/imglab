prepare:
	./scripts/prepare.sh

.PHONY: rootfs
rootfs: prepare
	./scripts/rootfs.sh

.PHONY: kernel
kernel: rootfs
	./scripts/kernel.sh

export: kernel
	./scripts/export.sh

image: export
	./scripts/mkimage.sh

.PHONY: pxe
pxe: export
	./scripts/pxe.sh

.PHONY: kvm
kvm: image
	./scripts/kvm.sh

http:
	./scripts/http.sh

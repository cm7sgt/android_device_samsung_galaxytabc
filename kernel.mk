KERNEL_BUILD := out/target/product/galaxytab/kernel_build
KERNEL_TOOLCHAIN := /opt/toolchains/arm-2009q3/bin/arm-none-eabi-

PRODUCT_COPY_FILES += \
    $(KERNEL_BUILD)/fs/cifs/cifs.ko:system/lib/modules/2.6.35.7/cifs.ko \
    $(KERNEL_BUILD)/drivers/net/tun.ko:system/lib/modules/2.6.35.7/tun.ko

# kernel modules we built
PRODUCT_COPY_FILES += \
    $(KERNEL_BUILD)/crypto/ansi_cprng.ko:recovery/root/lib/modules/ansi_cprng.ko \
    $(KERNEL_BUILD)/drivers/scsi/scsi_wait_scan.ko:recovery/root/lib/modules/scsi_wait_scan.ko \
    $(KERNEL_BUILD)/drivers/misc/vibtonz/vibrator.ko:recovery/root/lib/modules/vibrator.ko \
    $(KERNEL_BUILD)/drivers/bluetooth/bthid/bthid.ko:recovery/root/lib/modules/bthid.ko \
    $(KERNEL_BUILD)/drivers/net/wireless/bcm4329/dhd.ko:system/lib/modules/2.6.35.7/dhd.ko

$(KERNEL_BUILD)/.config:
	mkdir -p $(KERNEL_BUILD)
	$(MAKE) -C kernel/samsung/2.6.35-tab LOCALVERSION= ARCH=arm O=$(ANDROID_BUILD_TOP)/$(PRODUCT_OUT)/kernel_build p1_cm7_defconfig


KERNEL_MODULES := \
$(KERNEL_BUILD)/fs/cifs/cifs.ko \
$(KERNEL_BUILD)/drivers/net/tun.ko \
$(KERNEL_BUILD)/crypto/ansi_cprng.ko \
$(KERNEL_BUILD)/drivers/scsi/scsi_wait_scan.ko \
$(KERNEL_BUILD)/drivers/misc/vibtonz/vibrator.ko \
$(KERNEL_BUILD)/drivers/bluetooth/bthid/bthid.ko \
$(KERNEL_BUILD)/drivers/net/wireless/bcm4329/dhd.ko

$(KERNEL_MODULES): $(KERNEL_BUILD)/.config
	@echo "BUILDING MODULES"
	$(MAKE) -C kernel/samsung/2.6.35-tab LOCALVERSION= ARCH=arm O=$(ANDROID_BUILD_TOP)/$(PRODUCT_OUT)/kernel_build CROSS_COMPILE=$(KERNEL_TOOLCHAIN) modules

$(KERNEL_BUILD)/arch/arm/boot/zImage: out/target/product/galaxytab/recovery/root.ts $(KERNEL_BUILD)/.config
	@echo "BUILDING KERNEL"
	mkdir -p out/target/product/galaxytab/recovery/root/misc
	mv out/target/product/galaxytab/recovery/root/etc/* out/target/product/galaxytab/recovery/root/misc
	rm -rfv out/target/product/galaxytab/recovery/root/etc
	cp -v out/target/product/galaxytab/root/default.prop out/target/product/galaxytab/recovery/root/default.prop
	$(MAKE) -C kernel/samsung/2.6.35-tab LOCALVERSION= ARCH=arm O=$(ANDROID_BUILD_TOP)/$(PRODUCT_OUT)/kernel_build CROSS_COMPILE=$(KERNEL_TOOLCHAIN)

out/target/product/galaxytab/kernel: $(KERNEL_BUILD)/arch/arm/boot/zImage
	$(ACP) $(KERNEL_BUILD)/arch/arm/boot/zImage out/target/product/galaxytab/kernel


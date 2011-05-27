#
# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# This is the product configuration for a generic GSM passion,
# not specialized for any geography.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

## (1) First, the most specific values, i.e. the aspects that are specific to GSM

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/samsung/GT-P1000/GT-P1000-vendor.mk)

## (3) Finally, the least specific parts, i.e. the non-GSM-specific aspects

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=200 \
    ro.sf.hwrotation=90 \
    rild.libpath=/system/lib/libsec-ril.so \
    rild.libargs=-d[SPACE]/dev/s3c2410_serial3 \
    ro.telephony.ril_class=samsung \
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=15 \
    ro.wifi.channels=13 \
    ro.url.safetylegal=

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.startheapsize=8m \
    dalvik.vm.heapsize=48m \
    dalvik.vm.execution-mode=int:jit

# Galaxy S uses high-density artwork where available
PRODUCT_LOCALES += hdpi

# For emmc phone storage
PRODUCT_PROPERTY_OVERRIDES += \
    ro.phone_storage = 1 \
    ro.additionalmounts=/mnt/emmc

# For mobiledatainterfaces
PRODUCT_PROPERTY_OVERRIDES += \
    mobiledata.interfaces = eth0,pdp0

# For GPS
PRODUCT_PROPERTY_OVERRIDES += \
    ro.gps.soket = /data/gpspipe

# For FM-Radio
#PRODUCT_PROPERTY_OVERRIDES += \
#    fmradio.device = fmradio

#For RIL
PRODUCT_PROPERTY_OVERRIDES += \
    phone.ril.classname = com.android.internal.telephony.SamsungRIL

DEVICE_PACKAGE_OVERLAYS += device/samsung/galaxytab/overlay

# media profiles and capabilities spec
$(call inherit-product, device/samsung/galaxytab/media_a1026.mk)

# media config xml file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml

# additional postinit scripts
PRODUCT_COPY_FILES += \
    device/samsung/galaxytab/prebuilt/etc/init.d/10htccopyright:system/etc/init.d/10htccopyright

# Install the features available on this device.
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    $(LOCAL_PATH)/prebuilt/etc/asound.conf:system/etc/asound.conf \
    $(LOCAL_PATH)/prebuilt/etc/vold.fstab:system/etc/vold.fstab \
    $(LOCAL_PATH)/prebuilt/usr/keylayout/p1_keyboard.kl:system/usr/keylayout/p1_keyboard.kl

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/initramfs/init.smdkc110.rc:root/init.smdkc110.rc \
    $(LOCAL_PATH)/initramfs/init.rc:root/init.rc \
    $(LOCAL_PATH)/initramfs/lpm.rc:root/lpm.rc \
    $(LOCAL_PATH)/initramfs/recovery.rc:recovery/root/recovery.rc \
    $(LOCAL_PATH)/initramfs/recovery.fstab:recovery/root/misc/recovery.fstab \
    $(LOCAL_PATH)/initramfs/ueventd.rc:root/ueventd.rc


# GSM APN list override one in common_full
PRODUCT_COPY_FILES += \
    vendor/cyanogen/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# These are the OpenMAX IL configuration files
#PRODUCT_COPY_FILES += \
#    device/samsung/common/sec_mm/sec_omx/sec_omx_core/secomxregistry:system/etc/secomxregistry

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs

PRODUCT_PACKAGES += \
    libaudio

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


#out/target/product/galaxytab/kernel: out/target/product/galaxytab/recovery.img $(KERNEL_BUILD)/.config build_kernel

$(KERNEL_BUILD)/arch/arm/boot/zImage: out/target/product/galaxytab/recovery/root.ts $(KERNEL_BUILD)/.config
	@echo "BUILDING KERNEL"
	rm -rfv out/target/product/galaxytab/recovery/root/etc
	cp -v out/target/product/galaxytab/root/default.prop out/target/product/galaxytab/recovery/root/default.prop
	$(MAKE) -C kernel/samsung/2.6.35-tab LOCALVERSION= ARCH=arm O=$(ANDROID_BUILD_TOP)/$(PRODUCT_OUT)/kernel_build CROSS_COMPILE=$(KERNEL_TOOLCHAIN)

out/target/product/galaxytab/kernel: $(KERNEL_BUILD)/arch/arm/boot/zImage
	$(ACP) $(KERNEL_BUILD)/arch/arm/boot/zImage out/target/product/galaxytab/kernel


$(call inherit-product, build/target/product/full.mk)

PRODUCT_NAME := full_galaxytab
PRODUCT_DEVICE := galaxytab
PRODUCT_MODEL := GT-P1000
PRODUCT_BOARD := p1
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := Samsung
TARGET_IS_GALAXYS := true


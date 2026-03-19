#
# Copyright (C) 2026 Michael Owusu Ntim
# SPDX-License-Identifier: Apache-2.0
#

# Inherit Platform Configs
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, hardware/samsung_slsi-linaro/config/config.mk)

# API Level & Characteristics
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_CHARACTERISTICS := phone

# Optimized Dalvik (Tuned for 3GB RAM)
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

# Audio (Verified 32-bit and @6.0 blobs)
PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    android.hardware.audio@6.0-impl:32 \
    android.hardware.audio.effect@6.0-impl:32 \
    audio.primary.exynos850 \
    audio.bluetooth.default \
    audio.r_submix.default \
    audio.usb.default

# Graphics & Display (Verified HWC 2.2)
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.2-service \
    hwcomposer.exynos850 \
    gralloc.default

# Connectivity (Verified STMicro NFC & Samsung Wifi)
PRODUCT_PACKAGES += \
    android.hardware.nfc-service-st \
    android.hardware.wifi-service \
    vendor.samsung.hardware.wifi-service \
    hostapd \
    wpa_supplicant \
    cbd

# Samsung Biometrics, Vibrator & Sensors (Verified Versions)
PRODUCT_PACKAGES += \
    vendor.samsung.hardware.biometrics.fingerprint@3.0-service \
    vendor.samsung.hardware.vibrator-service \
    android.hardware.sensors@2.0-service.multihal

# Rootdir Scripts
PRODUCT_PACKAGES += \
    gps.sh \
    mx_logger.sh \
    fstab.exynos850

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.exynos850:$(TARGET_COPY_OUT_RAMDISK)/fstab.exynos850 \
    $(LOCAL_PATH)/rootdir/etc/fstab.exynos850:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.exynos850

# Namespaces (Required to link libaudioproxy.so)
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/samsung \
    hardware/samsung_slsi-linaro/exynos/libaudio/audiohal_comv1 \
    hardware/samsung_slsi-linaro/exynos/cpboot_v3

# Inherit proprietary vendor files
$(call inherit-product, vendor/samsung/a04s/a04s-vendor.mk)

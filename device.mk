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

# Boot Animation
TARGET_SCREEN_HEIGHT := 1600
TARGET_SCREEN_WIDTH := 720

# Optimized Dalvik (Verified 2048 for 3GB/4GB RAM)
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

# Audio (Verified @6.0 from VINTF and lib64 folder)
PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    android.hardware.audio@6.0-impl:32 \
    android.hardware.audio.effect@6.0-impl:32 \
    audio.primary.exynos850 \
    audio.bluetooth.default \
    audio.r_submix.default \
    audio.usb.default

# Graphics & Display (Verified Mapper/Allocator @4.0 and Gralloc.default)
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@4.0-service \
    android.hardware.graphics.mapper@4.0-impl \
    android.hardware.graphics.composer@2.2-service \
    hwcomposer.exynos850 \
    gralloc.default

# Connectivity (Verified STMicro AIDL NFC & Samsung Wifi)
PRODUCT_PACKAGES += \
    android.hardware.nfc-service-st \
    com.android.nfc_extras \
    Tag \
    android.hardware.bluetooth@1.0-service \
    android.hardware.wifi-service \
    vendor.samsung.hardware.wifi-service \
    hostapd \
    wpa_supplicant \
    cbd

# Samsung Biometrics, Vibrator & Sensors (Verified Versions)
PRODUCT_PACKAGES += \
    vendor.samsung.hardware.biometrics.fingerprint@3.0-service \
    vendor.samsung.hardware.vibrator-service \
    android.hardware.sensors@1.0-impl \
    sensors.exynos850

# Rootdir Scripts
PRODUCT_PACKAGES += \
    gps.sh \
    mx_logger.sh \
    fstab.exynos850

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.exynos850:$(TARGET_COPY_OUT_RAMDISK)/fstab.exynos850 \
    $(LOCAL_PATH)/rootdir/etc/fstab.exynos850:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.exynos850

# Namespaces (Verified paths for libaudioproxy and modem)
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/samsung \
    hardware/samsung_slsi-linaro/exynos/libaudio/audiohal_comv1 \
    hardware/samsung_slsi-linaro/exynos/cpboot_v3

# Inherit proprietary vendor files
$(call inherit-product, vendor/samsung/a04s/a04s-vendor.mk)

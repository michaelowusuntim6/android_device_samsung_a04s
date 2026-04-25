#
# Copyright (C) 2026 Michael Owusu Ntim
# SPDX-License-Identifier: Apache-2.0
#

# Inherit Platform Configs
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# API Level & Characteristics
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_CHARACTERISTICS := phone

# Boot Animation
TARGET_SCREEN_HEIGHT := 1600
TARGET_SCREEN_WIDTH := 720

# Optimized Dalvik (Verified for 3GB/4GB RAM)
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

# Audio - Aligned to universal3830 (AIDL)
PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    audio.primary.universal3830 \
    audio.bluetooth.default \
    audio.r_submix.default \
    audio.usb.default

# Graphics & Display - Aligned to universal3830
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@4.0-service \
    android.hardware.graphics.mapper@4.0-impl \
    hwcomposer.universal3830 \
    gralloc.default

# Connectivity - WiFi & NFC (hostapd removed as it's now internal/APEX managed)
PRODUCT_PACKAGES += \
    android.hardware.nfc-service.st \
    com.android.nfc_extras \
    Tag \
    android.hardware.bluetooth-service.default \
    android.hardware.wifi-service \
    wpa_supplicant \
    cbd

# Biometrics & Vibrator - Using confirmed AIDL Samsung services
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint-service.samsung \
    android.hardware.vibrator-service.samsung

# Rootdir Scripts
PRODUCT_PACKAGES += \
    gps.sh \
    mx_logger.sh

# Corrected Copy Paths (fstab matching BoardConfig platform name)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.exynos850:$(TARGET_COPY_OUT_RAMDISK)/fstab.universal3830 \
    $(LOCAL_PATH)/rootdir/etc/fstab.exynos850:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.universal3830

# Namespaces - Critical for Android 16 Soong Build
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/samsung

# Inherit proprietary vendor files
$(call inherit-product, vendor/samsung/a04s/a04s-vendor.mk)

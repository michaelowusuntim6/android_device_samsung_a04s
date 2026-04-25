#
# Copyright (C) 2026 Michael Owusu Ntim
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/samsung/a04s

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55

# 64-Bit Binder & SDK (Essential for Android 14+)
TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_USES_64_BIT_SDK := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := exynos850
TARGET_NO_BOOTLOADER := true
BOARD_VENDOR := samsung

TARGET_KERNEL_MIXED_MODE := false

# Display & Graphics
TARGET_SCREEN_DENSITY := 300
TARGET_USES_VULKAN := true
TARGET_RECOVERY_PIXEL_FORMAT := ABGR_8888

# Kernel Hardware Offsets
BOARD_BOOT_HEADER_VERSION := 2
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_DTB_SIZE := 142125
BOARD_INCLUDE_RECOVERY_DTBO := true

# Kernel Build Configuration
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
BOARD_KERNEL_IMAGE_NAME := Image
TARGET_KERNEL_CONFIG := exynos850-a04sxx_defconfig
BOARD_KERNEL_SEPARATED_DTBO := true

# CMDLINE (Verified: 12100000.dwmmc0 for eMMC)
BOARD_KERNEL_CMDLINE := console=ttySAC2,115200n8 androidboot.console=ttySAC2 printk.devkmsg=on
BOARD_KERNEL_CMDLINE += androidboot.hardware=exynos850 self_state=0x0
BOARD_KERNEL_CMDLINE += androidboot.boot_devices=12100000.dwmmc0
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += activity_manager_native_boot.use_freezer=true
BOARD_KERNEL_CMDLINE += zram.backend=lz4

# --- [PARTITION PATH DEFINITIONS] ---
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_ODM := odm

# Dynamic Partitions
BOARD_MAIN_FASTBOOT_DYNAMIC_PARTITIONS_SIZE := 6840909824
BOARD_DYNAMIC_PARTITIONS_SIZE := 6840909824
BOARD_DYNAMIC_PARTITIONS_PARTITION_LIST := system product vendor odm

# File System Configuration
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_F2FS := true

BOARD_USES_RECOVERY_AS_BOOT := true

# Platform / SoC
TARGET_BOARD_PLATFORM := universal3830
TARGET_SOC := universal850

# Force enable the HDR interface in the display HAL
COMMON_GLOBAL_CFLAGS += -DEXYNOS_DISPLAY_HDR_INTERFACE

# VINTF Manifests (Keep all as requested)
DEVICE_MANIFEST_FILE += \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/android.hardware.cas-service.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/android.hardware.cas@1.2-service.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/android.hardware.sensors@2.0-multihal.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/android.hardware.usb@1.3-service.coral.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/android.hardware.wifi-service.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/android.hardware.wifi.hostapd.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/android.hardware.wifi.supplicant.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/bluetooth_audio.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/deviceManifest.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/dumpstate-default.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/engmode_manifest.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/face-default-sec.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/hyper-default-sec.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/lights-default-sec.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/manifest_android.hardware.drm@1.4-service.clearkey.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/manifest_android.hardware.drm@1.4-service.widevine.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/memtrack.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/nfc-service-st.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/power-samsung.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/sec_c2_manifest_default_1_0.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vaultkeeper_manifest.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vendor.samsung.hardware.biometrics.fingerprint@3.0-service.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vendor.samsung.hardware.health-service.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vendor.samsung.hardware.radio.exclude.slsi.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vendor.samsung.hardware.radio_manifest_2_31.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vendor.samsung.hardware.security.drk@2.0.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vendor.samsung.hardware.security.fkeymaster-service.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vendor.samsung.hardware.security.hdcp.wifidisplay-default.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vendor.samsung.hardware.security.widevine.keyprov-service.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vendor.samsung.hardware.sehradio_manifest_2_31.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vendor.samsung.hardware.snap-default.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vendor.samsung.hardware.sysinput-default.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vendor.samsung.hardware.thermal-default.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vendor.samsung.hardware.tlc.iccc@1.0-manifest.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vendor.samsung.hardware.tlc.kg@1.1-manifest.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vendor.samsung.hardware.vibrator-default.xml \
    vendor/samsung/a04s/proprietary/vendor/etc/vintf/manifest/vendor.samsung.hardware.wifi-service.xml

# Security Patch & AVB
VENDOR_SECURITY_PATCH := 2025-12-01
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --algorithm NONE

# --- [SOONG CONFIGURATION - INTEGRATED FIXES] ---
SOONG_CONFIG_NAMESPACES += exynos_hwc
SOONG_CONFIG_exynos_hwc := \
    target_soc_base \
    libhdr_header_version \
    USE_HDR_INTERFACE

# Folder paths (ls showed 'essi' exists)
SOONG_CONFIG_exynos_hwc_target_soc_base := essi

# Header module name (MUST match the Android.bp we just updated)
SOONG_CONFIG_exynos_hwc_libhdr_header_version := exynos850

# Flag for display logic
SOONG_CONFIG_exynos_hwc_USE_HDR_INTERFACE := "true"

$(call soong_config_set,cbd,protocol,sipc)
$(call soong_config_set,samsungUsbGadgetVars,gadget_name,13600000.dwc3)

# Properties & Paths
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.exynos850
BOARD_USES_METADATA_PARTITION := true
BOARD_ROOT_EXTRA_FOLDERS := efs

# Inherit from proprietary vendor configs
-include vendor/samsung/a04s/BoardConfigVendor.mk

#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/samsung/a04s

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := cortex-a55
TARGET_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# 64‑bit binder and SDK
TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_USES_64_BIT_SDK := true

# Hardware Rendering and Memory
BOARD_USES_EXYNOS_LIBION := true
BOARD_USES_EXYNOS_ACRYL := true
BOARD_USES_EXYNOS_GRAPHICBUFFER := true
BOARD_USES_EXYNOS_LIBACRYL := true
BOARD_USES_EXYNOS_GRALLOC_VERSION := 4

# Soong‑to‑Kati bridge for OMX prebuilts
BUILD_BROKEN_MISSING_DEPENDENCIES := true

# Export a global flag so the source code can detect the Exynos libion header
COMMON_GLOBAL_CFLAGS += -DEXYNOS_LIBION_HEADER

## Bluetooth
BOARD_HAVE_BLUETOOTH_SLSI := true

# Build Broken Rules
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# VNDK
BOARD_VNDK_VERSION := current

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := exynos850
TARGET_NO_BOOTLOADER := true

# Display and Graphics
TARGET_SCREEN_DENSITY := 300
TARGET_USES_VULKAN := true
TARGET_RECOVERY_PIXEL_FORMAT := ABGR_8888

# -----------------------------------------------------------------
# Kernel – prebuilt only (source lines commented out)
# -----------------------------------------------------------------
#TARGET_KERNEL_CONFIG := a04s_defconfig
#TARGET_KERNEL_SOURCE := kernel/samsung/a04s
#BOARD_KERNEL_IMAGE_NAME := Image   # we use the prebuilt file named "kernel"

# We use a fully prebuilt kernel – disable source build
TARGET_FORCE_PREBUILT_KERNEL := true

# Prebuilt kernel binary and device tree blobs
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
TARGET_PREBUILT_DTB   := $(DEVICE_PATH)/prebuilts/dtb.img
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img

# The prebuilt kernel file is called "kernel", not "Image"
BOARD_KERNEL_IMAGE_NAME := kernel

# When using prebuilt kernel, dtb is embedded directly, separate DTBO is disabled
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := false

# Kernel offsets and header version
BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_BASE        := 0x10000000
BOARD_KERNEL_PAGESIZE    := 2048
BOARD_KERNEL_OFFSET      := 0x00008000
BOARD_RAMDISK_OFFSET     := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_SECOND_OFFSET      := 0x00f00000   # fixed from BOARD_KERNEL_SECOND_OFFSET
BOARD_DTB_OFFSET         := 0

# Kernel command line
BOARD_KERNEL_CMDLINE := console=ttySAC2,115200n8 androidboot.console=ttySAC2 printk.devkmsg=on
BOARD_KERNEL_CMDLINE += androidboot.hardware=exynos850 self_state=0x0
BOARD_KERNEL_CMDLINE += androidboot.boot_devices=12100000.dwmmc0
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += activity_manager_native_boot.use_freezer=true
BOARD_KERNEL_CMDLINE += zram.backend=lz4
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

# mkbootimg arguments
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --second_offset $(BOARD_SECOND_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --board $(TARGET_BOOTLOADER_BOARD_NAME)

## Camera
$(call soong_config_set,samsungCameraVars,usage_64bit,true)

# A/B
AB_OTA_UPDATER := false

## Keymaster
TARGET_KEYMASTER_VARIANT := samsung

# Storage flag (external SD card is supported)
BOARD_HAS_REMOVABLE_STORAGE := true

## Dynamic Partitions
BOARD_SUPER_PARTITION_SIZE := 6845104128
BOARD_SUPER_PARTITION_GROUPS := samsung_dynamic_partitions
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_SIZE := 6840909824
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    vendor \
    product \
    odm

-include vendor/lineage/config/BoardConfigReservedSize.mk

## Filesystem
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_VENDOR := vendor

## Platform
BOARD_VENDOR := samsung
TARGET_BOARD_PLATFORM := universal3830
TARGET_SOC := exynos3830

## Partitions
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 4599496704
BOARD_VENDORIMAGE_PARTITION_SIZE := 537047040
BOARD_PRODUCTIMAGE_PARTITION_SIZE := 1640783872
BOARD_ODMIMAGE_PARTITION_SIZE := 21385216
BOARD_BOOTIMAGE_PARTITION_SIZE := 46137344
BOARD_CACHEIMAGE_PARTITION_SIZE := 209715200
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 55574528

BOARD_USES_METADATA_PARTITION := true

BOARD_ROOT_EXTRA_FOLDERS := efs

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.exynos850
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2025-12-01

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_BUILD_DISABLED_VBMETAIMAGE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --algorithm NONE
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# Soong configuration for Exynos HWC and USB
SOONG_CONFIG_NAMESPACES += exynos_hwc
SOONG_CONFIG_exynos_hwc := \
    target_soc_base \
    libhdr_header_version \
    USE_HDR_INTERFACE

SOONG_CONFIG_exynos_hwc_target_soc_base := essi                # ← was missing
SOONG_CONFIG_exynos_hwc_libhdr_header_version := exynos850
SOONG_CONFIG_exynos_hwc_USE_HDR_INTERFACE := "true"

# USB gadget name
$(call soong_config_set,samsungUsbGadgetVars,gadget_name,13600000.dwc3)

# VINTF
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := $(DEVICE_PATH)/framework_compatibility_matrix.xml

# Inherit the proprietary files
include vendor/samsung/a04s/BoardConfigVendor.mk

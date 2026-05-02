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

# Build Broken Rules (Replicated from A21s common for stability)
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := exynos850
TARGET_NO_BOOTLOADER := true
BOARD_VENDOR := samsung

TARGET_KERNEL_MIXED_MODE := false

# Display & Graphics
TARGET_SCREEN_DENSITY := 300
TARGET_USES_VULKAN := true
TARGET_RECOVERY_PIXEL_FORMAT := ABGR_8888

# Kernel Hardware Offsets & Packing
BOARD_BOOT_HEADER_VERSION := 2
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := false

# Partition Sizes (Verified from hardware blocks)
BOARD_BOOTIMAGE_PARTITION_SIZE := 46137344
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 55574528
BOARD_DTBOIMG_PARTITION_SIZE := 8388608

# Compression - Switch to LZ4 to save space
BOARD_RAMDISK_USE_LZ4 := true

# Recovery Configuration
# This stops the 34MB kernel from overflowing the boot partition
BOARD_USES_RECOVERY_AS_BOOT := false
TARGET_NO_RECOVERY := false

# Kernel Build Configuration (Using Prebuilts)
BOARD_KERNEL_IMAGE_NAME := kernel
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
BOARD_PREBUILT_DTBIMAGE := $(DEVICE_PATH)/prebuilt/dtb

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

# Force separate partition building
BOARD_USES_VENDORIMAGE := true
BOARD_USES_PRODUCTIMAGE := true
BOARD_USES_ODMIMAGE := true

# --- [DYNAMIC PARTITIONS CONFIGURATION] ---
# Restructured into Groups to match Exynos 850 standards
BOARD_SUPER_PARTITION_SIZE := 6635388928
BOARD_SUPER_PARTITION_GROUPS := samsung_dynamic_partitions
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_SIZE := 6631194624 # (Total size minus 4MB overhead)
BOARD_SAMSUNG_DYNAMIC_PARTITIONS_PARTITION_LIST := system product vendor odm

BOARD_USES_METADATA_PARTITION := true

# Enable System-as-Root
BOARD_HAS_SYSTEM_ROOT_IMAGE := true

# Individual Logical Partition Sizes (Verified via blockdev)
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 4231294976
BOARD_VENDORIMAGE_PARTITION_SIZE := 537047040
BOARD_PRODUCTIMAGE_PARTITION_SIZE := 1640783872
BOARD_ODMIMAGE_PARTITION_SIZE := 21389312
BOARD_CACHEIMAGE_PARTITION_SIZE := 209715200
BOARD_METADATA_PARTITION_SIZE := 33554432

-include vendor/lineage/config/BoardConfigReservedSize.mk
include hardware/samsung_slsi-linaro/config/BoardConfig850.mk
BOARD_USES_FULL_RECOVERY_IMAGE := true

BOARD_EXT4_SHARE_DUP_BLOCKS := false

# Filesystem Configuration
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_F2FS := true

# A/B Logic
AB_OTA_UPDATER := false

# Samsung Specifics
ENABLE_VENDOR_RIL_SERVICE := true
BOARD_ROOT_EXTRA_FOLDERS := efs

# Platform / SoC
TARGET_BOARD_PLATFORM := universal3830
TARGET_SOC := universal850

# Force enable the HDR interface in the display HAL
COMMON_GLOBAL_CFLAGS += -DEXYNOS_DISPLAY_HDR_INTERFACE

# VINTF Manifests (Consolidated to Device Tree)
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml

DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := $(DEVICE_PATH)/framework_compatibility_matrix.xml

# Security Patch & AVB
VENDOR_SECURITY_PATCH := 2025-12-01
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --algorithm NONE

# AVB Signing Configuration
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# --- [SOONG CONFIGURATION - INTEGRATED FIXES] ---
SOONG_CONFIG_NAMESPACES += exynos_hwc
SOONG_CONFIG_exynos_hwc := \
    target_soc_base \
    libhdr_header_version \
    USE_HDR_INTERFACE

# Folder paths (ls showed 'essi' exists)
SOONG_CONFIG_exynos_hwc_target_soc_base := essi

# Header module name
SOONG_CONFIG_exynos_hwc_libhdr_header_version := exynos850

# Flag for display logic
SOONG_CONFIG_exynos_hwc_USE_HDR_INTERFACE := "true"

$(call soong_config_set,samsungUsbGadgetVars,gadget_name,13600000.dwc3)

# Properties & Paths
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.exynos850

# Inherit from proprietary vendor configs
-include vendor/samsung/a04s/BoardConfigVendor.mk

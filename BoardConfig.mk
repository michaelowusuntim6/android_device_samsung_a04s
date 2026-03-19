#
# Copyright (C) 2026 Michael Owusu Ntim
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/samsung/a04s

# Architecture
# Keeping cortex-a55 for better optimization on Exynos 850
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := cortex-a55
TARGET_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# 64-Bit Binder & SDK (Essential for Android 14+)
TARGET_USES_64_BIT_BINDER := true
TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_USES_64_BIT_SDK := true

# Treble Settings
BOARD_VNDK_VERSION := current
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := exynos850
TARGET_NO_BOOTLOADER := true
BOARD_VENDOR := samsung

# Display & Graphics
TARGET_SCREEN_DENSITY := 300
TARGET_USES_VULKAN := true
# Added from A21s reference to fix Recovery colors
TARGET_RECOVERY_PIXEL_FORMAT := ABGR_8888 

# Kernel Hardware Offsets (Matches A04s Firmware)
BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_DTB_SIZE := 142125
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_BOOTIMG_HEADER_VERSION := 2

# Kernel Build Configuration
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
BOARD_KERNEL_IMAGE_NAME := Image.gz
# Fixed: Correct filename verified via kernel tree ls
TARGET_KERNEL_CONFIG := exynos850-a04sxx_defconfig 
BOARD_KERNEL_SEPARATED_DTBO := true

# CMDLINE (Optimized for crDroid/Android 14)
BOARD_KERNEL_CMDLINE := console=ttySAC2,115200n8 androidboot.console=ttySAC2 printk.devkmsg=on 
BOARD_KERNEL_CMDLINE += androidboot.hardware=exynos850 self_state=0x0
BOARD_KERNEL_CMDLINE += androidboot.boot_devices=13200000.ufs
BOARD_KERNEL_CMDLINE += loop.max_part=7

# --- Performance & Efficiency Tweaks (Verified) ---
# Enables Kernel Freezer to mimic iOS background efficiency
BOARD_KERNEL_CMDLINE += activity_manager_native_boot.use_freezer=true

# Force ZRAM to use LZ4 backend for instant app resumes
BOARD_KERNEL_CMDLINE += zram.backend=lz4

# Disable Samsung prelauncher to maximize free RAM for background apps
PRODUCT_PROPERTY_OVERRIDES += \
    com.samsung.speg.prelauncher.disable=true

# Dynamic Partitions (Specific to A04s Storage Layout)
BOARD_MAIN_FASTBOOT_DYNAMIC_PARTITIONS_SIZE := 6840909824
BOARD_DYNAMIC_PARTITIONS_SIZE := 6840909824
BOARD_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product odm

# File System Configuration - Optimized for Read-Only Partitions
# EROFS provides faster read speeds than F2FS/EXT4
# Set to 'none' because kernel lacks CONFIG_EROFS_FS_ZIP_LZ4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_EROFS_COMPRESSOR := none

# Platform / SoC
TARGET_BOARD_PLATFORM := universal3830
TARGET_SOC := universal3830

# Inclusion of SoC-specific configurations
include hardware/samsung_slsi-linaro/config/BoardConfig850.mk

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop

# Recovery & Filesystem
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.exynos850
# Userdata remains F2FS for best write performance
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USES_METADATA_PARTITION := true
BOARD_ROOT_EXTRA_FOLDERS := efs

# Security Patch & AVB
VENDOR_SECURITY_PATCH := 2025-12-01
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 0
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --algorithm NONE

# Soong Namespaces
$(call soong_config_set,cbd,protocol,sipc)
$(call soong_config_set,samsungUsbGadgetVars,gadget_name,13600000.dwc3)
$(call soong_config_set,exynos_audio,PREDEFINED_LOW_CAPTURE_DURATION,20)

# Inherit from proprietary vendor configs
-include vendor/samsung/a04s/BoardConfigVendor.mk

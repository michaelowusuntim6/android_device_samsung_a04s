# Inherit from generic products
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/non_ab_device.mk)

## Inherit from YOUR A04s device tree
$(call inherit-product, device/samsung/a04s/device.mk)

## Boot Animation (A04s resolution)
TARGET_SCREEN_HEIGHT := 1600
TARGET_SCREEN_WIDTH := 720

## Inherit common crDroid/Lineage stuff
# NOTE: Use the path we verified exists in your vendor folder
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

## Device identifier (MUST match your lunch target)
PRODUCT_DEVICE := a04s
PRODUCT_NAME := crdroid_a04s
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-A047F
PRODUCT_MANUFACTURER := samsung

# Setting this correctly helps with camera and media blobs
PRODUCT_SHIPPING_API_LEVEL := 31

PRODUCT_GMS_CLIENTID_BASE := android-samsung

# Inherit from generic products
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/non_ab_device.mk)

## Inherit from YOUR A04s device tree
$(call inherit-product, device/samsung/a04s/device.mk)

## Inherit common Lineage stuff
# NOTE: Use the path we verified exists in your vendor folder
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

## Device identifier (MUST match your lunch target)
PRODUCT_DEVICE := a04s
PRODUCT_NAME := lineage_a04s
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-A047F
PRODUCT_MANUFACTURER := samsung

# Setting this correctly helps with camera and media blobs
PRODUCT_SHIPPING_API_LEVEL := 31

PRODUCT_GMS_CLIENTID_BASE := android-samsung

# Use the latest approved GMS identifiers for A04s (Android 14)
PRODUCT_BUILD_PROP_OVERRIDES += \
    DeviceProduct=a04s \
    SystemName=a04snsxx \
    BuildFingerprint=samsung/a04snsxx/a04s:14/UP1A.231005.007/A047FXXSDEYL1:user/release-keys \
    BuildDesc="a04snsxx-user 14 UP1A.231005.007 A047FXXSDEYL1 release-keys"

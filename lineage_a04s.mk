# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from a04s device configuration
$(call inherit-product, device/samsung/a04s/device.mk)

# Inherit common Lineage/Rising stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# RisingOS Specific Flags
RISING_MAINTAINER := Mike
WITH_GMS := true
TARGET_CORE_GMS := true
TARGET_USES_PICO_GAPPS := true
TARGET_ENABLE_BLUR := false  # Set to false for 3GB RAM performance

# Device Identity
PRODUCT_DEVICE := a04s
PRODUCT_NAME := lineage_a04s
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-A047F
PRODUCT_MANUFACTURER := samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung-ss

# Build Properties
PRODUCT_BUILD_PROP_OVERRIDES += \
    RisingChipset="Exynos 850" \
    RisingMaintainer="Mike" \
    BuildDesc="a04snnxx-user 14 UP1A.231005.007 A047FXXSDEYL1 release-keys"

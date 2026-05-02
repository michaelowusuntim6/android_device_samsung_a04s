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
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

# Audio - Aligned to universal3830 (AIDL)
PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    audio.bluetooth.default \
    audio.r_submix.default \
    audio.usb.default

# Graphics & Display - Aligned to universal3830
PRODUCT_PACKAGES += \
    gralloc.default

# Connectivity - WiFi & NFC
PRODUCT_PACKAGES += \
    android.hardware.nfc-service.st \
    com.android.nfc_extras \
    Tag \
    android.hardware.bluetooth-service.default \
    android.hardware.wifi-service


# Rootdir Scripts
PRODUCT_PACKAGES += \
    gps.sh \
    mx_logger.sh

PRODUCT_PACKAGES := $(filter-out FMRadio FM2 FMService, $(PRODUCT_PACKAGES))

# ===========================================================================
# VENDOR PREBUILT MODULES (defined in Android.mk — all 282 modules)
# These MUST appear in PRODUCT_PACKAGES or the build system will
# recognize but silently exclude them from the final ROM image.
# ===========================================================================

# Vendor Shared Libraries — 32+64-bit (MULTILIB BOTH)
PRODUCT_PACKAGES += \
    audio.sec_primary.default \
    gatekeeper.exynos850 \
    hwcomposer.exynos850 \
    libBeauty_v4.camera.samsung \
    libDualCamBokehCapture.camera.samsung \
    libExynosHWCService_samsung \
    libFaceService \
    libFace_Landmark_API.camera.samsung \
    libGLES_mali \
    libHprFace_GAE_api.camera.samsung \
    libHpr_RecGAE_cvFeature_v1.0.camera.samsung \
    libLocalTM_capture_core.camera.samsung \
    libLocalTM_wrapper.camera.samsung \
    libOMX.Exynos.HEVC.Encoder \
    libOpenCv.camera.samsung \
    libSEF.quram \
    lib_SoundAlive_3DPosition_ver202 \
    lib_SoundAlive_AlbumArt_ver105 \
    lib_SoundAlive_play_plus_ver500 \
    lib_SoundBooster_ver1100 \
    libaudioeffectoffload \
    libaudiosaplus_sec \
    libbauthserver \
    libbauthtzcommon \
    libbeautyshot.arcsoft \
    libbt-vendor-samsung \
    libegis_fp_normal_sensor_test \
    libeis_core \
    libepicoperator \
    libexifa.camera.samsung \
    libexynoscamera_plugin \
    libexynoscamera_plugin_utils \
    libexynoscamera_tdnr_plugin \
    libface_landmark_lite.arcsoft \
    libfloatingfeature \
    libgf_in_system_lib \
    libgpudataproducer \
    libhdrwrapper \
    libheifcapture \
    libimagecodec_native.quram \
    liblivefocus_capture_engine \
    liblivefocus_preview_engine \
    liblivefocus_preview_interface \
    libmfb \
    libmpbase \
    libmyspace \
    libpadm \
    libphotohdr \
    libphotohdrcp \
    libprofileparamstorage \
    libqfp_sensortest \
    libremosaic_wrapper \
    libsamsungSoundbooster_plus \
    libsavsac \
    libsavscmn \
    libsavsvc \
    libsecaudiocoreutils \
    libsecaudioinfo \
    libsecfr_engine \
    libsecfr_model \
    libsecnativefeature \
    libsecril-client \
    libsehbluetooth_audio_session_aidl \
    libsemnativecarrierfeature \
    libsimba.media.samsung \
    libsnaace \
    libsnamrnb \
    libsnamrwb \
    libspatializerparamstorage \
    libspeakercalibration \
    libswdap \
    libswspatializer \
    libsynaFpSensorTestNwd \
    libteecl \
    libucm_tlc_comm \
    libucm_tlc_direct_comm \
    libucm_tlc_tz_esecomm \
    libuniplugin \
    libvideobeauty.arcsoft \
    libvideobeauty_interface \
    libwrappergps \
    mali_symlink \
    sensors.exynos850 \
    sensors.grip \
    sensors.inputvirtual \
    sensors.sensorhub \
    vendor.samsung.hardware.audio@1.0 \
    vendor.samsung.hardware.audio@1.0-impl \
    vendor.samsung.hardware.biometrics.face-V3-ndk \
    vendor.samsung.hardware.bluetooth.audio-V2-ndk \
    vendor.samsung.hardware.bluetooth.audio-impl \
    vendor.samsung.hardware.security.drk@2.0 \
    vendor.samsung.hardware.tlc.ucm@2.0 \
    vendor.samsung.hardware.tlc.ucm@2.0-impl \
    vendor.samsung_slsi.hardware.epic-V1-ndk \
    vendor.samsung_slsi.hardware.epic@1.0 \
    vulkan.mali

# Vendor Shared Libraries — 32-bit only
PRODUCT_PACKAGES += \
    audio.primary.exynos850 \
    libBufferStats \
    libFrucSSMLib \
    libSamsungPostProcessConvertor \
    libSecRecorder \
    lib_SamsungRec_07010 \
    lib_SoundAlive_SRC384_ver320 \
    lib_soundaliveresampler \
    libaboxpcmdump \
    libalsautils_sec \
    libaudioparamupdate \
    libaudioproxy \
    libcodecsolutionhelper_vendor \
    libdatamod \
    liblastaboxmsg \
    liboemcrypto \
    libpredeflicker_native \
    librecordalive \
    libstagefright_bufferqueue_helper_vendor \
    libwvhidl \
    vintf-codecsolution-V2-ndk

# Vendor Shared Libraries — 64-bit only
PRODUCT_PACKAGES += \
    android.hardware.gnss@2.1-impl-samsung \
    camera.exynos850 \
    libSecC2ComponentStore \
    libSemDataProps \
    libSemTelephonyProps \
    libap2ap_calconversion \
    libcodec2_sec_aacdec \
    libcodec2_sec_aacenc \
    libcodec2_sec_amrnbdec \
    libcodec2_sec_amrwbdec \
    libcodec2_sec_flacdec \
    libcodec2_sec_imadec \
    libcodec2_sec_mp3dec \
    libcodec2_sec_mp4vdec \
    libcodec2_sec_soft_common \
    libcodec2_sec_vc1dec \
    libcodec2_soft_ac4dec \
    libcodec2_soft_eac3dec \
    libdeccfg \
    libdk_vnd_service_core \
    libdlrmsc \
    libdsms_vendor \
    libdualcam_refocus_image \
    libdualcam_refocus_video \
    libengmode15 \
    libengmode2lite \
    libengmode_client \
    libengmode_server \
    libengmode_tlc \
    libexynoscamera3 \
    libhigh_dynamic_range_bokeh \
    libhyper \
    libhypervintf \
    libremosaiclib \
    libril_sem \
    libsec-ril \
    libsensorlistener \
    libskeymint10device \
    libskeymint_cli \
    libsnap_compute \
    libsnap_compute_wrapper \
    libsnap_vndk \
    libsnaplite_native \
    libsnaplite_wrapper \
    libsomxcmn \
    libstork_shared \
    libtlc_comm_iccc \
    libtlc_direct_comm_iccc \
    libtvm_runtime \
    libtvm_wrapper \
    libuniapi \
    libvkmanager_vendor \
    libvkservice \
    nfc_nci.st21nfc.st \
    service-listener-ext-aidl-V1-ndk \
    vendor.samsung.frameworks.security.dsms-V1-ndk \
    vendor.samsung.hardware.biometrics.fingerprint@3.0 \
    vendor.samsung.hardware.bluetooth@2.0 \
    vendor.samsung.hardware.camera.device@5.0 \
    vendor.samsung.hardware.camera.device@5.0-impl \
    vendor.samsung.hardware.camera.provider@4.0 \
    vendor.samsung.hardware.camera.provider@4.0-legacy \
    vendor.samsung.hardware.gnss@2.0 \
    vendor.samsung.hardware.gnss@2.1 \
    vendor.samsung.hardware.gnss@2.1-impl \
    vendor.samsung.hardware.health-V1-ndk \
    vendor.samsung.hardware.hyper-V2-ndk \
    vendor.samsung.hardware.keymint-V1-ndk \
    vendor.samsung.hardware.light-V1-ndk \
    vendor.samsung.hardware.miscpower@2.0 \
    vendor.samsung.hardware.nfc_aidl-V1-ndk \
    vendor.samsung.hardware.radio.bridge@2.0 \
    vendor.samsung.hardware.radio.bridge@2.1 \
    vendor.samsung.hardware.radio.channel@2.0 \
    vendor.samsung.hardware.security.drk-V1-ndk \
    vendor.samsung.hardware.security.engmode@1.0 \
    vendor.samsung.hardware.security.fkeymaster-V1-ndk \
    vendor.samsung.hardware.security.hdcp.wifidisplay-V2-ndk \
    vendor.samsung.hardware.security.vaultkeeper@2.0 \
    vendor.samsung.hardware.security.widevine.keyprov-V1-ndk \
    vendor.samsung.hardware.snap-V2-ndk \
    vendor.samsung.hardware.sysinput-V2-ndk \
    vendor.samsung.hardware.thermal-V1-ndk \
    vendor.samsung.hardware.thermal@1.0 \
    vendor.samsung.hardware.tlc.iccc@1.0 \
    vendor.samsung.hardware.tlc.iccc@1.0-impl \
    vendor.samsung.hardware.tlc.kg@1.0 \
    vendor.samsung.hardware.tlc.kg@1.1 \
    vendor.samsung.hardware.vibrator-V5-ndk \
    vendor.samsung.hardware.wifi-V1-ndk \
    vendor.samsung.hardware.wifi.nan-V1-ndk \
    vendor.samsung.hardware.wifi.supplicant-V1-ndk \
    vendor.samsung_slsi.hardware.ExynosHWCServiceTW@1.0

# System Partition Shared Libraries
PRODUCT_PACKAGES += \
    libcharon \
    libhdcp2 \
    libhdcp_client_aidl \
    libomafldrm \
    libstagefright_hdcp \
    libstagefright_httplive_sec \
    libstrongswan \
    libucsengine.system \
    vendor.samsung.frameworks.security.ucm.crypto@1.0 \
    vendor.samsung.hardware.security.hdcp.wifidisplay-V2-ndk

# Vendor Executables (vendor/bin and vendor/bin/hw)
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4-service.clearkey \
    android.hardware.drm@1.4-service.widevine \
    android.hardware.nfc-service-st \
    android.hardware.power.samsung-service \
    android.hardware.usb@1.3-service.coral \
    argosd \
    cass \
    emservice \
    fsdbg_vendor \
    gpsd \
    iod \
    macloader \
    main_abox \
    mfgloader \
    samsung.hardware.media.c2@1.1-default-service \
    samsung.software.media.c2@1.0-service \
    snap_utility_64 \
    tzdaemon \
    tzts_daemon \
    vaultkeeperd \
    vendor.samsung.hardware.biometrics.face-service \
    vendor.samsung.hardware.biometrics.fingerprint@3.0-service \
    vendor.samsung.hardware.camera.provider@4.0-service_64 \
    vendor.samsung.hardware.gnss@2.1-service \
    vendor.samsung.hardware.health-service \
    vendor.samsung.hardware.hyper-service \
    vendor.samsung.hardware.light-service \
    vendor.samsung.hardware.miscpower@2.0-service \
    vendor.samsung.hardware.security.drk-service \
    vendor.samsung.hardware.security.drk@2.0-service \
    vendor.samsung.hardware.security.engmode@1.0-service \
    vendor.samsung.hardware.security.fkeymaster-service \
    vendor.samsung.hardware.security.hdcp.wifidisplay-service \
    vendor.samsung.hardware.security.proca@2.0-service \
    vendor.samsung.hardware.security.vaultkeeper@2.0-service \
    vendor.samsung.hardware.security.widevine.keyprov-service \
    vendor.samsung.hardware.snap-service \
    vendor.samsung.hardware.sysinput-service \
    vendor.samsung.hardware.thermal-service \
    vendor.samsung.hardware.tlc.iccc@1.0-service \
    vendor.samsung.hardware.tlc.kg@1.1-service \
    vendor.samsung.hardware.tlc.ucm@2.0-service \
    vendor.samsung.hardware.vibrator-service \
    vendor.samsung.hardware.wifi-service \
    vendor.samsung_slsi.hardware.ExynosHWCServiceTW@1.0-service \
    wlbtd \
    wvkprov

# Vendor Data Files (ETC class — non-ELF)
PRODUCT_PACKAGES += \
    add_tflite \
    test_model_json

# System Executables (system/bin)
PRODUCT_PACKAGES += \
    charon_samsung

# ===========================================================================
# END OF VENDOR PREBUILTS
# ===========================================================================

# Corrected Copy Paths (fstab matching BoardConfig platform name)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.exynos850:$(TARGET_COPY_OUT_RAMDISK)/fstab.universal3830 \
    $(LOCAL_PATH)/rootdir/etc/fstab.exynos850:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.universal3830

# Namespaces - Critical for Android 14+ Soong Build
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit proprietary vendor files
$(call inherit-product, vendor/samsung/a04s/a04s-vendor.mk)

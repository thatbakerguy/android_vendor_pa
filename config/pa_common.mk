# Set audio
PRODUCT_PROPERTY_OVERRIDES += \
  ro.config.ringtone=Themos.ogg \
  ro.config.notification_sound=Proxima.ogg \
  ro.config.alarm_alert=Cesium.ogg

# Copy specific ROM files
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/apk/GooManager.apk:system/app/GooManager.apk \
    vendor/pa/prebuilt/common/apk/SuperSU.apk:system/app/SuperSU.apk \
    vendor/pa/prebuilt/common/xbin/su:system/xbin/su

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/pa/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/pa/prebuilt/common/bin/50-backupScript.sh:system/addon.d/50-backupScript.sh

# Exclude prebuilt paprefs from builds if the flag is set
ifneq ($(PREFS_FROM_SOURCE),true)
    PRODUCT_COPY_FILES += \
        vendor/pa/prebuilt/common/apk/ParanoidPreferences.apk:system/app/ParanoidPreferences.apk
else
    # Build paprefs from sources
    PRODUCT_PACKAGES += \
        ParanoidPreferences
endif

ifneq ($(PARANOID_BOOTANIMATION_NAME),)
    PRODUCT_COPY_FILES += \
        vendor/pa/prebuilt/common/bootanimation/$(PARANOID_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
else
    PRODUCT_COPY_FILES += \
        vendor/pa/prebuilt/common/bootanimation/HDPI.zip:system/media/bootanimation.zip
endif

# ParanoidAndroid common packages
PRODUCT_PACKAGES += \
    ParanoidWallpapers

# device common prebuilts
ifneq ($(DEVICE_COMMON),)
    -include vendor/pa/prebuilt/$(DEVICE_COMMON)/prebuilt.mk
endif

# device specific prebuilts
-include vendor/pa/prebuilt/$(TARGET_PRODUCT)/prebuilt.mk

BOARD := $(subst pa_,,$(TARGET_PRODUCT))

# ParanoidAndroid Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/common
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(TARGET_PRODUCT)

# Allow device family to add overlays and use a same prop.conf
ifneq ($(OVERLAY_TARGET),)
    PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(OVERLAY_TARGET)
    PA_CONF_SOURCE := $(OVERLAY_TARGET)
else
    PA_CONF_SOURCE := $(TARGET_PRODUCT)
endif

PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/$(PA_CONF_SOURCE).conf:system/etc/paranoid/properties.conf \
    vendor/pa/prebuilt/$(PA_CONF_SOURCE).conf:system/etc/paranoid/backup.conf

PA_VERSION_MAJOR = 2
PA_VERSION_MINOR = 9
PA_VERSION_MAINTENANCE = 9

TARGET_CUSTOM_RELEASETOOL := vendor/pa/tools/squisher

VERSION := $(PA_VERSION_MAJOR).$(PA_VERSION_MINOR)$(PA_VERSION_MAINTENANCE)
PA_VERSION := $(TARGET_PRODUCT)-$(VERSION)-$(shell date +%0d%^b%Y-%H%M%S)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.modversion=$(PA_VERSION) \
  ro.pa.family=$(PA_CONF_SOURCE) \
  ro.pa.version=$(VERSION)

# goo.im properties
PRODUCT_PROPERTY_OVERRIDES += \
  ro.goo.developerid=paranoidandroid \
  ro.goo.rom=paranoidandroid \
  ro.goo.version=$(shell date +%s)

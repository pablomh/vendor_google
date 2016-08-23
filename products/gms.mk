# Copyright (C) 2016 The Sony AOSP Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Include overlays
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/google/overlay/common

# Audio (Notifications/Alarms)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Helium.ogg

# Audio (Ringtones)
ifneq ($(filter aosp_c6903 aosp_d6503 aosp_d6603 aosp_e6653 aosp_e6853 aosp_sgp521 aosp_sgp621 aosp_d5803 aosp_e2303 aosp_d2303 aosp_d2203 aosp_d5103 aosp_d5303 aosp_e5823 aosp_d5503 aosp_c6833 aosp_sgp771, $(TARGET_PRODUCT)),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Orion.ogg
endif

# bootanimation (240-320 DPI)
ifneq ($(filter aosp_sgp521 aosp_sgp511_windy aosp_sgp621 aosp_sgp611_windy aosp_d5803 aosp_e2303 aosp_d2303 aosp_d2203 aosp_d5103 aosp_d5303 aosp_e5823 aosp_d5503 aosp_c6833 aosp_sgp771 aosp_sgp712_windy, $(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES +=  \
    vendor/google/prebuilt/common/bootanimation/240_320/bootanimation.zip:system/media/bootanimation.zip
endif

# bootanimation (480 DPI)
ifneq ($(filter aosp_c6903 aosp_d6503 aosp_d6603 aosp_e6653 aosp_e6853, $(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES +=  \
    vendor/google/prebuilt/common/bootanimation/480/bootanimation.zip:system/media/bootanimation.zip
endif

# Recovery
PRODUCT_PACKAGES += \
    init_sony \
    toybox_static

# Provisional Keycheck (kitakami - kanuti - loire)
ifneq ($(filter aosp_e2303 aosp_e6553 aosp_sgp771 aosp_sgp712 aosp_e5823 aosp_e6653 aosp_e6853 aosp_f5121, $(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += \
    keycheck
endif

# OpenGapps
GAPPS_VARIANT := micro
GAPPS_FORCE_PACKAGE_OVERRIDES := true
GAPPS_FORCE_WEBVIEW_OVERRIDES := true
GAPPS_FORCE_BROWSER_OVERRIDES := true

# Telephony Packages (Not windy devices allowed)
ifneq ($(filter-out aosp_sgp511 aosp_sgp611 aosp_sgp712, $(TARGET_PRODUCT)),)
GAPPS_FORCE_DIALER_OVERRIDES := true
GAPPS_FORCE_MMS_OVERRIDES := true

# Audio (Ringtones)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Orion.ogg
endif

# Add some extras not in micro
# To override stock AOSP apps
PRODUCT_PACKAGES += \
    CalculatorGoogle \
    GoogleCamera \
    GoogleContacts \
    LatinImeGoogle \
    Music2 \
    Photos \
    PrebuiltDeskClockGoogle

ifneq ($(filter-out aosp_c6903 aosp_c6833 aosp_d5503, $(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += \
    TagGoogle
endif

$(call inherit-product, vendor/google/build/opengapps-packages.mk)

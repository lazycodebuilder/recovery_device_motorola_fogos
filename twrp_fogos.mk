#
# Copyright (C) 2020 The Android Open Source Project
# Copyright (C) 2020 The TWRP Open Source Project
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
#

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := fogos
PRODUCT_NAME := twrp_fogos
PRODUCT_BRAND := motorola
PRODUCT_MODEL := moto g34 5G
PRODUCT_MANUFACTURER := motorola
PRODUCT_RELEASE_NAME := fogos

# Default device path for tree
DEVICE_PATH := device/$(PRODUCT_BRAND)/$(PRODUCT_DEVICE)

# Configure twrp common.mk
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from device
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# Configure base.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Configure core_64_bit_only.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Enable virtual A/B OTA
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

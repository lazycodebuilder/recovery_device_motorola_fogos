#!/system/bin/sh
#
# Copyright (C) 2023-2024 The TeamWin Recovery Project
# SPDX-License-Identifier: GPL-3.0-or-later
#

# Function to set SELinux to permissive mode
set_permissive() {
  setenforce 0 && echo "I:postrecoveryboot: SELinux set to permissive." >> /tmp/recovery.log || echo "E:postrecoveryboot: Failed to set SELinux to permissive." >> /tmp/recovery.log
}

# Function to check and mount /vendor
check_and_mount_vendor() {
  if ! grep -qs '/vendor' /proc/mounts; then
    echo "I:postrecoveryboot: Mounting /vendor..." >> /tmp/recovery.log
    mount /vendor && echo "I:postrecoveryboot: /vendor mounted successfully." >> /tmp/recovery.log || echo "E:postrecoveryboot: Failed to mount /vendor." >> /tmp/recovery.log
  else
    echo "I:postrecoveryboot: /vendor is already mounted." >> /tmp/recovery.log
  fi
}

# Optimized function to check for touchscreen device and load the module
load_touchscreen_module() {
  local TOUCHSCREEN_PATH="/sys/chipone-tddi"
  local VENDOR_FILE="/sys/devices/virtual/touchscreen/primary/vendor"
  local MODULE_PATH="/vendor/lib/modules/1.1/chipone_tddi_v2_mmi.ko"

  # Check if Chipone paths exist
  if [ -d "$TOUCHSCREEN_PATH" ] || ( [ -f "$VENDOR_FILE" ] && grep -q "chipone" "$VENDOR_FILE" ); then
    echo "I:postrecoveryboot: Chipone touchscreen found." >> /tmp/recovery.log

    # Ensure /vendor is mounted
    #check_and_mount_vendor

    # Attempt to load the module if present
    if [ -f "$MODULE_PATH" ]; then
      echo "I:postrecoveryboot: Loading module from $MODULE_PATH" >> /tmp/recovery.log
      insmod "$MODULE_PATH" && echo "I:postrecoveryboot: Module loaded successfully." >> /tmp/recovery.log || echo "E:postrecoveryboot: Failed to load module." >> /tmp/recovery.log
    else
      echo "E:postrecoveryboot: Module file not found at $MODULE_PATH." >> /tmp/recovery.log
    fi
  else
    echo "E:postrecoveryboot: Chipone touchscreen not found. Skipping module load." >> /tmp/recovery.log
  fi
}

# Main script execution
set_permissive
load_touchscreen_module

exit 0
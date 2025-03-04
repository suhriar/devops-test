#!/bin/bash

log_file="/var/log/system_update.log"

echo "=============================" >> "$log_file"
echo "Update started at: $(date)" >> "$log_file"
echo "=============================" >> "$log_file"

if command -v apt &> /dev/null; then
    package_manager="apt"
    update_cmd="apt update && apt upgrade -y"
elif command -v yum &> /dev/null; then
    package_manager="yum"
    update_cmd="yum update -y"
elif command -v dnf &> /dev/null; then
    package_manager="dnf"
    update_cmd="dnf upgrade -y"
elif command -v zypper &> /dev/null; then
    package_manager="zypper"
    update_cmd="zypper update -y"
else
    echo "Error: Tidak dapat menemukan package manager yang didukung!" | tee -a "$log_file"
    exit 1
fi

echo "Using package manager: $package_manager" | tee -a "$log_file"

echo "Updating system..." | tee -a "$log_file"
eval "$update_cmd" | tee -a "$log_file"

echo "=============================" >> "$log_file"
echo "Update finished at: $(date)" >> "$log_file"
echo "=============================" >> "$log_file"

echo "System update completed! Log saved to $log_file"

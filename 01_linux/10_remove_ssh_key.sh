#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <unique_string_in_key> <username>"
    exit 1
fi

unique_string="$1"
username="$2"
auth_keys="/home/$username/.ssh/authorized_keys"

if [ ! -f "$auth_keys" ]; then
    echo "Error: File '$auth_keys' not found!"
    exit 1
fi

sed -i "/$unique_string/d" "$auth_keys"

chmod 600 "$auth_keys"

echo "SSH key with unique string '$unique_string' has been removed from $auth_keys."

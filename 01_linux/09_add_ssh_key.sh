#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <public_key_file> <username>"
    exit 1
fi

public_key_file="$1"
username="$2"

if [ ! -f "$public_key_file" ]; then
    echo "Error: Public key file '$public_key_file' not found!"
    exit 1
fi

if ! id "$username" &>/dev/null; then
    echo "Error: User '$username' does not exist on this system!"
    exit 1
fi

user_home=$(eval echo ~$username)

ssh_dir="$user_home/.ssh"
if [ ! -d "$ssh_dir" ]; then
    mkdir -p "$ssh_dir"
    chown "$username:$username" "$ssh_dir"
    chmod 700 "$ssh_dir"
fi

auth_keys="$ssh_dir/authorized_keys"
cat "$public_key_file" >> "$auth_keys"

chown "$username:$username" "$auth_keys"
chmod 600 "$auth_keys"

echo "Public key has been successfully added to authorized_keys for user $username."
exit 0

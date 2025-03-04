#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

ssh_dir="$1"

if [ ! -d "$ssh_dir" ]; then
    mkdir -p "$ssh_dir"
    echo "Directory $ssh_dir has been created."
fi

key_path="$ssh_dir/id_rsa"
ssh-keygen -t rsa -b 2048 -f "$key_path" -N ""

chmod 700 "$ssh_dir"
chmod 600 "$key_path"
chmod 644 "$key_path.pub"

echo "SSH key has been generated at: $key_path"

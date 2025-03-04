#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <public_key_file> <username> <server_ip>"
    exit 1
fi

public_key_file="$1"
username="$2"
server_ip="$3"

if [ ! -f "$public_key_file" ]; then
    echo "Error: Public key file '$public_key_file' not found!"
    exit 1
fi

ssh-copy-id -i "$public_key_file" "$username@$server_ip"

echo "Public key has been copied to $username@$server_ip"
echo "You can now SSH into the server without a password"

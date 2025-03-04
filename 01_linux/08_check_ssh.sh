#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Error: Invalid number of parameters"
    echo "Usage: $0 <username> <server_ip>"
    exit 1
fi

username="$1"
server_ip="$2"

echo "Attempting to connect to $username@$server_ip via SSH..."

ssh -o BatchMode=yes -o ConnectTimeout=5 "$username@$server_ip" exit >/dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "Successfully connected to $username@$server_ip"
    exit 0
else
    echo "Failed to connect to $username@$server_ip"
    exit 1
fi

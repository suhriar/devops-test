#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <source_directory> <username> <server_ip>"
    exit 1
fi

source="$1"
username="$2"
server_ip="$3"

if [ ! -d "$source" ]; then
    echo "Error: Source directory '$source' not found!"
    exit 1
fi

rsync -av "$source" "$username@$server_ip:~"

echo "Directory '$source' has been successfully copied to server $server_ip using rsync."

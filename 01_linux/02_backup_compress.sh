#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_destination>"
    exit 1
fi

source_directory="$1"
backup_destination="$2"

date_stamp=$(date +"%Y%m%d_%H%M%S")
backup_filename="backup_$(basename "$source_directory")_$date_stamp.tar.gz"

if [ ! -d "$source_directory" ]; then
    echo "Error: Source directory '$source_directory' not found!"
    exit 1
fi

mkdir -p "$backup_destination"
tar -czf "$backup_destination/$backup_filename" -C "$source_directory" .

echo "Backup completed: $backup_destination/$backup_filename"

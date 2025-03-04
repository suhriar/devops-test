#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_destination>"
    exit 1
fi

source_directory="$1"
backup_destination="$2"

if [ ! -d "$source_directory" ]; then
    echo "Error: Source directory '$source_directory' not found!"
    exit 1
fi

mkdir -p "$backup_destination"

timestamp=$(date +"%Y%m%d-%H%M%S")
backup_filename="backup-$timestamp.tar.gz"

tar -czf "$backup_destination/$backup_filename" -C "$source_directory" .

echo "Backup successful: $backup_destination/$backup_filename"

find "$backup_destination" -name "backup-*.tar.gz" -mtime +7 -exec rm {} \;

echo "Old backups (>7 days) have been deleted."

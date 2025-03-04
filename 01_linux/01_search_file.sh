#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <directory> <extension>"
    exit 1
fi

directory="$1"
extension="$2"

if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' not found!"
    exit 1
fi

find "$directory" -type f -name "*.$extension"

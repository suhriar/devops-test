#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

directory=$1

if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' not found!"
    exit 1
fi

echo "--------------------------------------------"
echo "| Filename        | Lines | Words | Chars |"
echo "--------------------------------------------"

for file in "$directory"/*.txt; do
    if [ -f "$file" ]; then
        stats=$(wc "$file")
        lines=$(echo "$stats" | awk '{print $1}')
        words=$(echo "$stats" | awk '{print $2}')
        chars=$(echo "$stats" | awk '{print $3}')
        filename=$(basename "$file")

        printf "| %-15s | %5s | %5s | %5s |\n" "$filename" "$lines" "$words" "$chars"
    fi
done

echo "--------------------------------------------"

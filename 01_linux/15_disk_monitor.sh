#!/bin/bash

discord_webhook="https://discord.com/api/webhooks/1346188830742675497/DKZg_vi7RNOKlVbhXxNh4SoDvtRFzfkxH7Wf4UTPK1kkvjW7sKrQ4WVA_VbvjOqof-Jp"

disk_usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//') 

if [ "$disk_usage" -gt 80 ]; then
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    message="*ALERT: High Disk Usage!*\n\n**Time:** $timestamp\n**Usage:** $disk_usage%\n**Server:** $(hostname)"

    curl -H "Content-Type: application/json" \
         -X POST \
         -d "{\"content\": \"$message\"}" \
         "$discord_webhook"
fi

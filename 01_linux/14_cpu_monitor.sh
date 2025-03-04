#!/bin/bash

log_file="/var/log/cpu_monitor.log"

if [ ! -f "$log_file" ]; then
    sudo touch "$log_file"
    sudo chmod 666 "$log_file"
fi

cpu_usage=$(awk '{print $1}' < /proc/loadavg)
cpu_usage_int=${cpu_usage%.*} 

if [ "$cpu_usage_int" -gt 75 ]; then
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$timestamp - WARNING: CPU usage is at $cpu_usage%" >> "$log_file"
fi

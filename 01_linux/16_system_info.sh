#!/bin/bash

HOSTNAME=$(hostname)
CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')
LOGGED_IN_USERS=$(who | wc -l)

echo "System Information"
echo "Hostname      : $HOSTNAME"
echo "Current Time  : $CURRENT_TIME"
echo "Logged Users : $LOGGED_IN_USERS"

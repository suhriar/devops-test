#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <start|stop|status> <service_name>"
    exit 1
fi

action="$1"
service="$2"

if ! systemctl list-units --type=service | grep -q "$service"; then
    echo "Error: Service '$service' not found!"
    exit 1
fi

case "$action" in
    start)
        echo "Starting service: $service..."
        sudo systemctl start "$service"
        ;;
    stop)
        echo "Stopping service: $service..."
        sudo systemctl stop "$service"
        ;;
    status)
        echo "Displaying status of service: $service..."
        systemctl status "$service"
        ;;
    *)
        echo "Error: Unknown command! Use 'start', 'stop', or 'status'."
        exit 1
        ;;
esac

echo "Operation '$action' on service '$service' completed."

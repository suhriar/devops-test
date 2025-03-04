#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <python_script_path_path> <service_name>"
    exit 1
fi

python_script_path="$(realpath "$1")"
service_name="$2"
service_file="/etc/systemd/system/$service_name.service"

if [ ! -f "$python_script_path" ]; then
    echo "Error: Python script '$python_script_path' not found!"
    exit 1
fi

echo "[Unit]
Description=Custom Python Service - $service_name
After=network.target

[Service]
ExecStart=/usr/bin/python3 $python_script_path
Restart=always
User=$(whoami)
Type=simple

[Install]
WantedBy=multi-user.target" | sudo tee "$service_file" > /dev/null

# Reload systemd, enable, and start the service
sudo systemctl daemon-reload
sudo systemctl enable "$service_name"
sudo systemctl start "$service_name"

echo "Service '$service_name' has been created and started."

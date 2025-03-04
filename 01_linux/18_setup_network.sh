#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "Please run this script with sudo or as root."
   exit 1
fi

netplan_config="/etc/netplan/01-netcfg.yaml"
sudo chmod 600 $netplan_config

cat <<EOF > $netplan_config
network:
  version: 2
  ethernets:
    eth0:
      addresses:
        - 192.168.1.100/24
      routes:
        - to: default
          via: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4

EOF

netplan apply

echo "Network configuration has been updated and applied."

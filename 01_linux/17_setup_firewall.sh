#!/bin/bash

echo "Mengkonfigurasi iptables Firewall..."

iptables -F
iptables -X

iptables -P OUTPUT ACCEPT

iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

iptables -P INPUT DROP
iptables -P FORWARD DROP

iptables-save > /etc/iptables.rules

echo "Konfigurasi firewall selesai!"

iptables -L -v -n

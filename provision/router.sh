#!/bin/bash

set -e

echo "1" | sudo tee /proc/sys/net/ipv4/ip_forward
sudo iptables -A PREROUTING -t nat -i enp0s9 -p tcp --dport 8080 -j DNAT --to 192.168.56.120:80
sudo iptables -A FORWARD -p tcp -d 192.168.56.120 --dport 80 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -j MASQUERADE


#!/bin/sh

# Workaround for missing static ip in vagrant while using bridged vbox networking
# https://github.com/hashicorp/vagrant/issues/743

echo "source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet static
address $1/24
gateway $2
dns-nameservers $3" > /etc/network/interfaces

echo "nameserver $3" > /etc/resolv.conf

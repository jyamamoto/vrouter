#!/bin/bash
#
cat <<EOF > /etc/network/interfaces
source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto ens3
iface ens3 inet dhcp

# The secundary network interface
auto ens4
iface ens4 inet dhcp
EOF

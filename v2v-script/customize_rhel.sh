#!/bin/bash
#
cat <<EOF > /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=dhcp
EOF
#
cat <<EOF > /etc/sysconfig/network-scripts/ifcfg-eth1
DEVICE=eth1
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=dhcp
EOF
#
rm -f /etc/udev/rules.d/70-persistent-net.rules
#
cat <<EOF > /boot/grub2/device.map
(hd0)        /dev/vda
(hd1)        /dev/vda
EOF
#
dracut --regenerate-all --force

#! /bin/bash
# NIC CONFIG

# S1F2R5U5  - nic_config.sh 172.17.41.12	172.17.57.141	192.168.128.141	192.168.136.141	 172.20.31.41	192.168.144.141
# S1F2R5U3  - nic_config.sh 172.17.41.13	172.17.57.142	192.168.128.142	192.168.136.142	 172.20.31.42	192.168.144.142
# S1F2R5U1  - nic_config.sh 172.17.41.14	172.17.57.143	192.168.128.143	192.168.136.143	 172.20.31.43	192.168.144.143
# S1F2R6U3  - nic_config.sh 172.17.41.10	172.17.57.144	192.168.128.144	192.168.136.144	 172.20.31.44	192.168.144.144
# S1F2R6U1  - nic_config.sh 172.17.41.11	172.17.57.145	192.168.128.145	192.168.136.145	 172.20.31.45	192.168.144.145


IPPROV=$1
IPINTAPI=$2
IPPUBAPI=$3
IPTENANT=$4
IPST=$5
IPSTMGM=$6

cat > /etc/sysconfig/network-scripts /ifcfg-em1 << 'EOF'
DEVICE=em1
ONBOOT=yes
HOTPLUG=no
NM_CONTROLLED=no
PEERDNS=no
MASTER=bond0
SLAVE=yes
BOOTPROTO=none
EOF

cat > /etc/sysconfig/network-scripts /ifcfg-p1p1 << 'EOF'
DEVICE=p1p1
ONBOOT=yes
HOTPLUG=no
NM_CONTROLLED=no
PEERDNS=no
MASTER=bond1
SLAVE=yes
BOOTPROTO=none
EOF

  cat > /etc/sysconfig/network-scripts /ifcfg-p3p1 << 'EOF'
DEVICE=p1p1
ONBOOT=yes
HOTPLUG=no
NM_CONTROLLED=no
PEERDNS=no
MASTER=bond1
SLAVE=yes
BOOTPROTO=none
EOF
 
cat > /etc/sysconfig/network-scripts /ifcfg-bond0 << 'EOF'
DEVICE=bond0
ONBOOT=yes
HOTPLUG=no
NM_CONTROLLED=no
BOOTPROTO=static
IPADDR=${IPPROV}
PREFIX=21
BONDING_OPTS="mode=4 lacp_rate=1 updelay=1000 miimon=100"
EOF
 
cat > /etc/sysconfig/network-scripts /ifcfg-bond0.110 << 'EOF'
DEVICE=bond0.110
VLAN=yes
ONBOOT=yes
HOTPLUG=no
NM_CONTROLLED=no
BOOTPROTO=static
IPADDR=${IPINTAPI}
PREFIX=21
EOF

cat > /etc/sysconfig/network-scripts /ifcfg-bond1 << 'EOF'
DEVICE=bond1
ONBOOT=yes
HOTPLUG=no
NM_CONTROLLED=no
MTU=9000
BONDING_OPTS="mode=4 lacp_rate=1 updelay=1000 miimon=100"
EOF
 
cat > /etc/sysconfig/network-scripts /ifcfg-bond1.901 << 'EOF'
DEVICE=bond1.901
VLAN=yes
ONBOOT=yes
HOTPLUG=no
NM_CONTROLLED=no
BOOTPROTO=static
IPADDR=${IPPUBAPI}
PREFIX=21
EOF

cat > /etc/sysconfig/network-scripts /ifcfg-bond1.902 << 'EOF'
DEVICE=bond1.902
VLAN=yes
ONBOOT=yes
HOTPLUG=no
NM_CONTROLLED=no
BOOTPROTO=static
IPADDR=${IPTENANT}
PREFIX=21
EOF

cat > /etc/sysconfig/network-scripts /ifcfg-bond1.60 << 'EOF'
DEVICE=bond1.60
VLAN=yes
ONBOOT=yes
HOTPLUG=no
NM_CONTROLLED=no
BOOTPROTO=static
IPADDR=${IPST}
PREFIX=21
EOF

cat > /etc/sysconfig/network-scripts /ifcfg-bond1.903 << 'EOF'
DEVICE=bond1.903
VLAN=yes
ONBOOT=yes
HOTPLUG=no
NM_CONTROLLED=no
BOOTPROTO=static
IPADDR=${IPSTMGM}
PREFIX=21
EOF

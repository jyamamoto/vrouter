
net=muni-net-priv
subnet=muni-subnet-priv
ip_address=$2
vm_name=$1

if [ $# -eq 2 ]; then
	openstack port create --network $net --fixed-ip subnet=$subnet,ip-address=$ip_address --no-security-group port-$vm_name
else
	echo "uso: $0 <vm_name> <ip_address>"
fi

# Por si se necesita el security group
#   --security-group <security-group> | --no-security-group]

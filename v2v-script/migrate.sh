#!/bin/bash
#
#verificacion de argumentos
if [ $# -eq 3 ]; then
	vm_name=$1
	image_name=$2
	customize_file=$3

	#adaptacion de vm
	echo "PASO 1 - Adantando VM para OSP"
	virt-customize --run $customize_file --root-password password:redhat01 -a $image_name

	#obteniendo el tamaño de la imagen
	echo "PASO 2 - Obteniendo el tamaño de la imagen"
	image_size=$(qemu-img info $image_name | awk ‘{if (NR==4) print $3+0}’)

	#generando el volumen y almacenando el id
	echo "PASO 3 - Generando volumen y almacenando el id"
	volume_id=$(cinder create --display-name $vm_name $image_size --poll | awk ‘{if (NR==11) print $4}’)

	#se borra el volumen desde ceph dejando intactos los registros de openstack
	echo "PASO 4 - Se borra el volumen desde ceph dejando intactos los registros de openstack"
	rbd --user=openstack -p osp-volumes rm volume-$volume_id

	#convirtiendo la imagen a ceph e inyectando el nuevo volumen
	echo "PASO 5 - Convirtiendo la imagen a ceph e inyectando el nuevo volumen"
	qemu-img convert -p $image_name -O rbd rbd:osp-volumes/volume-$volume_id:id=openstack

	#declarando el volumen como booteable
	echo "PASO 6 - Declarando el volumen como booteable"
	cinder set-bootable $volume_id

	#exponiendo el id de volumen por pantalla
	echo "El siguiente VOLUMEN_ID $volume_id fue generado para la VM $vm_name" 
else
	echo “usage: migrate <vm_name> <image_file> <customize_file>”
fi

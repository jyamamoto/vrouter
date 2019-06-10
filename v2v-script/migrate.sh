#!/bin/bash
#
#verificacion de argumentos
if [ $# -eq 2 ] && [ -e $1 ] && [ -e $2 ]; then
	image_name=$1
	#adaptacion de vm
	virt-customize --run $2 --root-password password:redhat01 -a $image_name
	#obteniendo el tamaño de la imagen
	image_size=$(qemu-img info $image_name | awk ‘{if (NR==4) print $3+0}’)
	#generando el volumen y almacenando el id
	volume_id=$(cinder create $image_size --poll | awk ‘{if (NR==11) print $4}’)
	#se borra el volumen desde ceph dejando intactos los registros de openstack
	rbd --user=openstack -p osp-volumes rm volume-$volume_id
	#convirtiendo la imagen a ceph e inyectando el nuevo volumen
	qemu-img convert -p $image_name -O rbd rbd:osp-volumes/volume-$volume_id:id=openstack
	#declarando el volumen como booteable
	cinder set-bootable $volume_id
	#exponiendo el id de volumen por pantalla
	echo $volume_id
else
	echo “usage: migrate <image_file> <customize_file>”
fi

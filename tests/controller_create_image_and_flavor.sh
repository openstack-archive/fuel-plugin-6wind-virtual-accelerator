# Copyright 2016 6WIND S.A.
#
#!/bin/bash

UBUNTU_IMAGE="ubuntu-14.04-server-cloudimg-amd64-disk1.img"
IMAGE_NAME="ubuntu-cloud"

source openrc

#Required to be able to install iperf package since Cirros image does not provide it
curl https://cloud-images.ubuntu.com/trusty/current/trusty-server-cloudimg-amd64-disk1.img -o $UBUNTU_IMAGE
glance image-create --name $IMAGE_NAME --file $UBUNTU_IMAGE --disk-format qcow2 --container-format bare --visibility public --progress
nova flavor-create m1.vm_hugepages auto 512 3 1
nova flavor-key m1.vm_hugepages set hw:mem_page_size=large


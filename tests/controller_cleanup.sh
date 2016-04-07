# Copyright 2016 6WIND S.A.
#
#!/bin/bash

source openrc

glance image-delete ubuntu-cloud
nova flavor-delete m1.vm_hugepages
nova delete test_vm
floating_ip=$(nova floating-ip-list | grep net04_ext | awk '{print $4}')
nova floating-ip-delete $floating_ip
nova secgroup-delete-rule default tcp 1 65535 0.0.0.0/0


# Copyright 2016 6WIND S.A.
#
#!/bin/bash

source openrc

glance image-delete ubuntu-cloud
nova flavor-delete m1.vm_hugepages

STATUS=$(nova show test_vm | grep status | awk '{print $4}')
if [[ ${STATUS} == "ACTIVE" ]] || [[ ${STATUS} == "ERROR" ]]; then
    nova delete test_vm
fi
nova secgroup-delete-rule default tcp 1 65535 0.0.0.0/0


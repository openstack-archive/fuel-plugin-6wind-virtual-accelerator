# Copyright 2016 6WIND S.A.
#
#!/bin/bash

source openrc

NET_ID=$(neutron net-list | grep 192 | tail -n1 | awk '{print $2}')
nova boot --flavor m1.vm_hugepages --image ubuntu-cloud test_vm --nic net-id=$NET_ID --user-data /root/cloud.cfg

while [ $(nova list | grep test_vm | grep BUILD | wc -l) -eq 1 ]; do
    sleep 1;
done

STATUS=$(nova show test_vm | grep status | awk '{print $4}')

if [[ ${STATUS} == "ACTIVE" ]]; then
    exit 0
fi
exit 1

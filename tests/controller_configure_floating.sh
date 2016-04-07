# Copyright 2016 6WIND S.A.
#
#!/bin/bash

source openrc

FLOATING_IP=$(nova floating-ip-create net04_ext | grep net04_ext | tail -n1 | awk '{print $4}')

if [[ ! -z ${FLOATING_IP} ]]; then
    nova floating-ip-associate test_vm ${FLOATING_IP}
    nova secgroup-add-rule default tcp 1 65535 0.0.0.0/0
fi


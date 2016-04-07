# Copyright 2016 6WIND S.A.
#
#!/bin/bash

TAP_IFACE=$(ip link | grep tap | awk '{print $2}' | sed 's#:##' | tail -n1)
DRIVER=$(ethtool -i $TAP_IFACE | grep driver | awk '{print $2}')

if [[ ${DRIVER} -eq "dpvi" ]]; then
    exit 0
fi
exit 1

# Copyright 2016 6WIND S.A.
#
#!/bin/bash

source openrc
floating_ip=$(nova floating-ip-list | grep net04_ext | awk '{print $4}')

apt-get install -y iperf
echo "Wait 2 minutes to make sure that vm cloud-init has finished"
sleep 120
iperf -c $floating_ip -p 6000


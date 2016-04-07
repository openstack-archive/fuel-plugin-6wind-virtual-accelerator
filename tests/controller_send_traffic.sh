# Copyright 2016 6WIND S.A.
#
#!/bin/bash

source openrc
floating_ip=$(nova floating-ip-list | grep net04_ext | awk '{print $4}')

apt-get install -y iperf
iperf -c $floating_ip -p 6000


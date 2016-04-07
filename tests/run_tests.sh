# Copyright 2016 6WIND S.A.
#
#!/bin/bash

echo "Upload scripts to controller node"
scp controller_* cloud.cfg root@$CONTROLLER:/root/

echo "Upload scripts to compute node"
scp compute_* root@$COMPUTE:/root/

function cleanup {
    echo "Cleanup of testing resources"
    ssh root@$CONTROLLER 'bash /root/controller_cleanup.sh'
}

echo "Download the ubuntu cloud image to spawn vms and create flavor for hugepages support"
ssh root@$CONTROLLER 'bash /root/controller_create_image_and_flavor.sh'
if [[ $? -eq 1 ]]; then
    echo "TEST FAILED: Failed to download test cloud image. Exiting..."
    cleanup
    exit 1
fi

echo "Spawn an accelerated vm"
ssh root@$CONTROLLER 'bash /root/controller_launch_instance.sh'
if [[ $? -eq 1 ]]; then
    echo "TEST FAILED: Unable to launch accelerated instance. Exiting..."
    cleanup
    exit 1
fi

echo "Verify that network interface is managed by virtual accelerator"
ssh root@$COMPUTE 'bash /root/compute_verify_driver.sh'
if [[ $? -eq 1 ]]; then
    echo "TEST FAILED: Virtual machine network interface is not managed by 6WIND virtual accelerator. Exiting..."
    cleanup
    exit 1
fi

echo "Add security group tcp rule and associate floating ip"
ssh root@$CONTROLLER 'bash /root/controller_configure_floating.sh'
if [[ $? -eq 1 ]]; then
    echo "TEST FAILED: Unable to correctly configure floating ip and security group. Exiting..."
    cleanup
    exit 1
fi

echo "Check virtual accelerator statistics before traffic"
ssh root@$COMPUTE 'bash /root/compute_check_stats_before.sh'
if [[ $? -eq 1 ]]; then
    echo "TEST FAILED: Unable to retrieve virtual interface pre-stats. Exiting..."
    cleanup
    exit 1
fi

echo "Send traffic from controller to virtual machine"
ssh root@$CONTROLLER 'bash /root/controller_send_traffic.sh'
if [[ $? -eq 1 ]]; then
    echo "TEST FAILED: Unable to correctly send traffic to virtual machine. Exiting..."
    cleanup
    exit 1
fi

echo "Check virtual accelerator statistics after traffic"
ssh root@$COMPUTE 'bash /root/compute_check_stats_after.sh'
if [[ $? -eq 1 ]]; then
    echo "TEST FAILED: A part or all the traffic sent was not accelerated"
    cleanup
    exit 1
fi

echo "TEST PASSED"
cleanup
exit 0

User Guide
==========

This section provides a deeper explanation of plugin parameters and a description
of required steps to verify that everything is working fine after deployment.

Note that this User Guide provides information on 6WIND Virtual Accelerator
plugin for Fuel (and not on the 6WIND Virtual Accelerator software itself).
`Contact 6WIND <http://www.6wind.com/company-profile/contact-us/>`_
to obtain more details on how to retrieve the Virtual Accelerator software and
its documentation.

When configuring the 6WIND Virtual Accelerator Fuel plugin, you have to provide
credentials for Virtual Accelerator software download.
The plugin will then install and run the Virtual Accelerator using its default
configuration values.

Configuring 6WIND Virtual Accelerator parameters
------------------------------------------------

The 6WIND Virtual Accelerator plugin makes possible to modify these default
configuration parameters before deployment.
In order to do this you need to activate the **Advanced parameters** checkbox
in the 6WIND Virtual Accelerator Fuel plugin section in the Web UI Settings tab.

    .. image:: images/advanced.png
       :width: 100%

At this point some additional fields will show up and you will be able to edit
with your desired values.

In particular you can modify the following:

    *  `FP_MEMORY`

       This parameter defines the amount of memory (in MB) you want to reserve
       for Virtual Accelerator. Sample values are 1024, 512 or 'auto'.

    *  `VM_MEMORY`

       This parameter defines the total amount of memory (in MB) you want to
       reserve for accelerated virtual machines.
       Sample values are 2048, 4096, 'auto'.

For all these parameters you can always set value to 'auto' (default value).
In this case the plugin will compute the most suitable value according to
your system resources.


In some cases you may already have a Virtual Accelerator configuration file.
You can upload it to the nodes having the 6WIND Virtual Accelerator role enabled
using the dedicated `External configuration file for VA` field.
Note, this file will replace the default Virtual Accelerator configuration file
and overload all the defined configuration paramaters.

It is **strongly recommended** to provide a license file if you have one.
Without license the plugin will still correclty install the
6WIND Virtual Accelerator but it will run in evaluation mode (48 hours).
At the end of the evaluation period you will experience significant performance
degradation and loss of connectivity for your instances since there will be
nomore any hugepages backing.

Use updated libvirt and qemu packages
-------------------------------------

As briefly described in the installation section, in order to correctly spawn
virtual machines using the accelerated network stack 6WIND Virtual Accelerator
provides, the compute nodes need to run recent versions of libvirt and qemu
packages.


By default the 6WIND Virtual Accelerator Fuel plugin retrieves and installs
its updated libvirt and qemu packages from a remote repository maintained by 6WIND.
It is possible to force the plugin to keep the default libvirt and qemu packages
provided by the Linux distribution.


To do this simply unselect the **Use updated external packages** checkbox.
Note, default libvirt and qemu packages on MOS 8.0 do not have all the features
required for proper 6WIND Virtual Accelerator integration. Thus we strongly
advise to keep the **Use updated external packages** enabled.

Use cpu host emulation for guests
---------------------------------

Openstack makes possible to launch instances that emulate compute physical
(or virtual) CPU. In order to that libvirt should be configured accordingly
via the Nova configuration file.

This plugin offers the possibility to enable/disable such configuration in Nova
with a specific option (`Host cpu emulation for guests`) in the advanced
parameters.

Configure hugepages support for virtual machines
------------------------------------------------

In order to benefit from 6WIND Virtual Accelerator high performance networking,
hugepages support needs to be enabled in Nova flavors.
The plugin does not perform this configuration since it should be still
possible to spawn virtual machines that don't need network acceleration.

For this reason end-users have to explicitly configure the Nova flavors they
want to use when launching virtual machines for fast networking.
In order to that it is enough to enable hugepages support in the desired Nova
flavor.

On the controller node type the following command to configure a given flavor:

    ::

        nova flavor-key flavor set hw:mem_page_size=large

Sanity checks after deployment
------------------------------

The installation section of this document described how to correctly start a
Fuel deployment using the 6WIND Virtual Accelerator plugin.
At the end of this process the 6WIND Virtual Accelerator and its dependent
components should be all up and running.

As first step make sure that the system uses the proper libvirt and qemu
versions.

#. Check libvirt version (should be **1.3.1-1ubuntu6**)

    ::

        aptitude show libvirt-bin | grep Version

#. Check qemu version (should be **2.5+dfsg-5ubuntu6**)

    ::

        aptitude show qemu-system-x86 | grep Version

The next step is checking that the 6WIND Virtual Accelerator software and
its Openstack extensions have been correctly installed.

#. Check 6WIND Virtual Accelerator package status (should be **State: installed**)

    ::

        aptitude show virtual-accelerator | grep State

#. Check 6WIND openstack extensions package status (should be **State: installed**)

    ::

        aptitude show 6wind-openstack-extensions | grep State


If this check is successful, verify that that ALL the following services are
correctly running (each of them should be **start/running**):

    ::

        service virtual-accelerator status
        service openvswitch-switch status
        service neutron-plugin-openvswitch-agent status
        service libvirtd status
        service nova-compute status

If some of the services are not properly running, please restart ALL of them
in the same order used before for their status check.
Otherwise if everything is active you should be able to correctly spawn
virtual machines.
To do that please refer to `6WIND Openstack extensions official documentation <http://www.6wind.com/company-profile/contact-us/>`_.

Known issues
============

The current implementation of the 6WIND Virtual Accelerator plugin uses a credentials
package in base64 format for 6WIND software download.
This behavior should be replaced using a regular credentials package instead of
its base64 encoding.
Unfortunately a bug in Fuel (affecting both 7.0 and 8.0) does not make
possible to correctly retrieve this package from the upload utility.
`<https://bugs.launchpad.net/fuel/+bug/1545795>`_

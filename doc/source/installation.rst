Installation Guide
==================

Prerequisites
-------------

This guide assumes that you have `installed Fuel <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html>`_
and all the nodes of your future environment are discovered and functional.
Note, the 6WIND Virtual Accelerator Fuel plugin will download virtual
accelerator packages from a remote repository. Make sure that nodes can correctly
reach Internet.

To correctly deploy the 6WIND Virtual Accelerator Fuel plugin you will need
a credentials package (in base64 format).

If you have already purchased 6WIND software you should have this package,
otherwise contact 6WIND support team.
On the other hand, if you just want to evaluate the 6WIND Virtual Accelerator
you still need to `contact 6WIND <http://www.6wind.com/company-profile/contact-us/>`_.

Requirements
------------

This plugin is intended to be installed on nodes running Fuel 7.0 (version 7.0.0)
Verify this typing the following command:
    ::

        fuel --version

In order to correctly install the 6WIND Virtual Accelerator plugin on Fuel
compute(s) the following requirements are mandatory:

#.   Use KVM as hypervisor virtualization driver
#.   Deploy on compute node(s) with **at least 4GB of RAM and 2 cpus**
#.   Internet connectivity on Master node (since the plugin will download software from 6WIND remote repositories)

This version of plugin supports VLAN and VxLAN as networking tunneling option.

The 6WIND Virtual Accelerator needs qemu and libvirt supporting vhostuser and
multiqueue features to correclty run its fast packet processing stack.
In particular on the compute nodes the following packages are needed:

#.   libvirt-bin (1.3.1-1ubuntu6)
#.   qemu (2.5+dfsg-5ubuntu6)

Note that Mirantis official repositories do not provide these packages.
For this reason the default behavior for the plugin is to retrieve the
6WIND libvirt and qemu packages and replace the Mirantis ones in the early
stages of deployment.


Installing 6WIND Virtual Accelerator Plugin
-------------------------------------------

#.  Download 6WIND Virtual Accelerator plugin from the `Fuel Plugins Catalog <https://software.mirantis.com/download-mirantis-openstack-fuel-plug-ins/>`_.
#.  Copy the downloaded rpm to the Fuel Master node:
    ::

        scp 6wind-virtual-accelerator-1.0-1.0.4-1.noarch.rpm  <Fuel Master node ip>:/tmp/

#.  Log into the Fuel Master node and install the plugin
    ::

        ssh <the Fuel Master node ip>
        fuel plugins --install /tmp/6wind-virtual-accelerator-1.0-1.0.4-1.noarch.rpm

#.  Now verify that the plugin is correctly installed
    ::

        fuel plugins
        3  | 6wind-virtual-accelerator | 1.0.4   | 3.0.0

    ..


Configuring 6WIND Virtual Accelerator Plugin
--------------------------------------------

#.  First you have to `create environment <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#create-a-new-openstack-environment>`_ in Fuel Web UI.

    .. image:: images/name_release.png
       :width: 70%

#.  Please select KVM hypervisor type for your environment.

    .. image:: images/hypervisor.png
       :width: 80%

#.  Please select Neutron networking.
    The 6WIND Virtual Accelerator supports VLAN and VxLAN segmentation.

    .. image:: images/network.png
       :width: 80%

#.  Activate the plugin in the Fuel Web UI Settings tab

    .. image:: images/activation.png
       :width: 90%

#.  Configure fields with correct values:

    *   Provide base64 credentials package you received from 6WIND support team

    *   Provide the license file to be used for 6WIND Virtual Accelerator
        activation

    *   Refer to next chapter for the description of Advanced Paramaters fields.


#.  Add nodes and assign them the following roles:

    *   At least 1 Controller

    *   At least one node with both Compute and 6WIND Virtual Accelerator roles.
        Make sure that the chosen node has **at least 2 cpus and 6 GB of RAM**

    .. image:: images/node-roles.png
       :width: 100%


#.  Verify nodes network connectivity (in the Fuel Web UI Network tab)

    .. image:: images/connectivity.png
       :width: 100%

#.  Press **Deploy changes** to `deploy the environment <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#
    deploy-changes>`_.




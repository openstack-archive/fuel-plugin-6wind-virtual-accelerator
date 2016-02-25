Installation Guide
==================

Prerequisites
-------------

This guide assumes that you have `installed Fuel <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html>`_
and all the nodes of your future environment are discovered and functional.
Note, the 6WIND virtual accelerator Fuel plugin will download virtual
accelerator packages from a remote repository. To perform this download you will
need credentials.


If you have already purchased 6WIND software you should have these credentials,
otherwise contact 6WIND support team.
On the other hand, if you just want to evaluate the 6WIND virtual accelerator
you still need to `contact 6WIND <http://www.6wind.com/company-profile/contact-us/>`_ to obtain these credentials.


Installing 6WIND virtual accelerator Plugin
-------------------------------------------

#.  Download 6WIND virtual accelerator plugin from the `Fuel Plugins Catalog <https://software.mirantis.com/download-mirantis-openstack-fuel-plug-ins/>`_.
#.  Copy the downloaded rpm to the Fuel Master node:
    ::

        scp 6wind-virtual-accelerator-1.0-1.0.0-1.noarch.rpm  <Fuel Master node ip>:/tmp/

#.  Log into the Fuel Master node and install the plugin
    ::

        ssh <the Fuel Master node ip>
        fuel plugins --install /tmp/6wind-virtual-accelerator-1.0-1.0.0-1.noarch.rpm

#.  You should get the following output
    ::

        Plugin 6wind-virtual-accelerator-1.0-1.0.0-1.noarch.rpm  was successfully installed
    ..


Configuring 6WIND virtual accelerator Plugin
--------------------------------------------

#.  First you have to `create environment <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#create-a-new-openstack-environment>`_ in Fuel Web UI.

    .. image:: images/name_release.png
       :width: 70%

#.  Please select KVM hypervisor type for your environment.

    .. image:: images/hypervisor.png
       :width: 80%

#.  Please select Neutron networking.
    The 6WIND virtual accelerator supports all tunneling models (VXLAN, GRE) and
    VLAN segmentation.
    For GRE segmentation you need to enable it from Fuel CLI

    .. image:: images/network.png
       :width: 80%

#.  Activate the plugin in the Fuel Web UI Settings tab

    .. image:: images/activation.png
       :width: 90%

#.  Configure fields with correct values:

    *   Provide credentials you received from 6WIND support team

    *   Refer to next chapter for detailed field description and configuration


#.  Add nodes and assign them the following roles:

    *   At least 1 Controller

    *   At least one node with both Compute and 6WIND Virtual Accelerator roles.
        Make sure that the chosen node has at least 2 virtual cpus and 4 GB of RAM

    .. image:: images/node-roles.png
       :width: 100%


#.  Press **Deploy changes** to `deploy the environment <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#
    deploy-changes>`_.




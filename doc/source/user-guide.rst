User Guide
==========

When configuring the 6WIND virtual accelerator Fuel plugin, you have to provide
credentials for virtual accelerator software download.
The plugin will then install and run the virtual accelerator using its default
configuration values.

Configuring 6WIND virtual accelerator parameters
------------------------------------------------

The 6WIND virtual accelerator plugin makes possible to modify these default
configuration parameters before deployment.
In order to do this you need to activate the **Advanced parameters** checkbox
in the 6WIND Virtual Accelerator fuel plugin section in the Web UI Settings tab.

    .. image:: images/advanced.png
       :width: 100%

At this point some additional fields will show up and you will be able to edit
with your desired values.
Please contact 6WIND support team or refer to 6WIND virtual accelerator documentation
for more information on the meaning of these fields.


If you already have a virtual accelerator configuration file,
you can upload it to the nodes having the 6WIND Virtual Accelerator role enabled.
Note, this file will replace the default virtual accelerator configuration file
and overload all the defined configuration paramaters.

Use updated libvirt and qemu packages
-------------------------------------

In order to correctly spawn virtual machines using the accelerated network
stack 6WIND virtual accelerator provides, the compute nodes need to run recent
versions of libvirt and qemu packages.


By default the 6WIND virtual accelerator Fuel plugin retrieves and installs
these updated packages from a remote repository maintained by 6WIND.
It is possible to force the plugin to keep the default libvirt and qemu packages
provided by the Linux distribution.


To do this simply unselect the **Use updated external packages** checkbox.
Note, default libvirt and qemu packages on MOS 7.0 do not have all the features
required for proper 6WIND virtual accelerator integration. Thus we strongly
advise to keep the **Use updated external packages** enabled.

Known issues
============

The current implementation of the 6WIND virtual accelerator plugin uses credentials
for virtual accelerator package download.
This behavior should be replaced using a credentials package instead of a
login/password pair.
Unfortunately a bug in Fuel 7.0 does not make possible to correctly retrieve
this package from the upload utility.
`<https://bugs.launchpad.net/fuel/+bug/1545795>`_

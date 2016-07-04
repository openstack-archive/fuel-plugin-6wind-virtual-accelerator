..
 This work is licensed under a Creative Commons Attribution 3.0 Unported
 License.

 http://creativecommons.org/licenses/by/3.0/legalcode

======================================================
Fuel Plugin for 6WIND Virtual Accelerator installation
======================================================

The Fuel plugin for 6WIND Virtual Accelerator allows to install and integrate
the Virtual Accelerator on desired nodes (compute) running Mirantis Openstack 8.0.

This plugin uses the Fuel pluggable architecture and it must be compatible with
the version 8.0 of Mirantis OpenStack.

Problem description
===================



Proposed change
===============

Implement a Fuel plugin which will perform all the necessary steps to install
and configure Mirantis OpenStack nodes to use the 6WIND Virtual Accelerator.

Alternatives
------------

SR-IOV

Data model impact
-----------------

None

REST API impact
---------------

None

Upgrade impact
--------------

When upgrading to newer versions of Mirantis Openstack, this plugin should be
upgraded accordingly.

Security impact
---------------

None. Nova security groups are still supported for deployed VMs on all compute
nodes running 6WIND VA.

Notifications impact
--------------------

None

Other end user impact
---------------------

After plugin installation, the end user can enable it on the Setting tab of the
Fuel web UI and customize plugin settings.

Performance Impact
------------------

Other deployer impact
---------------------

Developer impact
----------------

Implementation
==============

Assignee(s)
-----------

Primary assignee:

- Francesco Santoro <francesco.santoro@6wind.com>

Other contributors:

- Samuel Gauthier <samuel.gauthier@6wind.com> - developer
- Karim Mchirki   <karim.mchirki@6wind.com> - developer

Work Items
----------

* Create test environment (physical servers or KVM based vms)
* Create Fuel plugin bundle (containing deployments scripts, puppet modules and
  metadata)
* Implement puppet modules with the following functions:

 - Retrieve 6WIND Virtual Accelerator software from repository
 - Eventually updates libvirt and qemu Mirantis Openstack packages on compute nodes
 - 6WIND Virtual Accelerator deployment on selected OpenStack nodes
 - Configure Mirantis Openstack to support 6WIND Virtual Accelerator

* Test 6WIND Virtual Accelerator plugin
* Create Documentation


Dependencies
============

* Fuel 8.0
* Hypervisor with KVM capability
* Qemu with vhost-user and hugepage support

Testing
=======

* Sanity checks including plugin build
* Syntax check
* Functional testing
* Non-functional testing (Destructive and Negative)

Documentation Impact
====================

* Deployment Guide (how to prepare environment for plugin installation and configuration before MOS deployment)
* User Guide (list of features the plugin provides, how to customize them in the deployed MOS environment)
* Test Plan
* Test Report

References
==========

* Fuel Plugins Guide https://wiki.openstack.org/wiki/Fuel/Plugins
* 6WIND Virtual Accelerator product info http://www.6wind.com/products/6wind-virtual-accelerator/

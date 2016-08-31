Introduction
============

This document contains instructions for installing and configuring 6WIND Virtual
Accelerator plugin for Fuel.

Key terms, acronyms and abbreviations
-------------------------------------

+---------------------------+---------------------------+
| 6WIND Virtual Accelerator |                           |
|                           |                           |
+---------------------------+---------------------------+
| VA                        | 6WIND Virtual Accelerator |
+---------------------------+---------------------------+
| MOS                       | Mirantis Openstack        |
+---------------------------+---------------------------+

Overview
--------

.. |va| replace:: Virtual Accelerator
.. |6w| replace:: 6WIND
.. |6Wg| replace:: 6WIND Gate

|va| is a product of the |6w| speed series that provides packet processing
acceleration for virtual network infrastructures.

|va| runs inside the hypervisor and removes the performance bottlenecks by
offloading virtual switching from the networking stack. The cpu resources
necessary for packet processing are drastically reduced, so that less cores are
required to process network traffic at higher rates and Linux stability is
increased.

In addition to simple virtual switching (using OVS or the Linux bridge), |va|
supports an extensive set of networking protocols to provide a complete virtual
networking infrastructure.

|va| is fully integrated with Linux and its environment, so that existing Linux
applications do not need to be modified to benefit from packet processing
acceleration.

|va| is available for Intel x86-based servers and supports major Linux
distributions.

|va| is provided in three flavors according to the required feature set:

- baseline: simple virtual switching and ip forwarding
- L3: baseline + advanced L3 features such as vrf, filtering and nat
- ipsec: L3 + ipsec features

Features
--------

.. rubric:: High performance I/Os leveraging dpdk, with multi-vendor nic support
            from Intel, Mellanox and Emulex

- Intel 10G/40G XL710
- Intel 10G 82598, 82599, X540
- Mellanox 10G/40G ConnectX®-3 EN and ConnectX®-3 Pro EN series
- Mellanox 10G/25G/50G/100G ConnectX®-4 EN and ConnectX®-4 Lx EN series
- Emulex 10G/40G OneConnect® OCe14000 family
- Intel 1G 82575, 82576, 82580, I210, I211, I350, I354

.. rubric:: High performance virtual switching

- OVS acceleration
- Linux Bridge

.. rubric:: High performance virtual networking

In addition to virtual switching, |va| supports a complete set of networking
protocols, based on the |6wg| technology, that can be used to design
innovative virtual networking infrastructures.

- |va| baseline

  - Forwarding (ipv4 and ipv6)
  - vxlan
  - vlan
  - gre
  - Linux bridge filtering

- |va| L3

  - vrf
  - Filtering (ipv4 and ipv6)
  - nat
  - Tunneling (IPinIP)

- |va| ipsec

  - Intel Multi-Buffer and QuickAssist crypto
  - ipsec (ipv4 and ipv6)
  - ike (v1 and v2)

.. rubric:: Support of standard Virtio drivers

|va| comes with a high performance Virtio back-end driver for communication
with any guest running Virtio front-end drivers (can be based on dpdk, Linux,
or other OSes).

.. rubric:: Seamless integration with management and orchestration tools

|va| is fully integrated with Linux and its environment, so that existing Linux
applications do not need to be modified to benefit from packet processing
acceleration. Standard Linux APIs are preserved, including iproute2, iptables,
brctl, ovs-ofctl, ovs-vsctl, etc.

|va| is also validated with the Mirantis Openstack cloud operating system:

- Supports Mirantis Openstack 9.0

Supported platforms
-------------------

|va| is provided as a set of binary packages and is validated on the following
distributions:

- ubuntu-14.04
- redhat-7
- centos-7

.. seealso:: Refer to the |va| Release Notes for detailed information about the
             latest validated versions of the Linux distributions.


Licensing information
---------------------

+---------------------------+------------+
| 6WIND Virtual Accelerator | Commercial |
+---------------------------+------------+

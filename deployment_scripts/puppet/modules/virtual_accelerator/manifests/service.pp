#
# Copyright 2016 6WIND S.A.

class virtual_accelerator::service inherits virtual_accelerator {

  service { 'virtual-accelerator':
    ensure => 'running',
  } ->
  exec { 'restart_ovs':
     command => 'service openvswitch-switch restart',
  } ->
  exec { 'restart_ovs_agent':
     command => 'service neutron-plugin-openvswitch-agent restart',
  } ->
  exec { 'stop_libvirt':
      command => 'service libvirt-bin stop',
  } ->
  exec { 'restart_libvirt':
      command => 'service libvirtd restart',
  } ->
  exec { 'restart_nova':
      command => 'service nova-compute restart',
  }

}

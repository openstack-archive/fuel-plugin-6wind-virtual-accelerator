#
# Copyright 2016 6WIND S.A.

class virtual_accelerator::service inherits virtual_accelerator {

  $NOVA_CONF_FILE = "/etc/nova/nova.conf"

  service { 'virtual-accelerator':
    ensure => 'running',
  } ->
  exec { 'vcpu_pin':
     command => "crudini --set ${NOVA_CONF_FILE} DEFAULT vcpu_pin_set $(python /usr/local/bin/get_vcpu_pin_set.py)",
  }
  exec { 'restart_ovs':
     command => 'service openvswitch-switch restart',
  } ->
  exec { 'restart_ovs_agent':
     command => 'service neutron-plugin-openvswitch-agent restart',
  } ->
  service { 'libvirt-bin':
    ensure => 'stopped',
  } ->
  exec { 'restart_libvirt':
      command => 'service libvirtd restart',
  } ->
  exec { 'restart_nova':
      command => 'service nova-compute restart',
  }

}

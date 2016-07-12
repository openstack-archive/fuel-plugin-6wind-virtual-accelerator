#
# Copyright 2016 6WIND S.A.

class virtual_accelerator::service inherits virtual_accelerator {

  $NOVA_CONF_FILE = "/etc/nova/nova.conf"
  $enable_host_cpu = $virtual_accelerator::enable_host_cpu

  if $enable_host_cpu == true {
     command => "crudini --set ${NOVA_CONF_FILE} libvirt cpu_mode host-passthrough",
     notify => Exec['vcpu_pin'],
  }

  exec { 'vcpu_pin':
      command => "crudini --set ${NOVA_CONF_FILE} DEFAULT vcpu_pin_set $(python /usr/local/bin/get_vcpu_pin_set.py)",
      notify => Service['virtual-accelerator'],
  }

  service { 'virtual-accelerator':
      ensure => 'running',
      notify => Service['openvswitch-switch'],
  }

  service { 'openvswitch-switch':
      ensure => 'running',
      notify => Service['neutron-plugin-openvswitch-agent'],
  }

  service { 'neutron-plugin-openvswitch-agent':
      ensure => 'running',
      notify => Service['libvirt-bin'],
  }

  service { 'libvirt-bin':
      ensure => 'stopped',
      notify => Service['libvirtd'],
  }

  service { 'libvirtd':
      ensure => 'running',
      notify => Service['nova-compute'],
  }

  service { 'nova-compute':
      ensure => 'running',
  }

}

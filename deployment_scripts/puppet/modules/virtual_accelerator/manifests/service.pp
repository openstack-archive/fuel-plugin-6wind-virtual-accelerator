#
# Copyright 2016 6WIND S.A.

class virtual_accelerator::service inherits virtual_accelerator {

  $NOVA_CONF_FILE = "/etc/nova/nova.conf"
  $enable_host_cpu = $virtual_accelerator::enable_host_cpu
  $use_builtin_dpdk = $virtual_accelerator::use_builtin_dpdk

  if $enable_host_cpu == true {
    exec { 'cpu_host':
        command => "crudini --set ${NOVA_CONF_FILE} libvirt cpu_mode host-passthrough",
        notify => Exec['vcpu_pin'],
    }
  }

  if $use_builtin_dpdk == true {
    $hugepages_file = "/sys/kernel/mm/hugepages/hugepages-2048kB"

    exec { 'reset_hugepages':
        command => "echo 0 > ${hugepages_file}/nr_hugepages",
        notify => Exec['vcpu_pin'],
    }
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
      notify => Service['neutron-openvswitch-agent'],
  }

  service { 'neutron-openvswitch-agent':
      ensure => 'running',
  }

  # Let's make sure to use the default hugetlbfs mount point (that could have
  # been modified by Fuel)
  exec { 'disable_custom_hugepages_dir_qemu':
      command => "sed -i 's~^hugetlbfs_mount =~#hugetlbfs_mount =~' /etc/libvirt/qemu.conf",
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

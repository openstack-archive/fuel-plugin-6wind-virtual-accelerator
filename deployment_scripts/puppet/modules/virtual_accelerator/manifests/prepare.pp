#
# Copyright 2016 6WIND S.A.

class virtual_accelerator::prepare inherits virtual_accelerator {

  $dpdk_interfaces_file = "/usr/local/etc/dpdk_interfaces_file"
  $use_builtin_dpdk = $virtual_accelerator::use_builtin_dpdk

  exec { 'copy_dpdk_interfaces':
      command => "cp /etc/dpdk/interfaces ${dpdk_interfaces_file}",
  }

  if $use_builtin_dpdk == true {

    service { 'openvswitch-switch':
      ensure => 'stopped',
      notify => Package['dpdk-dkms'],
    }

    package { 'dpdk-dkms':
        ensure => 'absent',
        notify => Package['openvswitch-dpdk'],
    }

    package { 'openvswitch-switch-dpdk':
        ensure => 'absent',
    }

    exec { 'disable_dpdk_startup':
      command => 'echo manual > /etc/init/dpdk.override',
    }

  }

}

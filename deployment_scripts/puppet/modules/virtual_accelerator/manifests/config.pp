#
# Copyright 2016 6WIND S.A.

class virtual_accelerator::config inherits virtual_accelerator {

  $advanced_params = $virtual_accelerator::advanced_params

  file { '/etc/apparmor.d/disable/usr.sbin.libvirtd':
    ensure => 'link',
    target => '/etc/apparmor.d/usr.sbin.libvirtd',
  }

  $fp_mem = $virtual_accelerator::fp_mem

  file { '/usr/local/etc/fast-path.env':
    ensure => present,
    source => "/usr/local/etc/fast-path.env.tmpl",
  } ->
  exec { 'set_fp_mem':
    command => "config_va.sh FP_MEMORY ${fp_mem}",
    path    => '/usr/local/bin/',
  }

  if $advanced_params == true {
    $custom_conf_file = $virtual_accelerator::va_conf_file

    if $custom_conf_file != '' {
      exec { 'copy_custom_conf':
        command => "echo ${custom_conf_file} > /usr/local/etc/fast-path.env",
      }
    }
    else {
      $cores_per_port = $virtual_accelerator::cores_per_port
      exec { 'set_core':
        command => "config_va.sh CORE_PER_PORT ${cores_per_port}",
        path    => '/usr/local/bin/',
      }

      $vm_mem = $virtual_accelerator::vm_mem
      exec { 'set_vm_mem':
        command => "config_va.sh VM_MEMORY ${vm_mem}",
        path    => '/usr/local/bin/',
      }
    }
  }
}

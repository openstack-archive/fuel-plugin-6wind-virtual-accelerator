#
# Copyright 2016 6WIND S.A.

class virtual_accelerator::config inherits virtual_accelerator {

  $advanced_params = $virtual_accelerator::advanced_params

  file { '/etc/apparmor.d/disable/usr.sbin.libvirtd':
    ensure => 'link',
    target => '/etc/apparmor.d/usr.sbin.libvirtd',
  }

  exec {'disable_apparmor':
    command => "sed -i -- 's/unix,/#unix,/g' /etc/apparmor.d/usr.sbin.libvirtd && apparmor_parser -R /etc/apparmor.d/usr.sbin.libvirtd",
    unless  => "apparmor_parser -R /etc/apparmor.d/usr.sbin.libvirtd",
  }

  file { '/usr/local/etc/fast-path.env':
    ensure => present,
    source => "/usr/local/etc/fast-path.env.tmpl",
  }

  if $advanced_params == true {
    $custom_conf_file = $virtual_accelerator::va_conf_file

    if $custom_conf_file != '' {
      exec { 'copy_custom_conf':
        command => 'echo ${custom_conf_file} > /usr/local/etc/fast-path.env',
      }
    }
    else {
      $cores_per_port = $virtual_accelerator::cores_per_port
      exec { 'set_core':
        command => 'config_va.sh CORE_PER_PORT ${cores_per_port}',
        path    => '/usr/local/bin/',
      }

      $vm_mem = $virtual_accelerator::vm_mem
      exec { 'set_vm_mem':
        command => 'config_va.sh VM_MEMORY ${vm_mem}',
        path    => '/usr/local/bin/',
      }
    }
  }

  $admin_iface = $virtual_accelerator::admin_iface
  exec { 'blacklist_admin_iface':
    command => 'config_va.sh blacklist ${admin_iface}',
    path    => '/usr/local/bin/',
  }

  $fp_mem = $virtual_accelerator::fp_mem
  exec { 'set_fp_mem':
    command => 'config_va.sh FP_MEMORY ${fp_mem}',
    path    => '/usr/local/bin/',
  }

}

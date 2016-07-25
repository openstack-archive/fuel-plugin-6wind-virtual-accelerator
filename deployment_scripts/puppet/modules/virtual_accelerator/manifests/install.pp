#
# Copyright 2016 6WIND S.A.

class virtual_accelerator::install inherits virtual_accelerator {

  exec { 'update_repos':
      command => '/usr/bin/apt-get -y update',
  } ->
  package { 'dkms':
    ensure          => 'absent',
  } ->
  package { 'virtual-accelerator':
    ensure          => 'installed',
    install_options => ['--allow-unauthenticated'],
  }

  file { '/usr/local/bin/config_va.sh':
    owner   => 'root',
    group   => 'root',
    mode    => 0777,
    source  => 'puppet:///modules/virtual_accelerator/config_va.sh',
  }

  exec { 'install_linux_headers':
      command => 'apt-get install -y linux-headers-$(uname -r)',
  } ->
  package { 'crudini':
    ensure => 'installed',
  } ->
  package { "6wind-openstack-extensions":
    ensure   => 'installed',
    install_options => ['--allow-unauthenticated'],
  }

}

#
# Copyright 2016 6WIND S.A.

class virtual_accelerator::install inherits virtual_accelerator {

  $app_note_version = $virtual_accelerator::app_note_version
  $app_note_archive = $virtual_accelerator::app_note_archive
  $app_note_folder = $virtual_accelerator::app_note_folder

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

  notify {"Retrieving 6WIND openstack extensions package":}
  file { "/root/${app_note_archive}":
    owner   => 'root',
    group   => 'root',
    mode    => 0644,
    source => "puppet:///modules/virtual_accelerator/${app_note_archive}",
  }

  exec { 'untar-app-note':
    command => "tar -xzf /root/${app_note_archive} -C /tmp",
  }

  exec { 'install_linux_headers':
      command => 'apt-get install -y linux-headers-$(uname -r)',
  }

  package { 'crudini':
    ensure => 'installed',
  }

  notify {"Installing 6WIND openstack extensions package":}
  package { "6wind-openstack-extensions":
    provider => 'dpkg',
    ensure   => 'installed',
    source   => "/tmp/${app_note_folder}/6wind-openstack-extensions-${app_note_version}.deb"
  }

}

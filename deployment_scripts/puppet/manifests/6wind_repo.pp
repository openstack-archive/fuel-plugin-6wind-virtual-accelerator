#
# Copyright 2016 6WIND S.A.

notice('MODULAR: virtual_accelerator/6wind_repo.pp')

$settings = hiera('6wind-virtual-accelerator', {})

$app_note_version = "1.2"
$va_version = "1.3"

$cred_package_content = $settings['credentials_package'][content]
$cred_package_name = $settings['credentials_package'][name]

if $cred_package_name !~ /.+[.]deb[.]b64?/ {
  fail('The given credentials package has wrong format')
}

file {"/tmp/${cred_package_name}":
  ensure => file,
  content => $cred_package_content,
} ->
exec { 'decode_credentials':
  command => "/usr/bin/base64 --decode /tmp/${cred_package_name} > /tmp/6wind-authentication-credentials.deb",
} ->
package { "6wind-authentication-credentials":
  provider => 'dpkg',
  ensure   => 'installed',
  source   => "/tmp/6wind-authentication-credentials.deb"
} ->
exec { 'retrieve_va_repo':
  command => "/usr/bin/curl --cacert /usr/local/etc/certs/ca.crt --key /usr/local/etc/certs/client.key --cert /usr/local/etc/certs/client.crt -o /tmp/6wind-virtual-accelerator-repository.deb https://repo.6wind.com/virtual-accelerator/ubuntu-14.04/$(dpkg --print-architecture)/${va_version}/6wind-virtual-accelerator-ubuntu-14.04-repository_${va_version}-1_$(dpkg --print-architecture).deb",
} ->
package { "6wind-virtual-accelerator-repository":
  provider => 'dpkg',
  ensure   => 'installed',
  source   => "/tmp/6wind-virtual-accelerator-repository.deb"
} ->
exec { 'retrieve_app_note_repo':
  command => "/usr/bin/curl --cacert /usr/local/etc/certs/ca.crt --key /usr/local/etc/certs/client.key --cert /usr/local/etc/certs/client.crt -o /tmp/6wind-openstack-extensions-repository.deb https://repo.6wind.com/openstack-extensions/ubuntu-14.04/all/${app_note_version}/6wind-openstack-extensions-ubuntu-14.04-repository_${app_note_version}-1_all.deb",
} ->
package { "6wind-openstack-extensions-repository":
  provider => 'dpkg',
  ensure   => 'installed',
  source   => "/tmp/6wind-openstack-extensions-repository.deb"
} ->
file { '/etc/apt/preferences.d/6wind-virtual-accelerator.pref':
  owner   => 'root',
  group   => 'root',
  mode    => 0644,
  source => 'puppet:///modules/virtual_accelerator/6wind-virtual-accelerator.pref',
}

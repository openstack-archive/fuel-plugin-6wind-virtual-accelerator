#
# Copyright 2016 6WIND S.A.

class virtual_accelerator::neutron_conf inherits virtual_accelerator {

  $advanced_params = $virtual_accelerator::advanced_params

  $disable_ipset = $virtual_accelerator::disable_ipset
  $va_version = $virtual_accelerator::va_version

  if $disable_ipset == true or $va_version == '1.3' {
      $OVS_CONF_FILE = "/etc/neutron/plugins/ml2/ml2_conf.ini"

      package { 'crudini':
         ensure => 'latest',
      } ->
      exec { 'disable_ipset':
         command => "crudini --set ${OVS_CONF_FILE} securitygroup enable_ipset False",
         notify => Service['openvswitch-switch'],
      }

      service { 'openvswitch-switch':
         ensure => 'running',
         notify => Service['neutron-openvswitch-agent'],
      }

      service { 'neutron-openvswitch-agent':
         ensure => 'running',
      }
  }

}


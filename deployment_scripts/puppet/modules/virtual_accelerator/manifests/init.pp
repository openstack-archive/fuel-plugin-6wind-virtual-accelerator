#
# Copyright 2016 6WIND S.A.

class virtual_accelerator {

  # Export exec path
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  # General configuration
  $settings = hiera('6wind-virtual-accelerator', {})

  # 6WIND virtual accelerator settings
  $advanced_params = $settings['advanced_params_enabled']
  $fp_mem = $settings['fp_mem']
  $cores_per_port = $settings['cores_per_port']
  $vm_mem = $settings['vm_mem']
  $va_conf_file = ''

  if $settings['va_conf_file'] {
    $va_conf_file = $settings['va_conf_file'][content]
  }
  if $settings['va_license_file'] {
    $va_license_file = $settings['va_license_file'][content]
  }
}

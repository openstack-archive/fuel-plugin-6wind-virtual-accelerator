#
# Copyright 2016 6WIND S.A.

class virtual_accelerator {

  # Export exec path
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  # General configuration
  $settings = hiera('6wind-virtual-accelerator', {})

  # 6WIND Virtual Accelerator settings
  $advanced_params = $settings['advanced_params_enabled']
  $fp_mem = $settings['fp_mem']
  $vm_mem = $settings['vm_mem']
  $va_conf_file = ''
  $enable_host_cpu = $settings['enable_host_cpu']

  if $settings['va_conf_file'] {
    $va_conf_file = $settings['va_conf_file'][content]
  }
  if $settings['va_license_file'] {
    $va_license_file = $settings['va_license_file'][content]
  }

  # Retrieve dpdk settings
  $dpdk_options = hiera('dpdk', {})
  $use_builtin_dpdk = pick($dpdk_options['enabled'], false)
}

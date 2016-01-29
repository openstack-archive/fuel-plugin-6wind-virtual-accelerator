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
  $va_conf_file = $settings['va_conf_file'][content]

  # Both these variables should not be hard-coded but it's just a temporary
  # solution since this information won't be necessary in future releases of
  # plugin
  $app_note_version = "1.2.2"
  $app_note_folder = "6wind-app-note-openstack-support-v${app_note_version}-ubuntu-14.04"
  $app_note_archive_ext = ".tar.gz"
  $app_note_archive = "${$app_note_folder}${$app_note_archive_ext}"

  # TODO: add url for distant repo + key
}

#
# Copyright 2016 6WIND S.A.

notice('MODULAR: virtual_accelerator/neutron_conf.pp')

include virtual_accelerator
class { 'virtual_accelerator::neutron_conf': }
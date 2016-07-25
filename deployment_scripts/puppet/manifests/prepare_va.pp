#
# Copyright 2016 6WIND S.A.

notice('MODULAR: virtual_accelerator/prepare_va.pp')

include virtual_accelerator
class { 'virtual_accelerator::prepare': }
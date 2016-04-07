# Copyright 2016 6WIND S.A.
#
#!/bin/bash

TAP_IFACE=$(ip link | grep tap | awk '{print $2}' | sed 's#:##' | tail -n1)

NB_TAP_PACKETS_BEFORE=$(ethtool -S $TAP_IFACE | grep rx.good_packets | awk '{print $2}')
NB_FP_VSWITCH_PACKETS_BEFORE=$(fp-cli dump-stats | grep output_ok | sed 's#:# ##' | awk '{print $2}')
NB_EXCEPTIONS_BEFORE=$(fp-cli dump-stats | grep LocalBasicExceptions | sed 's#:# ##' | awk '{print $2}')

echo $NB_TAP_PACKETS_BEFORE > /tmp/6WIND_va_nb_tap_before
echo $NB_FP_VSWITCH_PACKETS_BEFORE > /tmp/6WIND_va_fp_vswitch_before
echo $NB_EXCEPTIONS_BEFORE > /tmp/6WIND_va_nb_exc_before


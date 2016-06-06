# Copyright 2016 6WIND S.A.
#
#!/bin/bash

TAP_IFACE=$(ip link | grep tap | awk '{print $2}' | sed 's#:##' | tail -n1)

NB_TAP_PACKETS_BEFORE=$(cat /tmp/6WIND_va_nb_tap_before)
NB_FP_VSWITCH_PACKETS_BEFORE=$(cat /tmp/6WIND_va_fp_vswitch_before)
NB_EXCEPTIONS_BEFORE=$(cat /tmp/6WIND_va_nb_exc_before)

NB_TAP_PACKETS_AFTER=$(ethtool -S $TAP_IFACE | grep rx.good_packets | awk '{print $2}')
NB_FP_VSWITCH_PACKETS_AFTER=$(fp-cli dump-stats | grep output_ok | sed 's#:# ##' | awk '{print $2}')
NB_EXCEPTIONS_AFTER=$(fp-cli dump-stats | grep LocalBasicExceptions | sed 's#:# ##' | awk '{print $2}')

NB_TAP_PACKETS=$(expr $NB_TAP_PACKETS_AFTER - $NB_TAP_PACKETS_BEFORE)
NB_FP_VSWITCH_PACKETS=$(expr $NB_FP_VSWITCH_PACKETS_AFTER - $NB_FP_VSWITCH_PACKETS_BEFORE)
NB_EXCEPTIONS=$(expr $NB_EXCEPTIONS_AFTER - $NB_EXCEPTIONS_BEFORE)

# Here we verify 2 things.
# The first check wants to assure that the packets received by the spawned vm
# were processed by 6WIND Virtual Accelerator and not sent to slow path (exception).
# The second check wants to assure that this traffic towards the vm correctly
# passed via the accelerated ovs.
# This is a simple heuristics but it should be enough.
if [[ ${NB_EXCEPTIONS} -lt ${NB_TAP_PACKETS} && ${NB_TAP_PACKETS} -le ${NB_FP_VSWITCH_PACKETS} ]]; then
    exit 0
fi
exit 1

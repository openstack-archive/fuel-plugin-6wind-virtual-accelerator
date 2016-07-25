#!/bin/bash

fpconf="/usr/local/etc/fast-path.env"

function set_fp_opt() {
	if grep -q '^#\?: \${'"$1"':=.*}' "$3"; then
		sed -i -- 's@^#\?: \${'"$1"':=.*@: ${'"$1"':='"$2"'}@' "$3";
	else
		echo >> $3;
		echo '# Config added by VA Fuel plugin' >> $3;
		echo ': ${'"$1"':='"$2"'}' >> $3;
	fi
}

if [ "$1" == "EAL_OPTIONS" ]; then
	if [ -f "/usr/local/etc/dpdk_interfaces_file" ]; then
		for pci_bus in $(grep -v '^[ \t]*#' /usr/local/etc/dpdk_interfaces_file | awk '{print $2'}); do
			whitelist=$whitelist' -w'$pci_bus
		done
		whitelist=$whitelist' -dlibrte_pmd_vhost.so'
		set_fp_opt "$1" "$whitelist" $fpconf
	fi
else
	set_fp_opt "$1" "$2" $fpconf
fi

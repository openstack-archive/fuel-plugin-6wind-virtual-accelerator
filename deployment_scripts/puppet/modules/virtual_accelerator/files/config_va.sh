#
# Copyright 2016 6WIND S.A.

#!/bin/bash

fpconf="/usr/local/etc/fast-path.env"

function set_fp_opt() {
	if grep -q '^#\?: \${'"$1"':=.*}' "$3"; then
		sed -i -- 's@^#\?: \${'"$1"':=.*@: ${'"$1"':='"$2"'}@' "$3";
	else
		echo >> $3;
		echo '# Config added by VA fuel plugin' >> $3;
		echo ': ${'"$1"':='"$2"'}' >> $3;
	fi
}

if [ $1 == "blacklist" ]; then
	pci_add=`ethtool -i $2 | grep bus-info | awk '{print $2}'`
	set_fp_opt EAL_OPTIONS " -b$pci_add" $fpconf
else
	set_fp_opt "$1" "$2" $fpconf
fi
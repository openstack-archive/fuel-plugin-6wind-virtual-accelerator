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

set_fp_opt "$1" "$2" $fpconf

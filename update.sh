#!/usr/bin/env bash

echo "Updating..."

function add_gef_rc {
    if [[ -f ~/.gef.rc ]]
    then
        echo ">>> GEF rc already present"
        return 1;
    fi
    cat > ~/.gef.rc <<-'GEF_RC'
	[aliases]
	dq = hexdump qword
	dd = hexdump dword
	dw = hexdump word
	dc = hexdump byte
	db = hexdump byte
	GEF_RC
    echo ">>> GEF rc added"
    return 0
}

add_gef_rc


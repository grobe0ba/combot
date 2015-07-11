#!/usr/local/bin/bash

function send_message
{
	RECIP=$(echo "$1" | cut -d' ' -f1)
	MSG=$(echo "$1" | cut -d' '-f2-)

	echo "$RECIP, message from $PERSON: $MSG" >> ./store/$RECIP
}

function get_message
{
	if $(find ./store | grep -q $RECIP);
	then
		if [ -e ./store/$RECIP ];
		then
			sed -e 's/^/ /' ./store/$RECIP >&10
			rm ./store/$RECIP
		fi
	fi
}

#!/usr/pkg/bin/bash

function send_message
{
    RECIP=$(echo "$1" | cut -d' ' -f1)
    MSG=$(echo "$1" | cut -d' ' -f2-)

    echo "$RECIP, message from $PERSON: $MSG" >> ./store/$RECIP
}

function get_message
{
    if [ -e "./store/${PERSON}" ];
    then
	cat "./store/${PERSON}" |
	    while read MSGLINE
	    do
		msg_out "${MSGLINE}"
	    done
	rm "./store/${PERSON}"
    fi
}

#!/usr/pkg/bin/bash

function send_message
{
    RECIP="$(echo "${1}" | cut -d' ' -f1)"
    MSG="$(echo "${1}" | cut -d' ' -f2-)"

    echo "${RECIP}, message from ${PERSON}: ${MSG}" >> "./store/${RECIP}"
    if [ -e "./store/${RECIP}" ];
    then
	msg_out "Message for ${RECIP} stored."
    else
	msg_out "Unable to store message for ${RECIP}."
    fi
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

#!/usr/pkg/bin/bash

# $Id$

function send_message
{
    RECIP="$(echo "${1}" | cut -d' ' -f1)"
    RECIP="$(basename "${RECIP}")"
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
    PERSON="$(basename "${PERSON}")"
    if [ -n "${PERSON}" ];
    then
	if [ -e "./store/${PERSON}" ];
	then
	    cat "./store/${PERSON}" |
		while read MSGLINE
		do
		    msg_out "${MSGLINE}"
		done
	    rm "./store/${PERSON}"
	fi
    fi
}

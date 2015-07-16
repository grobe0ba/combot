#!/usr/pkg/bin/bash

function whatis_add()
{
    WHAT="$(echo "${1}" | cut -d' ' -f1)"
    WHAT="$(basename "${WHAT}")"
    INF="$(echo "${1}" | cut -d' ' -f2-)"

    echo "${INF}" > "whatis/${WHAT}"
    if [ -e "./whatis/${WHAT}" ];
    then
	msg_out "WHATIS for ${WHAT} stored."
    else
	msg_out "Unable to store WHATIS."
    fi
}

function whatis_list()
{
    WHAT="$(echo "${1}" | cut -d' ' -f1)"
    WHAT="$(basename "${WHAT}")"
    
    if [ -e "./whatis/${WHAT}" ];
    then
	INF="$(cat "./whatis/${WHAT}")"
	msg_out "${INF}"
    else
	msg_out "I don't know what ${WHAT} is, but heroin addicts probably use it."
    fi
}

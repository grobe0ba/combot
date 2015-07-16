#!/usr/pkg/bin/bash

function whatis_add()
{
    WHAT="$(echo "${1}" | cut -d'|' -f1)"
    OWHAT="${WHAT}"
    WHAT="$(echo "${WHAT}" | sha1)"
    INF="$(echo "${1}" | cut -d'|' -f2-)"

    if [ -n "${INF}" ];
    then
	
	echo "${INF}" > "whatis/${WHAT}"
	if [ -e "./whatis/${WHAT}" ];
	then
	    msg_out "WHATIS for ${OWHAT} stored."
	else
	    msg_out "Unable to store WHATIS."
	fi
    else
	msg_out "No description provided. Correct format: wadd item|description"
	msg_out "Item can have multiple words."
    fi
}

function whatis_list()
{
    WHAT="$(echo "${1}" | cut -d'|' -f1)"
    OWHAT="${WHAT}"
    WHAT="$(echo "${WHAT}" | sha1)"
    
    if [ -e "./whatis/${WHAT}" ];
    then
	INF="$(cat "./whatis/${WHAT}")"
	msg_out "${INF}"
    else
	msg_out "I don't know what ${OWHAT} is, but heroin addicts probably use it."
    fi
}

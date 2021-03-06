#!/usr/pkg/bin/bash

# $Id$

function whatis_add()
{
    WHAT="$(echo "${1}" | cut -d'|' -f1)"
    OWHAT="${WHAT}"
    WHAT="$(echo "${WHAT}" | sha1)"
    INF="$(echo "${1}" | cut -d'|' -f2-)"

    if $(echo "${INF}" | grep -qv wadd);
    then
	
	echo "${INF}" > "whatis/${WHAT}"
	if [ -e "./whatis/${WHAT}" ];
	then
	    reply "WHATIS for ${OWHAT} stored."
	else
	    reply "Unable to store WHATIS."
	fi
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
	reply "${INF}"
    else
	reply "I don't know what ${OWHAT} is, but heroin addicts probably use it."
    fi
}

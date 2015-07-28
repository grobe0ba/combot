#!/usr/pkg/bin/bash

# $Id$

export PM=0
export PMPERSON=""

function msg
{
    if [ -n "${LINE}" ];
    then
	echo "${LINE}"
	echo "${LINE}" >> commode.log
    fi
    
    LINE="${1}"
    RLINE="${1}"

    PERSON="$(echo "$LINE" | cut -d' ' -f1)"

    if $(echo "${PERSON}" | grep -q "^*");
    then
	PM=1
	PMPERSON="$(echo "${PERSON}" | tr -cd "[:alnum:]@")"
    fi

    PERSON="$(echo "${PERSON}" | tr -cd "[:alnum:]@")"
    LINE="$(echo "${LINE}" | cut -d' ' -f2- | sed -e 's/^  *//' | tr -d "[:cntrl:]")"

    ABUSE=0
    for p in $(xargs < ./abuse);
    do
	if [ "${PERSON}" == "${p}" ];
	then
	    ABUSE=1
	else
	    ABUSE=0
	fi
    done
    if [ "${ABUSE}" == 0 ];
    then
	if [ "${PERSON}" == "${OWNER}" ];
	then
	    . ./owner-commands.sh
	else
	    . ./public-commands.sh
	fi

	if $(echo "${LINE}" | egrep -q '^KICK:');
	then
	    if $(echo "${LINE}" | egrep -qv 'no approval');
	    then
		. ./kick-handler.sh
	    fi
	fi

	if $(echo "${LINE}" | egrep -q '^MUTE:');
	then
	    . ./mute-handler.sh
	fi

	if $(echo "${LINE}" | egrep -q '^FLUSH:');
	then
	    echo -en "Fapprove\r\n" >&10
	fi

	return
    fi
}

function reply
{
    if [ "${PM}" == 1 ];
    then
	pm_out "${PMPERSON}" "${1}"
    else
	msg_out "${1}"
    fi
}
    

function key_out
{
    echo -en "${1}\r\n" >&10
    return
}

function msg_out
{
    echo -en " ${1}\r\n" >&10
    return
}

function pm_out
{
    echo -en "s${1}\r\n${2}\r\n" >&10
    return
}

function emote
{
    echo -en "e${1}\r\n" >&10
    return
}

function ch_sw
{
    echo -en "g${1}\r\n" >&10
    return
}

function kick_approve
{
    echo -en "kapprove\r\n" >&10
    return
}

function mute_approve
{
    echo -en "mapprove\r\n" >&10
    return
}

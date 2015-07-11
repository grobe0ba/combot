#!/usr/pkg/bin/bash

function msg
{
    LINE="${1}"
    RLINE="${1}"

    PERSON="$(echo "$LINE" | cut -d' ' -f1 | tr -cd "[:alnum:]@")"
    LINE="$(echo "${LINE}" | cut -d' ' -f2- | sed -e 's/^  *//' | tr -d "[:cntrl:]")"

    if [ "${PERSON}" == "${OWNER}" ];
    then
	. ./owner-commands.sh
    else
	. ./public-commands.sh
    fi

    if $(echo "${LINE}" | egrep -q '^KICK:');
    then
	. ./kick-handler.sh
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
}

function mute_approve
{
    echo -en "mapprove\r\n" >&10
}

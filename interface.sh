#!/usr/pkg/bin/bash

function msg
{
    if [ -n "${LINE}" ];
    then
	echo "${LINE}"
	echo "${LINE}" >> commode.log
    fi
    
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
}

function getlock
{
    while ! shlock -f "${LOCKFILE}" -p ${RANDOM}
    then
	echo "" >/dev/null
    done
}

function endlock
{
    rm "${LOCKFILE}"
}

function key_out
{
    getlock
    echo -en "${1}\r\n" >&10
    endlock
    return
}

function msg_out
{
    getlock
    echo -en " ${1}\r\n" >&10
    endlock
    return
}

function pm_out
{
    getlock
    echo -en "s${1}\r\n${2}\r\n" >&10
    endlock
    return
}

function emote
{
    getlock
    echo -en "e${1}\r\n" >&10
    endlock
    return
}

function ch_sw
{
    getlock
    echo -en "g${1}\r\n" >&10
    endlock
    return
}

function kick_approve
{
    getlock
    echo -en "kapprove\r\n" >&10
    endlock
    return
}

function mute_approve
{
    getlock
    echo -en "mapprove\r\n" >&10
    endlock
    return
}

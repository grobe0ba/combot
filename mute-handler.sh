#!/usr/pkg/bin/bash

# $Id$

#[20:11:23] KICK: bag@faeroes needs approval to kick grobe0ba@iceland out of library

WHO="$(echo "${LINE}" | cut -d' ' -f7)"
REQ="$(echo "${LINE}" | cut -d' ' -f2)"

for p in $(xargs < ./kickers);
do
    if [ "$(echo "${REQ}" | cut -d'@' -f1)" == "${p}" ];
    then
	if [[ "${WHO}" != "${OWNER}" && "${WHO}" != "${BOT}" ]];
	then
	    mute_approve &
	else
	    reply "Nope, not muting him. Do thine own dirty work!"
	fi
	break
    fi
done

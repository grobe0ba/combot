#!/usr/pkg/bin/bash

#[20:11:23] KICK: bag@faeroes needs approval to kick grobe0ba@iceland out of library

WHO="$(echo "${LINE}" | cut -d' ' -f7)"
REQ="$(echo "${LINE}" | cut -d' ' -f2)"

for p in $(xargs < ./kickers);
do
    if [ "$(echo ${REQ} | cut -d'@' -f1)" == "${P}" ];
    then
	kick_approve &
	break
    fi
done

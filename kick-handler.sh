#!/usr/pkg/bin/bash

REQ="$(echo "${LINE}" | cut -d' ' -f2)"

if [ "${REQ}" == "${OWNER}" ];
then
    kick_approve
fi

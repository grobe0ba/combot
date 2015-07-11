#!/usr/pkg/bin/bash

LINE="${1}"
REQ="$(echo "${LINE}" | cut -d' ' -f2)"

if [ "${REQ}" == "${OWNER}" ];
then
    kick_approve
fi

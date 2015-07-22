#!/usr/pkg/bin/bash

COMMAND="$(echo "${LINE}" | cut -d' ' -f1)"
ARGUMENTS="$(echo "${LINE}" | cut -d' ' -f2-)"

case "${COMMAND}" in
    quit)
	cleanup;
	;;
    say)
	msg_out "${ARGUMENTS}";
	;;
    emote)
	emote "${ARGUMENTS}";
	;;
    go)
	ch_sw "${ARGUMENTS}";
	;;
    reload)
	. ./interface.sh;
	;;
esac

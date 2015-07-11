#!/usr/local/bin/bash

COMMAND=$(echo "$LINE" | cut -d' ' -f1)
ARGUMENTS=$(echo "$LINE" | cut -d' ' -f2-)

case "$COMMAND" in
    quit)
	cleanup;
	;;
    say)
	msg_out "$ARGUMENTS";
	;;
    emote)
	emote "$ARGUMENTS";
	;;
    go)
	ch_sw $ARGUMENTS;
	;;
    reload)
	. ./interface.sh;
	;;
    '?')
	echo -en "sgrobe0ba@faeroes\r\nIncorrect function\r\n" >&10
	;;
esac

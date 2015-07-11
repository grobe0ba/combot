#!/usr/local/bin/bash

COMMAND=$(echo "$LINE" | cut -d' ' -f1)
ARGUMENTS=$(echo "$LINE" | sed -e 's/#.*#//')

case "$COMMAND" in
	quit)
		key_out q;
		;;
	say)
		RECIP=$(echo "$ARGUMENTS" | cut -d' ' -f1);
		MSG=$(echo "$ARGUMENTS" | cut -d' ' -f2-);
		msg_out "$RECIP" "$MSG";
		;;
	emote)
		emote "$ARGUMENTS";
		;;
	go)
		ch_sw $ARGUMENTS;
		;;
	'?')
		echo -en "sgrobe0ba@faeroes\r\nIncorrect function\r\n" >&10
		;;
esac

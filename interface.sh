#!/usr/local/bin/bash

function msg
{
	LINE=$1
	RLINE=$1

	PERSON=$(echo "$LINE" | cut -d' ' -f1 | tr -cd "[:alnum:]")
	LINE=$(echo "$LINE" | cut -d' ' -f2-)

	if [ "$PERSON" == "grobe0ba@faeroes" ];
	then
		. ./owner-commands.sh
	else
		. ./public-commands.sh
	fi

	return
}

function key_out
{
	echo -en "$1\r\n" >&10
	return
}

function msg_out
{
	echo -en " $1\r\n" >&10
	return
}

function pm_out
{
	echo -en "s$1\r\n$2\r\n" >&10
	return
}

function emote
{
	echo -en "e$1\r\n" >&10
	return
}

function sw_ch
{
	echo -en "g$1\r\n"
	return
}

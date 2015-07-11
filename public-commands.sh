#!/usr/local/bin/bash

#Additional processing functions
. ./urbandictionary.sh
. ./chat_bot.sh
. ./message_store.sh

COMMAND=$(echo "$LINE" | cut -d' ' -f1)
ARGUMENTS=$(echo "$LINE" | cut -d' ' -f2-)

case "$COMMAND" in
    chat)
	do_chat "$ARGUMENTS";
	;;
    ud)
	urbandict_lookup "$ARGUMENTS";
	;;
    source)
	msg_out "My source code is at: https://github.com/grobe0ba/scripts/tree/master/commode";
	;;
    msg)
	send_message "$ARGUMENTS";
	MSG_SENT=1
	;;
esac

if [ -z $MSG_SENT ];
then
    get_message &
fi
unset MSG_SENT

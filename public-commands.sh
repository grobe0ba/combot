#!/usr/pkg/bin/bash

#Additional processing functions
. ./urbandictionary.sh
#. ./chat_bot.sh
. ./message_store.sh
. ./whois.sh

LINE="$(echo "${LINE}" | sed -E  's/(^[ ]*bag[: ,;]*)(.*)/\2/')"

COMMAND="$(echo "${LINE}" | cut -d' ' -f1)"
ARGUMENTS="$(echo "${LINE}" | cut -d' ' -f2-)"

if $(echo "${LINE}" | egrep -qi "what is love");
then
    msg_out "Baby don't hurt me, don't hurt me, no more!"
fi

case "${COMMAND}" in
#    chat)
#	do_chat "$ARGUMENTS";
#	;;
    ud)
	urbandict_lookup "${ARGUMENTS}";
	;;
    source)
	msg_out "The CVS repository is mirrored at https://github.com/grobe0ba/combot"
	;;
    commands)
	msg_out "Public commands can be found at https://github.com/grobe0ba/combot/wiki/Public-Bot-Commands"
	;;
    msg)
	send_message "${ARGUMENTS}";
	MSG_SENT=1
	;;
    wadd)
	whatis_add "${ARGUMENTS}";
	#msg_out "Please contact grobe0ba for cvs information to modify WHOIS database."
	;;
    whois)
	whois_list "${ARGUMENTS}";
	;;
    whatis)
	whatis_list "${ARGUMENTS}";
	;;
    whoami)
	whois_list "${PERSON}";
	;;
esac

if [ -z ${MSG_SENT} ];
then
    get_message &
fi
unset MSG_SENT

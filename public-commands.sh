#!/usr/pkg/bin/bash

#Additional processing functions
. ./urbandictionary.sh
#. ./chat_bot.sh
. ./message_store.sh
. ./whois.sh

COMMAND="$(echo "${LINE}" | cut -d' ' -f1)"
ARGUMENTS="$(echo "${LINE}" | cut -d' ' -f2-)"

case "${COMMAND}" in
#    chat)
#	do_chat "$ARGUMENTS";
#	;;
    ud)
	urbandict_lookup "${ARGUMENTS}";
	;;
    source)
	msg_out "My source code is at: https://github.com/grobe0ba/scripts/tree/master/commode";
	;;
    commands)
	msg_out "Public commands can be found in the case statement at https://github.com/grobe0ba/scripts/blob/master/commode/public-commands.sh";
	;;
    msg)
	send_message "${ARGUMENTS}";
	MSG_SENT=1
	;;
    wadd)
	#	whois_add "${ARGUMENTS}";
	msg_out "Please contact grobe0ba for cvs information to modify WHOIS database."
	;;
    whois)
	whois_list "${ARGUMENTS}";
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

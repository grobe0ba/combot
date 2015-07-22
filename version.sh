#!/usr/pkg/bin/bash

# $Id :$

function getversion()
{
    SECTION="${1}"

    case "${SECTION}" in
	combot)
	    msg_out "$(getident combot.sh)"
	    ;;
	msg)
	    msg_out "$(getident message_store.sh)"
	    ;;
	whatis)
	    msg_out "$(getident whatis.sh)"
	    ;;
	whois)
	    msg_out "$(getident whois.sh)"
	    ;;
	ud)
	    msg_out "$(getident urbandictionary.sh)"
	    ;;
	kick)
	    msg_out "$(getident kick-handler.sh)"
	    ;;
	mute)
	    msg_out "$(getident mute-handler.sh)"
	    ;;
	interface)
	    msg_out "$(getident interface.sh)"
	    ;;
	commands)
	    msg_out "$(getident public-commands.sh)"
	    ;;
	*)
	    msg_out "$(getident public-commands.sh)"
	    ;;
    esac
}


function getident()
{
    ident "${1}" | sed -e 's/^[ \t]*//' | grep '^\$'
}

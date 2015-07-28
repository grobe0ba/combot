#!/usr/pkg/bin/bash

# $Id :$

function getversion()
{
    SECTION="${1}"

    case "${SECTION}" in
	combot)
	    reply "$(getident combot.sh)"
	    ;;
	msg)
	    reply "$(getident message_store.sh)"
	    ;;
	whatis)
	    reply "$(getident whatis.sh)"
	    ;;
	whois)
	    reply "$(getident whois.sh)"
	    ;;
	ud)
	    reply "$(getident urbandictionary.sh)"
	    ;;
	kick)
	    reply "$(getident kick-handler.sh)"
	    ;;
	mute)
	    reply "$(getident mute-handler.sh)"
	    ;;
	interface)
	    reply "$(getident interface.sh)"
	    ;;
	commands)
	    reply "$(getident public-commands.sh)"
	    ;;
	*)
	    reply "$(getident public-commands.sh)"
	    ;;
    esac
}


function getident()
{
    ident "${1}" | sed -e 's/^[ \t]*//' | grep '^\$'
}

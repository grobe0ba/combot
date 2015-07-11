#!/usr/local/bin/bash

function urbandict_lookup
{
	URL="http://www.urbandictionary.com/define.php?term=$1"
	echo -en "L$URL\r\nUrban Dictionary: $1\r\n" >&10
	OLINE=$(lynx --source "$URL" | grep -e "og:description" | sed -e "s/<meta content=\'//" -e "s/' name='Description' property='og:description'>//" -e "s/<br[/]*>/ /g" -e "s/\&quot\;/'/g" -e "s/&#39;/'/g")
	msg_out "$OLINE"
}

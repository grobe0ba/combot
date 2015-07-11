#!/usr/local/bin/bash

function geturban
{

	unset OLINE

	lynx --source  "http://www.urbandictionary.com/define.php?term=$1" |
	while read CLINE
	do
		if `grep -q "class='meaning'" <(echo "$CLINE")`; then
			DOPRNT=1
		fi
		if `grep -q '/div' <(echo "$CLINE")`; then
			unset DOPRNT
			DIDPRNT=1
		fi
		if [ -n "$DOPRNT" ]; then
			if [ -z $DIDPRNT ]; then
				echo -en " " >&10
				$HOME/src/scripts/commode/stripHTML.sed <(echo "$CLINE" | sed -e "s/<br[/]*>/ /g" -e "s/\&quot\;/'/g" -e "s/&#39;/'/g" | tr -d '\n') | tr -d '\n' | tr -cd '[:print:]' >&10
				echo -en "\r\n" >&10
			fi
		fi
	done
	exit
}

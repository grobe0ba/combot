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
		fi
		if [ -n "$DOPRNT" ]; then
			$HOME/src/scripts/commode/stripHTML.sed <(echo "$CLINE" | sed -s "s/<br[/]*>/ /g" | tr -d '\n') | tr -d '\n' | tr -cd '[:print:]'
			echo -en " "
		fi
	done
	echo -en "\n"
}

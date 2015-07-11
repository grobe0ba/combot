#!/usr/local/bin/bash

unset OLINE

lynx --source  http://www.urbandictionary.com/define.php?term=PRN |
while read CLINE
do
	if `grep -q "class='meaning'" <(echo "$CLINE")`; then
		DOPRNT=1
	fi
	if `grep -q '/div' <(echo "$CLINE")`; then
		unset DOPRNT
	fi
	if [ -n "$DOPRNT" ]; then
		./stripHTML.sed <(echo "$CLINE" | tr -d '\n') | tr -d '\n'
	fi
done

. $HOME/src/scripts/commode/messages.sh
#. $HOME/src/scripts/commode/geturban.sh

function chat
{
	EXTRA=$1
	PERSON=$2
	TMP=`mktemp chat.XXXXX`
	TMP1=`mktemp chat.XXXXX`
	SESNAM=`echo "$PERSON" | tr -cd "[:alnum:]"`
	EXTRA=`echo "$EXTRA" | tr -cd "[[:alnum:][:space:]]"`
	cat > $TMP <<EOF
<?xml version='1.0'?>
<methodCall>
	<methodName>respond</methodName>
	<params>
		<param>
			<value>$EXTRA</value>
		</param>
		<param>
			<value>$SESNAM</value>
		</param>
	</params>
</methodCall>
EOF
	echo $TMP
	SIZE=`cat $TMP | wc -c | sed -e 's/ *//g'`
	exec 15<>/dev/tcp/localhost/65300
	cat > $TMP1 <<EOF
POST / HTTP/1.0
User-Agent: bash
Host: localhost
Content-Type: text/xml
Content-Length: $SIZE

EOF
	cat $TMP1 >&15
	cat $TMP >&15
	cat <&15 |
	while read RESLINE
	do
		if `echo "$RESLINE" | grep -qve "^HTTP/1.0" -e "^Server:" -e "^Date:" -e "^Content"`; then
			if `echo "$RESLINE" | grep -q "<value>"`; then
				RESLINE=`echo "$RESLINE" | sed -e 's/<[^>]*>//g'`
				echo -en " $RESLINE\r\n" >&10
			fi
		fi
	done
	rm $TMP $TMP1
	return
}

function process_hooks
{
	#Add functionality here
	LINE="$1"

	if [ "$PERSON" == "grobe0ba@faeroes" ]; then
		COMMAND=`echo "$LINE" | gcut -d ' ' -f 1`
		EXTRA=`echo "$LINE" | gcut -d ' ' -f 1 --complement`

		case "$COMMAND" in
			raw)
				echo -en "$EXTRA\r\n" >&10
				;;
			mute)
				echo -en "m$EXTRA\r\n" >&10
				;;
			'?')
				echo -en "sgrobe0ba@faeroes\r\nIncorrect function\r\n" >&10
				;;
		esac
	fi

	echo "$LINE"

	LINE=`echo "$LINE" | sed -e 's/  */ /g' -e 's/^ *//'`

	PERSON=`echo "$LINE" | gcut -d ' ' -f 1 | tr -cd "[:alnum:]"`
	COMMAND=`echo "$LINE" | gcut -d ' ' -f 2`
	EXTRA=`echo "$LINE" | gcut -d ' ' -f 1,2 --complement`

	echo "$PERSON ordered $COMMAND - $EXTRA"

	case "$COMMAND" in
		chat)
			chat "$EXTRA" "$PERSON"
			DIDCHAT=1
			;;
		msg)
			PERS=`echo "$EXTRA" | gcut -d ' ' -f1`
			EX=`echo "$EXTRA" | gcut -d ' ' -f1 --complement`
			addmessage "$PERS" "$EX" "$PERSON"
			DIDMSG=1
			;;
		ud)
			URL="http://www.urbandictionary.com/define.php?term=$EXTRA"
			echo -en "L$URL\r\nUrban Dictionary: $EXTRA\r\n" >&10
			OLINE=`lynx --source "$URL" | grep -e "og:description" | sed -e "s/<meta content=\'//" -e "s/' name='Description' property='og:description'>//" -e "s/<br[/]*>/ /g" -e "s/\&quot\;/'/g" -e "s/&#39;/'/g"`
			echo -en " $OLINE\r\n" >&10
			;;
	esac

	if [ -z $DIDMSG ]; then
		getmessage "$PERSON" &
	fi
	unset DIDMSG

	#if [ -z $DIDCHAT ]; then
	#	allchat "$EXTRA" "$PERSON" &
	#fi

	if `echo "$LINE" | grep -q "nullogic spins"`; then
		echo -en "etrips nullogic\r\n" >&10
	fi

	if `echo "$LINE" | grep -q joined`; then
		if `echo "$LINE" | grep -q mjt`; then
			echo -en "eslaps mjt about the face with a large, wet, trout\r\n" >&10
		fi
		if `echo "$LINE" | grep -q elita`; then
			echo -en "eaffectionately fondles elita's tit\r\n" >&10
		fi
		if `echo "$LINE" | grep -q felix`; then
			echo -en "emotorboats felix tits\r\n" >&10
		fi
		if `echo "$LINE" | grep -q hapiworm`; then
			echo -en "egrabs hapiworm\s ass\r\n" >&10
		fi

	fi

	return
}

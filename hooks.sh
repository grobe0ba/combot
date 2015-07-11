. $HOME/src/scripts/commode/messages.sh

function allchat
{
        EXTRA=$1
        PERSON=$2
        TMP=`mktemp chat.XXXXX`
        TMP1=`mktemp chat.XXXXX`
        SESNAM=`echo "$PERSON" | tr -cd "[:alnum:]"`
        EXTRA=`echo "$EXTRA" | tr -cd "[[:alnum:][:space:]]\[\]"`
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
        cat <&15 >/dev/null
        rm $TMP $TMP1
        return
}

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
		if `grep -qve "^HTTP/1.0" -e "^Server:" -e "^Date:" -e "^Content" <(echo "$RESLINE")`; then
			if `grep -q "<value>" <(echo "$RESLINE")`; then
				RESLINE=`sed -e 's/<[^>]*>//g' <(echo "$RESLINE")`
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

	PERSON=`tr -cd '[:alnum:]@' <(echo "$LINE")`

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

	LINE=`sed -e 's/  */ /g' -e 's/^ *//' <(echo "$LINE")`

	PERSON=`echo "$LINE" | gcut -d ' ' -f 1 | tr -cd "[:alnum:]"`
	COMMAND=`gcut -d ' ' -f 2 <(echo "$LINE")`
	EXTRA=`echo "$LINE" | gcut -d ' ' -f 1,2 --complement`

	echo "$PERSON ordered $COMMAND - $EXTRA"

	case "$COMMAND" in
		chat)
			chat "$EXTRA" "$PERSON"
			DIDCHAT=1
			;;
		msg)
			PERS=`gcut -d ' ' -f1 <(echo "$EXTRA")`
			EX=`gcut -d ' ' -f1 --complement <(echo "$EXTRA")`
			addmessage "$PERS" "$EX" "$PERSON"
			DIDMSG=1
			;;
	esac

	if [ -z $DIDMSG ]; then
		getmessage "$PERSON" &
	fi
	unset DIDMSG

	#if [ -z $DIDCHAT ]; then
	#	allchat "$EXTRA" "$PERSON" &
	#fi

	if `grep -q joined <(echo "$LINE")`; then
		if `grep -q mjt <(echo "$LINE")`; then
			echo -en "eslaps mjt about the face with a large, wet, trout\r\n" >&10
		fi
	fi

	return
}

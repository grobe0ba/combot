#!/usr/local/bin/bash

function do_chat
{
	TMP=$(mktemp chat.XXXXX)
	TMP1=$(mktemp chat.XXXXX)
	cat > $TMP <<EOF
<?xml version='1.0'?>
<methodCall>
	<methodName>respond</methodName>
	<params>
	<param>
	<value>$ARGUMENTS</value>
	</param>
	<param>
	<value>$PERSON</value>
	</param>
	</params>
</methodCall>
EOF
	echo $TMP
	SIZE=$(cat $TMP | wc -c | sed -e 's/ *//g')
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
		if $(echo "$RESLINE" | grep -qve "^HTTP/1.0" | grep -qve "^Server:" | grep -qve "^Date:" | grep -qve "^Content"); then
			if $(echo "$RESLINE" | grep -q "<value>"); then
				RESLINE=$(echo "$RESLINE" | sed -e 's/<[^>]*>//g')
				echo -en " $RESLINE\r\n" >&10
			fi
		fi
	done
	rm $TMP $TMP1
	return
}

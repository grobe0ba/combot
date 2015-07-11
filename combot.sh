#!/usr/local/bin/bash

#combot is licensed under the MIT License (http://opensource.org/licenses/MIT). See LICENSE for details.
#This license supercedes all previous licenses used in this project, and applies to ALL previous commits to this repository.
#Certain files in the project are licensed under the GNU GPLv3, and are specified as such in the files themselves.

ROOM=bar
PORT=64462

if [ -e comsock ]; then rm comsock; fi

function cleanup
{
	echo Bailing out...
	pkill socat
	pkill cat
	BAIL=1
}
trap cleanup SIGTERM SIGKILL SIGQUIT SIGINT


function pubmsg
{
	LINE=$1
	PERSON=`echo "$LINE" | gcut -d ' ' -f 1`
	LINE=`echo "$LINE" | gcut -d ' ' -f 1 --complement`

	return
}

function msg
{
	LINE=$1
	RLINE=$1
	PERSON=`echo "$LINE" | gcut -d ' ' -f 1 | sed -e 's/://'`
	LINE=`echo "$LINE" | gcut -d' ' -f 1 --complement`


	if [ "$PERSON" == "grobe0ba@faeroes" ]; then
		COMMAND=`echo "$LINE" | gcut -d ' ' -f 1`
		EXTRA=`echo "$LINE" | gcut -d ' ' -f 1 --complement`

		case "$COMMAND" in
			quit)
				echo -en "q\r\n" >&10
				pkill socat
				;;
			say)
				echo -en " $EXTRA\r\n" >&10
				;;
			msg)
				TO=`echo "$LINE" | gcut -d ' ' -f 2,3`
				MSG=`echo "$LINE" | gcut -d ' ' -f 1,2,3 --complement`
				echo -en "s$TO\r\n$MSG\r\n" >&10
				;;
			emote)
				echo -en "e$EXTRA\r\n" >&10
				;;
			go)
				echo -en "g$EXTRA\r\n" >&10;
				;;
			'?')
				echo -en "sgrobe0ba@faeroes\r\nIncorrect function\r\n" >&10
				;;
		esac
	fi
	. $HOME/src/scripts/commode/hooks.sh
	process_hooks "$RLINE"
	return
}

function send_ping
{
	echo PING
	return
}

#Establish PTY->TCP socket link using socat
socat exec:'ssh -t gropebot@sdf.org com',stderr,pty,ctty,sigquit,sigint,raw,echo=0 TCP-LISTEN:$PORT,bind=127.0.0.1,crnl,fork &
#Grab PID for socat for loop monitoring
PID=$!

#Have to wait a bit for everything to clear up
sleep 2;

#Open the TCP socket, file descriptor 10
exec 10<>/dev/tcp/127.0.0.1/$PORT

#Join the room
echo -en "g$ROOM\r\n" >&10

#Wait again for everything to settle down
sleep 1;
while `kill -s 0 $PID`
do
	read -u 10 LINE
	#LINE=`echo "$LINE" | killcolor`
	LINE=`echo "$LINE" | sed -e "s,\x1B\[[0-9;]*[a-zA-Z],,g"`
	LINE=`echo "$LINE" | tr -cd '[[:alnum:][:space:]@]'`
	if `echo "$LINE" | grep -q grobe0ba`; then
		send_ping "$LINE"
	fi
	msg "$LINE"
done

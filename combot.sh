#!/usr/local/bin/bash

. ./config.sh

. ./interface.sh

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
while $(kill -s 0 $PID)
do
	read -u 10 LINE
	. ./config.sh
	LINE=$(echo "$LINE" | ./killcolor | sed -e 's/$(.*)//' -e 's/`.*`//')
	msg "$LINE"
done

#!/usr/pkg/bin/bash

function cleanup
{
    echo Bailing out...
    kill $SOCAT_PID
    BAIL=1
}
trap cleanup SIGTERM SIGKILL SIGQUIT SIGINT

. ./config.sh

. ./interface.sh

#Establish PTY->TCP socket link using socat
socat exec:'ssh -t bag@faeroes com',stderr,pty,ctty,sigquit,sigint,raw,echo=0 TCP-LISTEN:$PORT,bind=127.0.0.1,crnl,fork &
#Grab PID for socat for loop monitoring
export SOCAT_PID=$!

#Have to wait a bit for everything to clear up
sleep 2;

#Open the TCP socket, file descriptor 10
exec 10<>/dev/tcp/127.0.0.1/$PORT

sleep 5;

#Join the room
echo -en "g$ROOM\r\n" >&10

#Wait again for everything to settle down
sleep 3;
while $(kill -s 0 $SOCAT_PID)
do 
   read -u 10 -t 5 LINE
    . ./config.sh
    LINE=$(echo "$LINE" | ./killcolor | sed -e 's/$(.*)//' -e 's/`.*`//')
    msg "$LINE" &
done

. $HOME/src/scripts/commode/redis

function addmessage
{
	connect

	EXTRA="$1"
	PERSON="$2"
	UUID=`uuidgen`
	SESNAM=`echo "$PERSON" | tr -cd "[:alnum:]"`
	EXTRA=`echo "$EXTRA" | tr -cd "[:print:]"`
	HSET MSGS $UUID "$EXTRA"
	SADD $SESNAM $UUID
	
	disconnect
}

function getmessages
{
	connect
	
	PERSON="$1"
	SESNAM=`echo "$PERSON" | tr -cd "[[:alnum:]]"`
	NMSGS=$(SCARD $PERSON)
	if [ $NMSGS -gt 0 ]; then
		while [ $NMSGS -gt 0]
		do
			ID=$(SPOP $PERSON)
			MSG=$(HGET MSGS $ID)
			HDEL $ID
			echo -en " $PERSON, $MSG\r\n" >&10
			NMSGS=$(SCARD $PERSON)
		done
	fi

	disconnect
}

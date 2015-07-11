function connect
{
	exec 16<>/dev/tcp/localhost/6379
}

function disconnect
{
	echo -en "QUIT\r\n" >&16
	purge
}

function make_temp
{
	echo `mktemp /tmp/redis.XXXXX`
}

function purge
{
	cat <&16 >/dev/null
}

function to_tmp
{
	cat <&16 >$TMP &
	disconnect
}

function SCARD
{
	connect

	KEY="$1"

	TMP=$(make_temp)

	echo -en "SCARD $KEY\r\n" >&16
	to_tmp

	echo `grep "^:" $TMP | sed -e 's/^://' | tr -cd '[:alnum:]'`
	rm $TMP
}

function SADD
{
	connect

	KEY="$1"
	VALUE="$2"

	echo -en "SADD $KEY $VALUE\r\n" >&16
	disconnect
}

function SPOP
{
	connect

	KEY="$1"

	TMP=$(make_temp)

	echo -en "SPOP $KEY\r\n" >&16
	to_tmp
	
	echo `tail -n1 $TMP | tr -cd '[:alnum"]'`

	rm $TMP
}


function HSET
{
	connect

	KEY="$1"
	FIELD="$2"
	VALUE="$3"

	echo -en "HSET $KEY $FIELD \"$VALUE\"\r\n" >&16
	disconnect
}

function HGET
{
	connect
	KEY="$1"
	FIELD="$2"

	echo -en "HGET $KEY $FIELD\r\n" >&16
	to_tmp

	echo `tail -n $TMP | tr -cd '[:alnum:]'`
}

function HDEL
{
	connect
	KEY="$1"
	FIELD="$2"

	echo -en "HDEL $KEY $FIELD\r\n" >&16
	disconnect
}

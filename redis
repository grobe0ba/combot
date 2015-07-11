function connect
{
	exec 16<>/dev/tcp/localhost/6739
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
	cat <&16 >$TMP
}

function SCARD
{
	KEY="$1"

	TMP=$(make_temp)

	echo -en "SCARD $KEY\r\n" >&16
	to_tmp

	echo `grep "^:" $TMP | sed -e 's/^://'`
	rm $TMP
}

function SADD
{
	KEY="$1"
	VALUE="$2"

	echo -en "SADD $KEY $VALUE\r\n" >&16
	purge
}

function SPOP
{
	KEY="$1"

	TMP=$(make_temp)

	echo -en "SPOP $KEY\r\n" >&16
	to_tmp
	
	echo `tail -n1 $TMP`

	rm $TMP
}


function HSET
{
	KEY="$1"
	FIELD="$2"
	VALUE="$3"

	echo -en "HSET $KEY $FIELD \"$VALUE\"\r\n" >&16
	purge
}

function HGET
{
	KEY="$1"
	FIELD="$2"

	echo -en "HGET $KEY $FIELD\r\n" >&16
	to_tmp

	echo `tail -n $TMP`
}

function HDEL
{
	KEY="$1"
	FIELD="$2"

	echo -en "HDEL $KEY $FIELD\r\n" >&16
	purge
}

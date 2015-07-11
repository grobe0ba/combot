function addmessage
{
	EXTRA="$2"
	PERSON="$1"
	FROM="$3"
	SESNAM=`echo "$PERSON" | tr -cd "[:alnum:]"`
	FROM=`echo "$FROM" | tr -cd "[:alnum:]"`
	EXTRA=`echo "$EXTRA" | tr -cd "[:print:]"`
	echo "$SESNAM, message from $FROM: $EXTRA" >> $HOME/howie/msgs/$SESNAM
	
}

function getmessage
{
	PERSON="$1"
	SESNAM=`echo "$PERSON" | tr -cd "[:alnum:]"`

	if `grep -q $SESNAM <(find $HOME/howie/msgs)`; then
		sed -e 's/^/ /' $HOME/howie/msgs/$SESNAM >&10
		rm $HOME/howie/msgs/$SESNAM
	fi
}

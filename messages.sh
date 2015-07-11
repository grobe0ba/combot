function addmessage
{
	EXTRA="$2"
	PERSON="$1"
	SESNAM=`echo "$PERSON" | tr -cd "[:alnum:]"`
	EXTRA=`echo "$EXTRA" | tr -cd "[:print:]"`
	echo "$EXTRA" >> $HOME/howie/msgs/$SESNAM
	
}

function getmessage
{
	PERSON="$1"

	if `grep -q $PERSON <(find $HOME/howie/msgs)`; then
		sed -e 's/^/ /' $HOME/howie/msgs/$PERSON
		rm $HOME/howie/msgs/$PERSON
	fi
}

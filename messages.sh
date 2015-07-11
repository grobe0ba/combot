function addmessage
{
	EXTRA="$2"
	PERSON="$1"
	SESNAM=`echo "$PERSON" | tr -cd "[:alnum:]"`
	EXTRA=`echo "$EXTRA" | tr -cd "[:print:]"`
	echo PERSON=$PERSON\tSESNAM=$SESNAM\tEXTRA=$EXTRA
	echo "$EXTRA" >> $HOME/howie/msgs/$SESNAM
	
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

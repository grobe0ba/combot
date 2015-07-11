#!/usr/local/bin/bash

#All credit for this script goes to nullogic@sdf.org

BASE_URL='http://www.urbandictionary.com/define.php?'
#curl 
TERM=''
NUM='1'

case $1 in [0-9]*) NUM=$1; shift; ;; esac

until [ -z "$1" ]
do
	if [ "$TERM" = "" ]; then
		TERM=$1
	else
		TERM="$TERM+$1"
	fi
	shift
done

if [ "$TERM" = "" ]; then
	echo "error: no search terms"
	exit
fi
TERM="term=$TERM"

if [[ $NUM -ge 7 ]]; then
	PNUM=$((($NUM+6)/7))
	PAGE="page=$PNUM"
else 
	PAGE="page=1"
fi

URL="$BASE_URL$TERM&$PAGE"

# DEBUG
echo $URL
#echo $TERM
#echo $NUM
#echo $PAGE
lynx --source $URL |\
sed -e 's/\n//g' -e 's/<br\/>/ /g' -e 's/&quot;/"/g' |\
awk "/$NUM\.\<\/a>/"'{
	while( index($0, "definition")==0 ) {
			getline;
		} 
	printf("definition: ");
	while( index($0, "example")==0 ) {
			print $0;
			getline;
		}
	printf("example: ");
	while( index($0, "greenery")==0 ) {
			print $0;
			getline;
		}
}' |./stripHTML.sed

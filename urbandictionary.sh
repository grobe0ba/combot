#!/usr/pkg/bin/bash

function urbandict_lookup
{
    TERM="$(echo "${1}" | sed -e 's/ /\%20/g')"
    URL="http://www.urbandictionary.com/define.php?term=${TERM}"
    echo -en "L${URL}\r\nUrban Dictionary: ${1}\r\n" >&10
    OLINE="$(curl "${URL}" | grep -e "og:description" | ./udfilter)"
    msg_out "${OLINE}"
}

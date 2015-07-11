#!/usr/pkg/bin/bash

function urbandict_lookup
{
    URL="http://www.urbandictionary.com/define.php?term=${1}"
    echo -en "L${URL}\r\nUrban Dictionary: ${1}\r\n" >&10
    OLINE="$(curl "${URL}" | grep -e "og:description" | ./udfilter)"
    msg_out "${OLINE}"
}

#!/usr/pkg/bin/bash

# $Id$

function urbandict_lookup
{
    RTERM="${1}"
    TERM="${RTERM// /%20}"
    URL="http://www.urbandictionary.com/define.php?term=${TERM}"
    #echo -en "L${URL}\r\nUrban Dictionary: ${1}\r\n" >&10
    OLINE="$(wget -O - "${URL}" | grep -e "og:description" | ./udfilter)"
    msg_out "Urban Dictionary on '${RTERM}': ${OLINE}"
}

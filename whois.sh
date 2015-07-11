#!/usr/pkg/bin/bash

function whois_add()
{
    WHO="$(echo "${1}" | cut -d' ' -f1)"
    INF="$(echo "${1}" | cut -d' ' -f2-)"

    for p in $(xargs < ./wadd);
    do
	if [[ "${PERSON}" == "${p}" || "${PERSON}" == "${WHO}" ]];
	then
	    echo "${INF}" > "whois/${WHO}"
	    if [ -e "./whois/${WHO}" ];
	    then
	    	msg_out "WHOIS for ${WHO} stored."
	    else
		msg_out "Unable to store WHOIS."
	    fi
	    break
	fi
    done
}

function whois_list()
{
    WHO="$(echo "${1}" | cut -d' ' -f1)"
    
    if [ -e "./whois/${WHO}" ];
    then
	INF="$(cat "./whois/${WHO}")"
	msg_out "${INF}"
    else
	msg_out "I don't know who ${WHO} is, they're probably a nub or something."
    fi
}

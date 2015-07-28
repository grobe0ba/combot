#!/usr/pkg/bin/bash

# $Id$

function whois_add()
{
    WHO="$(echo "${1}" | cut -d' ' -f1)"
    WHO="$(basename "${WHO}")"
    INF="$(echo "${1}" | cut -d' ' -f2-)"

    for p in $(xargs < ./wadd);
    do
	if [[ "${PERSON}" == "${p}" || "${PERSON}" == "${WHO}" ]];
	then
	    echo "${INF}" > "whois/${WHO}"
	    if [ -e "./whois/${WHO}" ];
	    then
	    	reply "WHOIS for ${WHO} stored."
	    else
		reply "Unable to store WHOIS."
	    fi
	    break
	fi
    done
}

function whois_list()
{
    WHO="$(echo "${1}" | cut -d' ' -f1)"
    WHO="$(basename "${WHO}")"
    
    if [ -e "./whois/${WHO}" ];
    then
	INF="$(cat "./whois/${WHO}")"
	reply "${INF}"
    else
	reply "I don't know who ${WHO} is, probably a societal reject or something."
    fi
}

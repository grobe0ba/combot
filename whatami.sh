#!/usr/pkg/bin/bash

function mod
{
    A="${1}"
    B="${2}"

    #A-B(INT(A/B))

    C="$((A/B))"
    C="$((B*C))"
    A="$((A-C))"

    echo "${A}"
}

function whatami
{
    PERSON="$(echo "${1}"|cut -d' ' -f1)"

    NTHINGS="$(wc -l ./misc/things | cut -d' ' -f1)"

    THING="$(mod "${RANDOM}" "${NTHINGS}")"
    THING="$((THING+1))"
    
    OUT="$(gsed "${THING}!d" ./misc/things)"

    msg_out "${PERSON} is an ${OUT}"
}

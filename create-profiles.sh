#!/usr/bin/env bash
# vim: autoindent tabstop=4 shiftwidth=4 expandtab softtabstop=4 filetype=bash
# -*- mode: sh; indent-tabs-mode: nil; sh-basic-offset: 4 -*-

MAC_A=${1}
MAC_B=${2}

if [ -z "${MAC_A}" -o -z "${MAC_B}" ]; then
    echo "ERROR: You must specify both MAC_A and MAC_B as ordered arguments"
    exit 1
fi

CWD=$(dirname $0)

if pushd ${CWD}/base > /dev/null; then
    mkdir -p ../configured

    for profile in $(ls -1 *.json); do
	cat ${profile} | sed -e "s/MAC_A/${MAC_A}/" -e "s/MAC_B/${MAC_B}/" > ../configured/${profile}
    done

    ls -l ../configured

    popd > /dev/null
else
    echo "ERROR: Could not pushd to '${CWD}/base'"
    exit 2
fi

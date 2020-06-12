#!/usr/bin/env bash
# vim: autoindent tabstop=4 shiftwidth=4 expandtab softtabstop=4 filetype=bash
# -*- mode: sh; indent-tabs-mode: nil; sh-basic-offset: 4 -*-

TREX_MAC_A=${1}
TREX_MAC_B=${2}
DUT_MAC_A=${3}
DUT_MAC_B=${4}

if [ -z "${TREX_MAC_A}" -o -z "${TREX_MAC_B}" -o -z "${DUT_MAC_A}" -o -z "${DUT_MAC_B}" ]; then
    echo "ERROR: You must specify TREX_MAC_A, TREX_MAC_B, DUT_MAC_A, and DUT_MAC_B as ordered arguments"
    exit 1
fi

CWD=$(dirname $0)

if pushd ${CWD}/base > /dev/null; then
    mkdir -p ../configured

    for profile in $(ls -1 *.json); do
	cat ${profile} | sed -e "s/TREX_MAC_A/${TREX_MAC_A}/" -e "s/TREX_MAC_B/${TREX_MAC_B}/" -e "s/DUT_MAC_A/${DUT_MAC_A}/" -e "s/DUT_MAC_B/${DUT_MAC_B}/" > ../configured/${profile}
    done

    ls -l ../configured

    popd > /dev/null
else
    echo "ERROR: Could not pushd to '${CWD}/base'"
    exit 2
fi

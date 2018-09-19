#!/bin/sh
#===-- clean-test.sh - Remove unnecessary data from test scripts (like .ll) ===#
#
#                     The LLVM Compiler Infrastructure
#
# This file is distributed under the University of Illinois Open Source
# License.
#
#===------------------------------------------------------------------------===#
#
# Create branches and release candidates for the LLVM release.
#
#===------------------------------------------------------------------------===#

usage() {
    echo "usage: `basename $0` files"
    echo " "
}

case $1 in
    -h | --help | -help )
        usage
        exit 0
        ;;
esac

for i in "$@"; do
    sed -i -e '/^attributes #.*/d' \
        -e 's/ #[^ ][^ ]*//' \
        -e 's/ local_unnamed_addr//' \
        -e 's/ dso_local//' \
        -e '/^!llvm.*/d' \
        -e '/^!0 =/d' \
        -e '/^!1 =/d' \
        -e '/^; ModuleID/d' \
        -e '/^source_filename = /d' \
        -e '/^target datalayout =/d' \
        -e '/^target triple =/d' $i
    sed -i -e '/^$/N;/^\n$/D' $i
done

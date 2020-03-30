#!/bin/sh
#===-- check-asm-test - Compare each asm test with system as ---------------===#
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

AS=${AS:-/opt/nec/ve/bin/nas}
OBJCOPY=${OBJCOPY:-/opt/nec/ve/bin/nobjcopy}
LLVMMC=${LLVMMC:-llvm-mc}


case $1 in
    -h | --help | -help )
        usage
        exit 0
        ;;
esac

for i in "$@"; do
    $AS $i -o $i.tmp && $OBJCOPY -O binary --only-section=.text $i.tmp $i.tmp2
    $LLVMMC -triple ve-linux $i -filetype=obj > $i.tmp && $OBJCOPY -O binary --only-section=.text $i.tmp $i.tmp3
    cmp $i.tmp2 $i.tmp3 || echo error on $i
    rm $i.tmp $i.tmp2 $i.tmp3
done

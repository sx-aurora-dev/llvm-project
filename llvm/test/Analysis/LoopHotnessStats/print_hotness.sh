#!/bin/sh

LLFILE=`echo $1 | sed -e 's/\.c/.ll/g'`
SOURCE=$1
OPT=~/Documents/nec_llvm/bin/opt

./create_profiled_ll.sh ${SOURCE}
${OPT} ${LLFILE} -passes="print<loop-hotness>" -disable-output
rm ${LLFILE}

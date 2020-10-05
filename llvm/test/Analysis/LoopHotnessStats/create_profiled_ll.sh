#!/bin/sh

LLFILE=`echo $1 | sed -e 's/\.c/.ll/g'`
SOURCE=$1

clang -g ${SOURCE} -o instr_out -fprofile-instr-generate=data.profraw
./instr_out
# Normally, we would want to do multiple runs of the program but
# we assume that the loops will have the same trip counts in every run.
llvm-profdata merge -output=data.profdata data.profraw
clang ${SOURCE} -o ${LLFILE} -g -emit-llvm -S -c -fprofile-instr-use=data.profdata
# opt -loop-simplify ${LLFILE} -o ${LLFILE}
rm instr_out data.profraw data.profdata

#! /bin/sh

F=lib/Target/VE/veintrin.py

set -v

mkdir -p tmp

python $F -p > tmp/VEInstrIntrinsic.td
python $F -i > tmp/IntrinsicsVE2.td
python $F -b > tmp/BuiltinsVE2.def
python $F --veintrin > tmp/veintrin2.h
python $F --decl > tmp/decl.h
python $F -l > tmp/VEISelLoweringIntrinsic.inc

#python $F -t
python $F -r > tmp/ref.cc
python $F --html > tmp/intrinsics.html

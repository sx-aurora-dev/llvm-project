#! /bin/sh

set -v

python builtin.py -p > lib/Target/VE/VEInstrIntrinsic.td
python builtin.py -i > include/llvm/IR/IntrinsicsVE2.td
python builtin.py -b > tools/clang/include/clang/Basic/BuiltinsVE2.def
python builtin.py --header > ../test/intrinsic/veintrin2.h

dir=../test/intrinsic/tests
#rm -f ${dir}/*.c
python builtin.py -t

python builtin.py -r > ../test/intrinsic/ref.cc



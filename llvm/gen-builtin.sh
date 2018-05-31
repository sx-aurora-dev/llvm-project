#! /bin/sh

set -v

python builtin.py -p > tmp/VEInstrIntrinsic.td #> lib/Target/VE/VEInstrIntrinsic.td
python builtin.py -i > tmp/IntrinsicsVE2.td #> include/llvm/IR/IntrinsicsVE2.td
python builtin.py -b > tmp/BuiltinsVE2.def #> tools/clang/include/clang/Basic/BuiltinsVE2.def
python builtin.py --veintrin > tmp/veintrin2.h #> ../test/intrinsic/veintrin2.h
python builtin.py --decl > tmp/decl.h #> ../test/intrinsic/decl.h

dir=../test/intrinsic/tests
#rm -f ${dir}/*.c
python builtin.py -t

python builtin.py -r > tmp/ref.cc #> ../test/intrinsic/gen/ref.cc

python builtin.py --html > tmp/intrinsics.html

#touch include/llvm/IR/Intrinsics.td
#touch tools/clang/include/clang/Basic/Builtins.def


#! /bin/sh

set -v

python veintrin.py -p > tmp/VEInstrIntrinsic.td #> lib/Target/VE/VEInstrIntrinsic.td
python veintrin.py -i > tmp/IntrinsicsVE2.td #> include/llvm/IR/IntrinsicsVE2.td
python veintrin.py -b > tmp/BuiltinsVE2.def #> tools/clang/include/clang/Basic/BuiltinsVE2.def
python veintrin.py --veintrin > tmp/veintrin2.h #> ../test/intrinsic/veintrin2.h
python veintrin.py --decl > tmp/decl.h #> ../test/intrinsic/decl.h

dir=../test/intrinsic/tests
#rm -f ${dir}/*.c
python veintrin.py -t

python veintrin.py -r > tmp/ref.cc #> ../test/intrinsic/gen/ref.cc

python veintrin.py --html > tmp/intrinsics.html

#touch include/llvm/IR/Intrinsics.td
#touch tools/clang/include/clang/Basic/Builtins.def


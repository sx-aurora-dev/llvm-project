#! /bin/sh

#set -v

F=lib/Target/VE/veintrin.py

if test ! -f $F; then
	echo "Error. Run in llvm directory"
	exit
fi


python $F --inst > lib/Target/VE/VEInstrVecVL.gen.td
python $F -p > lib/Target/VE/VEInstrIntrinsicVL.gen.td
python $F -i > include/llvm/IR/IntrinsicsVEVL.gen.td
python $F -b > ../clang/include/clang/Basic/BuiltinsVEVL.gen.def
python $F --veintrin > ../clang/lib/Headers/velintrin_gen.h
python $F --vl-index > lib/Target/VE/vl-index.inc

#python $F --html > velintrin.html

#python $F -r  > ../../llvm-ve-intrinsic-test/gen/ref.cc
#python $F --decl  > ../../llvm-ve-intrinsic-test/decl.h
#python $F -t

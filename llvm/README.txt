LLVM for NEC SX-Aurora VE
=========================

This repository is a clone of public LLVM repository (http://llvm.org), plus an
experimental modifications which provides support for the NEC SX-Aurora Tsubasa
Vector Engine (VE).

Modifications are under the development.  For example, we implmented below.

 - integer, long long, float, double, and vector
 - function call passing arguments through registers
 - intrinsic functions to use vector instructions

However, following items are not implemented yet.

 - function call passing arguments through stack may fail
 - varargs
 - automatic vectorization is not supported yet

Please file issues if you have problems.

How to compile LLVM for NEC SX-Aurora VE
========================================

First, check out llvm and clang like below.

    $ git clone https://github.com/SXAuroraTSUBASAResearch/llvm.git \
      llvm -b develop
    $ git clone https://github.com/SXAuroraTSUBASAResearch/clang.git \
      llvm/tools/clang -b develop

Then, compile it with ninja.

    $ mkdir build
    $ cd build
    $ cmake3 -G Ninja -DCMAKE_BUILD_TYPE="Release" \
      -DLLVM_TARGETS_TO_BUILD="VE" ../llvm
    $ ninja-build

Use it from clang like:

    $ clang -target ve -O3 -fno-vectorize -fno-slp-vectorize \
      -fno-crash-diagnostics -c ...

 - Clang without -O3 may cause internal compiler errors.  Adding -O3 option
   will solve this problem.
 - Clang with -O3 may cause vectorization related errors.  Adding
   "-fno-vectorize -fno-slp-vectorize" options will solve this problem.
 - -fno-crash-diagnostics avoid generating diagnostics which contain
   compiling source codes.

Please see the documentation provided in docs/ for further
assistance with LLVM.

The LLVM Compiler Infrastructure
================================

This directory and its subdirectories contain source code for LLVM,
a toolkit for the construction of highly optimized compilers,
optimizers, and runtime environments.

LLVM is open source software. You may freely distribute it under the terms of
the license agreement found in LICENSE.txt.

Please see the documentation provided in docs/ for further
assistance with LLVM, and in particular docs/GettingStarted.rst for getting
started with LLVM and docs/README.txt for an overview of LLVM's
documentation setup.

If you are writing a package for LLVM, see docs/Packaging.rst for our
suggestions.


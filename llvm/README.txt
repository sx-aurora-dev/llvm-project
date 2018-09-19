LLVM for NEC SX-Aurora VE
=========================

This repository is a clone of public LLVM repository (http://llvm.org), plus an
experimental modifications which provides support for the NEC SX-Aurora Tsubasa
Vector Engine (VE).

Modifications are under the development.  We know following flaws.

 - automatic vectorization is not supported yet
 - long double is not fully supported

Please file issues if you have problems.

How to compile LLVM for NEC SX-Aurora VE
========================================

First, check out llvm and clang like below.

    $ git clone https://github.com/SXAuroraTSUBASAResearch/llvm.git \
      llvm -b develop
    $ git clone https://github.com/SXAuroraTSUBASAResearch/clang.git \
      llvm/tools/clang -b develop
    $ git clone https://github.com/SXAuroraTSUBASAResearch/compiler-rt.git \
      llvm/projects/compiler-rt -b develop

Then, compile clang/llvm with ninja and install it.

    $ mkdir build
    $ cd build
    $ cmake3 -G Ninja \
      -DCMAKE_BUILD_TYPE="Release" \
      -DLLVM_TARGETS_TO_BUILD="VE;X86" \
      -DCMAKE_INSTALL_PREFIX=$HOME/.local \
      ../llvm
    $ ninja-build install

And, cross-compile compiler-rt with compiled clang/llvm and install it.

    $ mkdir build-compiler-rt
    $ cd build-compiler-rt
    $ cmake3 -G Ninja \
      -DCOMPILER_RT_BUILD_BUILTINS=ON \
      -DCOMPILER_RT_BUILD_SANITIZERS=OFF \
      -DCOMPILER_RT_BUILD_XRAY=OFF \
      -DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
      -DCOMPILER_RT_BUILD_PROFILE=OFF \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_C_COMPILER=$HOME/.local/bin/clang \
      -DCMAKE_AR=$HOME/.local/bin/llvm-ar \
      -DCMAKE_RANLIB=$HOME/.local/bin/llvm-ranlib \
      -DCMAKE_ASM_COMPILER_TARGET="ve-linux-none" \
      -DCMAKE_C_COMPILER_TARGET="ve-linux-none" \
      -DCOMPILER_RT_DEFAULT_TARGET_ONLY=ON \
      -DLLVM_CONFIG_PATH=$HOME/.local/bin/llvm-config \
      -DCMAKE_BUILD_TYPE="Release" \
      -DCMAKE_INSTALL_PREFIX=$HOME/.local/lib/clang/8.0.0/ \
      -DCMAKE_CXX_FLAGS="-I$HOME/.local/ve/include -isystem /opt/nec/ve/musl/include -target ve-linux-none -ccc-gcc-name ve-linux-none -nostdlib" \
      -DCMAKE_CXX_FLAGS_RELEASE="-O2 -fno-vectorize -fno-slp-vectorize" \
      -DCMAKE_C_FLAGS="-I$HOME/.local/ve/include -isystem /opt/nec/ve/musl/include -target ve-linux-none -ccc-gcc-name ve-linux-none -nostdlib" \
      -DCMAKE_C_FLAGS_RELEASE="-O2 -fno-vectorize -fno-slp-vectorize" \
      ../llvm/projects/compiler-rt
   $ ninja-build install

Use clang like below.

    $ clang -target ve-linux -O3 -fno-vectorize -fno-slp-vectorize \
      -fno-crash-diagnostics -c ...

 - Clang without -O3 may cause internal compiler errors.  Adding -O3 option
   will solve this problem.
 - Clang with -O3 may cause vectorization related errors.  Adding
   "-fno-vectorize -fno-slp-vectorize" options will solve this problem.
 - -fno-crash-diagnostics avoid generating diagnostics which contain
   compiling source codes under /tmp.

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


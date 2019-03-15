LLVM for NEC SX-Aurora VE
=========================

This repository is a clone of public LLVM repository (http://llvm.org), plus an
experimental modifications which provides support for the NEC SX-Aurora Tsubasa
Vector Engine (VE).

Modifications are under the development.  We know following flaws.

 - automatic vectorization is not supported yet

Please file issues if you have problems.

Prerequisites to build
======================

 - gcc 5.1 or above for host

Prerequisites to use
====================

LLVM for VE supports only glibc environment.  Please be advised to
update VE environment if you are using musl environment.

Following packages are required.
Note that these packages are included in the veos software package,
or available from a site (https://sx-aurora.com/repos/veos/common/x86_64/).

 - binutils-ve
 - glibc-ve
 - glibc-ve-devel
 - kernel-headers-ve

RPM package contents
====================

We will release an RPM package of LLVM for VE soon.  It contains
following pre-compiled programs and libraries.

 - clang (C compiler)
 - clang++ (C++ compiler)
 - compier-rt library (runtime library)
 - ve-csu library (crtbeing.o/crtend.o from NetBSD CSU)
 - libc++ library (for C++)
 - libc++abi library (for libc++)
 - libcunwind library (for libc++abi)
 - openmp library (OpenMP)

Files are installed into /opt/nec/nosupport/llvm-<version> directory.

How to compile LLVM for NEC SX-Aurora VE automatically
======================================================

Use llvm-dev tool.  This retrieves source files, configures not only host
programs but also cross-compiling libraries, compiles all of them,
and installs all under ./install directory.

    $ git clone https://github.com/SXAuroraTSUBASAResearch/llvm-dev.git
    $ cd llvm-dev
    $ make shallow
    $ make
    $ ls install
    bin  include  lib  libexec  share

How to compile LLVM for NEC SX-Aurora VE by hand
================================================

First, check out llvm, clang, and other libraries like below.

    $ mkdir work
    $ cd work
    $ git clone https://github.com/SXAuroraTSUBASAResearch/llvm.git \
      llvm -b develop
    $ git clone https://github.com/SXAuroraTSUBASAResearch/clang.git \
      llvm/tools/clang -b develop
    $ git clone https://github.com/SXAuroraTSUBASAResearch/compiler-rt.git \
      llvm/projects/compiler-rt -b develop
    $ git clone https://github.com/SXAuroraTSUBASAResearch/libunwind.git \
      llvm/projects/libunwind -b develop
    $ git clone https://github.com/SXAuroraTSUBASAResearch/libcxx.git \
      llvm/projects/libcxx -b develop
    $ git clone https://github.com/SXAuroraTSUBASAResearch/libcxxabi.git \
      llvm/projects/libcxxabi -b develop
    $ git clone https://github.com/SXAuroraTSUBASAResearch/openmp.git \
      llvm/projects/openmp -b develop

Then, compile clang/llvm with ninja and install it.

    $ cd work
    $ mkdir build
    $ cd build
    $ export DEST=$HOME/.local
    $ cmake3 -G Ninja \
      -DCMAKE_BUILD_TYPE="Release" \
      -DLLVM_TARGETS_TO_BUILD="VE;X86" \
      -DCMAKE_INSTALL_PREFIX=$DEST \
      ../llvm
    $ ninja-build
    $ ninja-build install

How to cross-compile CSU for NEC SX-Aurora VE
=============================================

First, check out ve-csu like below.

    $ cd work
    $ git clone https://github.com/SXAuroraTSUBASAResearch/ve-csu.git \
      ve-csu

Then, cross-compile it with clang/llvm for VE and install it.

    $ cd work/ve-csu
    $ export DEST=$HOME/.local
    $ make TARGET=ve-linux
    $ make DEST=$DEST/lib/clang/9.0.0/lib/linux/ve install

How to cross-compile Compiler-RT for NEC SX-Aurora VE
=====================================================

Cross-compile compiler-rt with clang/llvm for VE and install it.

    $ cd work
    $ mkdir build-compiler-rt
    $ cd build-compiler-rt
    $ export DEST=$HOME/.local
    $ cmake3 -G Ninja \
      -DCOMPILER_RT_BUILD_BUILTINS=ON \
      -DCOMPILER_RT_BUILD_SANITIZERS=OFF \
      -DCOMPILER_RT_BUILD_XRAY=OFF \
      -DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
      -DCOMPILER_RT_BUILD_PROFILE=OFF \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_C_COMPILER=$DEST/bin/clang \
      -DCMAKE_C_COMPILER_TARGET="ve-linux" \
      -DCMAKE_ASM_COMPILER_TARGET="ve-linux" \
      -DCMAKE_AR=$DEST/bin/llvm-ar \
      -DCMAKE_RANLIB=$DEST/bin/llvm-ranlib \
      -DCOMPILER_RT_DEFAULT_TARGET_ONLY=ON \
      -DLLVM_CONFIG_PATH=$DEST/bin/llvm-config \
      -DCMAKE_BUILD_TYPE="Release" \
      -DCMAKE_INSTALL_PREFIX=$DEST/lib/clang/9.0.0/ \
      -DCMAKE_CXX_FLAGS="-nostdlib" \
      -DCMAKE_CXX_FLAGS_RELEASE="-O3 -fno-vectorize -fno-slp-vectorize" \
      -DCMAKE_C_FLAGS="-nostdlib" \
      -DCMAKE_C_FLAGS_RELEASE="-O3 -fno-vectorize -fno-slp-vectorize" \
      ../llvm/projects/compiler-rt
    $ ninja-build
    $ ninja-build install

How to cross-compile other libraries for NEC SX-Aurora VE
=========================================================

Cross-compile libunwind with clang/llvm for VE and install it.

    $ cd work
    $ mkdir build-libunwind
    $ cd build-libunwind
    $ export DEST=$HOME/.local
    $ cmake3 -G Ninja \
      -DLIBUNWIND_TARGET_TRIPLE="ve-linux" \
      -DCMAKE_C_COMPILER=$DEST/bin/clang \
      -DCMAKE_CXX_COMPILER=$DEST/bin/clang++ \
      -DCMAKE_AR=$DEST/bin/llvm-ar \
      -DCMAKE_RANLIB=$DEST/bin/llvm-ranlib \
      -DCMAKE_C_COMPILER_TARGET="ve-linux" \
      -DCMAKE_CXX_COMPILER_TARGET="ve-linux" \
      -DLLVM_CONFIG_PATH=$DEST/bin/llvm-config \
      -DLLVM_ENABLE_LIBCXX=ON \
      -DCMAKE_BUILD_TYPE="Release" \
      -DCMAKE_INSTALL_PREFIX=$DEST/lib/clang/9.0.0/ \
      -DLIBUNWIND_LIBDIR_SUFFIX=/linux/ve/ \
      -DCMAKE_CXX_FLAGS="-nostdlib" \
      -DCMAKE_CXX_FLAGS_RELEASE="-O3 -fno-vectorize -fno-slp-vectorize" \
      -DCMAKE_C_FLAGS="-nostdlib" \
      -DCMAKE_C_FLAGS_RELEASE="-O3 -fno-vectorize -fno-slp-vectorize" \
      ../llvm/projects/libunwind
    $ ninja-build
    $ ninja-build install

Cross-compile libcxxabi with clang/llvm for VE and install it.

    $ cd work
    $ mkdir build-libcxxabi
    $ cd build-libcxxabi
    $ export DEST=$HOME/.local
    $ cmake3 -G Ninja \
      -DCMAKE_C_COMPILER=$DEST/bin/clang \
      -DCMAKE_CXX_COMPILER=$DEST/bin/clang++ \
      -DCMAKE_AR=$DEST/bin/llvm-ar \
      -DCMAKE_RANLIB=$DEST/bin/llvm-ranlib \
      -DCMAKE_C_COMPILER_TARGET="ve-linux" \
      -DCMAKE_CXX_COMPILER_TARGET="ve-linux" \
      -DLLVM_CONFIG_PATH=$DEST/bin/llvm-config \
      -DCMAKE_BUILD_TYPE="Release" \
      -DCMAKE_INSTALL_PREFIX=$DEST/lib/clang/9.0.0/ \
      -DLIBCXXABI_LIBDIR_SUFFIX=/linux/ve/ \
      -DLIBCXXABI_USE_LLVM_UNWINDER=YES \
      -DCMAKE_CXX_FLAGS="-nostdlib++" \
      -DCMAKE_CXX_FLAGS_RELEASE="-O3 -fno-vectorize -fno-slp-vectorize" \
      -DCMAKE_C_FLAGS="-nostdlib++" \
      -DCMAKE_C_FLAGS_RELEASE="-O3 -fno-vectorize -fno-slp-vectorize" \
      -DLLVM_PATH=../llvm \
      -DLLVM_MAIN_SRC_DIR=../llvm \
      -DLLVM_ENABLE_LIBCXX=True \
      -DLIBCXXABI_USE_COMPILER_RT=True \
      -DLIBCXXABI_HAS_NOSTDINCXX_FLAG=True \
      ../llvm/projects/libcxxabi
    $ ninja-build
    $ ninja-build install

Cross-compile libcxx with clang/llvm for VE and install it.

    $ cd work
    $ mkdir build-libcxx
    $ cd build-libcxx
    $ export DEST=$HOME/.local
    $ cmake3 -G Ninja \
      -DLIBCXX_USE_COMPILER_RT=True \
      -DLIBCXX_TARGET_TRIPLE="ve-linux" \
      -DCMAKE_C_COMPILER=$DEST/bin/clang \
      -DCMAKE_CXX_COMPILER=$DEST/bin/clang++ \
      -DCMAKE_AR=$DEST/bin/llvm-ar \
      -DCMAKE_RANLIB=$DEST/bin/llvm-ranlib \
      -DCMAKE_C_COMPILER_TARGET="ve-linux" \
      -DCMAKE_CXX_COMPILER_TARGET="ve-linux" \
      -DLLVM_CONFIG_PATH=$DEST/bin/llvm-config \
      -DCMAKE_BUILD_TYPE="Release" \
      -DCMAKE_INSTALL_PREFIX=$DEST/lib/clang/9.0.0/ \
      -DLIBCXX_LIBDIR_SUFFIX=/linux/ve/ \
      -DCMAKE_C_FLAGS="-nostdlib++" \
      -DCMAKE_C_FLAGS_RELEASE="-O3 -fno-vectorize -fno-slp-vectorize" \
      -DCMAKE_CXX_FLAGS="-nostdlib++" \
      -DCMAKE_CXX_FLAGS_RELEASE="-O3 -fno-vectorize -fno-slp-vectorize" \
      ../llvm/projects/libcxx
    $ ninja-build
    $ ninja-build install

Cross-compile OpenMP with clang/llvm for VE and install it.

    $ cd work
    $ mkdir build-openmp
    $ cd build-openmp
    $ export DEST=$HOME/.local
    $ cmake3 -G Ninja \
      -DCMAKE_C_COMPILER=$DEST/bin/clang \
      -DCMAKE_CXX_COMPILER=$DEST/bin/clang++ \
      -DCMAKE_AR=$DEST/bin/llvm-ar \
      -DCMAKE_RANLIB=$DEST/bin/llvm-ranlib \
      -DCMAKE_C_COMPILER_TARGET="ve-linux" \
      -DCMAKE_CXX_COMPILER_TARGET="ve-linux" \
      -DCMAKE_BUILD_TYPE="Release" \
      -DCMAKE_INSTALL_PREFIX=$DEST/lib/clang/9.0.0/ \
      -DOPENMP_LIBDIR_SUFFIX=/linux/ve \
      -DCMAKE_CXX_FLAGS="" \
      -DCMAKE_CXX_FLAGS_RELEASE="-O3 -fno-vectorize -fno-slp-vectorize -mllvm -combiner-use-vector-store=false" \
      -DCMAKE_C_FLAGS="" \
      -DCMAKE_C_FLAGS_RELEASE="-O3 -fno-vectorize -fno-slp-vectorize -mllvm -combiner-use-vector-store=false" \
      -DLIBOMP_ARCH="ve" \
      ../llvm/projects/openmp
    $ ninja-build
    $ ninja-build install


How to use clang/llvm for VE
============================

Use clang like below.  Clang++ is also available.

    $ clang -target ve-linux -O3 -fno-vectorize -fno-slp-vectorize \
      -fno-crash-diagnostics ...

 - Clang with -O3 may vectorize programs, but llvm backend for VE doesn't
   support vector instructions yet.  So, add "-fno-vectorize 
   -fno-slp-vectorize" options to not vectorize programs.
 - -fno-crash-diagnostics avoid generating diagnostics which contain
   compiling source codes under /tmp.

Please see the documentation provided in docs/ for further
assistance with LLVM.

Intrinsics for SX-Aurora VE
===========================

See https://sxauroratsubasaresearch.github.io/intrinsics.html.


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

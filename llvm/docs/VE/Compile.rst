===============================
How to hand-compile LLVM for VE
===============================

.. contents:: Table of Contents
  :depth: 4
  :local:

Prerequisites
=============

  - cmake (cmake3 in RHEL7)
  - ninja (ninja-build in RHEL7)
  - gcc 5.1 or above (devtoolset-8 in RHEL7)

Retrieve source codes
=====================

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

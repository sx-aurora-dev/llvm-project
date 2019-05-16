LLVM for NEC SX-Aurora VE
=========================

This repository is a clone of public LLVM repository (http://llvm.org), plus an
experimental modifications which provides support for the NEC SX-Aurora Tsubasa
Vector Engine (VE).

Modifications are under the development.  Modified files are retrieved through
following command.

    $ git diff merged-upstream

We know following flaw(s).

 - automatic vectorization is not supported yet

Please file issues if you have problems.

Prerequisites to use
====================

LLVM for VE supports only glibc environment.  We don't support musl
environment anymore.

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
 - libc++ library (for C++)
 - libc++abi library (for libc++)
 - libunwind library (for libc++abi)
 - openmp library (OpenMP)

Files are installed into /opt/nec/nosupport/llvm-<version> directory.

How to compile LLVM for NEC SX-Aurora VE automatically
======================================================

Use llvm-dev tool.  This tool retrieves source files, configures not
only host programs but also cross-compiling libraries, compiles all of them,
and installs all under ./install directory.

    $ git clone https://github.com/SXAuroraTSUBASAResearch/llvm-dev.git
    $ cd llvm-dev
    $ make shallow    # perform shallow copies of all source code
    $ make            # compile clang/llvm and cross-compile libraries
    $ ls install
    bin  include  lib  libexec  share

How to use clang/llvm for VE
============================

Use clang like below.  Clang++ is also available.

    $ clang -target ve-linux -O3 -fno-vectorize -fno-slp-vectorize \
      -fno-crash-diagnostics -frtlib-add-rapth ...

 - Clang with -O3 may vectorize programs, but llvm backend for VE doesn't
   support vector instructions yet.  So, add "-fno-vectorize 
   -fno-slp-vectorize" options to not vectorize programs.
 - -fno-crash-diagnostics avoid generating diagnostics which contain
   compiling source codes under /tmp.
 - -frtlib-add-rpath passes default runtime libraries path to to linker.
   This solves "cannot open shared object file" error at run-time.

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

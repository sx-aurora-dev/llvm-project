LLVM for NEC SX-Aurora VE
=========================

This repository is a clone of public LLVM repository (http://llvm.org), plus an
experimental modifications which provides support for the NEC SX-Aurora Tsubasa
Vector Engine (VE).

Modifications are under the development.  Modified files are retrieved through
following command.

    $ git diff merged-upstream

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

We are releasing an RPM package of LLVM for VE.  It contains
following pre-compiled programs and libraries.

 - clang (C compiler)
 - clang++ (C++ compiler)
 - compiler-rt library (runtime library)
 - libc++ library (for C++)
 - libc++abi library (for libc++)
 - libunwind library (for libc++abi)
 - openmp library (OpenMP)
 - libRV library (Region Vectorizer)

Files are installed into /opt/nec/nosupport/llvm-<version> directory.

How to compile LLVM for NEC SX-Aurora VE automatically
======================================================

Use llvm-dev tool.  This tool retrieves source files, configures not
only host programs but also cross-compiling libraries, compiles all of them,
and installs all under ./install directory.

    $ git clone https://github.com/sx-aurora-dev/llvm-dev.git
    $ cd llvm-dev
    $ make shallow    # perform shallow copies of all source code
    $ make            # compile clang/llvm and cross-compile libraries
    $ ls install
    bin  include  lib  libexec  share

How to use clang/llvm for VE
============================

Use clang like below.  Clang++ is also available.

    $ clang -target ve-linux -O3 -fno-crash-diagnostics ...

 - -fno-crash-diagnostics avoid generating diagnostics which contain
   compiling source codes under /tmp.

Please see the documentation provided in docs/ for further
assistance with LLVM.

LLVM for NEC SX-Aurora VE
=========================

This repository is a clone of public LLVM repository (http://llvm.org), plus an
experimental modifications which provides support for the NEC SX-Aurora Tsubasa
Vector Engine (VE). See [README_MORE.rst](docs/VE/README_MORE.rst).

You can start with the PRM package.

```
% yum install \
  https://sx-aurora.com/repos/veos/ef_extra/x86_64/llvm-ve-1.1.0-1.1.0-1.x86_64.rpm \
  https://sx-aurora.com/repos/veos/ef_extra/x86_64/llvm-ve-link-1.1.0-1.x86_64.rpm
```

Then use clang like below.  Clang++ is also available.

    $ /opt/nec/nosupport/llvm-ve/clang -target ve-linux -O3 \
       -fno-vectorize -fno-slp-vectorize ...

Clang with -O3 may vectorize programs, but llvm backend for VE doesn't support
vector instructions yet.  So, add "-fno-vectorize -fno-slp-vectorize" options
to not vectorize programs.

- If you are interested in intrinsic functions for vector instructions, see
  [the manual](https://sx-aurora-dev.github.io/velintrin.html).
- If you are interested in the guided vectorization, or region vectorizer, see
  [RV](https://github.com/cdl-saarland/rv).
- If you want to build the llvm-ve, see
  [llvm-dev](https://github.com/sx-aurora-dev/llvm-dev) and
  [Compile.rst](docs/VE/Compile.rst].


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

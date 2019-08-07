LLVM for NEC SX-Aurora VE
=========================

This repository is a clone of public LLVM repository (http://llvm.org), plus an
experimental modifications which provides support for the NEC SX-Aurora TSUBASA
Vector Engine (VE). See [README_MORE.rst](docs/VE/README_MORE.rst).

You can start with the PRM package.

```
% yum install \
  https://sx-aurora.com/repos/veos/ef_extra/x86_64/llvm-ve-1.3.0-1.3.0-1.x86_64.rpm \
  https://sx-aurora.com/repos/veos/ef_extra/x86_64/llvm-ve-link-1.3.0-1.x86_64.rpm
```

Then use clang like below.  Clang++ is also available.

    $ /opt/nec/nosupport/llvm-ve/clang -target ve-linux -O3 ...

- If you are interested in intrinsic functions for vector instructions, see
  [the manual](https://sx-aurora-dev.github.io/velintrin.html).
- If you are interested in the guided vectorization, or region vectorizer, see
  [RV](https://github.com/cdl-saarland/rv).
- If you want to build the llvm-ve, see
  [llvm-dev](https://github.com/sx-aurora-dev/llvm-dev) and
  [Compile.rst](docs/VE/Compile.rst).
- Automatic vectorization is not supported.

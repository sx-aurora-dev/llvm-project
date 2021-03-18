# LLVM for NEC SX-Aurora VE (llvm-ve-rv 1.8-dev)

[![Build Status](https://travis-ci.com/sx-aurora-dev/llvm-project.svg?branch=hpce%2Fdevelop)](https://travis-ci.com/sx-aurora-dev/llvm-project)

This is a fork of the LLVM repositoy with support for the NEC
SX-Aurora TSUBASA Vector Engine (VE).

### Features

- C, C++ support.
- VEL intrinsics for low-level vector programming.
- Automatic vectorization through LLVM's loop and SLP vectorizers.
- When combined with RV for SX-Aurora, provides user-guided (and some automatic)
  outer-loop vectorization through the Region Vectorizer.
- Two OpenMP offloading modes: VE to VH and VH to VE.


### Build instructions

To build llvm-ve from source refer to
[llvm-dev](https://github.com/sx-aurora-dev/llvm-dev) and
[Compile.rst](llvm/docs/VE/Compile.rst).


### General Usage

To compile C/C++ code for the VE run Clang/Clang++ with the following command
line:

    $ clang -target ve-linux -O3 ...


### OpenMP offloading for/from SX-Aurora

To compile with OpenMP offloading from VE to VH (VHCall) use:

    $ clang -target ve-linux -fopenmp -fopenmp-targets=x86_64-pc-linux -O3 ...

To compile with OpenMP offloading from VH to VE (VEO) use:

    $ clang -march=native -fopenmp -fopenmp-targets=ve-linux -O3 ...


### Outer-loop Vectorization

LLVM for SX-Aurora provides outer-loop vectorization, provided it is build with
the Region Vectorizer.  The following usage examples require an RV-enabled
build.

To use user-guided outer-loop vectorization with RV annotate the loops to
vectorize with `#pragma omp simd` and use:

    $ clang -fopenmp-simd -mllvm -rv -O3 ...

This release comes with a preview feature for automatic outer-loop vectorization
with RV.  This will work for some loops that use `int64_t` for their iteration
variables (loop counters).  To enable automatic outer-loop vectorization with RV
use:

    $ clang -mllvm -rv -mllvm -rv-autovec -O3 ...


### VEL Intrinsics for direct vector programming

See [the manual](https://sx-aurora-dev.github.io/velintrin.html).  To use VEL
intrinsics, pass the compiler option `-mattr=+packed`.  The resulting LLVM
bitcode and objects are compatible with those compiler without this option.

### Clang Experimental Options

To enable packed mode support, call Clang with `-mve-packed`.
This sets the machine attribute `+packed`.

### LLVM Experimental Options

Clang and llc accept these flags directly, prefix them with `-mllvm ` to use them with Clang.

- `-ve-regalloc=0` disable the experimental improvements to the vector register allocator.

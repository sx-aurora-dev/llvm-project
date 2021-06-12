# LLVM for NEC SX-Aurora VE (llvm-ve-rv 1.8-dev)

[![Build Status](https://travis-ci.com/sx-aurora-dev/llvm-project.svg?branch=hpce%2Fdevelop)](https://travis-ci.com/sx-aurora-dev/llvm-project)

This is a fork of the LLVM repositoy with support for the NEC
SX-Aurora TSUBASA Vector Engine (VE).

### Features

- C, C++ support.
- VE Intrinsics for low-level vector programming.
- Packed-mode vector code generation by default.
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


### VE Intrinsics for direct vector programming

See [the manual](https://sx-aurora-dev.github.io/velintrin.html).
There is also [a tutorial](https://sx-aurora-dev.github.io/ve-intrinsics-tutorial/).

### Clang Options

Refer to the [Clang Command Line Reference](Ghttps://clang.llvm.org/docs/ClangCommandLineReference.html) for general compiler flags
There are VE-specific flags to control vector code generation:
Note that packed mode code generation and vectorization is enabled by default.

- `clang -mno-vepacked` disables packed mode support.
  LLVM and the vectorizers will not use packed instructions.
  This option is incompatible with VE Intrinsics.
- `clang -mno-vevpu` disables all vector code support.
  Disable vector code generation entirely.
  Vectorizers (of LLVM or RV) will keep all code scalar - no vector instructions will be generated.
  Incompatible with VE Intrinsics.
- `clang -mvesimd` switches to the fixed SIMD legacy code generation path (deprecated).


### LLVM Advanced Options

Clang and llc accept these flags directly, prefix them with `-mllvm ` to use them with Clang.

##### Code Generation

- `-ve-regalloc=0` disable the experimental improvements to the vector register allocator.
- `-ve-fast-mem=0` use `VGT` (gather op) for masked loads instead of ignoring the mask.
- `-ve-ignore-masks=0` do not ignore masks on arithmetic even if it's safe.
- `-ve-optimize-split-avl=0` use the same VL setting for both non-packed operations when a packed operation is split.


##### Cost Modelling

- `-ve-unroll-vector=0` discourage vector loop unrolling.
- `-ve-expensive-vector=1` penalize vector ops to surpress all automatic vectorization.
  May help with VE Intrinsics to rule out spurious auto-vectorization.

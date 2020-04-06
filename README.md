# LLVM for NEC SX-Aurora VE

This is a fork of the LLVM repositoy with experimental support for the NEC
SX-Aurora TSUBASA Vector Engine (VE).

### Features

- C, C++ support.
- Automatic vectorization through LLVM's loop and SLP vectorizers.
- VEL intrinsics for low-level vector programming.

### Build instructions

To build llvm-ve from source refer to 
[llvm-dev](https://github.com/sx-aurora-dev/llvm-dev) and
[Compile.rst](llvm/docs/VE/Compile.rst).

### Usage

To compile C/C++ code for the VE run Clang/Clang++ with the following command line:

    $ /opt/nec/nosupport/llvm-ve/clang -target ve-linux -O3 ...

### VEL Intrinsics for direct vector programming

See [the manual](https://sx-aurora-dev.github.io/velintrin.html).  To use VEL
intrinsics, pass the compiler option `-mattr=+velintrin`.  The resulting LLVM
bitcode and objects are compatible with those compiler without this option.

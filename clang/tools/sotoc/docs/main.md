sotoc - Source Transformation for OpenMP Code {#mainpage}
=====================================================================================================

`sotoc` is written as a Clang tool and makes use of the Clang tooling
infrastructure to parse C source files, search for target regions and other
code that will be offloaded to a target device, and then extract and transform
this code into new C code that can then be compiled by a target compiler into
a target image to be used as a OpenMP device binary.
The tool is part of this Clang repository and is automatically build together
with clang.

The tool comes with a regression test suite that uses `llvm-lit`.
The tests can be run using the CMake generated build script when the CMake
option `SOTOC_ENABLE_TESTS` is set to `ON` by running

    $ make check-sotoc

To run the tests, make sure that LLVM's `FileCheck` tool is in the path.


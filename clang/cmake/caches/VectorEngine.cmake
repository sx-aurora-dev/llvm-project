# This file sets up a CMakeCache for the simple VE build.

# The lld is not supported for VE yet.
set(LLVM_ENABLE_PROJECTS "clang;clang-tools-extra;lld" CACHE STRING "")
set(LLVM_ENABLE_RUNTIMES "compiler-rt;libcxx;libcxxabi;libunwind;openmp" CACHE STRING "")

# Compile for X86 and VE
set(LLVM_TARGETS_TO_BUILD X86 CACHE STRING "")
set(LLVM_EXPERIMENTAL_TARGETS_TO_BUILD VE CACHE STRING "")

# Not use default here to use RUNTIMES_x86_64-unknown-linux-gnu_* variables.
set(LLVM_BUILTIN_TARGETS "x86_64-unknown-linux-gnu;ve-unknown-linux-gnu" CACHE STRING "")
set(LLVM_RUNTIME_TARGETS "x86_64-unknown-linux-gnu;ve-unknown-linux-gnu" CACHE STRING "")

# VE supports builtins, crt, and profile only.
set(RUNTIMES_ve-unknown-linux-gnu_COMPILER_RT_BUILD_BUILTINS ON CACHE BOOL "")
set(RUNTIMES_ve-unknown-linux-gnu_COMPILER_RT_BUILD_CRT ON CACHE BOOL "")
set(RUNTIMES_ve-unknown-linux-gnu_COMPILER_RT_BUILD_SANITIZERS OFF CACHE BOOL "")
set(RUNTIMES_ve-unknown-linux-gnu_COMPILER_RT_BUILD_XRAY OFF CACHE BOOL "")
set(RUNTIMES_ve-unknown-linux-gnu_COMPILER_RT_BUILD_LIBFUZZER OFF CACHE BOOL "")
set(RUNTIMES_ve-unknown-linux-gnu_COMPILER_RT_BUILD_PROFILE ON CACHE BOOL "")
set(RUNTIMES_ve-unknown-linux-gnu_COMPILER_RT_BUILD_MEMPROF OFF CACHE BOOL "")
set(RUNTIMES_ve-unknown-linux-gnu_COMPILER_RT_BUILD_ORC OFF CACHE BOOL "")
set(RUNTIMES_ve-unknown-linux-gnu_COMPILER_RT_BUILD_GWP_ASAN OFF CACHE BOOL "")

# VE uses builtins from Compiler-RT.
set(RUNTIMES_ve-unknown-linux-gnu_COMPILER_RT_USE_BUILTINS_LIBRARY TRUE CACHE BOOL "")

# VE uses libunwind and Compiler-RT from libcxxabi.
set(RUNTIMES_ve-unknown-linux-gnu_LIBCXXABI_USE_LLVM_UNWINDER TRUE CACHE BOOL "")
set(RUNTIMES_ve-unknown-linux-gnu_LIBCXXABI_USE_COMPILER_RT TRUE CACHE BOOL "")

# VE uses Compiler-RT from libcxx.
set(RUNTIMES_ve-unknown-linux-gnu_LIBCXX_USE_COMPILER_RT TRUE CACHE BOOL "")

# Pretended standalone build for OpenMP since OpenMP doesn't support
# LLVM_ENABLE_PER_TARGET_RUNTIME_DIR yet.
set(RUNTIMES_x86_64-unknown-linux-gnu_OPENMP_STANDALONE_BUILD ON CACHE BOOL "")
set(RUNTIMES_ve-unknown-linux-gnu_OPENMP_STANDALONE_BUILD ON CACHE BOOL "")

# Specify LIBDIR_SUFFIX for OpenMP to install them at following directories.
#   install/lib/clang/14.0.0/lib/x86_64-unknown-linux-gnu
#   install/lib/clang/14.0.0/lib/ve-unknown-linux-gnu
set(RUNTIMES_x86_64-unknown-linux-gnu_OPENMP_LIBDIR_SUFFIX "/x86_64-unknown-linux-gnu" CACHE STRING "")
set(RUNTIMES_ve-unknown-linux-gnu_OPENMP_LIBDIR_SUFFIX "/ve-unknown-linux-gnu" CACHE STRING "")

# VE cannot use libomptarget profiling since libomptarget uses host's profiling.
set(RUNTIMES_ve-unknown-linux-gnu_OPENMP_ENABLE_LIBOMPTARGET_PROFILING FALSE CACHE BOOL "")

# VE requires -lrt for shm_open.
set(RUNTIMES_ve-unknown-linux-gnu_LIBOMP_HAVE_SHM_OPEN_WITH_LRT TRUE CACHE BOOL "")

# setup toolchain
set(LLVM_INSTALL_TOOLCHAIN_ONLY ON CACHE BOOL "")
set(LLVM_TOOLCHAIN_TOOLS
  dsymutil
  llc
  lld
  llvm-ar
  llvm-cxxfilt
  llvm-cov
  llvm-dwarfdump
  llvm-link
  llvm-nm
  llvm-objdump
  llvm-profdata
  llvm-ranlib
  llvm-readelf
  llvm-readobj
  llvm-size
  llvm-symbolizer
  opt
  CACHE STRING "")

set(LLVM_DISTRIBUTION_COMPONENTS
  clang
  clang-format
  clang-resource-headers
  builtins
  runtimes
  ${LLVM_TOOLCHAIN_TOOLS}
  CACHE STRING "")

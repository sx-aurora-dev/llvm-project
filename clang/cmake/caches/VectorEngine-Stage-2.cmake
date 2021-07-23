# Build Clang for VH and VE using compiler-rt builtins.

set(CMAKE_BUILD_TYPE "Release" CACHE STRING "")
set (LLVM_TARGETS_TO_BUILD "X86;VE" CACHE STRING "")

set(LLVM_BUILD_LLVM_DYLIB True CACHE Bool "")
set(LLVM_LINK_LLVM_DYLIB True CACHE Bool "")

# TODO set (LLVM_EXPERIMENTAL_TARGETS_TO_BUILD "VE" CACHE STRING "")

if(NOT BOOTSTRAP_PREFIX)
	message(FATAL_ERROR "Define -DBOOTSTRAP_PREIFX=<stage-1-installed-prefix>")
endif()

# Use stage 1 binaries.
set(LLVM_TABLEGEN "${BOOTSTRAP_PREFIX}/bin/llvm-tblgen" CACHE STRING "" FORCE)
set(CMAKE_C_COMPILER "${BOOTSTRAP_PREFIX}/bin/clang" CACHE STRING "" FORCE)
set(CMAKE_CXX_COMPILER "${BOOTSTRAP_PREFIX}/bin/clang++" CACHE STRING "" FORCE)
set(LLVM_TEMPORARILY_ALLOW_OLD_TOOLCHAIN True CACHE BOOL "") # FIXME Stage 1 uses stdc++ for VH.

# set(CMAKE_C_COMPILER "gcc" CACHE STRING "")
# set(CMAKE_CXX_COMPILER "g++" CACHE STRING "")

# Select projects & runtimes.
set(LLVM_ENABLE_PROJECTS "clang;openmp" CACHE STRING "")
# set(LLVM_ENABLE_RUNTIMES "libunwind;libcxxabi;libcxx" CACHE STRING "")
# set(LLVM_ENABLE_RUNTIMES "compiler-rt" CACHE STRING "")
set(LLVM_ENABLE_PER_TARGET_RUNTIME_DIR True CACHE BOOL "")

# ZLIB missing on VE (TODO make this target specific)
set(LLVM_ENABLE_ZLIB False CACHE BOOL "")

# Clang defaults (FIXME really VE defaults)
# set(CLANG_DEFAULT_UNWINDLIB "libunwind" CACHE STRING "")
# set(CLANG_DEFAULT_RTLIB "compiler-rt" CACHE STRING "")
# set(CLANG_DEFAULT_CXX_STDLIB "libc++" CACHE STRING "")
# set(CLANG_UNWIND_LIB "libunwind" CACHE STRING "")

# Region vectorizer
set (LLVM_TOOL_RV_BUILD ON CACHE STRING "")

# FIXME: Incompatible with LLVM dylib
set (LLVM_RVPLUG_LINK_INTO_TOOLS Off CACHE STRING "")

# Configure targets and flags.
set(VE_TARGET "ve-linux")
set(VH_TARGET "x86_64-unknown-linux-gnu")

# Build a complete compiler environment for VE. Use defaults for VH.
foreach(target ${VE_TARGET})
  list(APPEND BUILTIN_TARGETS "${target}")
  list(APPEND RUNTIME_TARGETS "${target}")

  # Compiler RT.
  set(RUNTIMES_${target}_COMPILER_RT_DEFAULT_TARGET_TRIPLE "${target}" CACHE STRING "")
  set(RUNTIMES_${target}_COMPILER_RT_DEFAULT_TARGET_ONLY         OFF CACHE BOOL "")

  set(RUNTIMES_${target}_COMPILER_RT_USE_BUILTINS_LIBRARY        On CACHE BOOL "")
  set(RUNTIMES_${target}_COMPILER_RT_USE_LIBCXX:BOOL             Off CACHE BOOL "")
  set(RUNTIMES_${target}_COMPILER_RT_BUILD_BUILTINS              ON CACHE BOOL "")
  set(RUNTIMES_${target}_COMPILER_RT_BUILD_CRT                   ON CACHE BOOL "")
  set(RUNTIMES_${target}_COMPILER_RT_BUILD_LIBFUZZER             OFF CACHE BOOL "")
  set(RUNTIMES_${target}_COMPILER_RT_BUILD_PROFILE               OFF CACHE BOOL "")
  set(RUNTIMES_${target}_COMPILER_RT_BUILD_SANITIZERS            OFF CACHE BOOL "")
  set(RUNTIMES_${target}_COMPILER_RT_BUILD_XRAY                  OFF CACHE BOOL "")
  set(RUNTIMES_${target}_COMPILER_RT_INCLUDE_TESTS               OFF CACHE BOOL "")
  
  # libunwind.
  set(RUNTIMES_${target}_LIBUNWIND_USE_COMPILER_RT True CACHE BOOL "")
  set(RUNTIMES_${target}_LIBUNWIND_ENABLE_SHARED True CACHE BOOL "") # Unsupported runtime dependency on libcxxabi.
  set(RUNTIMES_${target}_LIBUNWIND_HERMETIC_STATIC_LIBRARY True CACHE BOOL "")
  
  # libcxxabi.
  set(RUNTIMES_${target}_LIBCXXABI_USE_COMPILER_RT True CACHE BOOL "")
  set(RUNTIMES_${target}_LIBCXXABI_ENABLE_STATIC_UNWINDER True CACHE BOOL "")
  set(RUNTIMES_${target}_LIBCXXABI_USE_LLVM_UNWINDER True CACHE BOOL "")
  
  # libcxx.
  set(RUNTIMES_${target}_LIBCXX_USE_COMPILER_RT True CACHE BOOL "")
  set(RUNTIMES_${target}_LIBCXX_CXX_ABI libcxxabi CACHE STRING "")
  set(RUNTIMES_${target}_LIBCXX_ENABLE_STATIC_ABI_LIBRARY True CACHE BOOL "")
  
  # libopenmp.
  set(RUNTIMES_${target}_LIBOMP_TSAN_SUPPORT False CACHE BOOL "")
  set(RUNTIMES_${target}_OPENMP_ENABLE_LIBOMPTARGET True CACHE BOOL "")
  set(RUNTIMES_${target}_OPENMP_ENABLE_OMPT_TOOLS False CACHE BOOL "")
  
  # FIXME We only actually want this for compiler-rt....
  # set(RUNTIMES_${target}_CMAKE_CXX_FLAGS "-nostdlib++" CACHE STRING "")
  # set(RUNTIMES_${target}_CMAKE_C_FLAGS "-nostdlib" CACHE STRING "")
endforeach()
set(LLVM_BUILTIN_TARGETS "${BUILTIN_TARGETS}" CACHE STRING "")
set(LLVM_RUNTIME_TARGETS "${RUNTIME_TARGETS}" CACHE STRING "")

# OpenMP (target specific).
# set(RUNTIMES_${VE_TARGET}_LIBOMP_ARCH "ve" CACHE STRING "")
# set(RUNTIMES_${VH_TARGET}_LIBOMP_ARCH "x86_64" CACHE STRING "")

# Point to libunwind.so install location..
# set(VH_EXTRA_LIB_DIR "${CMAKE_CURRENT_BINARY_DIR}/lib/x86_64-unknown-linux-gnu/c++")
# set(VE_EXTRA_LIB_DIR "${CMAKE_CURRENT_BINARY_DIR}/lib/ve-linux/c++")

# VH configuration
# set(RUNTIMES_${VH_TARGET}_CMAKE_C_FLAGS "-march=native" CACHE STRING "")
# set(RUNTIMES_${VH_TARGET}_CMAKE_CXX_FLAGS "-march=native" CACHE STRING "")
# set(RUNTIMES_${VH_TARGET}_CMAKE_ASM_FLAGS "-march=native" CACHE STRING "")

# VE configuration
# Stage 2.
# set(RUNTIMES_${VE_TARGET}_CMAKE_C_FLAGS "-L${VE_EXTRA_LIB_DIR}" CACHE STRING "")
# set(RUNTIMES_${VE_TARGET}_CMAKE_CXX_FLAGS "-L${VE_EXTRA_LIB_DIR}" CACHE STRING "")


# Stage 1.
# libcxx,libcxxabi, etc not available yet

# set(RUNTIMES_${VE_TARGET}_COMPILER_RT_CMAKE_CXX_FLAGS "-nostdlib++" CACHE STRING "")
# set(RUNTIMES_${VE_TARGET}_COMPILER_RT_CMAKE_C_FLAGS "-nostdlib++" CACHE STRING "")
# set(RUNTIMES_${VE_TARGET}_LIBUNWIND_CMAKE_CXX_FLAGS "-nostdlib" CACHE STRING "")
# set(RUNTIMES_${VE_TARGET}_LIBUNWIND_CMAKE_C_FLAGS "-nostdlib" CACHE STRING "")
# set(RUNTIMES_${VE_TARGET}_LIBCXXABI_CMAKE_CXX_FLAGS "-nostdlib++" CACHE STRING "")
# set(RUNTIMES_${VE_TARGET}_LIBCXXABI_CMAKE_C_FLAGS "-nostdlib" CACHE STRING "")
# set(RUNTIMES_${VE_TARGET}_LIBCXX_CMAKE_CXX_FLAGS "--stdlib -nostdlib++" CACHE STRING "") # FIXME link rtlib but not stdlib++..
# set(RUNTIMES_${VE_TARGET}_CMAKE_ASM_FLAGS "--target=${VE_TARGET}" CACHE STRING "")

# DEBUGGING: `libunwind.so` getting build but not found in feature test macros..
# set(RUNTIMES_${VH_TARGET}_CMAKE_EXE_LINKER_FLAGS "-L${VH_EXTRA_LIB_DIR}")
# set(RUNTIMES_${VE_TARGET}_CMAKE_EXE_LINKER_FLAGS "-L${VE_EXTRA_LIB_DIR}")

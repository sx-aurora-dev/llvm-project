# TODO(phosek): We should use the runtimes build instead configured with
# LLVM_ENABLE_RUNTIMES=libcxxabi;libcxx to avoid duplication of logic.

cmake_minimum_required(VERSION 3.13.4)
project(custom-libcxx C CXX)

find_package(Python3 REQUIRED COMPONENTS Interpreter)

# Ninja Job Pool support
# The following only works with the Ninja generator in CMake >= 3.0.
set(LLVM_PARALLEL_COMPILE_JOBS "" CACHE STRING
  "Define the maximum number of concurrent compilation jobs (Ninja only).")
if(LLVM_PARALLEL_COMPILE_JOBS)
  if(NOT CMAKE_GENERATOR STREQUAL "Ninja")
    message(WARNING "Job pooling is only available with Ninja generators.")
  else()
    set_property(GLOBAL APPEND PROPERTY JOB_POOLS compile_job_pool=${LLVM_PARALLEL_COMPILE_JOBS})
    set(CMAKE_JOB_POOL_COMPILE compile_job_pool)
  endif()
endif()

set(LLVM_PARALLEL_LINK_JOBS "" CACHE STRING
  "Define the maximum number of concurrent link jobs (Ninja only).")
if(CMAKE_GENERATOR STREQUAL "Ninja")
  if(NOT LLVM_PARALLEL_LINK_JOBS AND uppercase_LLVM_ENABLE_LTO STREQUAL "THIN")
    message(STATUS "ThinLTO provides its own parallel linking - limiting parallel link jobs to 2.")
    set(LLVM_PARALLEL_LINK_JOBS "2")
  endif()
  if(LLVM_PARALLEL_LINK_JOBS)
    set_property(GLOBAL APPEND PROPERTY JOB_POOLS link_job_pool=${LLVM_PARALLEL_LINK_JOBS})
    set(CMAKE_JOB_POOL_LINK link_job_pool)
  endif()
elseif(LLVM_PARALLEL_LINK_JOBS)
  message(WARNING "Job pooling is only available with Ninja generators.")
endif()

# Build static libcxxabi.
set(LIBCXXABI_ENABLE_SHARED OFF CACHE BOOL "")
set(LIBCXXABI_ENABLE_EXCEPTIONS ON CACHE BOOL "")
set(LIBCXXABI_HERMETIC_STATIC_LIBRARY ON CACHE STRING "")
set(LIBCXXABI_LIBCXX_PATH ${COMPILER_RT_LIBCXX_PATH} CACHE PATH "")
set(LIBCXXABI_INCLUDE_TESTS OFF CACHE BOOL "")
add_subdirectory(${COMPILER_RT_LIBCXXABI_PATH} ${CMAKE_CURRENT_BINARY_DIR}/cxxabi)

# Build static libcxx without exceptions.
set(LIBCXX_ENABLE_EXPERIMENTAL_LIBRARY OFF CACHE BOOL "")
set(LIBCXX_ENABLE_SHARED OFF CACHE BOOL "")
set(LIBCXX_ENABLE_EXCEPTIONS OFF CACHE BOOL "")
set(LIBCXX_HERMETIC_STATIC_LIBRARY ON CACHE BOOL "")

# Use above libcxxabi.
set(LIBCXX_CXX_ABI "libcxxabi" CACHE STRING "")
set(LIBCXX_CXX_ABI_INTREE 1)
set(LIBCXX_ENABLE_STATIC_ABI_LIBRARY ON CACHE BOOL "")
set(LIBCXX_CXX_ABI_INCLUDE_PATHS ${COMPILER_RT_LIBCXXABI_PATH}/include CACHE PATH "")

add_subdirectory(${COMPILER_RT_LIBCXX_PATH} ${CMAKE_CURRENT_BINARY_DIR}/cxx)

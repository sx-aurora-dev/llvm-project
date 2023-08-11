#
#//===----------------------------------------------------------------------===//
#//
#// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
#// See https://llvm.org/LICENSE.txt for license information.
#// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#//
#//===----------------------------------------------------------------------===//
#

# Try to detect in the system several dependencies required by the different
# components of libomptarget. These are the dependencies we have:
#
# libffi : required to launch target kernels given function and argument
#          pointers.
# CUDA : required to control offloading to NVIDIA GPUs.
# VEOS : required to control offloading to NEC Aurora.
# VHCALL : required to control offloading from NEC Aurora to the host.
# VEPSEUDO : required to control offloading from NEC Aurora to the host.

include (FindPackageHandleStandardArgs)

################################################################################
# Looking for LLVM...
################################################################################

if (OPENMP_STANDALONE_BUILD)
  # Complete LLVM package is required for building libomptarget
  # in an out-of-tree mode.
  find_package(LLVM REQUIRED)
  message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
  message(STATUS "Using LLVM in: ${LLVM_DIR}")
  list(APPEND LIBOMPTARGET_LLVM_INCLUDE_DIRS ${LLVM_INCLUDE_DIRS})
  list(APPEND CMAKE_MODULE_PATH ${LLVM_CMAKE_DIR})
  include(AddLLVM)
  if(TARGET omptarget)
    message(FATAL_ERROR "CMake target 'omptarget' already exists. "
                        "Use an LLVM installation that doesn't expose its 'omptarget' target.")
  endif()
else()
  # Note that OPENMP_STANDALONE_BUILD is FALSE, when
  # openmp is built with -DLLVM_ENABLE_RUNTIMES="openmp" vs
  # -DLLVM_ENABLE_PROJECTS="openmp", but openmp build
  # is actually done as a standalone project build with many
  # LLVM CMake variables propagated to it.
  list(APPEND LIBOMPTARGET_LLVM_INCLUDE_DIRS
    ${LLVM_MAIN_INCLUDE_DIR} ${LLVM_BINARY_DIR}/include
    )
  message(STATUS
    "Using LLVM include directories: ${LIBOMPTARGET_LLVM_INCLUDE_DIRS}")
endif()

################################################################################
# Looking for libffi...
################################################################################
find_package(PkgConfig)

pkg_check_modules(LIBOMPTARGET_SEARCH_LIBFFI QUIET libffi)

find_path (
  LIBOMPTARGET_DEP_LIBFFI_INCLUDE_DIR
  NAMES
    ffi.h
  HINTS
    ${LIBOMPTARGET_SEARCH_LIBFFI_INCLUDEDIR}
    ${LIBOMPTARGET_SEARCH_LIBFFI_INCLUDE_DIRS}
  PATHS
    /usr/include
    /usr/local/include
    /opt/local/include
    /sw/include
    ENV CPATH)

# Don't bother look for the library if the header files were not found.
if (LIBOMPTARGET_DEP_LIBFFI_INCLUDE_DIR)
  find_library (
      LIBOMPTARGET_DEP_LIBFFI_LIBRARIES
    NAMES
      ffi
    HINTS
      ${LIBOMPTARGET_SEARCH_LIBFFI_LIBDIR}
      ${LIBOMPTARGET_SEARCH_LIBFFI_LIBRARY_DIRS}
    PATHS
      /usr/lib
      /usr/local/lib
      /opt/local/lib
      /sw/lib
      ENV LIBRARY_PATH
      ENV LD_LIBRARY_PATH)
endif()

set(LIBOMPTARGET_DEP_LIBFFI_INCLUDE_DIRS ${LIBOMPTARGET_DEP_LIBFFI_INCLUDE_DIR})
find_package_handle_standard_args(
  LIBOMPTARGET_DEP_LIBFFI
  DEFAULT_MSG
  LIBOMPTARGET_DEP_LIBFFI_LIBRARIES
  LIBOMPTARGET_DEP_LIBFFI_INCLUDE_DIRS)

mark_as_advanced(
  LIBOMPTARGET_DEP_LIBFFI_INCLUDE_DIRS
  LIBOMPTARGET_DEP_LIBFFI_LIBRARIES)

################################################################################
# Looking for CUDA...
################################################################################

find_package(CUDAToolkit QUIET)
set(LIBOMPTARGET_DEP_CUDA_FOUND ${CUDAToolkit_FOUND})

################################################################################
# Looking for NVIDIA GPUs...
################################################################################
set(LIBOMPTARGET_DEP_CUDA_ARCH "sm_35")

find_program(LIBOMPTARGET_NVPTX_ARCH NAMES nvptx-arch PATHS ${LLVM_BINARY_DIR}/bin)
if(LIBOMPTARGET_NVPTX_ARCH)
  execute_process(COMMAND ${LIBOMPTARGET_NVPTX_ARCH}
                  OUTPUT_VARIABLE LIBOMPTARGET_NVPTX_ARCH_OUTPUT
                  OUTPUT_STRIP_TRAILING_WHITESPACE)
  string(REPLACE "\n" ";" nvptx_arch_list "${LIBOMPTARGET_NVPTX_ARCH_OUTPUT}")
  if(nvptx_arch_list)
    set(LIBOMPTARGET_FOUND_NVIDIA_GPU TRUE)
    set(LIBOMPTARGET_NVPTX_DETECTED_ARCH_LIST "${nvptx_arch_list}")
    list(GET nvptx_arch_list 0 LIBOMPTARGET_DEP_CUDA_ARCH)
  endif()
endif()


################################################################################
# Looking for AMD GPUs...
################################################################################

if(TARGET amdgpu-arch)
  get_property(LIBOMPTARGET_AMDGPU_ARCH TARGET amdgpu-arch PROPERTY LOCATION)
 else()
   find_program(LIBOMPTARGET_AMDGPU_ARCH NAMES amdgpu-arch PATHS ${LLVM_BINARY_DIR}/bin)
endif()

if(LIBOMPTARGET_AMDGPU_ARCH)
  execute_process(COMMAND ${LIBOMPTARGET_AMDGPU_ARCH}
                  OUTPUT_VARIABLE LIBOMPTARGET_AMDGPU_ARCH_OUTPUT
                  OUTPUT_STRIP_TRAILING_WHITESPACE)
  string(REPLACE "\n" ";" amdgpu_arch_list "${LIBOMPTARGET_AMDGPU_ARCH_OUTPUT}")
  if(amdgpu_arch_list)
    set(LIBOMPTARGET_FOUND_AMDGPU_GPU TRUE)
    set(LIBOMPTARGET_AMDGPU_DETECTED_ARCH_LIST "${amdgpu_arch_list}")
  endif()
endif()


################################################################################
# Looking for VEO...
################################################################################

# Disable CUDA if compiling for VE
# TODO: Need to find a way to compile both VE and CUDA
if("${LIBOMP_ARCH}" STREQUAL "ve")
  # force to not compile CUDA libomptarget while compiling native VE libomp
  set(LIBOMPTARGET_FOUND_AMDGPU_GPU FALSE)
  set(LIBOMPTARGET_FOUND_NVIDIA_GPU FALSE)
endif("${LIBOMP_ARCH}" STREQUAL "ve")

find_path (
  LIBOMPTARGET_DEP_VEO_INCLUDE_DIR
  NAMES
    ve_offload.h
  PATHS
    /usr/include
    /usr/local/include
    /opt/local/include
    /sw/include
    /opt/nec/ve/veos/include
    ENV CPATH
  PATH_SUFFIXES
    libveo)

find_library (
  LIBOMPTARGET_DEP_VEO_LIBRARIES
  NAMES
    veo
  PATHS
    /usr/lib
    /usr/local/lib
    /opt/local/lib
    /sw/lib
    /opt/nec/ve/veos/lib64
    ENV LIBRARY_PATH
    ENV LD_LIBRARY_PATH)

find_library(
  LIBOMPTARGET_DEP_VEOSINFO_LIBRARIES
  NAMES
    veosinfo
  PATHS
    /usr/lib
    /usr/local/lib
    /opt/local/lib
    /sw/lib
    /opt/nec/ve/veos/lib64
    ENV LIBRARY_PATH
    ENV LD_LIBRARY_PATH)

set(LIBOMPTARGET_DEP_VEO_INCLUDE_DIRS ${LIBOMPTARGET_DEP_VEO_INCLUDE_DIR})
find_package_handle_standard_args(
  LIBOMPTARGET_DEP_VEO
  DEFAULT_MSG
  LIBOMPTARGET_DEP_VEO_LIBRARIES
  LIBOMPTARGET_DEP_VEOSINFO_LIBRARIES
  LIBOMPTARGET_DEP_VEO_INCLUDE_DIRS)

mark_as_advanced(
  LIBOMPTARGET_DEP_VEO_FOUND
  LIBOMPTARGET_DEP_VEO_INCLUDE_DIRS)

################################################################################
# Looking for VHCALL (VE side)
################################################################################

find_path (
  LIBOMPTARGET_DEP_VHCALL_INCLUDE_DIR
  NAMES
    libvhcall.h
  PATHS
    /opt/nec/ve/include
  PATH_SUFFIXES
    libvhcall)

find_library (
  LIBOMPTARGET_DEP_VHCALL_LIBRARIES
  NAMES
    sysve
  PATHS
    /opt/nec/ve/lib)

set(LIBOMPTARGET_DEP_VHCALL_INCLUDE_DIRS ${LIBOMPTARGET_DEP_VHCALL_INCLUDE_DIR})
find_package_handle_standard_args(
  LIBOMPTARGET_DEP_VHCALL
  DEFAULT_MSG
  LIBOMPTARGET_DEP_VHCALL_LIBRARIES
  LIBOMPTARGET_DEP_VHCALL_INCLUDE_DIRS)

mark_as_advanced(
  LIBOMPTARGET_DEP_VHCALL_FOUND
  LIBOMPTARGET_DEP_VHCALL_INCLUDE_DIRS)

################################################################################
# Looking for VEPSEUDO (VH side)
################################################################################

find_path (
  LIBOMPTARGET_DEP_VEPSEUDO_INCLUDE_DIR
  NAMES
    libvepseudo.h
  PATHS
    /opt/nec/ve/veos/include
    ENV CPATH
  PATH_SUFFIXES
    libvhcall)

find_library (
  LIBOMPTARGET_DEP_VEPSEUDO_LIBRARIES
  NAMES
    vepseudo
  PATHS
    /opt/nec/ve/veos/lib64
    ENV LIBRARY_PATH
    ENV LD_LIBRARY_PATH)

set(LIBOMPTARGET_DEP_VEPSEUDO_INCLUDE_DIRS ${LIBOMPTARGET_DEP_VEPSEUDO_INCLUDE_DIR})
find_package_handle_standard_args(
  LIBOMPTARGET_DEP_VEPSEUDO
  DEFAULT_MSG
  LIBOMPTARGET_DEP_VEPSEUDO_LIBRARIES
  LIBOMPTARGET_DEP_VEPSEUDO_INCLUDE_DIRS)

mark_as_advanced(
  LIBOMPTARGET_DEP_VEPSEUDO_FOUND
  LIBOMPTARGET_DEP_VEPSEUDO_INCLUDE_DIRS)

set(OPENMP_PTHREAD_LIB ${LLVM_PTHREAD_LIB})

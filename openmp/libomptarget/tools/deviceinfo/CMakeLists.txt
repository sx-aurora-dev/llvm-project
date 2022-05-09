##===----------------------------------------------------------------------===##
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
##===----------------------------------------------------------------------===##
#
# Build llvm-omp-device-info tool
#
##===----------------------------------------------------------------------===##

# Disable llvm-omp-device-info tool for VE.
# For the case of VE, we run compile twice.  The llvm-omp-device-info is
# compiled at first build for a host machine.  Then, openmp is compiled
# for VE using generated llvm from first build.  Therefore, we disable
# llvm-omp-device-info if the LIBOMP_ARCH is equal to VE.
if(NOT "${LIBOMP_ARCH}" STREQUAL "ve")
libomptarget_say("Building the llvm-omp-device-info tool")

add_llvm_tool(llvm-omp-device-info llvm-omp-device-info.cpp)

llvm_update_compile_flags(llvm-omp-device-info)

target_link_libraries(llvm-omp-device-info PRIVATE
  omp
  omptarget
)
endif(NOT "${LIBOMP_ARCH}" STREQUAL "ve")

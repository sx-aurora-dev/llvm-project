##===----------------------------------------------------------------------===##
#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
# ##===----------------------------------------------------------------------===##
#
# Build a device RTL for each available machine.
#
##===----------------------------------------------------------------------===##

# Offloading from a nec sx aurora device to a nvidia device makes no sense
if(NOT "${LIBOMP_ARCH}" STREQUAL "ve")
  add_subdirectory(amdgcn)
  add_subdirectory(nvptx)
endif()

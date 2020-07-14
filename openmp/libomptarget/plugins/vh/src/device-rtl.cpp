//===-RTLs/generic-64bit/src/rtl.cpp - Target RTLs Implementation - C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// RTL for vector host, a generic 64-bit machine
//
//===----------------------------------------------------------------------===//

#include <libvepseudo.h>
#include <cstdlib>

extern "C" uint64_t alloc_vh(uint64_t Size) {
  return reinterpret_cast<uint64_t>(malloc(Size));
}

extern "C" uint64_t submit_vh(veos_handle *handle, uint64_t src, uint64_t size, uint64_t* dst) {
  return ve_recv_data(handle, src, size, dst);
}

extern "C" uint64_t retrieve_vh(veos_handle *handle, uint64_t dst, uint64_t size, uint64_t* src) {
  return ve_send_data(handle, dst, size, src);
}

extern "C" uint64_t delete_vh(uint64_t TargetPtr) {
  free((void*)TargetPtr);
  return 0; // this is discarded
}

//===-RTLs/nec-aurora/voeshim/veoshim.h -----------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file provides the interface for the VE Offloading Framework (VEO) from
/// NEC. This allows compiling the RTL nec-aurora module without installing the
/// software stack from NEC on the local machine.
///
//===----------------------------------------------------------------------===//

#ifndef VEOSHIM_H
#define VEOSHIM_H

#include <stdint.h>

#define VEO_REQUEST_ID_INVALID (~0UL)

#ifdef __cplusplus
extern "C" {
#endif

#include <stdlib.h>

struct veo_proc_handle {
  uint64_t reserved;
};

struct veo_thr_ctxt {
  void *veoshim_dlhandle;
  uint64_t last_return_value;
};

struct veo_call_args {
  uint64_t arguments[8];
};

struct veo_args;

struct veo_proc_handle *veo_proc_create(int ve_node);

struct veo_thr_ctxt *veo_context_open(struct veo_proc_handle *proc_handle);

int veo_context_close(struct veo_thr_ctxt *thread_ctxt);

uint64_t veo_load_library(struct veo_proc_handle *request,
                          const char *filename);

uint64_t veo_get_sym(struct veo_proc_handle *request, uint64_t lib_handle,
                     const char *symbol_name);

uint64_t veo_call_async(struct veo_thr_ctxt *request, uint64_t entry_point,
                        const struct veo_args *args);

int veo_call_wait_result(struct veo_thr_ctxt *request,
                         uint64_t call_async_handle,
                         uint64_t *return_value_buffer);

int veo_alloc_mem(struct veo_proc_handle *request, uint64_t *ptr,
                  const size_t size);

int veo_free_mem(struct veo_proc_handle *request, uint64_t ptr);

int veo_read_mem(struct veo_proc_handle *request, void *dest_ptr,
                 uint64_t source, size_t bytes);

int veo_write_mem(struct veo_proc_handle *request, uint64_t dest,
                  void *source_ptr, size_t bytes);

struct veo_args *veo_args_alloc();

int veo_args_set_u64(struct veo_args *arg, int argnum, uint64_t u64);

void veo_args_free(struct veo_args *arg);

#ifdef __cplusplus
}
#endif

#endif /*VEOSHIM_H*/

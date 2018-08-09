//===-RTLs/nec-aurora/voeshim/veoshim.cpp ---------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file implements VE Offloading Framework (VEO) from NEC as dummy lib.
///
//===----------------------------------------------------------------------===//

#include "veoshim.h"
#include <cstring>
#include <dlfcn.h>
#include <ffi.h>
#include <list>
#include <vector>

class ShimInfoTy {
  std::list<struct veo_proc_handle> proc_handles;

public:
  struct veo_proc_handle *getNewProcHandle() {
    struct veo_proc_handle handle = {0};
    proc_handles.push_back(handle);
    return &proc_handles.back();
  }
};

static ShimInfoTy ShimInfo;

#ifdef __cplusplus
extern "C" {
#endif

#include <errno.h>

struct veo_args {
  std::vector<uint64_t> arg;
};

struct veo_proc_handle *veo_proc_create(int ve_node) {
  return ShimInfo.getNewProcHandle();
}

struct veo_thr_ctxt *veo_context_open(struct veo_proc_handle *proc_handle) {
  struct veo_thr_ctxt *ctx =
      (struct veo_thr_ctxt *)malloc(sizeof(struct veo_thr_ctxt));
  ctx->veoshim_dlhandle = NULL;
  return ctx;
}

int veo_context_close(struct veo_thr_ctxt *thread_ctxt) {
  int ret;
  if (thread_ctxt->veoshim_dlhandle) {
    ret = dlclose(thread_ctxt->veoshim_dlhandle);
    thread_ctxt->veoshim_dlhandle = NULL;
  }
  return ret;
}

uint64_t veo_load_library(struct veo_proc_handle *request,
                          const char *filename) {
  void *dlhandle = dlopen(filename, RTLD_NOW);
  request->reserved = (uint64_t)dlhandle;
  return (uint64_t)dlhandle;
}

uint64_t veo_get_sym(struct veo_proc_handle *request, uint64_t lib_handle,
                     const char *symbol_name) {
  return (uint64_t)dlsym((void *)lib_handle, symbol_name);
}

uint64_t veo_call_async(struct veo_thr_ctxt *request, uint64_t entry_point,
                        const struct veo_args *args) {
  ffi_cif cif;

  std::vector<ffi_type *> args_types(8, &ffi_type_uint64);

  std::vector<uint64_t> arg_values = args->arg; // copy to avoid const

  std::vector<void *> ptrs(args->arg.size());

  for (int i = 0; i < args->arg.size(); ++i) {
    ptrs[i] = static_cast<void *>(&arg_values[i]);
  }

  ffi_status status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI, arg_values.size(),
                                   &ffi_type_uint64, &args_types[0]);

  if (status != FFI_OK) {
    return VEO_REQUEST_ID_INVALID;
  }

  void (*entry)(void);
  *((void **)&entry) = (void *)entry_point;

  ffi_arg result_value;

  ffi_call(&cif, entry, &result_value, &ptrs[0]);

  request->last_return_value = static_cast<uint64_t>(result_value);

  return (uint64_t)(ShimInfo.getNewProcHandle());
}

int veo_call_wait_result(struct veo_thr_ctxt *request,
                         uint64_t call_async_handle,
                         uint64_t *return_value_buffer) {
  *return_value_buffer = request->last_return_value;
  return 0;
}

int veo_alloc_mem(struct veo_proc_handle *request, uint64_t *ptr,
                  const size_t size) {
  *ptr = (uint64_t)malloc(size);
  return ptr != NULL ? 0 : errno;
}

int veo_free_mem(struct veo_proc_handle *request, uint64_t ptr) {
  free((void *)ptr);
  return 0;
}
int veo_read_mem(struct veo_proc_handle *request, void *dest_ptr,
                 uint64_t source, size_t bytes) {
  memcpy(dest_ptr, (void *)source, bytes);
  return 0;
}

int veo_write_mem(struct veo_proc_handle *request, uint64_t dest,
                  void *source_ptr, size_t bytes) {
  memcpy((void *)dest, source_ptr, bytes);
  return 0;
}

struct veo_args *veo_args_alloc() {
  return new struct veo_args;
}

int veo_args_set_u64(struct veo_args *arg, int argnum, uint64_t u64) {
  if (argnum >= arg->arg.size()) {
    arg->arg.resize(argnum + 1);
  }
  arg->arg[argnum] = u64;
  return 0;
}

void veo_args_free(struct veo_args *arg) { delete arg; }

#ifdef __cplusplus
}
#endif

#include "veoshim.h"
#include <dlfcn.h>
#include <ffi.h>
#include <list>
#include <vector>
#include <cstring>


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


struct veo_proc_handle *veo_proc_create(int ve_node) {
  return ShimInfo.getNewProcHandle();
}

struct ve_thr_ctxt *veo_context_open(struct veo_proc_handle *proc_handle) {
  struct ve_thr_ctxt *ctx = (struct ve_thr_ctxt*)malloc(sizeof(struct ve_thr_ctxt));
  ctx->veoshim_dlhandle = NULL;
  return ctx;
}

int veo_context_close(struct ve_thr_ctxt *thread_ctxt) {
  int ret;
  if (thread_ctxt->veoshim_dlhandle) {
    ret = dlclose(thread_ctxt->veoshim_dlhandle);
    thread_ctxt->veoshim_dlhandle = NULL;
  }
  return ret;
}

uint64_t veo_load_library(struct ve_thr_ctxt *request, const char *filename) {
  void *dlhandle = dlopen(filename, RTLD_NOW);
  request->veoshim_dlhandle = dlhandle;
  return (uint64_t)dlhandle;
}

uint64_t veo_get_sym(struct ve_thr_ctxt *request, uint64_t lib_handle,
                     const char *symbol_name) {
  return (uint64_t)dlsym((void*)lib_handle, symbol_name);
}

void *veo_call_async(struct ve_thr_ctxt *request, uint64_t entry_point,
                     uint64_t args) {
  ffi_cif cif;

  std::vector<ffi_type *> args_types(8, &ffi_type_uint64);

  struct veo_call_args *VeoArgs = reinterpret_cast<struct veo_call_args *>(args);
  void *VeoArgsArguments = static_cast<void *>(VeoArgs->arguments);

  std::vector<void *> ptrs(8);

  for(int i = 0; i < 8; ++i) {
    ptrs[i] = static_cast<void *>(&VeoArgs->arguments[i]);
  }

  ffi_status status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI, 8, &ffi_type_uint64,
                                   &args_types[0]);

  if (status != FFI_OK) {
    return NULL;
  }

  void (*entry)(void);
  *((void**) &entry) = (void*)entry_point;

  ffi_arg result_value;

  ffi_call(&cif, entry, &result_value, &ptrs[0]);

  request->last_return_value = static_cast<uint64_t>(result_value);

  return ShimInfo.getNewProcHandle();
}

int veo_call_wait_result(struct ve_thr_ctxt *request, void *call_async_handle,
                         uint64_t *return_value_buffer) {
  *return_value_buffer = request->last_return_value;
  return 0;
}

int veo_read_mem(struct ve_thr_ctxt *reqeust, void *dest_ptr, void *source_ptr,
                 size_t bytes) {
  memcpy(dest_ptr, source_ptr, bytes);
  return 0;
}

int veo_write_mem(struct ve_thr_ctxt *request, void *dest_ptr, void *source_ptr,
                  size_t bytes) {
  memcpy(dest_ptr, source_ptr, bytes);
  return 0;
}

#ifdef __cplusplus
}
#endif

#ifndef VEOSHIM_H
#define VEOSHIM_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdlib.h>

struct veo_proc_handle {
  uint64_t reserved;
};


struct ve_thr_ctxt {
  void *veoshim_dlhandle;
  uint64_t last_return_value;
};


struct veo_proc_handle *veo_proc_create(int ve_node);

struct ve_thr_ctxt *veo_context_open(struct veo_proc_handle *proc_handle);

int veo_context_close(struct ve_thr_ctxt *thread_ctxt);

uint64_t veo_load_library(struct ve_thr_ctxt *request, const char *filename);

uint64_t veo_get_sym(struct ve_thr_ctxt *request, uint64_t lib_handle,
                     const char *symbol_name);

void *veo_call_async(struct ve_thr_ctxt *request, uint64_t entry_point,
                     uint64_t args);

int veo_call_wait_result(struct ve_thr_ctxt *request, void *call_async_handle,
                         uint64_t *return_value_buffer);

int veo_read_mem(struct ve_thr_ctxt *reqeust, void *dest_ptr, void *source_ptr,
                 size_t bytes);

int veo_write_mem(struct ve_thr_ctxt *request, void *dest_ptr, void *source_ptr,
                  size_t bytes);

#ifdef __cplusplus
}
#endif

#endif /*VEOSHIM_H*/

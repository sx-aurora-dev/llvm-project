//===-RTLs/nec-aurora/src/rtl.cpp - Target RTLs Implementation - C++ -*-======//
//
//                     The LLVM Compiler Infrastructure
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.txt for details.
//
//===----------------------------------------------------------------------===//
//
// RTL for NEC Aurora TSUBASE machines
//
//===----------------------------------------------------------------------===//

#include "omptargetplugin.h"

#include <cassert>
#include <cerrno>
#include <cstring>
#include <list>
#include <stdlib.h>
#include <string>
#include <sys/stat.h>
#include <ve_offload.h>
#include <vector>

#ifndef TARGET_ELF_ID
#define TARGET_ELF_ID 0
#endif

#ifdef OMPTARGET_DEBUG
static int DebugLevel = 0;

#define GETNAME2(name) #name
#define GETNAME(name) GETNAME2(name)
#define DP(...)                                                                \
  do {                                                                         \
    if (DebugLevel > 0) {                                                      \
      DEBUGP("Target " GETNAME(TARGET_NAME) " RTL", __VA_ARGS__);              \
    }                                                                          \
  } while (false)
#else // OMPTARGET_DEBUG
#define DP(...)                                                                \
  {}
#endif // OMPTARGET_DEBUG

#include "../../common/elf_common.c"

#define NUMBER_OF_DEVICES 8 // TODO: find out how many nodes we can have

#define VEO_MIN_VERSION 4
#define VEO_MAX_VERSION 4

struct DynLibTy {
  char *FileName;
  uint64_t VeoLibHandle;
};

/// Keep entries table per device.
struct FuncOrGblEntryTy {
  __tgt_target_table Table;
  std::vector<__tgt_offload_entry> Entries;
};

class RTLDeviceInfoTy {
  std::vector<FuncOrGblEntryTy> FuncOrGblEntry;

public:
  std::vector<struct veo_proc_handle *> ProcHandles;
  std::vector<struct veo_thr_ctxt *> Contexts;
  std::vector<uint64_t> LibraryHandles;
  std::list<DynLibTy> DynLibs;

  void buildOffloadTableFromHost(int32_t device_id, uint64_t VeoLibHandle,
                                 __tgt_offload_entry *HostBegin,
                                 __tgt_offload_entry *HostEnd) {
    std::vector<__tgt_offload_entry> &T = FuncOrGblEntry[device_id].Entries;
    T.clear();

    for (__tgt_offload_entry *i = HostBegin; i != HostEnd; ++i) {
      char *SymbolName = i->name;
      // we have not enough access to the target memory to conveniently parse
      // the offload table there so we need to lookup every symbol with the host
      // table
      DP("Looking up symbol: %s\n", SymbolName);
      uint64_t SymbolTargetAddr =
          veo_get_sym(ProcHandles[device_id], VeoLibHandle, SymbolName);
      __tgt_offload_entry Entry;

      if (!SymbolTargetAddr) {
        DP("Symbol %s not found in target image\n", SymbolName);
        Entry = {NULL, NULL, 0, 0, 0};
      } else {
        DP("Found symbol %s successfully in target image (addr: %p)\n",
           SymbolName, (void *)SymbolTargetAddr);
        Entry = {(void *)SymbolTargetAddr, i->name, i->size, i->flags, 0};
      }

      T.push_back(Entry);
    }

    // we need to have at least one additional element in the vector because
    // we want to return __tgt_target_table, which contains a pointer to the
    // the element after the last entry in the table.
    // If we didnt own the memory then we would have undefined behaviour
    // if (!(T.capacity() > T.size())) {
      // DP("DEBUG_2 %zx \n",T.size());
      __tgt_offload_entry DummyEntry = {NULL, NULL, 0, 0, 0};
      T.push_back(DummyEntry);
    // }

    // DP("DEBUG_1 %zx, %d \n",T.size(),T.capacity());

    FuncOrGblEntry[device_id].Table.EntriesBegin = &T.front();
    FuncOrGblEntry[device_id].Table.EntriesEnd = &T.back();
  }

  __tgt_target_table *getOffloadTable(int32_t device_id) {
    return &FuncOrGblEntry[device_id].Table;
  }

  RTLDeviceInfoTy(int32_t num_devices)
      : ProcHandles(num_devices, NULL), Contexts(num_devices, NULL),
        FuncOrGblEntry(num_devices), LibraryHandles(num_devices) {
    // TODO: some debug code here
#ifdef OMPTARGET_DEBUG
    if (char *envStr = getenv("LIBOMPTARGET_DEBUG")) {
      DebugLevel = std::stoi(envStr);
    }
#endif // OMPTARGET_DEBUG
  }

  ~RTLDeviceInfoTy() {
    for (auto &hdl : ProcHandles) {
      // TODO: Do we need to destroch the proc handles?
    }

    for (auto &ctx : Contexts) {
      if (ctx != NULL) {
        if (veo_context_close(ctx) != 0) {
          DP("Failed to close VEO context.\n");
        }
      }
    }

    for (auto &lib : DynLibs) {
      if (lib.FileName) {
        remove(lib.FileName);
      }
    }
  }
};

static RTLDeviceInfoTy DeviceInfo(NUMBER_OF_DEVICES);

static int target_run_function_wait(uint32_t DeviceID, uint64_t FuncAddr,
                                    struct veo_args *args, uint64_t *RetVal) {
  DP("Running function with entry point %p\n",
     reinterpret_cast<void *>(FuncAddr));
  uint64_t RequestHandle =
      veo_call_async(DeviceInfo.Contexts[DeviceID], FuncAddr, args);
  if (RequestHandle == VEO_REQUEST_ID_INVALID) {
    DP("Execution of entry point %p failed\n",
       reinterpret_cast<void *>(FuncAddr));
    return -1;
  } else {
    DP("Function at address %p called (VEO request ID: %" PRIu64 ")\n",
       reinterpret_cast<void *>(FuncAddr), RequestHandle);
  }

  int ret = veo_call_wait_result(DeviceInfo.Contexts[DeviceID], RequestHandle,
                                 RetVal);
  if (ret != 0) {
    DP("Waiting for entry point %p failed (Error code %d)\n",
       reinterpret_cast<void *>(FuncAddr), ret);
    // TODO: Do something with return value?
    return -1;
  }
  return 0;
}

#ifdef __cplusplus
extern "C" {
#endif

// Return the number of available devices of the type supported by the
// target RTL.
int32_t __tgt_rtl_number_of_devices(void) { return NUMBER_OF_DEVICES; }

// Return an integer different from zero if the provided device image can be
// supported by the runtime. The functionality is similar to comparing the
// result of __tgt__rtl__load__binary to NULL. However, this is meant to be a
// lightweight query to determine if the RTL is suitable for an image without
// having to load the library, which can be expensive.
int32_t __tgt_rtl_is_valid_binary(__tgt_device_image *Image) {
#if TARGET_ELF_ID < 1
  return 0;
#else
  return elf_check_machine(Image, TARGET_ELF_ID);
#endif
}

// Initialize the specified device. In case of success return 0; otherwise
// return an error code.
int32_t __tgt_rtl_init_device(int32_t ID) {
  // First of all: check the veo API version
  int veo_version = veo_api_version();
  if (veo_version < VEO_MIN_VERSION) {
    DP("veo_get_version() reported version %i. Minimum supported veo api version is %i\n", veo_version, VEO_MIN_VERSION);
    return -1;
  } else if (veo_version > VEO_MAX_VERSION) {
    DP("veo_get_version() reported version %i, Maximum supported veo api version is %i\n", veo_version, VEO_MAX_VERSION);
    return -2;
  }
  DP("Available VEO version: %i (supported)\n", veo_version);
// we will try to use 1 context per device

// TODO: At the moment we do not initilize the device here, but in
// "__tgt_rtl_load_binary". The reason is that we need to set an the
// ENV VEORUN_BIN to the static bin. As long as we dont have any possibilty
// to to pass the location of the binary to veo_proc_create it is much more
// convinient to set the ENV here (sentenv()). However, we do not know where
// the tgt_binary (ELF) for that which we dont have at this point. :-(.
// Thus, we do nothing here for now.
#if 0
  struct veo_proc_handle *proc_handle = veo_proc_create(ID);
  if (!proc_handle) {
    //TODO: errno does not seem to be set by VEO
    //DP("veo_proc_create() failed: %s\n", std::strerror(errno));
    DP("veo_proc_create() failed for device %d\n",ID);
    return 1;
  }

  struct veo_thr_ctxt *ctx = veo_context_open(proc_handle);
  if (!ctx) {
    //TODO: errno does not seem to be set by VEO
    DP("veo_context_open() failed: %s\n", std::strerror(errno));
    return 2;
  }

  DeviceInfo.ProcHandles[ID] = proc_handle;
  DeviceInfo.Contexts[ID] = ctx;

  DP("Aurora device successfully initialized: proc_handle=%p, ctx=%p\n",
     proc_handle, ctx);
#endif
  return 0;
}

// Pass an executable image section described by image to the specified
// device and prepare an address table of target entities. In case of error,
// return NULL. Otherwise, return a pointer to the built address table.
// Individual entries in the table may also be NULL, when the corresponding
// offload region is not supported on the target device.
__tgt_target_table *__tgt_rtl_load_binary(int32_t ID,
                                          __tgt_device_image *Image) {
  DP("Dev %d: load binary from " DPxMOD " image\n", ID,
     DPxPTR(Image->ImageStart));

  assert(ID >= 0 && ID < NUMBER_OF_DEVICES && "bad dev id");

  size_t ImageSize = (size_t)Image->ImageEnd - (size_t)Image->ImageStart;
  size_t NumEntries = (size_t)(Image->EntriesEnd - Image->EntriesBegin);
  DP("Expecting to have %zd entries defined.\n", NumEntries);

  // Is the library version incompatible with the header file?
  if (elf_version(EV_CURRENT) == EV_NONE) {
    DP("Incompatible ELF library!\n");
    return NULL;
  }

  // load dynamic library and get the entry points. We use the dl library
  // to do the loading of the library, but we could do it directly to avoid the
  // dump to the temporary file.
  //
  // 1) Create tmp file with the library contents.
  // 2) Use dlopen to load the file and dlsym to retrieve the symbols.
  // TODO: Remove hard-coded "/tmp"
  char tmp_name[] = "/tmp/tmpfile_XXXXXX";
  int tmp_fd = mkstemp(tmp_name);

  if (tmp_fd == -1) {
    return NULL;
  }

  FILE *ftmp = fdopen(tmp_fd, "wb");

  if (!ftmp) {
    DP("fdopen() for %s failed. Could not write target image\n", tmp_name);
    return NULL;
  }

  fwrite(Image->ImageStart, ImageSize, 1, ftmp);

  // at least for the static case we need to change the permissions
  chmod(tmp_name, 0700);

  DP("Wrote target image to %s. ImageSize=%zu\n", tmp_name, ImageSize);

  fclose(ftmp);

  // See comment in "__tgt_rtl_init_device"
#if 1
  bool is_dyn = true;
  if (DeviceInfo.ProcHandles[ID] == NULL){
  struct veo_proc_handle *proc_handle;
  is_dyn = elf_is_dynamic(Image);
  // If we have a dynamically linked image, we create the process handle, then
  // the thread, and then load the image.
  // If we have a statically linked image, we need to create the process handle
  // and load the image at the same time with veo_proc_create_static().
  if (is_dyn) {
    proc_handle = veo_proc_create(ID);
    if (!proc_handle) {
      DP("veo_proc_create() failed for device %d\n", ID);
      return NULL;
    }
  } else {
    proc_handle = veo_proc_create_static(ID, tmp_name);
    if (!proc_handle) {
      DP("veo_proc_create_static() failed for device %d, image=%s\n", ID, tmp_name);
      return NULL;
    }
  }
  DeviceInfo.ProcHandles[ID] = proc_handle;
  }

  struct veo_thr_ctxt *ctx = veo_context_open(DeviceInfo.ProcHandles[ID]);
  if (!ctx) {
    // TODO: errno does not seem to be set by VEO
    DP("veo_context_open() failed: %s\n", std::strerror(errno));
    return NULL;
  }

  DeviceInfo.Contexts[ID] = ctx;

  DP("Aurora device successfully initialized: proc_handle=%p, ctx=%p\n",
     DeviceInfo.ProcHandles[ID] , ctx);
#endif

  uint64_t LibHandle = 0UL;
  if (is_dyn) {
    LibHandle = veo_load_library(DeviceInfo.ProcHandles[ID], tmp_name);

    if (!LibHandle) {
      DP("veo_load_library() failed: LibHandle=%" PRIu64
         " Name=%s. Set env VEORUN_BIN for static linked target code.\n",
         LibHandle, tmp_name);
      return NULL;
    }

    DP("Successfully loaded library dynamically\n");
  } else {
    DP("Symbol table is expected to have been created by veo_create_proc_static()\n");
  }

  DynLibTy Lib = {tmp_name, LibHandle};
  DeviceInfo.DynLibs.push_back(Lib);
  DeviceInfo.LibraryHandles[ID] = LibHandle;

  DeviceInfo.buildOffloadTableFromHost(ID, LibHandle, Image->EntriesBegin,
                                       Image->EntriesEnd);

  return DeviceInfo.getOffloadTable(ID);
}

// Allocate data on the particular target device, of the specified size.
// HostPtr is a address of the host data the allocated target data
// will be associated with (HostPtr may be NULL if it is not known at
// allocation time, like for example it would be for target data that
// is allocated by omp_target_alloc() API). Return address of the
// allocated data on the target that will be used by libomptarget.so to
// initialize the target data mapping structures. These addresses are
// used to generate a table of target variables to pass to
// __tgt_rtl_run_region(). The __tgt_rtl_data_alloc() returns NULL in
// case an error occurred on the target device.
void *__tgt_rtl_data_alloc(int32_t ID, int64_t Size, void *HostPtr) {
  uint64_t ret;
  uint64_t addr;

  if (DeviceInfo.ProcHandles[ID] == NULL) {
    struct veo_proc_handle *proc_handle;
    proc_handle = veo_proc_create(ID);
    if (!proc_handle) {
      DP("veo_proc_create() failed for device %d\n", ID);
      return NULL;
    }
    DeviceInfo.ProcHandles[ID] = proc_handle;
    DP("Aurora device successfully initialized: proc_handle=%p", proc_handle);
 }

  DP("Store dev addr to: target addr=%p \n", &addr);
  ret = veo_alloc_mem(DeviceInfo.ProcHandles[ID], &addr, Size);
  DP("Allocate target memory: device=%d, target addr=%p, size=%" PRIu64 "\n",
     ID, (void *)addr, Size);
  if (ret != 0) {
    DP("veo_alloc_mem(%d, %p, %" PRIu64 ") failed with error code %" PRIu64
       "\n",
       ID, (void *)addr, Size, ret);
    return NULL;
  }
  return (void *)addr;
}

// Pass the data content to the target device using the target address.
// In case of success, return zero. Otherwise, return an error code.
int32_t __tgt_rtl_data_submit(int32_t ID, void *TargetPtr, void *HostPtr,
                              int64_t Size) {
  int ret = veo_write_mem(DeviceInfo.ProcHandles[ID], (uint64_t)TargetPtr,
                          HostPtr, (size_t)Size);
  if (ret != 0) {
    DP("veo_write_mem() failed with error code %d\n", ret);
  }
  return ret;
}

// Retrieve the data content from the target device using its address.
// In case of success, return zero. Otherwise, return an error code.
int32_t __tgt_rtl_data_retrieve(int32_t ID, void *HostPtr, void *TargetPtr,
                                int64_t Size) {
  int ret = veo_read_mem(DeviceInfo.ProcHandles[ID], HostPtr,
                         (uint64_t)TargetPtr, Size);
  if (ret != 0) {
    DP("veo_read_mem() failed with error code %d\n", ret);
  }
  return ret;
}

// De-allocate the data referenced by target ptr on the device. In case of
// success, return zero. Otherwise, return an error code.
int32_t __tgt_rtl_data_delete(int32_t ID, void *TargetPtr) {
  uint64_t ret;

  return veo_free_mem(DeviceInfo.ProcHandles[ID], (uint64_t)TargetPtr);
}

// Similar to __tgt_rtl_run_target_region, but additionally specify the
// number of teams to be created and a number of threads in each team.
int32_t __tgt_rtl_run_target_team_region(int32_t ID, void *Entry, void **Args,
                                         ptrdiff_t *Offsets, int32_t NumArgs,
                                         int32_t NumTeams, int32_t ThreadLimit,
                                         uint64_t loop_tripcount) {
  // ignore team num and thread limit.
  std::vector<void *> ptrs(NumArgs);

  struct veo_args *TargetArgs;
  TargetArgs = veo_args_alloc();

  for (int32_t i = 0; i < NumArgs; ++i) {
    // TargetArgs.arguments[i] = ((intptr_t)(Args[i]));
    veo_args_set_u64(TargetArgs, i, (intptr_t)Args[i]);
  }

  uint64_t RetVal;
  if (target_run_function_wait(ID, reinterpret_cast<uint64_t>(Entry),
                               TargetArgs, &RetVal) != 0) {
    veo_args_free(TargetArgs);
    return OFFLOAD_FAIL;
  }
  veo_args_free(TargetArgs);
  return OFFLOAD_SUCCESS;
}

// Transfer control to the offloaded entry Entry on the target device.
// Args and Offsets are arrays of NumArgs size of target addresses and
// offsets. An offset should be added to the target address before passing it
// to the outlined function on device side. In case of success, return zero.
// Otherwise, return an error code.
int32_t __tgt_rtl_run_target_region(int32_t ID, void *Entry, void **Args,
                                    ptrdiff_t *Offsets, int32_t NumArgs) {
  return __tgt_rtl_run_target_team_region(ID, Entry, Args, Offsets, NumArgs, 1,
                                          1, 0);
}

#ifdef __cplusplus
}
#endif

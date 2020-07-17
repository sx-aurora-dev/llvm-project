//===-RTLs/nec-aurora/src/rtl.cpp - Target RTLs Implementation - C++ -*-======//
//
//                     The LLVM Compiler Infrastructure
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.txt for details.
//
//===----------------------------------------------------------------------===//
//
// RTL for NEC Aurora TSUBASA machines
//
//===----------------------------------------------------------------------===//

#include "omptargetplugin.h"
#include <libvhcall.h>
#include <algorithm>
#include <cassert>
#include <cerrno>
#include <cstring>
#include <list>
#include <stdlib.h>
#include <string>
#include <sys/stat.h>
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


struct DynLibTy {
  char *FileName;
  vhcall_handle Handle;
};

/// Keep entries table per device.
struct FuncOrGblEntryTy {
  __tgt_target_table Table;
  std::vector<__tgt_offload_entry> Entries;
};

class RTLDeviceInfoTy {
  std::list<FuncOrGblEntryTy> FuncOrGblEntry;

public:
  uint64_t LibraryHandle;
  std::list<DynLibTy> DynLibs;

  void buildOffloadTableFromHost(int32_t device_id, uint64_t VHCallLibHandle,
                                 __tgt_offload_entry *HostBegin,
                                 __tgt_offload_entry *HostEnd) {
    FuncOrGblEntry.emplace_back();
    std::vector<__tgt_offload_entry> &T = FuncOrGblEntry.back().Entries;
    T.clear();

    for (__tgt_offload_entry *i = HostBegin; i != HostEnd; ++i) {
      char *SymbolName = i->name;
      // we need the symbol id so we have to ask
      DP("Looking up symbol: %s\n", SymbolName);
      int64_t SymbolTargetAddr = vhcall_find(VHCallLibHandle, SymbolName);
      __tgt_offload_entry Entry;

      if (!SymbolTargetAddr) {
        DP("Symbol %s not found in target image\n", SymbolName);
        Entry = {NULL, NULL, 0, 0, 0};
      } else {
        DP("Found symbol %s successfully in target image (addr: %p)\n",
           SymbolName, reinterpret_cast<void *>(SymbolTargetAddr));
        Entry = { reinterpret_cast<void *>(SymbolTargetAddr),
                  i->name,
                  i->size,
                  i->flags,
                  0 };
      }

      T.push_back(Entry);
    }

    FuncOrGblEntry.back().Table.EntriesBegin = &T.front();
    FuncOrGblEntry.back().Table.EntriesEnd = &T.back() + 1;
  }

  __tgt_target_table *getOffloadTable(int32_t device_id) {
    return &FuncOrGblEntry.back().Table;
  }

  RTLDeviceInfoTy() {
#ifdef OMPTARGET_DEBUG
    if (char *envStr = getenv("LIBOMPTARGET_DEBUG")) {
      DebugLevel = std::stoi(envStr);
    }
#endif // OMPTARGET_DEBUG
  }

  ~RTLDeviceInfoTy() {
    for (auto &lib : DynLibs) {
      vhcall_uninstall(lib.Handle);
      if (lib.FileName) {
        remove(lib.FileName);
      }
    }
  }
};

static RTLDeviceInfoTy DeviceInfo;


// Return the number of available devices of the type supported by the
// target RTL.
// In this case there is the assumption that there is one device.
// TODO: maybe respond with the number of NUMA nodes of the host
int32_t __tgt_rtl_number_of_devices(void) { return 1; }

// Return an integer different from zero if the provided device image can be
// supported by the runtime. The functionality is similar to comparing the
// result of __tgt__rtl__load__binary to NULL. However, this is meant to be a
// lightweight query to determine if the RTL is suitable for an image without
// having to load the library, which can be expensive.
int32_t __tgt_rtl_is_valid_binary(__tgt_device_image *Image) {
#if TARGET_ELF_ID < 1
  return 0;
#else
  // This check would need `#include "../../common/elf_common.c"` which in turn
  // would pull libelf as a dependency.
  // It's not that much of an issue since aurora binaries can only use this
  // target plugin.
  // return elf_check_machine(Image, TARGET_ELF_ID);
  return 1;
#endif
}

int64_t __tgt_rtl_data_alloc_vh_id;
int64_t __tgt_rtl_data_submit_vh_id;
int64_t __tgt_rtl_data_retrieve_vh_id;
int64_t __tgt_rtl_data_delete_vh_id;
// Initialize the specified device. In case of success return 0; otherwise
// return an error code.
int32_t __tgt_rtl_init_device(int32_t ID) {
  DP("Loading support library on vh.\n");

  const char* libname = "libomptarget.device-rtl.vh.so";
  auto device_rtl_handle = vhcall_install(libname);
  if (device_rtl_handle == -1) {
    DP("Failed to load support library \"%s\".\n", libname);
    DP("Please make sure it is in your library path.\n");
    return OFFLOAD_FAIL;
  }

  DynLibTy Lib = {NULL, device_rtl_handle};
  DeviceInfo.DynLibs.push_back(Lib);

  __tgt_rtl_data_alloc_vh_id = vhcall_find(device_rtl_handle, "alloc_vh");
  __tgt_rtl_data_submit_vh_id = vhcall_find(device_rtl_handle, "submit_vh");
  __tgt_rtl_data_retrieve_vh_id = vhcall_find(device_rtl_handle, "retrieve_vh");
  __tgt_rtl_data_delete_vh_id = vhcall_find(device_rtl_handle, "delete_vh");

  if (__tgt_rtl_data_alloc_vh_id == -1 || __tgt_rtl_data_submit_vh_id == -1 ||
      __tgt_rtl_data_retrieve_vh_id == -1 || __tgt_rtl_data_delete_vh_id == -1)
  {
    DP("Failed to find required functions in %s.\n", libname);
    return OFFLOAD_FAIL;
  }
  return OFFLOAD_SUCCESS;
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

  assert(ID >= 0 && "bad dev id");

  size_t ImageSize = (size_t)Image->ImageEnd - (size_t)Image->ImageStart;
  size_t NumEntries = (size_t)(Image->EntriesEnd - Image->EntriesBegin);
  DP("Expecting to have %zd entries defined.\n", NumEntries);

  // load dynamic library and get the entry points. We use the dl library
  // to do the loading of the library, but we could do it directly to avoid the
  // dump to the temporary file.
  //
  // 1) Create tmp file with the library contents.
  // 2) Use dlopen to load the file and dlsym to retrieve the symbols.
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


  DP("Host successfully initialized as offload target.");

  uint64_t LibHandle = 0UL;
    LibHandle = vhcall_install(tmp_name);

    if (!LibHandle) {
      DP("vhcall_install() failed: LibHandle=%" PRIu64
         " Name=%s. \n", LibHandle, tmp_name);
      return NULL;
    }

    DP("Successfully loaded library dynamically\n");

  DynLibTy Lib = {tmp_name, LibHandle};
  DeviceInfo.DynLibs.push_back(Lib);
  DeviceInfo.LibraryHandle = LibHandle;

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

  DP("Allocate target memory: size=%" PRIu64 "\n", Size);

  auto args = vhcall_args_alloc();
  vhcall_args_set_u64(args, 0, (uint64_t)Size);

  if (vhcall_invoke_with_args(__tgt_rtl_data_alloc_vh_id, args, &ret) != 0 ||
      ret == 0) {
    DP("malloc on vh failed.\n");
    vhcall_args_free(args);
    return nullptr;
  }

  vhcall_args_free(args);
  return reinterpret_cast<void *>(ret);
}

// Pass the data content to the target device using the target address.
// In case of success, return zero. Otherwise, return an error code.
int32_t __tgt_rtl_data_submit(int32_t ID, void *TargetPtr, void *HostPtr,
                              int64_t Size) {
  DP("Submitting data to vh.\n");
  auto args = vhcall_args_alloc();
  vhcall_args_set_veoshandle(args, 0);
  vhcall_args_set_u64(args, 1, (uint64_t)HostPtr);
  vhcall_args_set_u64(args, 2, (uint64_t)Size);
  vhcall_args_set_u64(args, 3, (uint64_t)TargetPtr);

  uint64_t ret;
  if (vhcall_invoke_with_args(__tgt_rtl_data_submit_vh_id, args, &ret) != 0 ||
      ret != 0) {
    DP("Data transfer failed.\n");
    vhcall_args_free(args);
    return OFFLOAD_FAIL;
  }

  vhcall_args_free(args);
  return OFFLOAD_SUCCESS;
}

// Retrieve the data content from the target device using its address.
// In case of success, return zero. Otherwise, return an error code.
int32_t __tgt_rtl_data_retrieve(int32_t ID, void *HostPtr, void *TargetPtr,
                                int64_t Size) {
  DP("Retrieving data from vh.\n");
  auto args = vhcall_args_alloc();
  vhcall_args_set_veoshandle(args, 0);
  vhcall_args_set_u64(args, 1, (uint64_t)HostPtr);
  vhcall_args_set_u64(args, 2, (uint64_t)Size);
  vhcall_args_set_u64(args, 3, (uint64_t)TargetPtr);

  uint64_t ret;
  if (vhcall_invoke_with_args(__tgt_rtl_data_retrieve_vh_id, args, &ret) != 0 ||
      ret != 0) {
    DP("Data transfer failed.\n");
    vhcall_args_free(args);
    return OFFLOAD_FAIL;
  }

  vhcall_args_free(args);
  return OFFLOAD_SUCCESS;
}

// De-allocate the data referenced by target ptr on the device. In case of
// success, return zero. Otherwise, return an error code.
int32_t __tgt_rtl_data_delete(int32_t ID, void *TargetPtr) {
  uint64_t ret;

  DP("Release target memory: ptr=%" PRIu64 "\n", (uint64_t)TargetPtr);

  auto args = vhcall_args_alloc();
  vhcall_args_set_u64(args, 0, (uint64_t)TargetPtr);

  if (vhcall_invoke_with_args(__tgt_rtl_data_delete_vh_id, args, &ret) != 0) {
    DP("free on vh failed.\n");
    vhcall_args_free(args);
    return OFFLOAD_FAIL;
  }

  vhcall_args_free(args);
  return OFFLOAD_SUCCESS;
}

// Similar to __tgt_rtl_run_target_region, but additionally specify the
// number of teams to be created and a number of threads in each team.
int32_t __tgt_rtl_run_target_team_region(int32_t ID, void *Entry, void **Args,
                                         ptrdiff_t *Offsets, int32_t NumArgs,
                                         int32_t NumTeams, int32_t ThreadLimit,
                                         uint64_t loop_tripcount) {
  int ret;
  DP("Running function with entry point %p\n", Entry);

  // ignore team num and thread limit.
  std::vector<void *> ptrs(NumArgs);

  auto TargetArgs = vhcall_args_alloc();

  if (TargetArgs == NULL) {
    DP("Could not allocate VHCALL args\n");
    return OFFLOAD_FAIL;
  }

  for (int i = 0; i < NumArgs; ++i) {
    ret = vhcall_args_set_u64(TargetArgs, i, (intptr_t)Args[i]);

    if (ret != 0) {
      DP("vhcall_args_set_u64() has returned %d for argnum=%d and value %p\n",
         ret, i, Args[i]);
      vhcall_args_free(TargetArgs);
      return OFFLOAD_FAIL;
    }
  }

  uint64_t RetVal;
  auto entrypoint = reinterpret_cast<int64_t>(Entry);
  if (vhcall_invoke_with_args(entrypoint, TargetArgs, &RetVal) != 0) {
    DP("Execution of entry point %p failed\n", Entry);
    vhcall_args_free(TargetArgs);
    return OFFLOAD_FAIL;
  }
  vhcall_args_free(TargetArgs);
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

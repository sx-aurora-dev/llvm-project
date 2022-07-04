#include "types.h"
#include "velintrin.h"
#include "alloca.h"

#define REGCALL fastcall

/// Test store instructions
///
/// Note:
///   We test store instructions using general stack, stack with dynamic
///   allocation, stack with dynamic allocation and alignment, and stack
///   with dynamic allocation, alignment, and spill.
///
/// Fist test using a stack for leaf function.
///
///   |                                              | Higher address
///   |----------------------------------------------| <- old sp
///   | Local variables of fixed size                |
///   |----------------------------------------------| <- sp
///   |                                              | Lower address
///
/// Access local variable using sp (%s11).  In addition, please remember
/// that stack is aligned by 16 bytes.
///
/// Second test using a general stack.
///
///   |                                              | Higher address
///   |----------------------------------------------|
///   | Parameter area for this function             |
///   |----------------------------------------------|
///   | Register save area (RSA) for this function   |
///   |----------------------------------------------|
///   | Return address for this function             |
///   |----------------------------------------------|
///   | Frame pointer for this function              |
///   |----------------------------------------------| <- fp(=old sp)
///   | Local variables of fixed size                |
///   |----------------------------------------------|
///   |.variable-sized.local.variables.(VLAs)........|
///   |..............................................|
///   |..............................................|
///   |----------------------------------------------| <- returned by alloca
///   | Parameter area for callee                    |
///   |----------------------------------------------|
///   | Register save area (RSA) for callee          |
///   |----------------------------------------------|
///   | Return address for callee                    |
///   |----------------------------------------------|
///   | Frame pointer for callee                     |
///   |----------------------------------------------| <- sp
///   |                                              | Lower address
///
/// Access local variable using fp (%s9) since the size of VLA is not
/// known.  At the beginning of the functions, allocates 240 + data
/// bytes.  240 means RSA+RA+FP (=176) + Parameter (=64).
///
/// Third test using a general stack.
///
///   |                                              | Higher address
///   |----------------------------------------------|
///   | Parameter area for this function             |
///   |----------------------------------------------|
///   | Register save area (RSA) for this function   |
///   |----------------------------------------------|
///   | Return address for this function             |
///   |----------------------------------------------|
///   | Frame pointer for this function              |
///   |----------------------------------------------| <- fp(=old sp)
///   |.empty.space.to.make.part.below.aligned.in....|
///   |.case.it.needs.more.than.the.standard.16-byte.| (size of this area is
///   |.alignment....................................|  unknown at compile time)
///   |----------------------------------------------|
///   | Local variables of fixed size including spill|
///   | slots                                        |
///   |----------------------------------------------| <- bp(not defined by ABI,
///   |.variable-sized.local.variables.(VLAs)........|       LLVM chooses SX17)
///   |..............................................| (size of this area is
///   |..............................................|  unknown at compile time)
///   |----------------------------------------------| <- stack top (returned by
///   | Parameter area for callee                    |               alloca)
///   |----------------------------------------------|
///   | Register save area (RSA) for callee          |
///   |----------------------------------------------|
///   | Return address for callee                    |
///   |----------------------------------------------|
///   | Frame pointer for callee                     |
///   |----------------------------------------------| <- sp
///   |                                              | Lower address
///
/// Access local variable using bp (%s17) since the size of alignment
/// and VLA are not known.  At the beginning of the functions, allocates
/// pad(240 + data + align) bytes.  Then, access data through bp + pad(240)
/// since this address doesn't change even if VLA is dynamically allocated.
///
/// Fourth test using a general stack with some spills.
///

#define STK_TEST(KIND, TYPE) \
__attribute__ ((REGCALL)) \
void KIND ## TYPE ## _stk(TYPE v) { \
  volatile TYPE stk; \
  stk = v; \
} \
__attribute__ ((REGCALL)) \
void KIND ## TYPE ## _stk_big(TYPE v, i64 v2) { \
  volatile TYPE stk; \
  volatile i64 array[268435455]; \
  stk = v; \
  for (i64 i = 0; i < 268435455; ++i) { \
    array[i] = v2; \
  } \
} \
__attribute__ ((REGCALL)) \
void KIND ## TYPE ## _stk_big2(TYPE v, i64 v2) { \
  volatile TYPE stk; \
  volatile i64 array[268435456]; \
  stk = v; \
  for (i64 i = 0; i < 268435456; ++i) { \
    array[i] = v2; \
  } \
}

#define DYN_TEST(KIND, TYPE) \
__attribute__ ((REGCALL)) \
void KIND ## TYPE ## _stk_dyn(TYPE v, i64 bytes) { \
  volatile TYPE stk; \
  volatile TYPE* ptr = __builtin_alloca_with_align(bytes, 32); \
  *ptr = v; \
  stk = v; \
}

#define DYN_ALIGN_TEST(KIND, TYPE) \
__attribute__ ((REGCALL)) \
void KIND ## TYPE ## _stk_dyn_align(TYPE v, i64 bytes) { \
  volatile struct { TYPE stk; } s __attribute__ ((aligned (32))); \
  volatile TYPE* ptr = __builtin_alloca_with_align(bytes, 32); \
  *ptr = v; \
  s.stk = v; \
}

#define DYN_ALIGN2_TEST(KIND, TYPE) \
__attribute__ ((REGCALL)) \
void KIND ## TYPE ## _stk_dyn_align2(TYPE v, i64 bytes) { \
  volatile struct { TYPE stk; } s __attribute__ ((aligned (32))); \
  volatile TYPE* ptr = __builtin_alloca_with_align(bytes, 32); \
  *ptr = v; \
  s.stk = v; \
  volatile struct { TYPE stk; } s2 __attribute__ ((aligned (64))); \
  s2.stk = v; \
}

#define DYN_ALIGN_SPILL_TEST(KIND, TYPE) \
__attribute__ ((REGCALL)) \
void KIND ## TYPE ## _stk_dyn_align_spill(TYPE v, i64 bytes) { \
  volatile struct { TYPE stk; } s __attribute__ ((aligned (32))); \
  volatile TYPE* ptr = __builtin_alloca_with_align(bytes, 32); \
  extern void dummy(); \
  extern void pass(i64); \
  dummy(); \
  pass(bytes); \
  *ptr = v; \
  s.stk = v; \
}

STK_TEST(store, i64)
DYN_TEST(store, i64)
DYN_ALIGN_TEST(store, i64)
DYN_ALIGN2_TEST(store, i64)
DYN_ALIGN_SPILL_TEST(store, i64)
STK_TEST(store, quad)
DYN_TEST(store, quad)
DYN_ALIGN_TEST(store, quad)
DYN_ALIGN2_TEST(store, quad)
DYN_ALIGN_SPILL_TEST(store, quad)

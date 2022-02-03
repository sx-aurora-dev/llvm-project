#ifndef __VEL_INTRIN_H__
#define __VEL_INTRIN_H__

typedef double __vr __attribute__((__vector_size__(2048)));
#if __STDC_VERSION__ >= 199901L
// For C99
typedef _Bool __vm    __attribute__((ext_vector_type(256)));
typedef _Bool __vm256 __attribute__((ext_vector_type(256)));
typedef _Bool __vm512 __attribute__((ext_vector_type(512)));
#else
#ifdef __cplusplus
// For C++
typedef bool __vm    __attribute__((ext_vector_type(256)));
typedef bool __vm256 __attribute__((ext_vector_type(256)));
typedef bool __vm512 __attribute__((ext_vector_type(512)));
#else
#error need C++ or C99 to use vector intrinsics for VE
#endif
#endif

enum VShuffleCodes {
    VE_VSHUFFLE_YUYU =  0,
    VE_VSHUFFLE_YUYL =  1,
    VE_VSHUFFLE_YUZU =  2,
    VE_VSHUFFLE_YUZL =  3,
    VE_VSHUFFLE_YLYU =  4,
    VE_VSHUFFLE_YLYL =  5,
    VE_VSHUFFLE_YLZU =  6,
    VE_VSHUFFLE_YLZL =  7,
    VE_VSHUFFLE_ZUYU =  8,
    VE_VSHUFFLE_ZUYL =  9,
    VE_VSHUFFLE_ZUZU = 10,
    VE_VSHUFFLE_ZUZL = 11,
    VE_VSHUFFLE_ZLYU = 12,
    VE_VSHUFFLE_ZLYL = 13,
    VE_VSHUFFLE_ZLZU = 14,
    VE_VSHUFFLE_ZLZL = 15,
} ;


// deprecated

#if 1
#define _vel_vslaw_vvvl _vel_vslawzx_vvvl
#define _vel_vslaw_vvvvl _vel_vslawzx_vvvvl
#define _vel_vslaw_vvsl _vel_vslawzx_vvsl
#define _vel_vslaw_vvsvl _vel_vslawzx_vvsvl
#define _vel_vslaw_vvvmvl _vel_vslawzx_vvvmvl
#define _vel_vslaw_vvsmvl _vel_vslawzx_vvsmvl

#define _vel_vsraw_vvvl _vel_vsrawzx_vvvl
#define _vel_vsraw_vvvvl _vel_vsrawzx_vvvvl
#define _vel_vsraw_vvsl _vel_vsrawzx_vvsl
#define _vel_vsraw_vvsvl _vel_vsrawzx_vvsvl
#define _vel_vsraw_vvvmvl _vel_vsrawzx_vvvmvl
#define _vel_vsraw_vvsmvl _vel_vsrawzx_vvsmvl
#endif

#include <velintrin_gen.h>
#include <velintrin_approx.h>

// pack

#define _vel_pack_f32p __builtin_ve_vl_pack_f32p
#define _vel_pack_f32a __builtin_ve_vl_pack_f32a

static inline unsigned long int _vel_pack_i32(int a, int b)
{
    return (((unsigned long int)a) << 32) | (unsigned int)b;
}

#define _vel_extract_vm512u(vm) __builtin_ve_vl_extract_vm512u(vm)
#define _vel_extract_vm512l(vm) __builtin_ve_vl_extract_vm512l(vm)
#define _vel_insert_vm512u(vm512, vm) __builtin_ve_vl_insert_vm512u(vm512, vm)
#define _vel_insert_vm512l(vm512, vm) __builtin_ve_vl_insert_vm512l(vm512, vm)

#endif

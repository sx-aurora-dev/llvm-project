#ifndef __VE_INTRIN_H__
#define __VE_INTRIN_H__

#include <veintrin_common.h>

/*
 * suffix
 *
 * v: vector register
 * s: scalar register
 * I: immediate
 * m: mask register
 * M: 512b mask register (paired vm)
 * c: condition code
 * i: RFU (vector index register)
 */

#define _ve_lvl(l) __builtin_ve_lvl(l)
#define _ve_svob() __builtin_ve_svob()

#define _ve_lvm_MMss __builtin_ve_lvm_MMss
#define _ve_svm_sMs __builtin_ve_svm_sMs

#define _ve_pack_f32p __builtin_ve_pack_f32p
#define _ve_pack_f32a __builtin_ve_pack_f32a

static inline unsigned long int _ve_pack_i32(int a, int b)
{
    return (((unsigned long int)a) << 32) | (unsigned int)b;
}

#define _ve_vec_call __builtin_ve_vec_call

extern void __vec_expf(void);
extern void __vec_exp(void);
#define _ve_vec_expf_vv(vr) _ve_vec_call(vr, __vec_expf)
#define _ve_vec_exp_vv(vr) _ve_vec_call(vr, __vec_exp)

#define _ve_extract_vm512u(vm) __builtin_ve_extract_vm512u(vm)
#define _ve_extract_vm512l(vm) __builtin_ve_extract_vm512l(vm)
#define _ve_insert_vm512u(vm512, vm) __builtin_ve_insert_vm512u(vm512, vm)
#define _ve_insert_vm512l(vm512, vm) __builtin_ve_insert_vm512l(vm512, vm)

#include <veintrin2.h>

#endif

#ifndef __VE_INTRIN_H__
#define __VE_INTRIN_H__

#include <veintrin_common.h>

enum CondCodes {
    VECC_IG    =  0   ,  // Greater
    VECC_IL    =  1   ,  // Less
    VECC_INE   =  2   ,  // Not Equal
    VECC_IEQ   =  3   ,  // Equal
    VECC_IGE   =  4   ,  // Greater or Equal
    VECC_ILE   =  5   ,  // Less or Equal
    VECC_AF    =  0+6 ,  // Never
    VECC_G     =  1+6 ,  // Greater
    VECC_L     =  2+6 ,  // Less
    VECC_NE    =  3+6 ,  // Not Equal
    VECC_EQ    =  4+6 ,  // Equal
    VECC_GE    =  5+6 ,  // Greater or Equal
    VECC_LE    =  6+6 ,  // Less or Equal
    VECC_NUM   =  7+6 ,  // Number
    VECC_NAN   =  8+6 ,  // NaN
    VECC_GNAN  =  9+6 ,  // Greater or NaN
    VECC_LNAN  = 10+6 ,  // Less or NaN
    VECC_NENAN = 11+6 ,  // Not Equal or NaN
    VECC_EQNAN = 12+6 ,  // Equal or NaN
    VECC_GENAN = 13+6 ,  // Greater or Equal or NaN
    VECC_LENAN = 14+6 ,  // Less or Equal or NaN
    VECC_AT    = 15+6 ,  // Always
};

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

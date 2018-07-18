#ifndef __VE_INTRIN_H__
#define __VE_INTRIN_H__

typedef double __vr __attribute__((__vector_size__(2048)));
typedef double __vm __attribute__((__vector_size__(32)));
typedef double __vm256 __attribute__((__vector_size__(32)));
typedef double __vm512 __attribute__((__vector_size__(64)));

// FIXME: rename to VECC_*
enum CondCodes {
    VECC_AF    =  0   ,  // Never
    VECC_G     =  1   ,  // Greater
    VECC_L     =  2   ,  // Less
    VECC_NE    =  3   ,  // Not Equal
    VECC_EQ    =  4   ,  // Equal
    VECC_GE    =  5   ,  // Greater or Equal
    VECC_LE    =  6   ,  // Less or Equal
    VECC_NUM   =  7   ,  // Number
    VECC_NAN   =  8   ,  // NaN
    VECC_GNAN  =  9   ,  // Greater or NaN
    VECC_LNAN  = 10   ,  // Less or NaN
    VECC_NENAN = 11   ,  // Not Equal or NaN
    VECC_EQNAN = 12   ,  // Equal or NaN
    VECC_GENAN = 13   ,  // Greater or Equal or NaN
    VECC_LENAN = 14   ,  // Less or Equal or NaN
    VECC_AT    = 15   ,  // Always
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

#define _ve_lvm_MMss __builtin_ve_lvm_MMss
#define _ve_svm_sMs __builtin_ve_svm_sMs

#define _ve_pack_f32p __builtin_ve_pack_f32p
#define _ve_pack_f32a __builtin_ve_pack_f32a

#define _ve_vec_call __builtin_ve_vec_call

extern void __vec_expf(void);
extern void __vec_exp(void);
#define _ve_vec_expf_vv(vr) _ve_vec_call(vr, __vec_expf)
#define _ve_vec_exp_vv(vr) _ve_vec_call(vr, __vec_exp)


#include <veintrin2.h>

#endif

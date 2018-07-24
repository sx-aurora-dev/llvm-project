#ifndef __VE_INTRIN_H__
#define __VE_INTRIN_H__

typedef double __vr __attribute__((__vector_size__(2048)));
typedef double __vm __attribute__((__vector_size__(32)));
typedef double __vm256 __attribute__((__vector_size__(32)));
typedef double __vm512 __attribute__((__vector_size__(64)));

// FIXME: rename to VECC_*
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

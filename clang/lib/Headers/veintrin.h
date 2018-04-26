#ifndef __VE_INTRIN_H__
#define __VE_INTRIN_H__

typedef double __vr __attribute__((__vector_size__(2048)));
typedef double __vm __attribute__((__vector_size__(32)));

enum CondCodes {
    CC_AF    =  0   ,  // Never
    CC_G     =  1   ,  // Greater
    CC_L     =  2   ,  // Less
    CC_NE    =  3   ,  // Not Equal
    CC_EQ    =  4   ,  // Equal
    CC_GE    =  5   ,  // Greater or Equal
    CC_LE    =  6   ,  // Less or Equal
    CC_NUM   =  7   ,  // Number
    CC_NAN   =  8   ,  // NaN
    CC_GNAN  =  9   ,  // Greater or NaN
    CC_LNAN  = 10   ,  // Less or NaN
    CC_NENAN = 11   ,  // Not Equal or NaN
    CC_EQNAN = 12   ,  // Equal or NaN
    CC_GENAN = 13   ,  // Greater or Equal or NaN
    CC_LENAN = 14   ,  // Less or Equal or NaN
    CC_AT    = 15   ,  // Always
};

#define _ve_lvl(l) __builtin_ve_lvl(l)
#define _ve_vld(p, s) __builtin_ve_vld(p, s)
#define _ve_vldu(p, s) __builtin_ve_vldu(p, s)
#define _ve_vldl(p, s) __builtin_ve_vldl(p, s)
#define _ve_vst(p, v, s) __builtin_ve_vst(p, v, s)
#define _ve_vstu(p, v, s) __builtin_ve_vstu(p, v, s)
#define _ve_vstl(p, v, s) __builtin_ve_vstl(p, v, s)

#define _ve_lsv_vss __builtin_ve_lsv_vss

#include <veintrin2.h>

#endif

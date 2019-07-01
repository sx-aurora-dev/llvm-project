#ifndef __VE_INTRIN_COMMON_H__
#define __VE_INTRIN_COMMON_H__

typedef double __vr __attribute__((__vector_size__(2048)));
typedef double __vm __attribute__((__vector_size__(32)));
typedef double __vm256 __attribute__((__vector_size__(32)));
typedef double __vm512 __attribute__((__vector_size__(64)));

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

#endif

#ifndef __TYPES_H__
#define __TYPES_H__
#if __STDC_VERSION__ >= 199901L
// For C99
typedef _Bool i1;
#else
#ifdef __cplusplus
// For C++
typedef bool i1;
#else
#error need C++ or C99 to use vector intrinsics for VE
#endif
#endif
typedef char i8;
typedef unsigned char u8;
typedef short i16;
typedef unsigned short u16;
typedef int i32;
typedef unsigned int u32;
typedef long i64;
typedef unsigned long u64;
typedef __int128 i128;
typedef unsigned __int128 u128;
typedef long double quad;
typedef _Complex float fcomp;
typedef _Complex double dcomp;
typedef _Complex long double qcomp;
#endif // __TYPES_H__

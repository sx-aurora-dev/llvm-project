typedef _Bool int1_t;
typedef char int8_t;
typedef unsigned char uint8_t;
typedef short int16_t;
typedef unsigned short uint16_t;
typedef int int32_t;
typedef unsigned int uint32_t;
typedef long int64_t;
typedef unsigned long uint64_t;
typedef __int128 int128_t;
typedef unsigned __int128 uint128_t;
typedef long double quad;
typedef float _Complex fcomp;
typedef double _Complex dcomp;
typedef long double _Complex qcomp;


/* Compare function between variables */
#define SELECTCC(TYCMP, TY, FUNC_NAME) \
TY func_ ## FUNC_NAME(TYCMP l, TYCMP r, TY a, TY b) { \
  return l == r ? a : b; \
}

/* Compare function between variable and zero */
#define SELECTCC_ZERO(TYCMP, TY, FUNC_NAME) \
TY func_ ## FUNC_NAME(TYCMP l, TY a, TY b) { \
  return l == 0 ? a : b; \
}

/* Compare function between variable and immediate value of "I" */
#define SELECTCC_I(TYCMP, TY, FUNC_NAME) \
TY func_ ## FUNC_NAME(TYCMP l, TY a, TY b) { \
  return l == (TYCMP)12 ? a : b; \
}

/* Compare function between variable and immediate value of "M" */
#define SELECTCC_M(TYCMP, TY, FUNC_NAME) \
TY func_ ## FUNC_NAME(TYCMP l, TY a, TY b) { \
  return l == (TYCMP)-2.0 ? a : b; \
}

/* === fcomp === */

/* Compare function between variables */
SELECTCC(fcomp,   int1_t,      fcomp_1)
SELECTCC(fcomp,   int8_t,      fcomp_8)
SELECTCC(fcomp,  uint8_t,      fcomp_u8)
SELECTCC(fcomp,   int16_t,     fcomp_16)
SELECTCC(fcomp,  uint16_t,     fcomp_u16)
SELECTCC(fcomp,   int32_t,     fcomp_32)
SELECTCC(fcomp,  uint32_t,     fcomp_u32)
SELECTCC(fcomp,   int64_t,     fcomp_64)
SELECTCC(fcomp,  uint64_t,     fcomp_u64)
SELECTCC(fcomp,   int128_t,    fcomp_128)
SELECTCC(fcomp,  uint128_t,    fcomp_u128)
SELECTCC(fcomp,   float,       fcomp_float)
SELECTCC(fcomp,   double,      fcomp_double)
SELECTCC(fcomp,   quad,        fcomp_quad)
SELECTCC(fcomp,   fcomp,       fcomp_fcomp)
SELECTCC(fcomp,   dcomp,       fcomp_dcomp)
SELECTCC(fcomp,   qcomp,       fcomp_qcomp)


/* Compare function between variable and zero */
SELECTCC_ZERO(fcomp,   int1_t,      fcomp_1_zero)
SELECTCC_ZERO(fcomp,   int8_t,      fcomp_8_zero)
SELECTCC_ZERO(fcomp,  uint8_t,      fcomp_u8_zero)
SELECTCC_ZERO(fcomp,   int16_t,     fcomp_16_zero)
SELECTCC_ZERO(fcomp,  uint16_t,     fcomp_u16_zero)
SELECTCC_ZERO(fcomp,   int32_t,     fcomp_32_zero)
SELECTCC_ZERO(fcomp,  uint32_t,     fcomp_u32_zero)
SELECTCC_ZERO(fcomp,   int64_t,     fcomp_64_zero)
SELECTCC_ZERO(fcomp,  uint64_t,     fcomp_u64_zero)
SELECTCC_ZERO(fcomp,   int128_t,    fcomp_128_zero)
SELECTCC_ZERO(fcomp,  uint128_t,    fcomp_u128_zero)
SELECTCC_ZERO(fcomp,   float,       fcomp_float_zero)
SELECTCC_ZERO(fcomp,   double,      fcomp_double_zero)
SELECTCC_ZERO(fcomp,   quad,        fcomp_quad_zero)
SELECTCC_ZERO(fcomp,   fcomp,       fcomp_fcomp_zero)
SELECTCC_ZERO(fcomp,   dcomp,       fcomp_dcomp_zero)
SELECTCC_ZERO(fcomp,  qcomp,        fcomp_qcomp_zero)


/* Compare function between variable and immediate value of "I" */
SELECTCC_I(fcomp,   int1_t,      fcomp_1_i)
SELECTCC_I(fcomp,   int8_t,      fcomp_8_i)
SELECTCC_I(fcomp,  uint8_t,      fcomp_u8_i)
SELECTCC_I(fcomp,   int16_t,     fcomp_16_i)
SELECTCC_I(fcomp,  uint16_t,     fcomp_u16_i)
SELECTCC_I(fcomp,   int32_t,     fcomp_32_i)
SELECTCC_I(fcomp,  uint32_t,     fcomp_u32_i)
SELECTCC_I(fcomp,   int64_t,     fcomp_64_i)
SELECTCC_I(fcomp,  uint64_t,     fcomp_u64_i)
SELECTCC_I(fcomp,   int128_t,    fcomp_128_i)
SELECTCC_I(fcomp,  uint128_t,    fcomp_u128_i)
SELECTCC_I(fcomp,   float,       fcomp_float_i)
SELECTCC_I(fcomp,   double,      fcomp_double_i)
SELECTCC_I(fcomp,   quad,        fcomp_quad_i)
SELECTCC_I(fcomp,   fcomp,       fcomp_fcomp_i)
SELECTCC_I(fcomp,   dcomp,       fcomp_dcomp_i)
SELECTCC_I(fcomp,   qcomp,       fcomp_qcomp_i)


/* Compare function between variable and immediate value of "M" */
SELECTCC_M(fcomp,   int1_t,      fcomp_1_m)
SELECTCC_M(fcomp,   int8_t,      fcomp_8_m)
SELECTCC_M(fcomp,  uint8_t,      fcomp_u8_m)
SELECTCC_M(fcomp,   int16_t,     fcomp_16_m)
SELECTCC_M(fcomp,  uint16_t,     fcomp_u16_m)
SELECTCC_M(fcomp,   int32_t,     fcomp_32_m)
SELECTCC_M(fcomp,  uint32_t,     fcomp_u32_m)
SELECTCC_M(fcomp,   int64_t,     fcomp_64_m)
SELECTCC_M(fcomp,  uint64_t,     fcomp_u64_m)
SELECTCC_M(fcomp,   int128_t,    fcomp_128_m)
SELECTCC_M(fcomp,  uint128_t,    fcomp_u128_m)
SELECTCC_M(fcomp,   float,       fcomp_float_m)
SELECTCC_M(fcomp,   double,      fcomp_double_m)
SELECTCC_M(fcomp,   quad,        fcomp_quad_m)
SELECTCC_M(fcomp,   fcomp,       fcomp_fcomp_m)
SELECTCC_M(fcomp,   dcomp,       fcomp_dcomp_m)
SELECTCC_M(fcomp,   qcomp,       fcomp_qcomp_m)

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

/* === int16_t === */

/* Compare function between variables */
SELECTCC(int16_t,   int1_t,      16_1)
SELECTCC(int16_t,   int8_t,      16_8)
SELECTCC(int16_t,  uint8_t,      16_u8)
SELECTCC(int16_t,   int16_t,     16_16)
SELECTCC(int16_t,  uint16_t,     16_u16)
SELECTCC(int16_t,   int32_t,     16_32)
SELECTCC(int16_t,  uint32_t,     16_u32)
SELECTCC(int16_t,   int64_t,     16_64)
SELECTCC(int16_t,  uint64_t,     16_u64)
SELECTCC(int16_t,   int128_t,    16_128)
SELECTCC(int16_t,  uint128_t,    16_u128)
SELECTCC(int16_t,   float,       16_float)
SELECTCC(int16_t,   double,      16_double)
SELECTCC(int16_t,   quad,        16_quad)
SELECTCC(int16_t,   fcomp,       16_fcomp)
SELECTCC(int16_t,   dcomp,       16_dcomp)
SELECTCC(int16_t,   qcomp,       16_qcomp)


/* Compare function between variable and zero */
SELECTCC_ZERO(int16_t,   int1_t,      16_1_zero)
SELECTCC_ZERO(int16_t,   int8_t,      16_8_zero)
SELECTCC_ZERO(int16_t,  uint8_t,      16_u8_zero)
SELECTCC_ZERO(int16_t,   int16_t,     16_16_zero)
SELECTCC_ZERO(int16_t,  uint16_t,     16_u16_zero)
SELECTCC_ZERO(int16_t,   int32_t,     16_32_zero)
SELECTCC_ZERO(int16_t,  uint32_t,     16_u32_zero)
SELECTCC_ZERO(int16_t,   int64_t,     16_64_zero)
SELECTCC_ZERO(int16_t,  uint64_t,     16_u64_zero)
SELECTCC_ZERO(int16_t,   int128_t,    16_128_zero)
SELECTCC_ZERO(int16_t,  uint128_t,    16_u128_zero)
SELECTCC_ZERO(int16_t,   float,       16_float_zero)
SELECTCC_ZERO(int16_t,   double,      16_double_zero)
SELECTCC_ZERO(int16_t,   quad,        16_quad_zero)
SELECTCC_ZERO(int16_t,   fcomp,       16_fcomp_zero)
SELECTCC_ZERO(int16_t,   dcomp,       16_dcomp_zero)
SELECTCC_ZERO(int16_t,   qcomp,       16_qcomp_zero)


/* Compare function between variable and immediate value of "I" */
SELECTCC_I(int16_t,   int1_t,      16_1_i)
SELECTCC_I(int16_t,   int8_t,      16_8_i)
SELECTCC_I(int16_t,  uint8_t,      16_u8_i)
SELECTCC_I(int16_t,   int16_t,     16_16_i)
SELECTCC_I(int16_t,  uint16_t,     16_u16_i)
SELECTCC_I(int16_t,   int32_t,     16_32_i)
SELECTCC_I(int16_t,  uint32_t,     16_u32_i)
SELECTCC_I(int16_t,   int64_t,     16_64_i)
SELECTCC_I(int16_t,  uint64_t,     16_u64_i)
SELECTCC_I(int16_t,   int128_t,    16_128_i)
SELECTCC_I(int16_t,  uint128_t,    16_u128_i)
SELECTCC_I(int16_t,   float,       16_float_i)
SELECTCC_I(int16_t,   double,      16_double_i)
SELECTCC_I(int16_t,   quad,        16_quad_i)
SELECTCC_I(int16_t,   fcomp,       16_fcomp_i)
SELECTCC_I(int16_t,   dcomp,       16_dcomp_i)
SELECTCC_I(int16_t,   qcomp,       16_qcomp_i)


/* Compare function between variable and immediate value of "M" */
SELECTCC_M(int16_t,   int1_t,      16_1_m)
SELECTCC_M(int16_t,   int8_t,      16_8_m)
SELECTCC_M(int16_t,  uint8_t,      16_u8_m)
SELECTCC_M(int16_t,   int16_t,     16_16_m)
SELECTCC_M(int16_t,  uint16_t,     16_u16_m)
SELECTCC_M(int16_t,   int32_t,     16_32_m)
SELECTCC_M(int16_t,  uint32_t,     16_u32_m)
SELECTCC_M(int16_t,   int64_t,     16_64_m)
SELECTCC_M(int16_t,  uint64_t,     16_u64_m)
SELECTCC_M(int16_t,   int128_t,    16_128_m)
SELECTCC_M(int16_t,  uint128_t,    16_u128_m)
SELECTCC_M(int16_t,   float,       16_float_m)
SELECTCC_M(int16_t,   double,      16_double_m)
SELECTCC_M(int16_t,   quad,        16_quad_m)
SELECTCC_M(int16_t,   fcomp,       16_fcomp_m)
SELECTCC_M(int16_t,   dcomp,       16_dcomp_m)
SELECTCC_M(int16_t,   qcomp,       16_qcomp_m)

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

/* === int64_t === */

/* Compare function between variables */
SELECTCC(int64_t,   int1_t,      64_1)
SELECTCC(int64_t,   int8_t,      64_8)
SELECTCC(int64_t,  uint8_t,      64_u8)
SELECTCC(int64_t,   int16_t,     64_16)
SELECTCC(int64_t,  uint16_t,     64_u16)
SELECTCC(int64_t,   int32_t,     64_32)
SELECTCC(int64_t,  uint32_t,     64_u32)
SELECTCC(int64_t,   int64_t,     64_64)
SELECTCC(int64_t,  uint64_t,     64_u64)
SELECTCC(int64_t,   int128_t,    64_128)
SELECTCC(int64_t,  uint128_t,    64_u128)
SELECTCC(int64_t,   float,       64_float)
SELECTCC(int64_t,   double,      64_double)
SELECTCC(int64_t,   quad,        64_quad)
SELECTCC(int64_t,   fcomp,       64_fcomp)
SELECTCC(int64_t,   dcomp,       64_dcomp)
SELECTCC(int64_t,   qcomp,       64_qcomp)


/* Compare function between variable and zero */
SELECTCC_ZERO(int64_t,   int1_t,      64_1_zero)
SELECTCC_ZERO(int64_t,   int8_t,      64_8_zero)
SELECTCC_ZERO(int64_t,  uint8_t,      64_u8_zero)
SELECTCC_ZERO(int64_t,   int16_t,     64_16_zero)
SELECTCC_ZERO(int64_t,  uint16_t,     64_u16_zero)
SELECTCC_ZERO(int64_t,   int32_t,     64_32_zero)
SELECTCC_ZERO(int64_t,  uint32_t,     64_u32_zero)
SELECTCC_ZERO(int64_t,   int64_t,     64_64_zero)
SELECTCC_ZERO(int64_t,  uint64_t,     64_u64_zero)
SELECTCC_ZERO(int64_t,   int128_t,    64_128_zero)
SELECTCC_ZERO(int64_t,  uint128_t,    64_u128_zero)
SELECTCC_ZERO(int64_t,   float,       64_float_zero)
SELECTCC_ZERO(int64_t,   double,      64_double_zero)
SELECTCC_ZERO(int64_t,   quad,        64_quad_zero)
SELECTCC_ZERO(int64_t,   fcomp,       64_fcomp_zero)
SELECTCC_ZERO(int64_t,   dcomp,       64_dcomp_zero)
SELECTCC_ZERO(int64_t,   qcomp,       64_qcomp_zero)


/* Compare function between variable and immediate value of "I" */
SELECTCC_I(int64_t,   int1_t,      64_1_i)
SELECTCC_I(int64_t,   int8_t,      64_8_i)
SELECTCC_I(int64_t,  uint8_t,      64_u8_i)
SELECTCC_I(int64_t,   int16_t,     64_16_i)
SELECTCC_I(int64_t,  uint16_t,     64_u16_i)
SELECTCC_I(int64_t,   int32_t,     64_32_i)
SELECTCC_I(int64_t,  uint32_t,     64_u32_i)
SELECTCC_I(int64_t,   int64_t,     64_64_i)
SELECTCC_I(int64_t,  uint64_t,     64_u64_i)
SELECTCC_I(int64_t,   int128_t,    64_128_i)
SELECTCC_I(int64_t,  uint128_t,    64_u128_i)
SELECTCC_I(int64_t,   float,       64_float_i)
SELECTCC_I(int64_t,   double,      64_double_i)
SELECTCC_I(int64_t,   quad,        64_quad_i)
SELECTCC_I(int64_t,   fcomp,       64_fcomp_i)
SELECTCC_I(int64_t,   dcomp,       64_dcomp_i)
SELECTCC_I(int64_t,   qcomp,       64_qcomp_i)


/* Compare function between variable and immediate value of "M" */
SELECTCC_M(int64_t,   int1_t,      64_1_m)
SELECTCC_M(int64_t,   int8_t,      64_8_m)
SELECTCC_M(int64_t,  uint8_t,      64_u8_m)
SELECTCC_M(int64_t,   int16_t,     64_16_m)
SELECTCC_M(int64_t,  uint16_t,     64_u16_m)
SELECTCC_M(int64_t,   int32_t,     64_32_m)
SELECTCC_M(int64_t,  uint32_t,     64_u32_m)
SELECTCC_M(int64_t,   int64_t,     64_64_m)
SELECTCC_M(int64_t,  uint64_t,     64_u64_m)
SELECTCC_M(int64_t,   int128_t,    64_128_m)
SELECTCC_M(int64_t,  uint128_t,    64_u128_m)
SELECTCC_M(int64_t,   float,       64_float_m)
SELECTCC_M(int64_t,   double,      64_double_m)
SELECTCC_M(int64_t,   quad,        64_quad_m)
SELECTCC_M(int64_t,   fcomp,       64_fcomp_m)
SELECTCC_M(int64_t,   dcomp,       64_dcomp_m)
SELECTCC_M(int64_t,   qcomp,       64_qcomp_m)

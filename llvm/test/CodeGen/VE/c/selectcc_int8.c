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

/* === int8_t === */

/* Compare function between variables */
SELECTCC(int8_t,   int1_t,      8_1)
SELECTCC(int8_t,   int8_t,      8_8)
SELECTCC(int8_t,  uint8_t,      8_u8)
SELECTCC(int8_t,   int16_t,     8_16)
SELECTCC(int8_t,  uint16_t,     8_u16)
SELECTCC(int8_t,   int32_t,     8_32)
SELECTCC(int8_t,  uint32_t,     8_u32)
SELECTCC(int8_t,   int64_t,     8_64)
SELECTCC(int8_t,  uint64_t,     8_u64)
SELECTCC(int8_t,   int128_t,    8_128)
SELECTCC(int8_t,  uint128_t,    8_u128)
SELECTCC(int8_t,   float,       8_float)
SELECTCC(int8_t,   double,      8_double)
SELECTCC(int8_t,   quad,        8_quad)
SELECTCC(int8_t,   fcomp,       8_fcomp)
SELECTCC(int8_t,   dcomp,       8_dcomp)
SELECTCC(int8_t,   qcomp,       8_qcomp)


/* Compare function between variable and zero */
SELECTCC_ZERO(int8_t,   int1_t,      8_1_zero)
SELECTCC_ZERO(int8_t,   int8_t,      8_8_zero)
SELECTCC_ZERO(int8_t,  uint8_t,      8_u8_zero)
SELECTCC_ZERO(int8_t,   int16_t,     8_16_zero)
SELECTCC_ZERO(int8_t,  uint16_t,     8_u16_zero)
SELECTCC_ZERO(int8_t,   int32_t,     8_32_zero)
SELECTCC_ZERO(int8_t,  uint32_t,     8_u32_zero)
SELECTCC_ZERO(int8_t,   int64_t,     8_64_zero)
SELECTCC_ZERO(int8_t,  uint64_t,     8_u64_zero)
SELECTCC_ZERO(int8_t,   int128_t,    8_128_zero)
SELECTCC_ZERO(int8_t,  uint128_t,    8_u128_zero)
SELECTCC_ZERO(int8_t,   float,       8_float_zero)
SELECTCC_ZERO(int8_t,   double,      8_double_zero)
SELECTCC_ZERO(int8_t,   quad,        8_quad_zero)
SELECTCC_ZERO(int8_t,   fcomp,       8_fcomp_zero)
SELECTCC_ZERO(int8_t,   dcomp,       8_dcomp_zero)
SELECTCC_ZERO(int8_t,   qcomp,       8_qcomp_zero)


/* Compare function between variable and immediate value of "I" */
SELECTCC_I(int8_t,   int1_t,      8_1_i)
SELECTCC_I(int8_t,   int8_t,      8_8_i)
SELECTCC_I(int8_t,  uint8_t,      8_u8_i)
SELECTCC_I(int8_t,   int16_t,     8_16_i)
SELECTCC_I(int8_t,  uint16_t,     8_u16_i)
SELECTCC_I(int8_t,   int32_t,     8_32_i)
SELECTCC_I(int8_t,  uint32_t,     8_u32_i)
SELECTCC_I(int8_t,   int64_t,     8_64_i)
SELECTCC_I(int8_t,  uint64_t,     8_u64_i)
SELECTCC_I(int8_t,   int128_t,    8_128_i)
SELECTCC_I(int8_t,  uint128_t,    8_u128_i)
SELECTCC_I(int8_t,   float,       8_float_i)
SELECTCC_I(int8_t,   double,      8_double_i)
SELECTCC_I(int8_t,   quad,        8_quad_i)
SELECTCC_I(int8_t,   fcomp,       8_fcomp_i)
SELECTCC_I(int8_t,   dcomp,       8_dcomp_i)
SELECTCC_I(int8_t,   qcomp,       8_qcomp_i)


/* Compare function between variable and immediate value of "M" */
SELECTCC_M(int8_t,   int1_t,      8_1_m)
SELECTCC_M(int8_t,   int8_t,      8_8_m)
SELECTCC_M(int8_t,  uint8_t,      8_u8_m)
SELECTCC_M(int8_t,   int16_t,     8_16_m)
SELECTCC_M(int8_t,  uint16_t,     8_u16_m)
SELECTCC_M(int8_t,   int32_t,     8_32_m)
SELECTCC_M(int8_t,  uint32_t,     8_u32_m)
SELECTCC_M(int8_t,   int64_t,     8_64_m)
SELECTCC_M(int8_t,  uint64_t,     8_u64_m)
SELECTCC_M(int8_t,   int128_t,    8_128_m)
SELECTCC_M(int8_t,  uint128_t,    8_u128_m)
SELECTCC_M(int8_t,   float,       8_float_m)
SELECTCC_M(int8_t,   double,      8_double_m)
SELECTCC_M(int8_t,   quad,        8_quad_m)
SELECTCC_M(int8_t,   fcomp,       8_fcomp_m)
SELECTCC_M(int8_t,   dcomp,       8_dcomp_m)
SELECTCC_M(int8_t,   qcomp,       8_qcomp_m)

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

/* Complex type */
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

/* === int1_t === */

/* Compare function between variables */
SELECTCC(int1_t,   int1_t,      1_1)
SELECTCC(int1_t,   int8_t,      1_8)
SELECTCC(int1_t,  uint8_t,      1_u8)
SELECTCC(int1_t,   int16_t,     1_16)
SELECTCC(int1_t,  uint16_t,     1_u16)
SELECTCC(int1_t,   int32_t,     1_32)
SELECTCC(int1_t,  uint32_t,     1_u32)
SELECTCC(int1_t,   int64_t,     1_64)
SELECTCC(int1_t,  uint64_t,     1_u64)
SELECTCC(int1_t,   int128_t,    1_128)
SELECTCC(int1_t,  uint128_t,    1_u128)
SELECTCC(int1_t,   float,       1_float)
SELECTCC(int1_t,   double,      1_double)
SELECTCC(int1_t,   quad,        1_quad)
SELECTCC(int1_t,   fcomp,       1_fcomp)
SELECTCC(int1_t,   dcomp,       1_dcomp)
SELECTCC(int1_t,   qcomp,       1_qcomp)


/* Compare function between variable and zero */
SELECTCC_ZERO(int1_t,   int1_t,      1_1_zero)
SELECTCC_ZERO(int1_t,   int8_t,      1_8_zero)
SELECTCC_ZERO(int1_t,  uint8_t,      1_u8_zero)
SELECTCC_ZERO(int1_t,   int16_t,     1_16_zero)
SELECTCC_ZERO(int1_t,  uint16_t,     1_u16_zero)
SELECTCC_ZERO(int1_t,   int32_t,     1_32_zero)
SELECTCC_ZERO(int1_t,  uint32_t,     1_u32_zero)
SELECTCC_ZERO(int1_t,   int64_t,     1_64_zero)
SELECTCC_ZERO(int1_t,  uint64_t,     1_u64_zero)
SELECTCC_ZERO(int1_t,   int128_t,    1_128_zero)
SELECTCC_ZERO(int1_t,  uint128_t,    1_u128_zero)
SELECTCC_ZERO(int1_t,   float,       1_float_zero)
SELECTCC_ZERO(int1_t,   double,      1_double_zero)
SELECTCC_ZERO(int1_t,   quad,        1_quad_zero)
SELECTCC_ZERO(int1_t,   fcomp,       1_fcomp_zero)
SELECTCC_ZERO(int1_t,   dcomp,       1_dcomp_zero)
SELECTCC_ZERO(int1_t,   qcomp,       1_qcomp_zero)


/* Compare function between variable and immediate value of "I" */
SELECTCC_I(int1_t,   int1_t,      1_1_i)
SELECTCC_I(int1_t,   int8_t,      1_8_i)
SELECTCC_I(int1_t,  uint8_t,      1_u8_i)
SELECTCC_I(int1_t,   int16_t,     1_16_i)
SELECTCC_I(int1_t,  uint16_t,     1_u16_i)
SELECTCC_I(int1_t,   int32_t,     1_32_i)
SELECTCC_I(int1_t,  uint32_t,     1_u32_i)
SELECTCC_I(int1_t,   int64_t,     1_64_i)
SELECTCC_I(int1_t,  uint64_t,     1_u64_i)
SELECTCC_I(int1_t,   int128_t,    1_128_i)
SELECTCC_I(int1_t,  uint128_t,    1_u128_i)
SELECTCC_I(int1_t,   float,       1_float_i)
SELECTCC_I(int1_t,   double,      1_double_i)
SELECTCC_I(int1_t,   quad,        1_quad_i)
SELECTCC_I(int1_t,   fcomp,       1_fcomp_i)
SELECTCC_I(int1_t,   dcomp,       1_dcomp_i)
SELECTCC_I(int1_t,   qcomp,       1_qcomp_i)


/* Compare function between variable and immediate value of "M" */
SELECTCC_M(int1_t,   int1_t,      1_1_m)
SELECTCC_M(int1_t,   int8_t,      1_8_m)
SELECTCC_M(int1_t,  uint8_t,      1_u8_m)
SELECTCC_M(int1_t,   int16_t,     1_16_m)
SELECTCC_M(int1_t,  uint16_t,     1_u16_m)
SELECTCC_M(int1_t,   int32_t,     1_32_m)
SELECTCC_M(int1_t,  uint32_t,     1_u32_m)
SELECTCC_M(int1_t,   int64_t,     1_64_m)
SELECTCC_M(int1_t,  uint64_t,     1_u64_m)
SELECTCC_M(int1_t,   int128_t,    1_128_m)
SELECTCC_M(int1_t,  uint128_t,    1_u128_m)
SELECTCC_M(int1_t,   float,       1_float_m)
SELECTCC_M(int1_t,   double,      1_double_m)
SELECTCC_M(int1_t,   quad,        1_quad_m)
SELECTCC_M(int1_t,   fcomp,       1_fcomp_m)
SELECTCC_M(int1_t,   dcomp,       1_dcomp_m)
SELECTCC_M(int1_t,   qcomp,       1_qcomp_m)

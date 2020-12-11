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

/* === int128_t === */

/* Compare function between variables */
SELECTCC(int128_t,   int1_t,      128_1)
SELECTCC(int128_t,   int8_t,      128_8)
SELECTCC(int128_t,  uint8_t,      128_u8)
SELECTCC(int128_t,   int16_t,     128_16)
SELECTCC(int128_t,  uint16_t,     128_u16)
SELECTCC(int128_t,   int32_t,     128_32)
SELECTCC(int128_t,  uint32_t,     128_u32)
SELECTCC(int128_t,   int64_t,     128_64)
SELECTCC(int128_t,  uint64_t,     128_u64)
SELECTCC(int128_t,   int128_t,    128_128)
SELECTCC(int128_t,  uint128_t,    128_u128)
SELECTCC(int128_t,   float,       128_float)
SELECTCC(int128_t,   double,      128_double)
SELECTCC(int128_t,   quad,        128_quad)
SELECTCC(int128_t,   fcomp,       128_fcomp)
SELECTCC(int128_t,   dcomp,       128_dcomp)
SELECTCC(int128_t,   qcomp,       128_qcomp)


/* Compare function between variable and zero */
SELECTCC_ZERO(int128_t,   int1_t,      128_1_zero)
SELECTCC_ZERO(int128_t,   int8_t,      128_8_zero)
SELECTCC_ZERO(int128_t,  uint8_t,      128_u8_zero)
SELECTCC_ZERO(int128_t,   int16_t,     128_16_zero)
SELECTCC_ZERO(int128_t,  uint16_t,     128_u16_zero)
SELECTCC_ZERO(int128_t,   int32_t,     128_32_zero)
SELECTCC_ZERO(int128_t,  uint32_t,     128_u32_zero)
SELECTCC_ZERO(int128_t,   int64_t,     128_64_zero)
SELECTCC_ZERO(int128_t,  uint64_t,     128_u64_zero)
SELECTCC_ZERO(int128_t,   int128_t,    128_128_zero)
SELECTCC_ZERO(int128_t,  uint128_t,    128_u128_zero)
SELECTCC_ZERO(int128_t,   float,       128_float_zero)
SELECTCC_ZERO(int128_t,   double,      128_double_zero)
SELECTCC_ZERO(int128_t,   quad,        128_quad_zero)
SELECTCC_ZERO(int128_t,   fcomp,       128_fcomp_zero)
SELECTCC_ZERO(int128_t,   dcomp,       128_dcomp_zero)
SELECTCC_ZERO(int128_t,   qcomp,       128_qcomp_zero)


/* Compare function between variable and immediate value of "I" */
SELECTCC_I(int128_t,   int1_t,      128_1_i)
SELECTCC_I(int128_t,   int8_t,      128_8_i)
SELECTCC_I(int128_t,  uint8_t,      128_u8_i)
SELECTCC_I(int128_t,   int16_t,     128_16_i)
SELECTCC_I(int128_t,  uint16_t,     128_u16_i)
SELECTCC_I(int128_t,   int32_t,     128_32_i)
SELECTCC_I(int128_t,  uint32_t,     128_u32_i)
SELECTCC_I(int128_t,   int64_t,     128_64_i)
SELECTCC_I(int128_t,  uint64_t,     128_u64_i)
SELECTCC_I(int128_t,   int128_t,    128_128_i)
SELECTCC_I(int128_t,  uint128_t,    128_u128_i)
SELECTCC_I(int128_t,   float,       128_float_i)
SELECTCC_I(int128_t,   double,      128_double_i)
SELECTCC_I(int128_t,   quad,        128_quad_i)
SELECTCC_I(int128_t,   fcomp,       128_fcomp_i)
SELECTCC_I(int128_t,   dcomp,       128_dcomp_i)
SELECTCC_I(int128_t,   qcomp,       128_qcomp_i)


/* Compare function between variable and immediate value of "M" */
SELECTCC_M(int128_t,   int1_t,      128_1_m)
SELECTCC_M(int128_t,   int8_t,      128_8_m)
SELECTCC_M(int128_t,  uint8_t,      128_u8_m)
SELECTCC_M(int128_t,   int16_t,     128_16_m)
SELECTCC_M(int128_t,  uint16_t,     128_u16_m)
SELECTCC_M(int128_t,   int32_t,     128_32_m)
SELECTCC_M(int128_t,  uint32_t,     128_u32_m)
SELECTCC_M(int128_t,   int64_t,     128_64_m)
SELECTCC_M(int128_t,  uint64_t,     128_u64_m)
SELECTCC_M(int128_t,   int128_t,    128_128_m)
SELECTCC_M(int128_t,  uint128_t,    128_u128_m)
SELECTCC_M(int128_t,   float,       128_float_m)
SELECTCC_M(int128_t,   double,      128_double_m)
SELECTCC_M(int128_t,   quad,        128_quad_m)
SELECTCC_M(int128_t,   fcomp,       128_fcomp_m)
SELECTCC_M(int128_t,   dcomp,       128_dcomp_m)
SELECTCC_M(int128_t,   qcomp,       128_qcomp_m)

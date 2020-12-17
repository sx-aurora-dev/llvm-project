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

/* === quad === */

/* Compare function between variables */
SELECTCC(quad,   int1_t,      quad_1)
SELECTCC(quad,   int8_t,      quad_8)
SELECTCC(quad,  uint8_t,      quad_u8)
SELECTCC(quad,   int16_t,     quad_16)
SELECTCC(quad,  uint16_t,     quad_u16)
SELECTCC(quad,   int32_t,     quad_32)
SELECTCC(quad,  uint32_t,     quad_u32)
SELECTCC(quad,   int64_t,     quad_64)
SELECTCC(quad,  uint64_t,     quad_u64)
SELECTCC(quad,   int128_t,    quad_128)
SELECTCC(quad,  uint128_t,    quad_u128)
SELECTCC(quad,   float,       quad_float)
SELECTCC(quad,   double,      quad_double)
SELECTCC(quad,   quad,        quad_quad)
SELECTCC(quad,   fcomp,       quad_fcomp)
SELECTCC(quad,   dcomp,       quad_dcomp)
SELECTCC(quad,   qcomp,       quad_qcomp)


/* Compare function between variable and zero */
SELECTCC_ZERO(quad,   int1_t,      quad_1_zero)
SELECTCC_ZERO(quad,   int8_t,      quad_8_zero)
SELECTCC_ZERO(quad,  uint8_t,      quad_u8_zero)
SELECTCC_ZERO(quad,   int16_t,     quad_16_zero)
SELECTCC_ZERO(quad,  uint16_t,     quad_u16_zero)
SELECTCC_ZERO(quad,   int32_t,     quad_32_zero)
SELECTCC_ZERO(quad,  uint32_t,     quad_u32_zero)
SELECTCC_ZERO(quad,   int64_t,     quad_64_zero)
SELECTCC_ZERO(quad,  uint64_t,     quad_u64_zero)
SELECTCC_ZERO(quad,   int128_t,    quad_128_zero)
SELECTCC_ZERO(quad,  uint128_t,    quad_u128_zero)
SELECTCC_ZERO(quad,   float,       quad_float_zero)
SELECTCC_ZERO(quad,   double,      quad_double_zero)
SELECTCC_ZERO(quad,   quad,        quad_quad_zero)
SELECTCC_ZERO(quad,   fcomp,       quad_fcomp_zero)
SELECTCC_ZERO(quad,   dcomp,       quad_dcomp_zero)
SELECTCC_ZERO(quad,   qcomp,       quad_qcomp_zero)


/* Compare function between variable and immediate value of "I" */
SELECTCC_I(quad,   int1_t,      quad_1_i)
SELECTCC_I(quad,   int8_t,      quad_8_i)
SELECTCC_I(quad,  uint8_t,      quad_u8_i)
SELECTCC_I(quad,   int16_t,     quad_16_i)
SELECTCC_I(quad,  uint16_t,     quad_u16_i)
SELECTCC_I(quad,   int32_t,     quad_32_i)
SELECTCC_I(quad,  uint32_t,     quad_u32_i)
SELECTCC_I(quad,   int64_t,     quad_64_i)
SELECTCC_I(quad,  uint64_t,     quad_u64_i)
SELECTCC_I(quad,   int128_t,    quad_128_i)
SELECTCC_I(quad,  uint128_t,    quad_u128_i)
SELECTCC_I(quad,   float,       quad_float_i)
SELECTCC_I(quad,   double,      quad_double_i)
SELECTCC_I(quad,   quad,        quad_quad_i)
SELECTCC_I(quad,   fcomp,       quad_fcomp_i)
SELECTCC_I(quad,   dcomp,       quad_dcomp_i)
SELECTCC_I(quad,   qcomp,       quad_qcomp_i)


/* Compare function between variable and immediate value of "M" */
SELECTCC_M(quad,   int1_t,      quad_1_m)
SELECTCC_M(quad,   int8_t,      quad_8_m)
SELECTCC_M(quad,  uint8_t,      quad_u8_m)
SELECTCC_M(quad,   int16_t,     quad_16_m)
SELECTCC_M(quad,  uint16_t,     quad_u16_m)
SELECTCC_M(quad,   int32_t,     quad_32_m)
SELECTCC_M(quad,  uint32_t,     quad_u32_m)
SELECTCC_M(quad,   int64_t,     quad_64_m)
SELECTCC_M(quad,  uint64_t,     quad_u64_m)
SELECTCC_M(quad,   int128_t,    quad_128_m)
SELECTCC_M(quad,  uint128_t,    quad_u128_m)
SELECTCC_M(quad,   float,       quad_float_m)
SELECTCC_M(quad,   double,      quad_double_m)
SELECTCC_M(quad,   quad,        quad_quad_m)
SELECTCC_M(quad,   fcomp,       quad_fcomp_m)
SELECTCC_M(quad,   dcomp,       quad_dcomp_m)
SELECTCC_M(quad,   qcomp,       quad_qcomp_m)

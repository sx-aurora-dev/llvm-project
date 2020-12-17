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

/* === uint32_t === */

/* Compare function between variables */
SELECTCC(uint32_t,   int1_t,      u32_1)
SELECTCC(uint32_t,   int8_t,      u32_8)
SELECTCC(uint32_t,  uint8_t,      u32_u8)
SELECTCC(uint32_t,   int16_t,     u32_16)
SELECTCC(uint32_t,  uint16_t,     u32_u16)
SELECTCC(uint32_t,   int32_t,     u32_32)
SELECTCC(uint32_t,  uint32_t,     u32_u32)
SELECTCC(uint32_t,   int64_t,     u32_64)
SELECTCC(uint32_t,  uint64_t,     u32_u64)
SELECTCC(uint32_t,   int128_t,    u32_128)
SELECTCC(uint32_t,  uint128_t,    u32_u128)
SELECTCC(uint32_t,   float,       u32_float)
SELECTCC(uint32_t,   double,      u32_double)
SELECTCC(uint32_t,   quad,        u32_quad)
SELECTCC(uint32_t,   fcomp,       u32_fcomp)
SELECTCC(uint32_t,   dcomp,       u32_dcomp)
SELECTCC(uint32_t,   qcomp,       u32_qcomp)


/* Compare function between variable and zero */
SELECTCC_ZERO(uint32_t,   int1_t,      u32_1_zero)
SELECTCC_ZERO(uint32_t,   int8_t,      u32_8_zero)
SELECTCC_ZERO(uint32_t,  uint8_t,      u32_u8_zero)
SELECTCC_ZERO(uint32_t,   int16_t,     u32_16_zero)
SELECTCC_ZERO(uint32_t,  uint16_t,     u32_u16_zero)
SELECTCC_ZERO(uint32_t,   int32_t,     u32_32_zero)
SELECTCC_ZERO(uint32_t,  uint32_t,     u32_u32_zero)
SELECTCC_ZERO(uint32_t,   int64_t,     u32_64_zero)
SELECTCC_ZERO(uint32_t,  uint64_t,     u32_u64_zero)
SELECTCC_ZERO(uint32_t,   int128_t,    u32_128_zero)
SELECTCC_ZERO(uint32_t,  uint128_t,    u32_u128_zero)
SELECTCC_ZERO(uint32_t,   float,       u32_float_zero)
SELECTCC_ZERO(uint32_t,   double,      u32_double_zero)
SELECTCC_ZERO(uint32_t,   quad,        u32_quad_zero)
SELECTCC_ZERO(uint32_t,   fcomp,       u32_fcomp_zero)
SELECTCC_ZERO(uint32_t,   dcomp,       u32_dcomp_zero)
SELECTCC_ZERO(uint32_t,   qcomp,       u32_qcomp_zero)


/* Compare function between variable and immediate value of "I" */
SELECTCC_I(uint32_t,   int1_t,      u32_1_i)
SELECTCC_I(uint32_t,   int8_t,      u32_8_i)
SELECTCC_I(uint32_t,  uint8_t,      u32_u8_i)
SELECTCC_I(uint32_t,   int16_t,     u32_16_i)
SELECTCC_I(uint32_t,  uint16_t,     u32_u16_i)
SELECTCC_I(uint32_t,   int32_t,     u32_32_i)
SELECTCC_I(uint32_t,  uint32_t,     u32_u32_i)
SELECTCC_I(uint32_t,   int64_t,     u32_64_i)
SELECTCC_I(uint32_t,  uint64_t,     u32_u64_i)
SELECTCC_I(uint32_t,   int128_t,    u32_128_i)
SELECTCC_I(uint32_t,  uint128_t,    u32_u128_i)
SELECTCC_I(uint32_t,   float,       u32_float_i)
SELECTCC_I(uint32_t,   double,      u32_double_i)
SELECTCC_I(uint32_t,   quad,        u32_quad_i)
SELECTCC_I(uint32_t,   fcomp,       u32_fcomp_i)
SELECTCC_I(uint32_t,   dcomp,       u32_dcomp_i)
SELECTCC_I(uint32_t,   qcomp,       u32_qcomp_i)


/* Compare function between variable and immediate value of "M" */
SELECTCC_M(uint32_t,   int1_t,      u32_1_m)
SELECTCC_M(uint32_t,   int8_t,      u32_8_m)
SELECTCC_M(uint32_t,  uint8_t,      u32_u8_m)
SELECTCC_M(uint32_t,   int16_t,     u32_16_m)
SELECTCC_M(uint32_t,  uint16_t,     u32_u16_m)
SELECTCC_M(uint32_t,   int32_t,     u32_32_m)
SELECTCC_M(uint32_t,  uint32_t,     u32_u32_m)
SELECTCC_M(uint32_t,   int64_t,     u32_64_m)
SELECTCC_M(uint32_t,  uint64_t,     u32_u64_m)
SELECTCC_M(uint32_t,   int128_t,    u32_128_m)
SELECTCC_M(uint32_t,  uint128_t,    u32_u128_m)
SELECTCC_M(uint32_t,   float,       u32_float_m)
SELECTCC_M(uint32_t,   double,      u32_double_m)
SELECTCC_M(uint32_t,   quad,        u32_quad_m)
SELECTCC_M(uint32_t,   fcomp,       u32_fcomp_m)
SELECTCC_M(uint32_t,   dcomp,       u32_dcomp_m)
SELECTCC_M(uint32_t,   qcomp,       u32_qcomp_m)

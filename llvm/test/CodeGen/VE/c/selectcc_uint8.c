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

/* === uint8_t === */

/* Compare function between variables */
SELECTCC(uint8_t,   int1_t,      u8_1)
SELECTCC(uint8_t,   int8_t,      u8_8)
SELECTCC(uint8_t,  uint8_t,      u8_u8)
SELECTCC(uint8_t,   int16_t,     u8_16)
SELECTCC(uint8_t,  uint16_t,     u8_u16)
SELECTCC(uint8_t,   int32_t,     u8_32)
SELECTCC(uint8_t,  uint32_t,     u8_u32)
SELECTCC(uint8_t,   int64_t,     u8_64)
SELECTCC(uint8_t,  uint64_t,     u8_u64)
SELECTCC(uint8_t,   int128_t,    u8_128)
SELECTCC(uint8_t,  uint128_t,    u8_u128)
SELECTCC(uint8_t,   float,       u8_float)
SELECTCC(uint8_t,   double,      u8_double)
SELECTCC(uint8_t,   quad,        u8_quad)
SELECTCC(uint8_t,   fcomp,       u8_fcomp)
SELECTCC(uint8_t,   dcomp,       u8_dcomp)
SELECTCC(uint8_t,   qcomp,       u8_qcomp)


/* Compare function between variable and zero */
SELECTCC_ZERO(uint8_t,   int1_t,      u8_1_zero)
SELECTCC_ZERO(uint8_t,   int8_t,      u8_8_zero)
SELECTCC_ZERO(uint8_t,  uint8_t,      u8_u8_zero)
SELECTCC_ZERO(uint8_t,   int16_t,     u8_16_zero)
SELECTCC_ZERO(uint8_t,  uint16_t,     u8_u16_zero)
SELECTCC_ZERO(uint8_t,   int32_t,     u8_32_zero)
SELECTCC_ZERO(uint8_t,  uint32_t,     u8_u32_zero)
SELECTCC_ZERO(uint8_t,   int64_t,     u8_64_zero)
SELECTCC_ZERO(uint8_t,  uint64_t,     u8_u64_zero)
SELECTCC_ZERO(uint8_t,   int128_t,    u8_128_zero)
SELECTCC_ZERO(uint8_t,  uint128_t,    u8_u128_zero)
SELECTCC_ZERO(uint8_t,   float,       u8_float_zero)
SELECTCC_ZERO(uint8_t,   double,      u8_double_zero)
SELECTCC_ZERO(uint8_t,   quad,        u8_quad_zero)
SELECTCC_ZERO(uint8_t,   fcomp,       u8_fcomp_zero)
SELECTCC_ZERO(uint8_t,   dcomp,       u8_dcomp_zero)
SELECTCC_ZERO(uint8_t,   qcomp,       u8_qcomp_zero)


/* Compare function between variable and immediate value of "I" */
SELECTCC_I(uint8_t,   int1_t,      u8_1_i)
SELECTCC_I(uint8_t,   int8_t,      u8_8_i)
SELECTCC_I(uint8_t,  uint8_t,      u8_u8_i)
SELECTCC_I(uint8_t,   int16_t,     u8_16_i)
SELECTCC_I(uint8_t,  uint16_t,     u8_u16_i)
SELECTCC_I(uint8_t,   int32_t,     u8_32_i)
SELECTCC_I(uint8_t,  uint32_t,     u8_u32_i)
SELECTCC_I(uint8_t,   int64_t,     u8_64_i)
SELECTCC_I(uint8_t,  uint64_t,     u8_u64_i)
SELECTCC_I(uint8_t,   int128_t,    u8_128_i)
SELECTCC_I(uint8_t,  uint128_t,    u8_u128_i)
SELECTCC_I(uint8_t,   float,       u8_float_i)
SELECTCC_I(uint8_t,   double,      u8_double_i)
SELECTCC_I(uint8_t,   quad,        u8_quad_i)
SELECTCC_I(uint8_t,   fcomp,       u8_fcomp_i)
SELECTCC_I(uint8_t,   dcomp,       u8_dcomp_i)
SELECTCC_I(uint8_t,   qcomp,       u8_qcomp_i)


/* Compare function between variable and immediate value of "M" */
SELECTCC_M(uint8_t,   int1_t,      u8_1_m)
SELECTCC_M(uint8_t,   int8_t,      u8_8_m)
SELECTCC_M(uint8_t,  uint8_t,      u8_u8_m)
SELECTCC_M(uint8_t,   int16_t,     u8_16_m)
SELECTCC_M(uint8_t,  uint16_t,     u8_u16_m)
SELECTCC_M(uint8_t,   int32_t,     u8_32_m)
SELECTCC_M(uint8_t,  uint32_t,     u8_u32_m)
SELECTCC_M(uint8_t,   int64_t,     u8_64_m)
SELECTCC_M(uint8_t,  uint64_t,     u8_u64_m)
SELECTCC_M(uint8_t,   int128_t,    u8_128_m)
SELECTCC_M(uint8_t,  uint128_t,    u8_u128_m)
SELECTCC_M(uint8_t,   float,       u8_float_m)
SELECTCC_M(uint8_t,   double,      u8_double_m)
SELECTCC_M(uint8_t,   quad,        u8_quad_m)
SELECTCC_M(uint8_t,   fcomp,       u8_fcomp_m)
SELECTCC_M(uint8_t,   dcomp,       u8_dcomp_m)
SELECTCC_M(uint8_t,   qcomp,       u8_qcomp_m)

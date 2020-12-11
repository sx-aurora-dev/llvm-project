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
typedef _Complex float fcomp;
typedef _Complex double dcomp;
typedef _Complex long double qcomp;


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

/* === dcomp === */

/* Compare function between variables */
SELECTCC(dcomp,   int1_t,      dcomp_1)
SELECTCC(dcomp,   int8_t,      dcomp_8)
SELECTCC(dcomp,  uint8_t,      dcomp_u8)
SELECTCC(dcomp,   int16_t,     dcomp_16)
SELECTCC(dcomp,  uint16_t,     dcomp_u16)
SELECTCC(dcomp,   int32_t,     dcomp_32)
SELECTCC(dcomp,  uint32_t,     dcomp_u32)
SELECTCC(dcomp,   int64_t,     dcomp_64)
SELECTCC(dcomp,  uint64_t,     dcomp_u64)
SELECTCC(dcomp,   int128_t,    dcomp_128)
SELECTCC(dcomp,  uint128_t,    dcomp_u128)
SELECTCC(dcomp,   float,       dcomp_float)
SELECTCC(dcomp,   double,      dcomp_double)
SELECTCC(dcomp,   quad,        dcomp_quad)
SELECTCC(dcomp,   fcomp,       dcomp_fcomp)
SELECTCC(dcomp,   dcomp,       dcomp_dcomp)
SELECTCC(dcomp,   qcomp,       dcomp_qcomp)


/* Compare function between variable and zero */
SELECTCC_ZERO(dcomp,   int1_t,      dcomp_1_zero)
SELECTCC_ZERO(dcomp,   int8_t,      dcomp_8_zero)
SELECTCC_ZERO(dcomp,  uint8_t,      dcomp_u8_zero)
SELECTCC_ZERO(dcomp,   int16_t,     dcomp_16_zero)
SELECTCC_ZERO(dcomp,  uint16_t,     dcomp_u16_zero)
SELECTCC_ZERO(dcomp,   int32_t,     dcomp_32_zero)
SELECTCC_ZERO(dcomp,  uint32_t,     dcomp_u32_zero)
SELECTCC_ZERO(dcomp,   int64_t,     dcomp_64_zero)
SELECTCC_ZERO(dcomp,  uint64_t,     dcomp_u64_zero)
SELECTCC_ZERO(dcomp,   int128_t,    dcomp_128_zero)
SELECTCC_ZERO(dcomp,  uint128_t,    dcomp_u128_zero)
SELECTCC_ZERO(dcomp,   float,       dcomp_float_zero)
SELECTCC_ZERO(dcomp,   double,      dcomp_double_zero)
SELECTCC_ZERO(dcomp,   quad,        dcomp_quad_zero)
SELECTCC_ZERO(dcomp,   fcomp,       dcomp_fcomp_zero)
SELECTCC_ZERO(dcomp,   dcomp,       dcomp_dcomp_zero)
SELECTCC_ZERO(dcomp,   qcomp,       dcomp_qcomp_zero)


/* Compare function between variable and immediate value of "I" */
SELECTCC_I(dcomp,   int1_t,      dcomp_1_i)
SELECTCC_I(dcomp,   int8_t,      dcomp_8_i)
SELECTCC_I(dcomp,  uint8_t,      dcomp_u8_i)
SELECTCC_I(dcomp,   int16_t,     dcomp_16_i)
SELECTCC_I(dcomp,  uint16_t,     dcomp_u16_i)
SELECTCC_I(dcomp,   int32_t,     dcomp_32_i)
SELECTCC_I(dcomp,  uint32_t,     dcomp_u32_i)
SELECTCC_I(dcomp,   int64_t,     dcomp_64_i)
SELECTCC_I(dcomp,  uint64_t,     dcomp_u64_i)
SELECTCC_I(dcomp,   int128_t,    dcomp_128_i)
SELECTCC_I(dcomp,  uint128_t,    dcomp_u128_i)
SELECTCC_I(dcomp,   float,       dcomp_float_i)
SELECTCC_I(dcomp,   double,      dcomp_double_i)
SELECTCC_I(dcomp,   quad,        dcomp_quad_i)
SELECTCC_I(dcomp,   fcomp,       dcomp_fcomp_i)
SELECTCC_I(dcomp,   dcomp,       dcomp_dcomp_i)
SELECTCC_I(dcomp,   qcomp,       dcomp_qcomp_i)


/* Compare function between variable and immediate value of "M" */
SELECTCC_M(dcomp,   int1_t,      dcomp_1_m)
SELECTCC_M(dcomp,   int8_t,      dcomp_8_m)
SELECTCC_M(dcomp,  uint8_t,      dcomp_u8_m)
SELECTCC_M(dcomp,   int16_t,     dcomp_16_m)
SELECTCC_M(dcomp,  uint16_t,     dcomp_u16_m)
SELECTCC_M(dcomp,   int32_t,     dcomp_32_m)
SELECTCC_M(dcomp,  uint32_t,     dcomp_u32_m)
SELECTCC_M(dcomp,   int64_t,     dcomp_64_m)
SELECTCC_M(dcomp,  uint64_t,     dcomp_u64_m)
SELECTCC_M(dcomp,   int128_t,    dcomp_128_m)
SELECTCC_M(dcomp,  uint128_t,    dcomp_u128_m)
SELECTCC_M(dcomp,   float,       dcomp_float_m)
SELECTCC_M(dcomp,   double,      dcomp_double_m)
SELECTCC_M(dcomp,   quad,        dcomp_quad_m)
SELECTCC_M(dcomp,   fcomp,       dcomp_fcomp_m)
SELECTCC_M(dcomp,   dcomp,       dcomp_dcomp_m)
SELECTCC_M(dcomp,   qcomp,       dcomp_qcomp_m)


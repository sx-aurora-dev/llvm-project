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

/* === float === */

/* Compare function between variables */
SELECTCC(float,   int1_t,      float_1)
SELECTCC(float,   int8_t,      float_8)
SELECTCC(float,  uint8_t,      float_u8)
SELECTCC(float,   int16_t,     float_16)
SELECTCC(float,  uint16_t,     float_u16)
SELECTCC(float,   int32_t,     float_32)
SELECTCC(float,  uint32_t,     float_u32)
SELECTCC(float,   int64_t,     float_64)
SELECTCC(float,  uint64_t,     float_u64)
SELECTCC(float,   int128_t,    float_128)
SELECTCC(float,  uint128_t,    float_u128)
SELECTCC(float,   float,       float_float)
SELECTCC(float,   double,      float_double)
SELECTCC(float,   quad,        float_quad)
SELECTCC(float,   fcomp,       float_fcomp)
SELECTCC(float,   dcomp,       float_dcomp)
SELECTCC(float,   qcomp,       float_qcomp)


/* Compare function between variable and zero */
SELECTCC_ZERO(float,   int1_t,      float_1_zero)
SELECTCC_ZERO(float,   int8_t,      float_8_zero)
SELECTCC_ZERO(float,  uint8_t,      float_u8_zero)
SELECTCC_ZERO(float,   int16_t,     float_16_zero)
SELECTCC_ZERO(float,  uint16_t,     float_u16_zero)
SELECTCC_ZERO(float,   int32_t,     float_32_zero)
SELECTCC_ZERO(float,  uint32_t,     float_u32_zero)
SELECTCC_ZERO(float,   int64_t,     float_64_zero)
SELECTCC_ZERO(float,  uint64_t,     float_u64_zero)
SELECTCC_ZERO(float,   int128_t,    float_128_zero)
SELECTCC_ZERO(float,  uint128_t,    float_u128_zero)
SELECTCC_ZERO(float,   float,       float_float_zero)
SELECTCC_ZERO(float,   double,      float_double_zero)
SELECTCC_ZERO(float,   quad,        float_quad_zero)
SELECTCC_ZERO(float,   fcomp,       float_fcomp_zero)
SELECTCC_ZERO(float,   dcomp,       float_dcomp_zero)
SELECTCC_ZERO(float,   qcomp,       float_qcomp_zero)


/* Compare function between variable and immediate value of "I" */
SELECTCC_I(float,   int1_t,      float_1_i)
SELECTCC_I(float,   int8_t,      float_8_i)
SELECTCC_I(float,  uint8_t,      float_u8_i)
SELECTCC_I(float,   int16_t,     float_16_i)
SELECTCC_I(float,  uint16_t,     float_u16_i)
SELECTCC_I(float,   int32_t,     float_32_i)
SELECTCC_I(float,  uint32_t,     float_u32_i)
SELECTCC_I(float,   int64_t,     float_64_i)
SELECTCC_I(float,  uint64_t,     float_u64_i)
SELECTCC_I(float,   int128_t,    float_128_i)
SELECTCC_I(float,  uint128_t,    float_u128_i)
SELECTCC_I(float,   float,       float_float_i)
SELECTCC_I(float,   double,      float_double_i)
SELECTCC_I(float,   quad,        float_quad_i)
SELECTCC_I(float,   fcomp,       float_fcomp_i)
SELECTCC_I(float,   dcomp,       float_dcomp_i)
SELECTCC_I(float,   qcomp,       float_qcomp_i)


/* Compare function between variable and immediate value of "M" */
SELECTCC_M(float,   int1_t,      float_1_m)
SELECTCC_M(float,   int8_t,      float_8_m)
SELECTCC_M(float,  uint8_t,      float_u8_m)
SELECTCC_M(float,   int16_t,     float_16_m)
SELECTCC_M(float,  uint16_t,     float_u16_m)
SELECTCC_M(float,   int32_t,     float_32_m)
SELECTCC_M(float,  uint32_t,     float_u32_m)
SELECTCC_M(float,   int64_t,     float_64_m)
SELECTCC_M(float,  uint64_t,     float_u64_m)
SELECTCC_M(float,   int128_t,    float_128_m)
SELECTCC_M(float,  uint128_t,    float_u128_m)
SELECTCC_M(float,   float,       float_float_m)
SELECTCC_M(float,   double,      float_double_m)
SELECTCC_M(float,   quad,        float_quad_m)
SELECTCC_M(float,   fcomp,       float_fcomp_m)
SELECTCC_M(float,   dcomp,       float_dcomp_m)
SELECTCC_M(float,   qcomp,       float_qcomp_m)

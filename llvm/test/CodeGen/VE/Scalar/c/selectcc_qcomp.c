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

/* === qcomp === */

/* Compare function between variables */
SELECTCC(qcomp,   int1_t,      qcomp_1)
SELECTCC(qcomp,   int8_t,      qcomp_8)
SELECTCC(qcomp,  uint8_t,      qcomp_u8)
SELECTCC(qcomp,   int16_t,     qcomp_16)
SELECTCC(qcomp,  uint16_t,     qcomp_u16)
SELECTCC(qcomp,   int32_t,     qcomp_32)
SELECTCC(qcomp,  uint32_t,     qcomp_u32)
SELECTCC(qcomp,   int64_t,     qcomp_64)
SELECTCC(qcomp,  uint64_t,     qcomp_u64)
SELECTCC(qcomp,   int128_t,    qcomp_128)
SELECTCC(qcomp,  uint128_t,    qcomp_u128)
SELECTCC(qcomp,   float,       qcomp_float)
SELECTCC(qcomp,   double,      qcomp_double)
SELECTCC(qcomp,   quad,        qcomp_quad)
SELECTCC(qcomp,   fcomp,       qcomp_fcomp)
SELECTCC(qcomp,   dcomp,       qcomp_dcomp)
SELECTCC(qcomp,   qcomp,       qcomp_qcomp)


/* Compare function between variable and zero */
SELECTCC_ZERO(qcomp,   int1_t,      qcomp_1_zero)
SELECTCC_ZERO(qcomp,   int8_t,      qcomp_8_zero)
SELECTCC_ZERO(qcomp,  uint8_t,      qcomp_u8_zero)
SELECTCC_ZERO(qcomp,   int16_t,     qcomp_16_zero)
SELECTCC_ZERO(qcomp,  uint16_t,     qcomp_u16_zero)
SELECTCC_ZERO(qcomp,   int32_t,     qcomp_32_zero)
SELECTCC_ZERO(qcomp,  uint32_t,     qcomp_u32_zero)
SELECTCC_ZERO(qcomp,   int64_t,     qcomp_64_zero)
SELECTCC_ZERO(qcomp,  uint64_t,     qcomp_u64_zero)
SELECTCC_ZERO(qcomp,   int128_t,    qcomp_128_zero)
SELECTCC_ZERO(qcomp,  uint128_t,    qcomp_u128_zero)
SELECTCC_ZERO(qcomp,   float,       qcomp_float_zero)
SELECTCC_ZERO(qcomp,   double,      qcomp_double_zero)
SELECTCC_ZERO(qcomp,   quad,        qcomp_quad_zero)
SELECTCC_ZERO(qcomp,   fcomp,       qcomp_fcomp_zero)
SELECTCC_ZERO(qcomp,   dcomp,       qcomp_dcomp_zero)
SELECTCC_ZERO(qcomp,   qcomp,       qcomp_qcomp_zero)


/* Compare function between variable and immediate value of "I" */
SELECTCC_I(qcomp,   int1_t,      qcomp_1_i)
SELECTCC_I(qcomp,   int8_t,      qcomp_8_i)
SELECTCC_I(qcomp,  uint8_t,      qcomp_u8_i)
SELECTCC_I(qcomp,   int16_t,     qcomp_16_i)
SELECTCC_I(qcomp,  uint16_t,     qcomp_u16_i)
SELECTCC_I(qcomp,   int32_t,     qcomp_32_i)
SELECTCC_I(qcomp,  uint32_t,     qcomp_u32_i)
SELECTCC_I(qcomp,   int64_t,     qcomp_64_i)
SELECTCC_I(qcomp,  uint64_t,     qcomp_u64_i)
SELECTCC_I(qcomp,   int128_t,    qcomp_128_i)
SELECTCC_I(qcomp,  uint128_t,    qcomp_u128_i)
SELECTCC_I(qcomp,   float,       qcomp_float_i)
SELECTCC_I(qcomp,   double,      qcomp_double_i)
SELECTCC_I(qcomp,   quad,        qcomp_quad_i)
SELECTCC_I(qcomp,   fcomp,       qcomp_fcomp_i)
SELECTCC_I(qcomp,   dcomp,       qcomp_dcomp_i)
SELECTCC_I(qcomp,   qcomp,       qcomp_qcomp_i)


/* Compare function between variable and immediate value of "M" */
SELECTCC_M(qcomp,   int1_t,      qcomp_1_m)
SELECTCC_M(qcomp,   int8_t,      qcomp_8_m)
SELECTCC_M(qcomp,  uint8_t,      qcomp_u8_m)
SELECTCC_M(qcomp,   int16_t,     qcomp_16_m)
SELECTCC_M(qcomp,  uint16_t,     qcomp_u16_m)
SELECTCC_M(qcomp,   int32_t,     qcomp_32_m)
SELECTCC_M(qcomp,  uint32_t,     qcomp_u32_m)
SELECTCC_M(qcomp,   int64_t,     qcomp_64_m)
SELECTCC_M(qcomp,  uint64_t,     qcomp_u64_m)
SELECTCC_M(qcomp,   int128_t,    qcomp_128_m)
SELECTCC_M(qcomp,  uint128_t,    qcomp_u128_m)
SELECTCC_M(qcomp,   float,       qcomp_float_m)
SELECTCC_M(qcomp,   double,      qcomp_double_m)
SELECTCC_M(qcomp,   quad,        qcomp_quad_m)
SELECTCC_M(qcomp,   fcomp,       qcomp_fcomp_m)
SELECTCC_M(qcomp,   dcomp,       qcomp_dcomp_m)
SELECTCC_M(qcomp,   qcomp,       qcomp_qcomp_m)

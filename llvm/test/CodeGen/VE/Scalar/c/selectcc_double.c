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
  return (TYCMP)-2.0 == l ? a : b; \
}

/* === double === */

/* Compare function between variables */
SELECTCC(double,   int1_t,      double_1)
SELECTCC(double,   int8_t,      double_8)
SELECTCC(double,  uint8_t,      double_u8)
SELECTCC(double,   int16_t,     double_16)
SELECTCC(double,  uint16_t,     double_u16)
SELECTCC(double,   int32_t,     double_32)
SELECTCC(double,  uint32_t,     double_u32)
SELECTCC(double,   int64_t,     double_64)
SELECTCC(double,  uint64_t,     double_u64)
SELECTCC(double,   int128_t,    double_128)
SELECTCC(double,  uint128_t,    double_u128)
SELECTCC(double,   float,       double_float)
SELECTCC(double,   double,      double_double)
SELECTCC(double,   quad,        double_quad)
SELECTCC(double,   fcomp,       double_fcomp)
SELECTCC(double,   dcomp,       double_dcomp)
SELECTCC(double,   qcomp,       double_qcomp)


/* Compare function between variable and zero */
SELECTCC_ZERO(double,   int1_t,      double_1_zero)
SELECTCC_ZERO(double,   int8_t,      double_8_zero)
SELECTCC_ZERO(double,  uint8_t,      double_u8_zero)
SELECTCC_ZERO(double,   int16_t,     double_16_zero)
SELECTCC_ZERO(double,  uint16_t,     double_u16_zero)
SELECTCC_ZERO(double,   int32_t,     double_32_zero)
SELECTCC_ZERO(double,  uint32_t,     double_u32_zero)
SELECTCC_ZERO(double,   int64_t,     double_64_zero)
SELECTCC_ZERO(double,  uint64_t,     double_u64_zero)
SELECTCC_ZERO(double,   int128_t,    double_128_zero)
SELECTCC_ZERO(double,  uint128_t,    double_u128_zero)
SELECTCC_ZERO(double,   float,       double_float_zero)
SELECTCC_ZERO(double,   double,      double_double_zero)
SELECTCC_ZERO(double,   quad,        double_quad_zero)
SELECTCC_ZERO(double,   fcomp,       double_fcomp_zero)
SELECTCC_ZERO(double,   dcomp,       double_dcomp_zero)
SELECTCC_ZERO(double,   qcomp,       double_qcomp_zero)


/* Compare function between variable and immediate value of "I" */
SELECTCC_I(double,   int1_t,      double_1_i)
SELECTCC_I(double,   int8_t,      double_8_i)
SELECTCC_I(double,  uint8_t,      double_u8_i)
SELECTCC_I(double,   int16_t,     double_16_i)
SELECTCC_I(double,  uint16_t,     double_u16_i)
SELECTCC_I(double,   int32_t,     double_32_i)
SELECTCC_I(double,  uint32_t,     double_u32_i)
SELECTCC_I(double,   int64_t,     double_64_i)
SELECTCC_I(double,  uint64_t,     double_u64_i)
SELECTCC_I(double,   int128_t,    double_128_i)
SELECTCC_I(double,  uint128_t,    double_u128_i)
SELECTCC_I(double,   float,       double_float_i)
SELECTCC_I(double,   double,      double_double_i)
SELECTCC_I(double,   quad,        double_quad_i)
SELECTCC_I(double,   fcomp,       double_fcomp_i)
SELECTCC_I(double,   dcomp,       double_dcomp_i)
SELECTCC_I(double,   qcomp,       double_qcomp_i)


/* Compare function between variable and immediate value of "M" */
SELECTCC_M(double,   int1_t,      double_1_m)
SELECTCC_M(double,   int8_t,      double_8_m)
SELECTCC_M(double,  uint8_t,      double_u8_m)
SELECTCC_M(double,   int16_t,     double_16_m)
SELECTCC_M(double,  uint16_t,     double_u16_m)
SELECTCC_M(double,   int32_t,     double_32_m)
SELECTCC_M(double,  uint32_t,     double_u32_m)
SELECTCC_M(double,   int64_t,     double_64_m)
SELECTCC_M(double,  uint64_t,     double_u64_m)
SELECTCC_M(double,   int128_t,    double_128_m)
SELECTCC_M(double,  uint128_t,    double_u128_m)
SELECTCC_M(double,   float,       double_float_m)
SELECTCC_M(double,   double,      double_double_m)
SELECTCC_M(double,   quad,        double_quad_m)
SELECTCC_M(double,   fcomp,       double_fcomp_m)
SELECTCC_M(double,   dcomp,       double_dcomp_m)
SELECTCC_M(double,   qcomp,       double_qcomp_m)

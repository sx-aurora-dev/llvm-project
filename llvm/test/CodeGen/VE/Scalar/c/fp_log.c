#include <math.h>
#include <complex.h>
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

#define FP_LOGF_VAR(TY) \
TY func_fp_logf_var_ ## TY(TY a) { \
  return logf(a); \
}
FP_LOGF_VAR(float)

#define FP_CLOGF_VAR(TY) \
TY func_fp_clogf_var_ ## TY(TY a) { \
  return clogf(a); \
}
FP_CLOGF_VAR(fcomp)

#define FP_LOG_VAR(TY) \
TY func_fp_log_var_ ## TY(TY a) { \
  return log(a); \
}
FP_LOG_VAR(double)

#define FP_CLOG_VAR(TY) \
TY func_fp_clog_var_ ## TY(TY a) { \
  return clog(a); \
}
FP_CLOG_VAR(dcomp)

#define FP_LOGL_VAR(TY) \
TY func_fp_logl_var_ ## TY(TY a) { \
  return logl(a); \
}
FP_LOGL_VAR(quad)

#define FP_CLOGL_VAR(TY) \
TY func_fp_clogl_var_ ## TY(TY a) { \
  return clogl(a); \
}
FP_CLOGL_VAR(qcomp)

#define FP_LOGF_ZERO(TY) \
TY func_fp_logf_zero_ ## TY() { \
  return  logf((TY)0.0) ; \
}
FP_LOGF_ZERO(float)

#define FP_CLOGF_ZERO(TY) \
TY func_fp_clogf_zero_ ## TY() { \
  return  clogf((TY)0.0) ; \
}
FP_CLOGF_ZERO(fcomp)

#define FP_LOG_ZERO(TY) \
TY func_fp_LOG_zero_ ## TY() { \
  return  log((TY)0.0) ; \
}
FP_LOG_ZERO(double)

#define FP_CLOG_ZERO(TY) \
TY func_fp_clog_zero_ ## TY() { \
  return  clog((TY)0.0) ; \
}
FP_CLOG_ZERO(dcomp)

#define FP_LOGL_ZERO(TY) \
TY func_fp_logl_zero_ ## TY() { \
  return  logl((TY)0.0) ; \
}
FP_LOGL_ZERO(quad)

#define FP_CLOGL_ZERO(TY) \
TY func_fp_clogl_zero_ ## TY() { \
  return  clogl((TY)0.0) ; \
}
FP_CLOGL_ZERO(qcomp)

#define FP_LOGF_CONST(TY) \
TY func_fp_logf_const_ ## TY() { \
  return logf((TY)-2.0); \
}
FP_LOGF_CONST(float)

#define FP_CLOGF_CONST(TY) \
TY func_fp_clogf_const_ ## TY() { \
  return clogf((TY)-2.0); \
}
FP_CLOGF_CONST(fcomp)

#define FP_LOG_CONST(TY) \
TY func_fp_log_const_ ## TY() { \
  return log((TY)-2.0); \
}
FP_LOG_CONST(double)

#define FP_CLOG_CONST(TY) \
TY func_fp_clog_const_ ## TY() { \
  return clog((TY)-2.0); \
}
FP_CLOG_CONST(dcomp)

#define FP_LOGL_CONST(TY) \
TY func_fp_logl_const_ ## TY() { \
  return logl((TY)-2.0); \
}
FP_LOGL_CONST(quad)

#define FP_CLOGL_CONST(TY) \
TY func_fp_clogl_const_ ## TY() { \
  return clogl((TY)-2.0); \
}
FP_CLOGL_CONST(qcomp)

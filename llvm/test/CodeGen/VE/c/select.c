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

#define SELECT(TY) \
TY func_ ## TY(_Bool cmp, TY a, TY b) { \
  return cmp ? a : b; \
}

#if 1
SELECT(int1_t)
SELECT(int8_t)
SELECT(uint8_t)
SELECT(int16_t)
SELECT(uint16_t)
SELECT(int32_t)
SELECT(uint32_t)
SELECT(int64_t)
SELECT(uint64_t)
SELECT(int128_t)
SELECT(uint128_t)
SELECT(float)
SELECT(double)
SELECT(quad)
SELECT(fcomp)
SELECT(dcomp)
SELECT(qcomp)
#else
SELECT(quad)
SELECT(double)
SELECT(float)
SELECT(int64_t)
SELECT(int32_t)
SELECT(int1_t)
#endif

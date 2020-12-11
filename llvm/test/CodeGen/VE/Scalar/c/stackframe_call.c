
/// Check stack frame allocation of a function which calls other functions
/// under following conditions and combinations of them:
///   - access variable or not
///   - no stack object, a stack object using BP, or a stack object not using BP
///   - isPositionIndependent or not

extern char *fun(char *, char *);
extern char data;

char *test_frame0(char *a, char *b) {
  return fun(a, b);
}

char *test_frame32(char *a) {
  char tmp[32];
  return fun(tmp, a);
}

char *test_align32(int n, char *a) {
  char tmp1[32] __attribute__((aligned(32)));
  char *tmp2 = __builtin_alloca_with_align(n, 256);
  return fun(tmp1, tmp2);
}

char *test_frame0_var(char *a, char *b) {
  *a = data;
  return fun(a, b);
}

char *test_frame32_var(char *a) {
  char tmp[32];
  *tmp = data;
  return fun(tmp, a);
}

char *test_align32_var(int n, char *a) {
  char tmp1[32] __attribute__((aligned(32)));
  char *tmp2 = __builtin_alloca_with_align(n, 256);
  *tmp2 = data;
  return fun(tmp1, tmp2);
}

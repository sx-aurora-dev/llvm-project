
/// Check stack frame allocation of a function which does not calls other
/// functions under following conditions and combinations of them:
///   - access variable or not
///   - no stack object, a stack object using BP, or a stack object not using BP
///   - isPositionIndependent or not

extern char data;

char *test_frame0(char *a, char *b) {
  return b;
}

char *test_frame32(char *a) {
  volatile char tmp[32];
  tmp[0] = *a;
  return tmp;
}

char *test_align32(int n, char *a) {
  char tmp1[32] __attribute__((aligned(32)));
  volatile char *tmp2 = __builtin_alloca_with_align(n, 256);
  tmp1[1] = tmp2[0] = *a;
  return tmp1;
}

char *test_frame0_var(char *a, char *b) {
  *a = data;
  return a;
}

char *test_frame32_var(char *a) {
  volatile char tmp[32];
  *tmp = data;
  return tmp;
}

char *test_align32_var(int n, char *a) {
  char tmp1[32] __attribute__((aligned(32)));
  volatile char *tmp2 = __builtin_alloca_with_align(n, 256);
  tmp1[1] = tmp2[0] = *a;
  return tmp1;
}

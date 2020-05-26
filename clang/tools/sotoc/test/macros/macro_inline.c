// RUN: %sotoc-transform-compile

#define INLINE inline

#pragma omp declare target
INLINE double foo()
{
  return 42;
}
#pragma omp end declare target

int main()
{
  double v;
  int    i;
  #pragma omp target teams distribute parallel for
  for (i = 1; i <= 42; i++) {
    v = foo();
  }
  return 0;
}

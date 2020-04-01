// RUN: %sotoc-transform-compile

#pragma omp declare target
extern int n;
#pragma omp end declare target

void foo()
{
  int k;
  double rhsX[n];

#pragma omp target map(rhsX[:])
  for (k = 0; k < n; k++) {
    rhsX[k] += 1;
  }
}

// RUN: %sotoc-transform-compile
#define N 23

#pragma omp declare target
extern int n;
#pragma omp end declare target

void foo()
{
  int k;
  double rhsX[42][n][N];

#pragma omp target map(rhsX[:][:][:])
  for (k = 0; k < n; k++) {
    rhsX[k][42-23][N-1] += 1;
  }
}

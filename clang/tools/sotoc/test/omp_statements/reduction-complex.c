// RUN: %sotoc-transform-compile
// RUN: %run-on-host | %filecheck %s


#include <stdio.h>

#define N   1000000ll
#define SUM (N * (N-1)/2)

int main (void)
{
  long long a, i;

  #pragma omp target parallel shared(a) private(i) num_threads(10) map(to: a)
  {
    #pragma omp master
    a = 0;

    #pragma omp barrier

    #pragma omp for reduction(+:a)
    for (i = 0; i < N; i++) {
        a += i;
    }

    // The Sum shall be sum:[0:N]
    #pragma omp single
    {
        printf ("%lld", a);
        fflush(0);
    }
  }

  return 0;
}

// CHECK: 499999500000

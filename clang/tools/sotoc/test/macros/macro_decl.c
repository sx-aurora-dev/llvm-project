// RUN: %sotoc-transform-compile

#define N 42

#pragma omp declare target
static int a[N];
#pragma omp end declare target

static void foo() {
  #pragma omp target data map(alloc:a[0:N])
  {
      #pragma omp target
      {;}
  }
}


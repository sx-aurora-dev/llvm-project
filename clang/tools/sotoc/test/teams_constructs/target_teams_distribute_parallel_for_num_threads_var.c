// RUN: %sotoc-transform-compile

#include <omp.h>
#include <stdio.h>

int main() {
  int num_threads_array[] = {1, 10, 100, 10000};
  int num_threads[1024];

  for (int t = 1; t < 8; t++) {

#pragma omp target teams distribute parallel for map(tofrom                    \
                                                     : num_threads)            \
    num_threads(t)
    for (int i = 0; i < 1024; i++) {
      num_threads[i] = omp_get_num_threads();
    }
  }

  for (int nt = 0; nt < 4; nt++) {

#pragma omp target teams distribute parallel for map(tofrom                    \
                                                     : num_threads)            \
    num_threads(num_threads_array[nt])
    for (int i = 0; i < 1024; i++) {
      num_threads[i] = omp_get_num_threads();
    }
  }
}

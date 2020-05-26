// RUN: %sotoc-transform-compile

int main(void) {

  #pragma omp target
  {
    int i;
    int x[10] = {2,3,5,7,11,13,17,23,29,31};
    int y[10] = {31,29,23,17,13,11,7,5,3,2};
    int a = 5;
    int z[10];

    #pragma omp parallel for simd
    for (i = 0; i < 10 ; i++) {
      z[i] = x[i] + a*y[i];
    }
  }

  return 0;
}

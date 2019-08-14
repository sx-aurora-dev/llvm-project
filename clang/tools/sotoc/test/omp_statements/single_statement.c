// RUN: %sotoc-transform-compile

int main(void) {
  int h = 0;

  #pragma omp target
  h += 1;


  return 0;
}

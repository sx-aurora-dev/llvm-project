// RUN: %sotoc-transform-compile

int main(void) {
  int h = 0, j = 0, i = 0;

  #pragma omp target device(0) private(i,j,h)
  {
    h += 1;
    j += 1;
    i += 1;
  }

  return 0;
}

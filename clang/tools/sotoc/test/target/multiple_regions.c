// RUN: %sotoc-transform-compile

int main(void) {
  int h = 0, j = 0, i = 0;

  #pragma omp target
  {
    h += 1;
    j += 1;
    i += 1;
  }

  #pragma omp target
  {
    h += 1;
    j += 1;
    i += 1;
  }

  #pragma omp target
  {
    h += 1;
    j += 1;
    i += 1;
  }

  return 0;
}

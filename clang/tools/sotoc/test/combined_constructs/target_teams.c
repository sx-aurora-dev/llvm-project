// RUN: %sotoc-transform-compile

int main(void) {
  int j = 0;

  #pragma omp target teams
  {
    j++;
  }
  return 0;
}

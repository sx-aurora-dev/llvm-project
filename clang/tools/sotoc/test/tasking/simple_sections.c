// RUN: %sotoc-transform-compile

int main(void) {
  int h = 0;
  int i = 0;


  #pragma omp target
  #pragma omp parallel num_threads(10)
  {
    #pragma omp sections
    {
      #pragma omp section
      {
        h++;
      }

      #pragma omp section
      {
        i++;
      }
    }
  }

  return 0;
}

// RUN: %sotoc-transform-compile

int main(void) {
  int h = 0;
  int i = 0;


  #pragma omp target
  #pragma omp parallel num_threads(10)
  {
    #pragma omp single
    {
      #pragma omp task
      {
        h++;
      }

      #pragma omp task
      {
        i++;
      }
    }
  }

  return 0;
}

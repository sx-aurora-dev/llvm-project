// RUN: %sotoc-transform-compile


int task(int n) {
  if (n < 15) return 0;

  #pragma omp task
  task(n--);

  return 0;

}

int main(void) {

  #pragma omp target
  #pragma omp parallel num_threads(10)
  {
    #pragma omp single
    {
      #pragma omp task
      {
        task(10);
      }

      #pragma omp task
      {
        task(20);
      }

      #pragma omp taskwait
    }
  }
}

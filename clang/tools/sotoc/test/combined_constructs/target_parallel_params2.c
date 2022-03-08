// RUN: %sotoc-transform-compile

int main() {
  int n = 42;

  #pragma omp target parallel map(n) num_threads(2)
  {
    n++;
  }

  return 0;
}


// RUN: %sotoc-transform-compile

int main() {
  int n = 42;
  int m = 23;
  float f = 42.23;

  #pragma omp target parallel map(n) num_threads(2) if(1) shared(n,m) private(f)  default(shared) proc_bind(spread)
  {
    f = n / m;
  }

  return 0;
}


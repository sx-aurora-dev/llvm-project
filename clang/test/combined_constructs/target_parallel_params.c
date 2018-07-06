// RUN: %sotoc-transform-compile

int main() {
  int n = 42;

  #pragma omp target parallel map(n) reduction(+:n)
  {
    n++;
  }

  return 0;
}


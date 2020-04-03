// RUN: %sotoc-transform-compile

int main() {
  int n = 42;
  int m = 23;
  float f = 42.23;

  #pragma omp target parallel map(n) private(m,f)
  {
    f = n / m;
  }

  return 0;
}


// RUN: %sotoc-transform-compile

int main() {

  #pragma omp target parallel
  {
    // non-empty
  }

  return 0;
}


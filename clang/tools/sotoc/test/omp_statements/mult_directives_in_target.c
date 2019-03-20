// RUN: %sotoc-transform-compile

void foo(int numK, int numX) {
  float expArg;
  float cosArg;
  float sinArg;

  int indexK, indexX;
#pragma omp target 
  {
#pragma omp teams distribute parallel for private(expArg, cosArg, sinArg)
    for (indexX = 0; indexX < numX; indexX++) {
#pragma omp simd private(expArg, cosArg, sinArg)
      for (indexK = 0; indexK < numK; indexK++) {
        expArg = 42;
        cosArg = 42;
        sinArg = 42;
     }
    }
  }
}


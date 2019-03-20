// RUN: %sotoc-transform-compile

#define START for(i=0;i<42; i++){ 
#define END }
 
void foo(){
  int a = 23;
  int i;
  #pragma omp target map(a)
  #pragma omp teams distribute parallel for simd
	START
	END
}


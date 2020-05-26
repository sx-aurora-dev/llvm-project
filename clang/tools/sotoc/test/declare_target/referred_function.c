// RUN: %sotoc-transform-compile
typedef char data_t;
typedef int calc_t;

static inline calc_t ffirst(calc_t first, calc_t second)
{
	return first;
}

static inline calc_t fsecond(calc_t first, calc_t second)
{
	return second;
}

static inline data_t falpha(data_t a)
{
  return a;
}

static int bar(int first, int second, data_t a){
  calc_t one = ffirst((calc_t)first,(calc_t)second);
  calc_t two = fsecond((calc_t)first,(calc_t)second);
  data_t alpha = falpha(a);

  return (int)(one + two + alpha);
}

#pragma omp declare target
static void foo(int first, int second, data_t a){
#pragma omp parallel for
  for (int i=0; i<10; ++i){
    bar(first,second,a);
  }
}
#pragma omp end declare target

int main(){

  calc_t i=0;
  calc_t j=0;
  data_t var='a';

  #pragma omp parallel
  {
    foo(i,j,var);
  }

  return 0;
}

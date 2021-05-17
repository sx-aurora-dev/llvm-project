// RUN: %sotoc-transform-compile


int main() {
  double ux  = 0;
  double tx  = 0;
  double tmp = 0;
  #pragma omp target map(tofrom: tmp)
  {
    // It works with firstprivate
#ifdef NOBUG
    #pragma omp parallel firstprivate(ux) reduction (+: tmp)
#else
    #pragma omp parallel private(ux) reduction (+: tmp)
#endif
    {
      ux = 42;
      tmp += ux;
    }

	
   #pragma omp parallel private(tx) reduction (+: tmp)
   {
     tx = 42;
     tmp += tx;
   }

  }
}

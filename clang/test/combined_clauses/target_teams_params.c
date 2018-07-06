// RUN: %sotoc-transform-compile
#include <omp.h>

// example from IBM knowledge
int main() {

  int res = 0, n = 0;
  #pragma omp target teams num_teams(42) map(res, n) reduction(+:res)
  {
    res = omp_get_team_num();
    if (omp_get_team_num() == 0)
      n = omp_get_num_teams();
  }

  return 0;
}

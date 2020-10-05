void other_function(void) {
  for (int i = 0; i < 120; ++i)
    ;
}

int main(void) {
  other_function();

  int sum = 0;
  for (int i = 0; i < 120; ++i)
    sum += i;
  return sum;
}

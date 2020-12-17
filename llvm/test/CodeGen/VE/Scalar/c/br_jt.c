int br_jt3(int a)
{
  switch (a) {
  case 1: return a+2;
  case 2: return a-2;
  case 4: return a+3;
  default: return a;
  }
}

int br_jt4(int a)
{
  switch (a) {
  case 1: return a+2;
  case 2: return a-2;
  case 3: return a+1;
  case 4: return a+3;
  default: return a;
  }
}

int br_jt7(int a)
{
  switch (a) {
  case 1: return a+2;
  case 2: return a-2;
  case 3: return a+1;
  case 4: return a+3;
  case 7: return a-2;
  case 9: return a+1;
  case 8: return a+3;
  default: return a;
  }
}

int br_jt8(int a)
{
  switch (a) {
  case 1: return a+2;
  case 2: return a-2;
  case 3: return a+1;
  case 4: return a+3;
  case 6: return a-5;
  case 7: return a-2;
  case 9: return a+1;
  case 8: return a+3;
  default: return a;
  }
}

int br_jt3_m(int a, int b)
{
  switch (a) {
  case 1: return a+2;
  case 2: return a-2;
  case 4: return b+3;
  default: return a;
  }
}

int br_jt4_m(int a, int b)
{
  switch (a) {
  case 1: return a+2;
  case 2: return a-2;
  case 3: return a+1;
  case 4: return b+3;
  default: return a;
  }
}

int br_jt7_m(int a, int b)
{
  switch (a) {
  case 1: return a+2;
  case 2: return a-2;
  case 3: return a+1;
  case 4: return b+3;
  case 7: return b-2;
  case 9: return a+1;
  case 8: return a+3;
  default: return a;
  }
}

int br_jt8_m(int a, int b)
{
  switch (a) {
  case 1: return a+2;
  case 2: return a-2;
  case 3: return a+1;
  case 4: return b+3;
  case 6: return b-5;
  case 7: return b-2;
  case 9: return a+1;
  case 8: return a+3;
  default: return a;
  }
}

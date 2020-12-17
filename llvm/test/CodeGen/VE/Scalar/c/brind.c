int brind(int a)
{
  void* ptr = &&label1;
  if (a == 1) ptr = &&label2;
  if (a) ptr = &&label3;
  goto *ptr;
label1:
  return -1;
label2:
  return 1;
label3:
  return 2;
}

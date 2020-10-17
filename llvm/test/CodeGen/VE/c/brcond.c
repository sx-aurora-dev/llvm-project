void brcond_then(_Bool cond) {
  if (cond)
    __asm volatile("nop");
}

void brcond_else(_Bool cond) {
  if (!cond)
    __asm volatile("nop");
}

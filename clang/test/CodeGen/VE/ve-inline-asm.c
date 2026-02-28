// REQUIRES: ve-registered-target
// RUN: %clang_cc1 -triple ve-linux-gnu -emit-llvm -o - %s | FileCheck %s

void r(long v) {
  long b;
  asm("lea %0, 256(%1)"
      : "=r"(b)
      : "r"(v));
  // CHECK: %1 = call i64 asm "lea $0, 256($1)", "=r,r"(i64 %0)
}

void v(char *ptr, char *ptr2) {
  typedef double __vr __attribute__((__vector_size__(2048)));
  __vr a;
  asm("vld %0, 8, %1"
      : "=v"(a)
      : "r"(ptr));
  asm("vst %0, 8, %1"
      :
      : "v"(a), "r"(ptr2));
  // CHECK: %1 = call <256 x double> asm "vld $0, 8, $1", "=v,r"(ptr %0)
  // CHECK: call void asm sideeffect "vst $0, 8, $1", "v,r"(<256 x double> %2, ptr %3)
}

void vm(long val) {
  typedef _Bool __vm __attribute__((ext_vector_type(256)));
  __vm m;
  asm("lvm %0, 0, %1"
      : "=v"(m)
      : "r"(val));
  asm("svm %0, %1, 0"
      : "=r"(val)
      : "v"(m));
  // CHECK: %1 = call <256 x i1> asm "lvm $0, 0, $1", "=v,r"(i64 %0)
  // CHECK: %4 = call i64 asm "svm $0, $1, 0", "=r,v"(<256 x i1> %3)
}

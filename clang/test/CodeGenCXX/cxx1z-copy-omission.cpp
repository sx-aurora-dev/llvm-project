// RUN: %clang_cc1 -std=c++1z -emit-llvm -triple x86_64-linux-gnu -o - %s | FileCheck %s

struct A {
  A(int);
  A(A&&);
  A(const A&);
  ~A();

  operator bool();

  int arr[10];
};

A f();
void h();

// CHECK-LABEL: define {{.*}} @_Z1gv(
void g() {
  // CHECK: %[[A:.*]] = alloca
  // CHECK-NOT: alloca
  // CHECK-NOT: call
  // CHECK: call {{.*}} @_Z1fv(ptr dead_on_unwind writable sret({{.*}}) align 4 %[[A]])
  A a = A( A{ f() } );
  // CHECK-NOT: call

  // CHECK: call void @_Z1hv(
  h();
  // CHECK-NOT: call

  // CHECK: call void @_ZN1AD1Ev(ptr {{[^,]*}} %[[A]])
  // CHECK-NOT: call
  // CHECK-LABEL: }
}

void f(A);

// CHECK-LABEL: define {{.*}} @_Z1hv(
void h() {
  // CHECK: %[[A:.*]] = alloca
  // CHECK-NOT: alloca
  // CHECK-NOT: call

  // CHECK: call {{.*}} @_Z1fv(ptr dead_on_unwind writable sret({{.*}}) align 4 %[[A]])
  // CHECK-NOT: call
  // CHECK: call {{.*}} @_Z1f1A(ptr noundef %[[A]])
  f(f());
  // CHECK-NOT: call
  // CHECK: call void @_ZN1AD1Ev(ptr {{[^,]*}} %[[A]])

  // CHECK: call void @_Z1hv(
  h();

  // CHECK-NOT: call
  // CHECK-LABEL: }
}

// We still pass classes with trivial copy/move constructors and destructors in
// registers, even if the copy is formally omitted.
struct B {
  B(int);
  int n;
};

B fB();
void fB(B);

// CHECK-LABEL: define {{.*}} @_Z1iv(
void i() {
  // CHECK: %[[B:.*]] = alloca
  // CHECK-NOT: alloca
  // CHECK-NOT: call

  // CHECK: %[[B_N:.*]] = call i32 @_Z2fBv()
  // CHECK-NOT: call
  // CHECK: store i32 %[[B_N]],
  // CHECK-NOT: call
  // CHECK: %[[B_N:.*]] = load i32
  // CHECK-NOT: call
  // CHECK: call void @_Z2fB1B(i32 %[[B_N]])
  fB(fB());

  // CHECK-LABEL: }
}

// CHECK-LABEL: define {{.*}} @_Z1jv(
void j() {
  // CHECK:   alloca ptr
  // CHECK:   %[[OUTERTEMP:.*]] = alloca %{{.*}}
  // CHECK:   %[[INNERTEMP:.*]] = alloca %{{.*}}
  // CHECK:   call void @_ZN1AC1Ei(ptr {{.*}} %[[INNERTEMP]], i32 noundef 1)
  // CHECK:   call noundef zeroext i1 @_ZN1AcvbEv(ptr {{.*}} %[[INNERTEMP]])
  // CHECK:   br i1
  //
  // CHECK:   call void @_ZN1AC1EOS_(ptr {{.*}} %[[OUTERTEMP]], ptr {{.*}} %[[INNERTEMP]])
  // CHECK:   br label
  //
  // CHECK:   call void @_ZN1AC1Ei(ptr {{.*}} %[[OUTERTEMP]], i32 noundef 2)
  // CHECK:   br label
  //
  // CHECK:   call void @_ZN1AD1Ev(ptr {{.*}} %[[INNERTEMP]])
  A &&a = A(1) ?: A(2);

  // CHECK:   call void @_Z1iv()
  i();

  // CHECK:   call void @_ZN1AD1Ev(ptr {{.*}} %[[OUTERTEMP]])
}

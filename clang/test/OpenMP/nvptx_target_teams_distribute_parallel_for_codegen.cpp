// Test target codegen - host bc file has to be created first.
// RUN: %clang_cc1 -verify -fopenmp -fopenmp-version=45 -fopenmp-cuda-mode -x c++ -triple powerpc64le-unknown-unknown -fopenmp-targets=nvptx64-nvidia-cuda -emit-llvm-bc %s -o %t-ppc-host.bc
// RUN: %clang_cc1 -verify -fopenmp -fopenmp-version=45 -fopenmp-cuda-mode -x c++ -triple nvptx64-unknown-unknown -fopenmp-targets=nvptx64-nvidia-cuda -emit-llvm %s -fopenmp-is-device -fopenmp-host-ir-file-path %t-ppc-host.bc -o - | FileCheck %s --check-prefix CHECK --check-prefix CHECK-64
// RUN: %clang_cc1 -verify -fopenmp -fopenmp-version=45 -fopenmp-cuda-mode -x c++ -triple i386-unknown-unknown -fopenmp-targets=nvptx-nvidia-cuda -emit-llvm-bc %s -o %t-x86-host.bc
// RUN: %clang_cc1 -verify -fopenmp -fopenmp-version=45 -fopenmp-cuda-mode -x c++ -triple nvptx-unknown-unknown -fopenmp-targets=nvptx-nvidia-cuda -emit-llvm %s -fopenmp-is-device -fopenmp-host-ir-file-path %t-x86-host.bc -o - | FileCheck %s --check-prefix CHECK --check-prefix CHECK-32
// RUN: %clang_cc1 -verify -fopenmp -fopenmp-version=45 -fopenmp-cuda-mode -fexceptions -fcxx-exceptions -x c++ -triple nvptx-unknown-unknown -fopenmp-targets=nvptx-nvidia-cuda -emit-llvm %s -fopenmp-is-device -fopenmp-host-ir-file-path %t-x86-host.bc -o - | FileCheck %s --check-prefix CHECK --check-prefix CHECK-32
// expected-no-diagnostics
#ifndef HEADER
#define HEADER

// Check that the execution mode of the target region with lastprivates on the gpu is set to Non-SPMD Mode.
// CHECK-DAG: {{@__omp_offloading_.+l33}}_exec_mode = weak constant i8 1
// Check that the execution mode of all 4 target regions on the gpu is set to SPMD Mode.
// CHECK-DAG: {{@__omp_offloading_.+l39}}_exec_mode = weak constant i8 0
// CHECK-DAG: {{@__omp_offloading_.+l44}}_exec_mode = weak constant i8 0
// CHECK-DAG: {{@__omp_offloading_.+l49}}_exec_mode = weak constant i8 0
// CHECK-DAG: {{@__omp_offloading_.+l57}}_exec_mode = weak constant i8 0

#define N 1000
#define M 10

template<typename tx>
tx ftemplate(int n) {
  tx a[N];
  short aa[N];
  tx b[10];
  tx c[M][M];
  tx f = n;
  tx l;
  int k;
  tx *v;

#pragma omp target teams distribute parallel for lastprivate(l) dist_schedule(static,128) schedule(static,32)
  for(int i = 0; i < n; i++) {
    a[i] = 1;
    l = i;
  }

  #pragma omp target teams distribute parallel for map(tofrom: aa) num_teams(M) thread_limit(64)
  for(int i = 0; i < n; i++) {
    aa[i] += 1;
  }

#pragma omp target teams distribute parallel for map(tofrom:a, aa, b) if(target: n>40) proc_bind(spread)
  for(int i = 0; i < 10; i++) {
    b[i] += 1;
  }

#pragma omp target teams distribute parallel for collapse(2) firstprivate(f) private(k)
  for(int i = 0; i < M; i++) {
    for(int j = 0; j < M; j++) {
      k = M;
      c[i][j] = i + j * f + k;
    }
  }

#pragma omp target teams distribute parallel for map(a, v[:N])
  for(int i = 0; i < n; i++)
    a[i] = v[i];
  return a[0];
}

int bar(int n){
  int a = 0;

  a += ftemplate<int>(n);

  return a;
}

// CHECK_LABEL: define internal void @__omp_offloading_{{.+}}_l33_worker()

// CHECK-LABEL: define {{.*}}void {{@__omp_offloading_.+}}_l33(
// CHECK: call void @__kmpc_kernel_init(i32 %{{.+}}, i16 1)
// CHECK: call void @__kmpc_for_static_init_4({{.+}}, {{.+}}, {{.+}} 91,
// CHECK: call void @__kmpc_kernel_prepare_parallel(i8* bitcast (void (i16, i32)* [[OUTL1:@__omp_outlined.*]]_wrapper to i8*), i16 1)
// CHECK: call void @__kmpc_for_static_fini(
// CHECK: call void @__kmpc_kernel_deinit(i16 1)
// CHECK: ret void

// CHECK: define internal void [[OUTL1]](
// CHECK: call void @__kmpc_for_static_init_4({{.+}}, {{.+}}, {{.+}} 33,
// CHECK: call void @__kmpc_for_static_fini(
// CHECK: ret void

// CHECK-LABEL: define {{.*}}void {{@__omp_offloading_.+}}(
// CHECK-DAG: [[THREAD_LIMIT:%.+]] = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x()
// CHECK: call void @__kmpc_spmd_kernel_init(i32 [[THREAD_LIMIT]], i16 0, i16 0)
// CHECK: call void @__kmpc_for_static_init_4({{.+}}, {{.+}}, {{.+}} 92,
// CHECK: {{call|invoke}} void [[OUTL2:@.+]](
// CHECK: call void @__kmpc_for_static_fini(
// CHECK: call void @__kmpc_spmd_kernel_deinit()
// CHECK: ret void

// CHECK: define internal void [[OUTL2]](
// CHECK: call void @__kmpc_for_static_init_4({{.+}}, {{.+}}, {{.+}} 34,
// CHECK: call void @__kmpc_for_static_fini(
// CHECK: ret void

// CHECK-LABEL: define {{.*}}void {{@__omp_offloading_.+}}(
// CHECK-DAG: [[THREAD_LIMIT:%.+]] = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x()
// CHECK: call void @__kmpc_spmd_kernel_init(i32 [[THREAD_LIMIT]], i16 0, i16 0)
// CHECK: call void @__kmpc_for_static_init_4({{.+}}, {{.+}}, {{.+}} 92,
// CHECK: {{call|invoke}} void [[OUTL3:@.+]](
// CHECK: call void @__kmpc_for_static_fini(
// CHECK: call void @__kmpc_spmd_kernel_deinit()
// CHECK: ret void

// CHECK: define internal void [[OUTL3]](
// CHECK: call void @__kmpc_for_static_init_4({{.+}}, {{.+}}, {{.+}} 34,
// CHECK: call void @__kmpc_for_static_fini(
// CHECK: ret void

// CHECK: define {{.*}}void {{@__omp_offloading_.+}}({{.+}}, i{{32|64}} [[F_IN:%.+]])
// CHECK: store {{.+}} [[F_IN]], {{.+}}* {{.+}},
// CHECK-DAG: [[THREAD_LIMIT:%.+]] = call i32 @llvm.nvvm.read.ptx.sreg.ntid.x()
// CHECK: call void @__kmpc_spmd_kernel_init(i32 [[THREAD_LIMIT]], i16 0, i16 0)
// CHECK: store {{.+}} 99, {{.+}}* [[COMB_UB:%.+]], align
// CHECK: call void @__kmpc_for_static_init_4({{.+}}, {{.+}}, {{.+}} 92, {{.+}}, {{.+}}, {{.+}}* [[COMB_UB]],
// CHECK: {{call|invoke}} void [[OUTL4:@.+]](
// CHECK: call void @__kmpc_for_static_fini(
// CHECK: call void @__kmpc_spmd_kernel_deinit()
// CHECK: ret void

// CHECK: define internal void [[OUTL4]](
// CHECK: call void @__kmpc_for_static_init_4({{.+}}, {{.+}}, {{.+}} 34,
// CHECK: call void @__kmpc_for_static_fini(
// CHECK: ret void

// CHECK: define weak void @__omp_offloading_{{.*}}_l57(i[[SZ:64|32]] %{{[^,]+}}, [1000 x i32]* dereferenceable{{.*}}, i32* %{{[^)]+}})
// CHECK: call void [[OUTLINED:@__omp_outlined.*]](i32* %{{.+}}, i32* %{{.+}}, i[[SZ]] %{{.*}}, i[[SZ]] %{{.*}}, i[[SZ]] %{{.*}}, [1000 x i32]* %{{.*}}, i32* %{{.*}})
// CHECK: define internal void [[OUTLINED]](i32* noalias %{{.*}}, i32* noalias %{{.*}} i[[SZ]] %{{.+}}, i[[SZ]] %{{.+}}, i[[SZ]] %{{.+}}, [1000 x i32]* dereferenceable{{.*}}, i32* %{{.*}})

#endif

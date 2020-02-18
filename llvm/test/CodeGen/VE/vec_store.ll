; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=-packed | FileCheck %s

; Function Attrs: nounwind
define void @vec_store_v1f64(<1 x double>* %P, <1 x double> %V) {
  store <1 x double> %V, <1 x double>* %P, align 8
  ret void
}

; Function Attrs: nounwind
define void @vec_store_v17f64(<17 x double>* %P, <17 x double> %V) {
  store <17 x double> %V, <17 x double>* %P, align 8
  ret void
}

declare void @llvm.masked.store.v256f64.p0v256f64(<256 x double>, <256 x double>*, i32 immarg, <256 x i1>)
declare void @llvm.masked.store.v128f64.p0v128f64(<128 x double>, <128 x double>*, i32 immarg, <128 x i1>)

; Function Attrs: nounwind
define void @vec_mstore_v128f64(<128 x double>* %P, <128 x double> %V, <128 x i1> %M) {
  call void @llvm.masked.store.v128f64.p0v128f64(<128 x double> %V, <128 x double>* %P, i32 16, <128 x i1> %M)
  ret void
}

define void @vec_mstore_v256f64(<256 x double>* %P, <256 x double> %V, <256 x i1> %M) {
  call void @llvm.masked.store.v256f64.p0v256f64(<256 x double> %V, <256 x double>* %P, i32 16, <256 x i1> %M)
  ret void
}

declare void @llvm.masked.scatter.v256f64.v256p0f64(<256 x double>, <256 x double*>, i32 immarg, <256 x i1>)
declare void @llvm.masked.scatter.v128f64.v128p0f64(<128 x double>, <128 x double*>, i32 immarg, <128 x i1>)

define void @vec_scatter_v128f64(<128 x double*> %P, <128 x double> %V, <128 x i1> %M) {
  call void @llvm.masked.scatter.v128f64.v128p0f64(<128 x double> %V, <128 x double*> %P, i32 16, <128 x i1> %M)
  ret void
}

define void @vec_scatter_v256f64(<256 x double*> %P, <256 x double> %V, <256 x i1> %M) {
  call void @llvm.masked.scatter.v256f64.v256p0f64(<256 x double> %V, <256 x double*> %P, i32 16, <256 x i1> %M)
  ret void
}

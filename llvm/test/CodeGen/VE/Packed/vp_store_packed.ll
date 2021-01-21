; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+vpu,+packed | FileCheck %s

declare void @llvm.masked.store.v512f64.p0v512f64(<512 x double>, <512 x double>*, i32 immarg, <512 x i1>)

; Function Attrs: nounwind
define fastcc void @vec_mstore_v512f64(<512 x double>* %P, <512 x double> %V, <512 x i1> %M) {
  call void @llvm.masked.store.v512f64.p0v512f64(<512 x double> %V, <512 x double>* %P, i32 16, <512 x i1> %M)
  ret void
}

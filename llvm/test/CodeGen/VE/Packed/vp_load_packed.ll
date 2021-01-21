; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+vpu,+packed | FileCheck %s

declare <512 x double> @llvm.masked.load.v512f64.p0v512f64(<512 x double>*, i32 immarg, <512 x i1>, <512 x double>)

; Function Attrs: nounwind
define fastcc <512 x double> @vec_mload_v512f64(<512 x double>* %P, <512 x i1> %M) {
  %ret = call <512 x double> @llvm.masked.load.v512f64.p0v512f64(<512 x double>* %P, i32 16, <512 x i1> %M, <512 x double> undef)
  ret <512 x double> %ret
}

;;; declare <1024 x double> @llvm.masked.load.v1024f64.p0v1024f64(<1024 x double>*, i32 immarg, <1024 x i1>, <1024 x double>)
;;; 
;;; ; Function Attrs: nounwind
;;; define fastcc <1024 x double> @vec_mload_v1024f64(<1024 x double>* %P, <1024 x i1> %M) {
;;;   %ret = call <1024 x double> @llvm.masked.load.v1024f64.p0v1024f64(<1024 x double>* %P, i32 16, <1024 x i1> %M, <1024 x double> undef)
;;;   ret <1024 x double> %ret
;;; }

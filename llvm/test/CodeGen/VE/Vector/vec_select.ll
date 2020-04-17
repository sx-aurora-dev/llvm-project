; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=-packed | FileCheck %s

define <192 x double> @vec_select_vvv_v192f64(<192 x i1> %C, <192 x double> %T, <192 x double> %F) {
; CHECK-LABEL: vec_select_vvv_v192f64:
  %r = select <192 x i1> %C, <192 x double> %T, <192 x double> %F
  ret <192 x double> %r
}

define <256 x double> @vec_select_vvv_v256f64(<256 x i1> %C, <256 x double> %T, <256 x double> %F) {
; CHECK-LABEL: vec_select_vvv_v256f64:
  %r = select <256 x i1> %C, <256 x double> %T, <256 x double> %F
  ret <256 x double> %r
}

define <256 x double> @vec_select_svv_v256f64(i1 %SC, <256 x double> %T, <256 x double> %F) {
; CHECK-LABEL: vec_select_svv_v256f64:
  %SC0 = insertelement <256 x i1> undef, i1 %SC, i32 0
  %C = shufflevector <256 x i1> %SC0, <256 x i1> %SC0, <256 x i32> zeroinitializer
  %r = select <256 x i1> %C, <256 x double> %T, <256 x double> %F
  ret <256 x double> %r
}

define <256 x double> @vec_select_ssv_v256f64(i1 %SC, double %ST, <256 x double> %F) {
; CHECK-LABEL: vec_select_ssv_v256f64:
  %SC0 = insertelement <256 x i1> undef, i1 %SC, i32 0
  %C = shufflevector <256 x i1> %SC0, <256 x i1> %SC0, <256 x i32> zeroinitializer
  %ST0 = insertelement <256 x double> undef, double %ST, i32 0
  %T = shufflevector <256 x double> %ST0, <256 x double> %ST0, <256 x i32> zeroinitializer
  %r = select <256 x i1> %C, <256 x double> %T, <256 x double> %F
  ret <256 x double> %r
}

define <256 x i1> @vec_select_mmm_v256f64(<256 x i1> %C, <256 x i1> %T, <256 x i1> %F) {
; CHECK-LABEL: vec_select_mmm_v256f64:
  %r = select <256 x i1> %C, <256 x i1> %T, <256 x i1> %F
  ret <256 x i1> %r
}

define <256 x i1> @vec_select_smm_v256f64(i1 %SC, <256 x i1> %T, <256 x i1> %F) {
; CHECK-LABEL: vec_select_smm_v256f64:
  %SC0 = insertelement <256 x i1> undef, i1 %SC, i32 0
  %C = shufflevector <256 x i1> %SC0, <256 x i1> %SC0, <256 x i32> zeroinitializer
  %r = select <256 x i1> %C, <256 x i1> %T, <256 x i1> %F
  ret <256 x i1> %r
}

define <256 x i1> @vec_select_ssm_v256f64(i1 %SC, i1 %ST, <256 x i1> %F) {
; CHECK-LABEL: vec_select_ssm_v256f64:
  %SC0 = insertelement <256 x i1> undef, i1 %SC, i32 0
  %C = shufflevector <256 x i1> %SC0, <256 x i1> %SC0, <256 x i32> zeroinitializer
  %ST0 = insertelement <256 x i1> undef, i1 %ST, i32 0
  %T = shufflevector <256 x i1> %ST0, <256 x i1> %ST0, <256 x i32> zeroinitializer
  %r = select <256 x i1> %C, <256 x i1> %T, <256 x i1> %F
  ret <256 x i1> %r
}

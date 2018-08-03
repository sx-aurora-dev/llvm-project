; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define dso_local double @func1() local_unnamed_addr #0 {
; CHECK-LABEL: func1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, %lo(func_fl)
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, %hi(func_fl)(%s34)
; CHECK-NEXT:    lea %s0,-4(,%s9)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    ldu %s34, -4(,%s9)
; CHECK-NEXT:    cvt.d.s %s0, %s34
  %1 = alloca float, align 4
  %2 = bitcast float* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %2) #3
  call void @func_fl(float* nonnull %1) #3
  %3 = load float, float* %1, align 4, !tbaa !2
  %4 = fpext float %3 to double
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %2) #3
  ret double %4
}

declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1
declare dso_local void @func_fl(float*) local_unnamed_addr #2
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

define dso_local fp128 @func2() local_unnamed_addr #0 {
; CHECK-LABEL: func2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, %lo(func_fl)
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, %hi(func_fl)(%s34)
; CHECK-NEXT:    lea %s0,-4(,%s9)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    ldu %s34, -4(,%s9)
; CHECK-NEXT:    cvt.q.s %s0, %s34
  %1 = alloca float, align 4
  %2 = bitcast float* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %2) #3
  call void @func_fl(float* nonnull %1) #3
  %3 = load float, float* %1, align 4, !tbaa !2
  %4 = fpext float %3 to fp128
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %2) #3
  ret fp128 %4
}

define dso_local fp128 @func3() local_unnamed_addr #0 {
; CHECK-LABEL: func3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s34, %lo(func_db)
; CHECK-NEXT:    and %s34, %s34, (32)0
; CHECK-NEXT:    lea.sl %s12, %hi(func_db)(%s34)
; CHECK-NEXT:    lea %s0,-8(,%s9)
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    ld %s34, -8(,%s9)
; CHECK-NEXT:    cvt.q.d %s0, %s34
  %1 = alloca double, align 8
  %2 = bitcast double* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2) #3
  call void @func_db(double* nonnull %1) #3
  %3 = load double, double* %1, align 8, !tbaa !6
  %4 = fpext double %3 to fp128
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2) #3
  ret fp128 %4
}

declare dso_local void @func_db(double*) local_unnamed_addr #2

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 (git@socsv218.svp.cl.nec.co.jp:ve-llvm/clang.git 94c1203774d203ef69c0c9429c11efb086946b05) (llvm/llvm.git 770f66a66652c1eec9a930ad681ac1b097ca4d5a)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"float", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!7, !7, i64 0}
!7 = !{!"double", !4, i64 0}

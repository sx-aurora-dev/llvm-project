; RUN: llc -mtriple ve < %s | FileCheck %s -check-prefix=ENABLE
; RUN: llc -mtriple ve -disable-promote-to-i1 < %s | FileCheck %s -check-prefix=DISABLE

@pIn = common global i8* null, align 8

; Function Attrs: nounwind
define void @VM256V64_test1() {
; ENABLE-LABEL:   VM256V64_test1:
; ENABLE:         .LBB{{[0-9]+}}_2:
; ENABLE-NEXT:      lea %s34, pIn@lo
; ENABLE-NEXT:      and %s34, %s34, (32)0
; ENABLE-NEXT:      lea.sl %s34, pIn@hi(%s34)
; ENABLE-NEXT:      ld %s34, (,%s34)
; ENABLE-NEXT:      vldu %v0,4,%s34
; ENABLE-NEXT:      vfmk.s.eq %vm1,%v0
; ENABLE-NEXT:      nndm %vm1,%vm1,%vm1
; ENABLE-NEXT:      vadds.l %v0,%v0,%v0,%vm1
; ENABLE-NEXT:      vstl %v0,4,%s34
; DISABLE-LABEL:  VM256V64_test1:
; DISABLE:        .LBB{{[0-9]+}}_2:
; DISABLE-NEXT:     lea %s34, pIn@lo
; DISABLE-NEXT:     and %s34, %s34, (32)0
; DISABLE-NEXT:     lea.sl %s34, pIn@hi(%s34)
; DISABLE-NEXT:     ld %s34, (,%s34)
; DISABLE-NEXT:     vldu %v0,4,%s34
; DISABLE-NEXT:     vfmk.s.eq %vm1,%v0
; DISABLE-NEXT:     nndm %vm1,%vm1,%vm1
; DISABLE-NEXT:     vadds.l %v0,%v0,%v0,%vm1
; DISABLE-NEXT:     vstl %v0,4,%s34
  %1 = load i8*, i8** @pIn, align 8, !tbaa !2
  %2 = tail call <256 x double> @llvm.ve.vldu.vss(i64 4, i8* %1)
  %3 = tail call <4 x i64> @llvm.ve.vfmks.mcv(i32 10, <256 x double> %2)
  %4 = tail call <4 x i64> @llvm.ve.nndm.mmm(<4 x i64> %3, <4 x i64> %3)
  %5 = tail call <256 x double> @llvm.ve.vaddsl.vvvmv(<256 x double> %2, <256 x double> %2, <4 x i64> %4, <256 x double> undef)
  tail call void @llvm.ve.vstl.vss(<256 x double> %5, i64 4, i8* %1)
  ret void
}

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vldu.vss(i64, i8*)

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vfmks.mcv(i32, <256 x double>)

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.nndm.mmm(<4 x i64>, <4 x i64>)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vaddsl.vvvmv(<256 x double>, <256 x double>, <4 x i64>, <256 x double>)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vstl.vss(<256 x double>, i64, i8*)

; Function Attrs: nounwind
define void @VM256V64_test2(i32) {
; ENABLE-LABEL:   VM256V64_test2:
; ENABLE:         .LBB{{[0-9]+}}_6:
; ENABLE-NEXT:      lea %s34, pIn@lo
; ENABLE-NEXT:      and %s34, %s34, (32)0
; ENABLE-NEXT:      lea.sl %s34, pIn@hi(%s34)
; ENABLE-NEXT:      ld %s34, (,%s34)
; ENABLE-NEXT:      vldu %v0,4,%s34
; ENABLE-NEXT:      lea %s35, -1(%s0)
; ENABLE-NEXT:      or %s36, 1, (0)1
; ENABLE-NEXT:      vfmk.s.eq %vm2,%v0
; ENABLE-NEXT:      brlt.w %s35, %s36, .LBB1_1
; ENABLE:         .LBB{{[0-9]+}}_3:
; ENABLE-NEXT:      nndm %vm1,%vm2,%vm1
; ENABLE-NEXT:      brgt.w %s35, %s36, .LBB1_3
; ENABLE-NEXT:      br.l .LBB1_4
; ENABLE:         .LBB{{[0-9]+}}_1:
; ENABLE-NEXT:      andm %vm1,%vm0,%vm2
; ENABLE:         .LBB{{[0-9]+}}_4:
; ENABLE-NEXT:      vadds.l %v0,%v0,%v0,%vm1
; ENABLE-NEXT:      vstl %v0,4,%s34
; DISABLE-LABEL:  VM256V64_test2:
; DISABLE:        .LBB{{[0-9]+}}_6:
; DISABLE-NEXT:     lea %s34, pIn@lo
; DISABLE-NEXT:     and %s34, %s34, (32)0
; DISABLE-NEXT:     lea.sl %s34, pIn@hi(%s34)
; DISABLE-NEXT:     ld %s34, (,%s34)
; DISABLE-NEXT:     vldu %v0,4,%s34
; DISABLE-NEXT:     vfmk.s.eq %vm1,%v0
; DISABLE-NEXT:     lea %s35, -1(%s0)
; DISABLE-NEXT:     or %s36, 1, (0)1
; DISABLE-NEXT:     svm %s16,%vm1,0
; DISABLE-NEXT:     lsv %v1(0),%s16
; DISABLE-NEXT:     svm %s16,%vm1,1
; DISABLE-NEXT:     lsv %v1(1),%s16
; DISABLE-NEXT:     svm %s16,%vm1,2
; DISABLE-NEXT:     lsv %v1(2),%s16
; DISABLE-NEXT:     svm %s16,%vm1,3
; DISABLE-NEXT:     lsv %v1(3),%s16
; DISABLE-NEXT:     brlt.w %s35, %s36, .LBB1_1
; DISABLE:        .LBB{{[0-9]+}}_3:
; DISABLE-NEXT:     lvs %s16,%v2(0)
; DISABLE-NEXT:     lvm %vm1,0,%s16
; DISABLE-NEXT:     lvs %s16,%v2(1)
; DISABLE-NEXT:     lvm %vm1,1,%s16
; DISABLE-NEXT:     lvs %s16,%v2(2)
; DISABLE-NEXT:     lvm %vm1,2,%s16
; DISABLE-NEXT:     lvs %s16,%v2(3)
; DISABLE-NEXT:     lvm %vm1,3,%s16
; DISABLE-NEXT:     lvs %s16,%v1(0)
; DISABLE-NEXT:     lvm %vm2,0,%s16
; DISABLE-NEXT:     lvs %s16,%v1(1)
; DISABLE-NEXT:     lvm %vm2,1,%s16
; DISABLE-NEXT:     lvs %s16,%v1(2)
; DISABLE-NEXT:     lvm %vm2,2,%s16
; DISABLE-NEXT:     lvs %s16,%v1(3)
; DISABLE-NEXT:     lvm %vm2,3,%s16
; DISABLE-NEXT:     nndm %vm1,%vm2,%vm1
; DISABLE-NEXT:     svm %s16,%vm1,0
; DISABLE-NEXT:     lsv %v2(0),%s16
; DISABLE-NEXT:     svm %s16,%vm1,1
; DISABLE-NEXT:     lsv %v2(1),%s16
; DISABLE-NEXT:     svm %s16,%vm1,2
; DISABLE-NEXT:     lsv %v2(2),%s16
; DISABLE-NEXT:     svm %s16,%vm1,3
; DISABLE-NEXT:     lsv %v2(3),%s16
; DISABLE-NEXT:     brgt.w %s35, %s36, .LBB1_3
; DISABLE-NEXT:     br.l .LBB1_4
; DISABLE:        .LBB{{[0-9]+}}_1:
; DISABLE-NEXT:     svl %s16
; DISABLE-NEXT:     lea %s12, 256
; DISABLE-NEXT:     lvl %s12
; DISABLE-NEXT:     vor %v2,(0)1,%v1
; DISABLE-NEXT:     lvl %s16
; DISABLE:        .LBB{{[0-9]+}}_4:
; DISABLE-NEXT:     lvs %s16,%v2(0)
; DISABLE-NEXT:     lvm %vm1,0,%s16
; DISABLE-NEXT:     lvs %s16,%v2(1)
; DISABLE-NEXT:     lvm %vm1,1,%s16
; DISABLE-NEXT:     lvs %s16,%v2(2)
; DISABLE-NEXT:     lvm %vm1,2,%s16
; DISABLE-NEXT:     lvs %s16,%v2(3)
; DISABLE-NEXT:     lvm %vm1,3,%s16
; DISABLE-NEXT:     vadds.l %v0,%v0,%v0,%vm1
; DISABLE-NEXT:     vstl %v0,4,%s34
  %2 = load i8*, i8** @pIn, align 8, !tbaa !2
  %3 = tail call <256 x double> @llvm.ve.vldu.vss(i64 4, i8* %2)
  %4 = tail call <4 x i64> @llvm.ve.vfmks.mcv(i32 10, <256 x double> %3)
  %5 = add nsw i32 %0, -1
  %6 = icmp sgt i32 %5, 0
  br i1 %6, label %7, label %10

; <label>:7:                                      ; preds = %1, %7
  %8 = phi <4 x i64> [ %9, %7 ], [ %4, %1 ]
  %9 = tail call <4 x i64> @llvm.ve.nndm.mmm(<4 x i64> %4, <4 x i64> %8)
  br i1 %6, label %7, label %10

; <label>:10:                                     ; preds = %7, %1
  %11 = phi <4 x i64> [ %4, %1 ], [ %9, %7 ]
  %12 = tail call <256 x double> @llvm.ve.vaddsl.vvvmv(<256 x double> %3, <256 x double> %3, <4 x i64> %11, <256 x double> undef)
  tail call void @llvm.ve.vstl.vss(<256 x double> %12, i64 4, i8* %2)
  ret void
}

; Function Attrs: nounwind
define void @VM512V64_test1() {
; ENABLE-LABEL:   VM512V64_test1:
; ENABLE:         .LBB{{[0-9]+}}_2:
; ENABLE-NEXT:      lea %s34, pIn@lo
; ENABLE-NEXT:      and %s34, %s34, (32)0
; ENABLE-NEXT:      lea.sl %s34, pIn@hi(%s34)
; ENABLE-NEXT:      ld %s34, (,%s34)
; ENABLE-NEXT:      vldu %v0,4,%s34
; ENABLE-NEXT:      vfmk.s.eq %vm2,%v0
; ENABLE-NEXT:      pvfmk.s.lo.eq %vm3,%v0
; ENABLE-NEXT:      nndm %vm2,%vm2,%vm2
; ENABLE-NEXT:      nndm %vm3,%vm3,%vm3
; ENABLE-NEXT:      pvadds %v0,%v0,%v0,%vm2
; ENABLE-NEXT:      vstl %v0,4,%s34
; DISABLE-LABEL:  VM512V64_test1:
; DISABLE:        .LBB{{[0-9]+}}_2:
; DISABLE-NEXT:     lea %s34, pIn@lo
; DISABLE-NEXT:     and %s34, %s34, (32)0
; DISABLE-NEXT:     lea.sl %s34, pIn@hi(%s34)
; DISABLE-NEXT:     ld %s34, (,%s34)
; DISABLE-NEXT:     vldu %v0,4,%s34
; DISABLE-NEXT:     vfmk.s.eq %vm2,%v0
; DISABLE-NEXT:     pvfmk.s.lo.eq %vm3,%v0
; DISABLE-NEXT:     nndm %vm2,%vm2,%vm2
; DISABLE-NEXT:     nndm %vm3,%vm3,%vm3
; DISABLE-NEXT:     pvadds %v0,%v0,%v0,%vm2
; DISABLE-NEXT:     vstl %v0,4,%s34
  %1 = load i8*, i8** @pIn, align 8, !tbaa !2
  %2 = tail call <256 x double> @llvm.ve.vldu.vss(i64 4, i8* %1)
  %3 = tail call <8 x i64> @llvm.ve.pvfmks.Mcv(i32 10, <256 x double> %2)
  %4 = tail call <8 x i64> @llvm.ve.nndm.MMM(<8 x i64> %3, <8 x i64> %3)
  %5 = tail call <256 x double> @llvm.ve.pvadds.vvvMv(<256 x double> %2, <256 x double> %2, <8 x i64> %4, <256 x double> undef)
  tail call void @llvm.ve.vstl.vss(<256 x double> %5, i64 4, i8* %1)
  ret void
}

; Function Attrs: nounwind readnone
declare <8 x i64> @llvm.ve.pvfmks.Mcv(i32, <256 x double>)

; Function Attrs: nounwind readnone
declare <8 x i64> @llvm.ve.nndm.MMM(<8 x i64>, <8 x i64>)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.pvadds.vvvMv(<256 x double>, <256 x double>, <8 x i64>, <256 x double>)

; Function Attrs: nounwind
define void @VM512V64_test2(i32) {
; ENABLE-LABEL:   VM512V64_test2:
; ENABLE:         .LBB{{[0-9]+}}_4:
; ENABLE-NEXT:      lea %s34, pIn@lo
; ENABLE-NEXT:      and %s34, %s34, (32)0
; ENABLE-NEXT:      lea.sl %s34, pIn@hi(%s34)
; ENABLE-NEXT:      ld %s34, (,%s34)
; ENABLE-NEXT:      vldu %v0,4,%s34
; ENABLE-NEXT:      vfmk.s.eq %vm4,%v0
; ENABLE-NEXT:      pvfmk.s.lo.eq %vm5,%v0
; ENABLE-NEXT:      or %s35, 1, (0)1
; ENABLE-NEXT:      nndm %vm2,%vm4,%vm4
; ENABLE-NEXT:      nndm %vm3,%vm5,%vm5
; ENABLE-NEXT:      brlt.w %s0, %s35, .LBB3_2
; ENABLE:         .LBB{{[0-9]+}}_1:
; ENABLE-NEXT:      nndm %vm2,%vm4,%vm2
; ENABLE-NEXT:      nndm %vm3,%vm5,%vm3
; ENABLE-NEXT:      brlt.w %s0, %s35, .LBB3_1
; ENABLE:         .LBB{{[0-9]+}}_2:
; ENABLE-NEXT:      pvadds %v0,%v0,%v0,%vm2
; ENABLE-NEXT:      vstl %v0,4,%s34
; DISABLE-LABEL:  VM512V64_test2:
; DISABLE:        .LBB{{[0-9]+}}_5:
; DISABLE-NEXT:     lea %s34, pIn@lo
; DISABLE-NEXT:     and %s34, %s34, (32)0
; DISABLE-NEXT:     lea.sl %s34, pIn@hi(%s34)
; DISABLE-NEXT:     ld %s34, (,%s34)
; DISABLE-NEXT:     vldu %v0,4,%s34
; DISABLE-NEXT:     vfmk.s.eq %vm2,%v0
; DISABLE-NEXT:     pvfmk.s.lo.eq %vm3,%v0
; DISABLE-NEXT:     nndm %vm4,%vm2,%vm2
; DISABLE-NEXT:     nndm %vm5,%vm3,%vm3
; DISABLE-NEXT:     or %s35, 1, (0)1
; DISABLE-NEXT:     svm %s16,%vm5,0
; DISABLE-NEXT:     lsv %v1(0),%s16
; DISABLE-NEXT:     svm %s16,%vm5,1
; DISABLE-NEXT:     lsv %v1(1),%s16
; DISABLE-NEXT:     svm %s16,%vm5,2
; DISABLE-NEXT:     lsv %v1(2),%s16
; DISABLE-NEXT:     svm %s16,%vm5,3
; DISABLE-NEXT:     lsv %v1(3),%s16
; DISABLE-NEXT:     svm %s16,%vm4,0
; DISABLE-NEXT:     lsv %v1(4),%s16
; DISABLE-NEXT:     svm %s16,%vm4,1
; DISABLE-NEXT:     lsv %v1(5),%s16
; DISABLE-NEXT:     svm %s16,%vm4,2
; DISABLE-NEXT:     lsv %v1(6),%s16
; DISABLE-NEXT:     svm %s16,%vm4,3
; DISABLE-NEXT:     lsv %v1(7),%s16
; DISABLE-NEXT:     brlt.w %s0, %s35, .LBB{{[0-9]+}}_3
; DISABLE:        .LBB{{[0-9]+}}_2:
; DISABLE-NEXT:     lvs %s16,%v1(0)
; DISABLE-NEXT:     lvm %vm5,0,%s16
; DISABLE-NEXT:     lvs %s16,%v1(1)
; DISABLE-NEXT:     lvm %vm5,1,%s16
; DISABLE-NEXT:     lvs %s16,%v1(2)
; DISABLE-NEXT:     lvm %vm5,2,%s16
; DISABLE-NEXT:     lvs %s16,%v1(3)
; DISABLE-NEXT:     lvm %vm5,3,%s16
; DISABLE-NEXT:     lvs %s16,%v1(4)
; DISABLE-NEXT:     lvm %vm4,0,%s16
; DISABLE-NEXT:     lvs %s16,%v1(5)
; DISABLE-NEXT:     lvm %vm4,1,%s16
; DISABLE-NEXT:     lvs %s16,%v1(6)
; DISABLE-NEXT:     lvm %vm4,2,%s16
; DISABLE-NEXT:     lvs %s16,%v1(7)
; DISABLE-NEXT:     lvm %vm4,3,%s16
; DISABLE-NEXT:     nndm %vm4,%vm2,%vm4
; DISABLE-NEXT:     nndm %vm5,%vm3,%vm5
; DISABLE-NEXT:     svm %s16,%vm5,0
; DISABLE-NEXT:     lsv %v1(0),%s16
; DISABLE-NEXT:     svm %s16,%vm5,1
; DISABLE-NEXT:     lsv %v1(1),%s16
; DISABLE-NEXT:     svm %s16,%vm5,2
; DISABLE-NEXT:     lsv %v1(2),%s16
; DISABLE-NEXT:     svm %s16,%vm5,3
; DISABLE-NEXT:     lsv %v1(3),%s16
; DISABLE-NEXT:     svm %s16,%vm4,0
; DISABLE-NEXT:     lsv %v1(4),%s16
; DISABLE-NEXT:     svm %s16,%vm4,1
; DISABLE-NEXT:     lsv %v1(5),%s16
; DISABLE-NEXT:     svm %s16,%vm4,2
; DISABLE-NEXT:     lsv %v1(6),%s16
; DISABLE-NEXT:     svm %s16,%vm4,3
; DISABLE-NEXT:     lsv %v1(7),%s16
; DISABLE-NEXT:     brlt.w %s0, %s35, .LBB{{[0-9]+}}_2
; DISABLE:        .LBB{{[0-9]+}}_3:
; DISABLE-NEXT:     lvs %s16,%v1(0)
; DISABLE-NEXT:     lvm %vm3,0,%s16
; DISABLE-NEXT:     lvs %s16,%v1(1)
; DISABLE-NEXT:     lvm %vm3,1,%s16
; DISABLE-NEXT:     lvs %s16,%v1(2)
; DISABLE-NEXT:     lvm %vm3,2,%s16
; DISABLE-NEXT:     lvs %s16,%v1(3)
; DISABLE-NEXT:     lvm %vm3,3,%s16
; DISABLE-NEXT:     lvs %s16,%v1(4)
; DISABLE-NEXT:     lvm %vm2,0,%s16
; DISABLE-NEXT:     lvs %s16,%v1(5)
; DISABLE-NEXT:     lvm %vm2,1,%s16
; DISABLE-NEXT:     lvs %s16,%v1(6)
; DISABLE-NEXT:     lvm %vm2,2,%s16
; DISABLE-NEXT:     lvs %s16,%v1(7)
; DISABLE-NEXT:     lvm %vm2,3,%s16
; DISABLE-NEXT:     pvadds %v0,%v0,%v0,%vm2
; DISABLE-NEXT:     vstl %v0,4,%s34
; DISABLE-NEXT:     or %s11, 0, %s9
; DISABLE-NEXT:     ld %s16, 32(,%s11)
; DISABLE-NEXT:     ld %s15, 24(,%s11)
; DISABLE-NEXT:     ld %s10, 8(,%s11)
; DISABLE-NEXT:     ld %s9, (,%s11)
; DISABLE-NEXT:     b.l (,%lr)
  %2 = load i8*, i8** @pIn, align 8, !tbaa !2
  %3 = tail call <256 x double> @llvm.ve.vldu.vss(i64 4, i8* %2)
  %4 = tail call <8 x i64> @llvm.ve.pvfmks.Mcv(i32 10, <256 x double> %3)
  %5 = tail call <8 x i64> @llvm.ve.nndm.MMM(<8 x i64> %4, <8 x i64> %4)
  %6 = icmp sgt i32 %0, 0
  br i1 %6, label %7, label %10

; <label>:7:                                      ; preds = %1, %7
  %8 = phi <8 x i64> [ %9, %7 ], [ %5, %1 ]
  %9 = tail call <8 x i64> @llvm.ve.nndm.MMM(<8 x i64> %4, <8 x i64> %8)
  br i1 %6, label %10, label %7

; <label>:10:                                     ; preds = %7, %1
  %11 = phi <8 x i64> [ %5, %1 ], [ %9, %7 ]
  %12 = tail call <256 x double> @llvm.ve.pvadds.vvvMv(<256 x double> %3, <256 x double> %3, <8 x i64> %11, <256 x double> undef)
  tail call void @llvm.ve.vstl.vss(<256 x double> %12, i64 4, i8* %2)
  ret void
}

!2 = !{!3, !3, i64 0}
!3 = !{!"any pointer", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}


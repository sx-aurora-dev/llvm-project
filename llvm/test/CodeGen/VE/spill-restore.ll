; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

@.str.1 = private unnamed_addr constant [7 x i8] c"x=%ld\0A\00", align 1
@str = private unnamed_addr constant [13 x i8] c"Hello World!\00", align 1

; Function Attrs: nounwind
define void @check_spill_restore() {
; CHECK-LABEL: check_spill_restore:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st %s18, 48(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s19, 56(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    lea %s0, memset@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, memset@hi(, %s0)
; CHECK-NEXT:    lea %s18, -2048(, %s9)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    lea %s2, 2048
; CHECK-NEXT:    or %s0, 0, %s18
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lea %s19, 256
; CHECK-NEXT:    lvl %s19
; CHECK-NEXT:    vld %v0,8,%s18
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lea %s0, -4096(, %s9)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vst %v0,8,%s0 # 2048-byte Folded Spill
; CHECK-NEXT:    lea %s0, puts@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, puts@hi(, %s0)
; CHECK-NEXT:    lea %s0, .Lstr@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, .Lstr@hi(, %s0)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lea %s0, -4096(, %s9)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s0 # 2048-byte Folded Reload
; CHECK-NEXT:    lvl %s19
; CHECK-NEXT:    vadds.w.sx %v0,3,%v0
; CHECK-NEXT:    vst %v0,8,%s18
; CHECK-NEXT:    ld %s19, 56(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s18, 48(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = alloca [256 x i64], align 8
  %2 = bitcast [256 x i64]* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 2048, i8* nonnull %2)
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %2, i8 0, i64 2048, i1 false)
  %3 = call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* nonnull %2, i32 256)
  %4 = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str, i64 0, i64 0))
  %5 = call <256 x double> @llvm.ve.vl.vaddswsx.vsvl(i32 3, <256 x double> %3, i32 256)
  call void @llvm.ve.vl.vst.vssl(<256 x double> %5, i64 8, i8* nonnull %2, i32 256)
  call void @llvm.lifetime.end.p0i8(i64 2048, i8* nonnull %2)
  ret void
}

declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture)
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1)
declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32)
declare <256 x double> @llvm.ve.vl.vaddswsx.vsvl(i32, <256 x double>, i32)
declare void @llvm.ve.vl.vst.vssl(<256 x double>, i64, i8*, i32)
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture)
declare i32 @puts(i8* nocapture readonly)

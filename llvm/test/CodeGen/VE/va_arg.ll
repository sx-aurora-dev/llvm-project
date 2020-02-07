; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

@.str = private unnamed_addr constant [6 x i8] c"a=%d\0A\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"b=%d\0A\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"c=%d\0A\00", align 1
@.str.3 = private unnamed_addr constant [6 x i8] c"d=%u\0A\00", align 1
@.str.4 = private unnamed_addr constant [6 x i8] c"e=%u\0A\00", align 1
@.str.5 = private unnamed_addr constant [6 x i8] c"f=%u\0A\00", align 1
@.str.6 = private unnamed_addr constant [6 x i8] c"g=%f\0A\00", align 1
@.str.7 = private unnamed_addr constant [6 x i8] c"h=%p\0A\00", align 1
@.str.8 = private unnamed_addr constant [7 x i8] c"i=%ld\0A\00", align 1
@.str.9 = private unnamed_addr constant [7 x i8] c"j=%lf\0A\00", align 1
@.str.10 = private unnamed_addr constant [8 x i8] c"k=%lld\0A\00", align 1
@.str.11 = private unnamed_addr constant [8 x i8] c"l=%llu\0A\00", align 1

define i32 @func(i32, ...) {
; CHECK-LABEL: func:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK:       ldl.sx %s1, 184(, %s9)
; CHECK:       ld2b.sx %s20, 192(, %s9)
; CHECK:       ld1b.sx %s21, 200(, %s9)
; CHECK:       ldl.sx %s22, 208(, %s9)
; CHECK:       ld2b.zx %s23, 216(, %s9)
; CHECK:       ld1b.zx %s24, 224(, %s9)
; CHECK:       ldu %s18, 236(, %s9)
; CHECK:       ld %s26, 240(, %s9)
; CHECK:       ld %s27, 248(, %s9)
; CHECK:       ld %s28, 256(, %s9)
; CHECK:       ld %s29, 264(, %s9)
; CHECK:       ld %s32, 272(, %s9)
; CHECK:       ld %s30, 280(, %s9)
; CHECK:       ld %s31, 288(, %s9)

  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = bitcast i8** %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %4)
  %5 = bitcast i8** %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %5)
  call void @llvm.va_start(i8* nonnull %4)
  call void @llvm.va_copy(i8* nonnull %5, i8* nonnull %4)
  %6 = va_arg i8** %2, i32
  %7 = va_arg i8** %2, i16
  %8 = va_arg i8** %2, i8
  %9 = va_arg i8** %2, i32
  %10 = va_arg i8** %2, i16
  %11 = va_arg i8** %2, i8
  %12 = va_arg i8** %2, float
  %13 = va_arg i8** %2, i8*
  %14 = va_arg i8** %2, i64
  %15 = va_arg i8** %2, double
  %16 = va_arg i8** %2, i128
  %17 = va_arg i8** %2, i128
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0), i32 %6)
  %19 = sext i16 %7 to i32
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i32 %19)
  %21 = sext i8 %8 to i32
  %22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i32 %21)
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0), i32 %9)
  %24 = zext i16 %10 to i32
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i64 0, i64 0), i32 %24)
  %26 = zext i8 %11 to i32
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i32 %26)
  %28 = fpext float %12 to double
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i64 0, i64 0), double %28)
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.7, i64 0, i64 0), i8* %13)
  %31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.8, i64 0, i64 0), i64 %14)
  %32 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.9, i64 0, i64 0), double %15)
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.10, i64 0, i64 0), i128 %16)
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.11, i64 0, i64 0), i128 %17)
  call void @llvm.va_end(i8* nonnull %4)
  %35 = va_arg i8** %3, i32
  %36 = va_arg i8** %3, i16
  %37 = va_arg i8** %3, i8
  %38 = va_arg i8** %3, i32
  %39 = va_arg i8** %3, i16
  %40 = va_arg i8** %3, i8
  %41 = va_arg i8** %3, float
  %42 = va_arg i8** %3, i8*
  %43 = va_arg i8** %3, i64
  %44 = va_arg i8** %3, double
  %45 = va_arg i8** %3, i128
  %46 = va_arg i8** %3, i128
  %47 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0), i32 %35)
  %48 = sext i16 %36 to i32
  %49 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i32 %48)
  %50 = sext i8 %37 to i32
  %51 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i32 %50)
  %52 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0), i32 %38)
  %53 = zext i16 %39 to i32
  %54 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i64 0, i64 0), i32 %53)
  %55 = zext i8 %40 to i32
  %56 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i32 %55)
  %57 = fpext float %41 to double
  %58 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i64 0, i64 0), double %57)
  %59 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.7, i64 0, i64 0), i8* %42)
  %60 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.8, i64 0, i64 0), i64 %43)
  %61 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.9, i64 0, i64 0), double %44)
  %62 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.10, i64 0, i64 0), i128 %45)
  %63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.11, i64 0, i64 0), i128 %46)
  call void @llvm.va_end(i8* nonnull %5)
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %5)
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %4)
  ret i32 0
}

define i32 @caller() {
; CHECK-LABEL: caller:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  st %s18, 48(, %s9)               # 8-byte Folded Spill
; CHECK-NEXT:  or %s7, 0, (0)1
; CHECK-NEXT:  st %s7, 280(, %s11)
; CHECK-NEXT:  or %s0, 11, (0)1
; CHECK-NEXT:  st %s0, 272(, %s11)
; CHECK-NEXT:  st %s7, 264(, %s11)
; CHECK-NEXT:  or %s0, 10, (0)1
; CHECK-NEXT:  st %s0, 256(, %s11)
; CHECK-NEXT:  lea.sl %s0, 1075970048
; CHECK-NEXT:  st %s0, 248(, %s11)
; CHECK-NEXT:  or %s0, 8, (0)1
; CHECK-NEXT:  st %s0, 240(, %s11)
; CHECK-NEXT:  st %s7, 232(, %s11)
; CHECK-NEXT:  lea %s0, 1086324736
; CHECK-NEXT:  stl %s0, 228(, %s11)
; CHECK-NEXT:  or %s5, 5, (0)1
; CHECK-NEXT:  stl %s5, 216(, %s11)
; CHECK-NEXT:  or %s4, 4, (0)1
; CHECK-NEXT:  stl %s4, 208(, %s11)
; CHECK-NEXT:  or %s3, 3, (0)1
; CHECK-NEXT:  stl %s3, 200(, %s11)
; CHECK-NEXT:  or %s2, 2, (0)1
; CHECK-NEXT:  stl %s2, 192(, %s11)
; CHECK-NEXT:  or %s1, 1, (0)1
; CHECK-NEXT:  stl %s1, 184(, %s11)
; CHECK-NEXT:  or %s18, 0, (0)1
; CHECK-NEXT:  lea %s0, func@lo
; CHECK-NEXT:  and %s0, %s0, (32)0
; CHECK-NEXT:  lea.sl %s12, func@hi(, %s0)
; CHECK-NEXT:  lea.sl %s0, 1086324736
; CHECK-NEXT:  stl %s18, 176(, %s11)
; CHECK-NEXT:  or %s6, 0, %s0
; CHECK-NEXT:  or %s0, 0, %s18
; CHECK-NEXT:  bsic %lr, (, %s12)
; CHECK-NEXT:  or %s0, 0, %s18
; CHECK-NEXT:  ld %s18, 48(, %s9)               # 8-byte Folded Reload
; CHECK-NEXT:  or %s11, 0, %s9
  call i32 (i32, ...) @func(i32 0, i16 1, i8 2, i32 3, i16 4, i8 5, float 6.0, i8* null, i64 8, double 9.0, i128 10, i128 11)
  ret i32 0
}

define i32 @func_vainout(i32, ...) {
; CHECK-LABEL: func_vainout:
; CHECK:         ldl.sx %s1, 184(, %s9)
; CHECK:         ld2b.sx %s18, 192(, %s9)
; CHECK:         ld1b.sx %s19, 200(, %s9)
; CHECK:         ldl.sx %s20, 208(, %s9)
; CHECK:         ld2b.zx %s21, 216(, %s9)
; CHECK:         ld1b.zx %s22, 224(, %s9)
; CHECK:         ldu %s23, 236(, %s9)
; CHECK:         ld %s24, 240(, %s9)
; CHECK:         ld %s25, 248(, %s9)
; CHECK:         ld %s26, 256(, %s9)

  %a = alloca i8*, align 8
  %a8 = bitcast i8** %a to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %a8)
  call void @llvm.va_start(i8* nonnull %a8)
  %p0 = va_arg i8** %a, i32
  %p1 = va_arg i8** %a, i16
  %p2 = va_arg i8** %a, i8
  %p3 = va_arg i8** %a, i32
  %p4 = va_arg i8** %a, i16
  %p5 = va_arg i8** %a, i8
  %p6 = va_arg i8** %a, float
  %p7 = va_arg i8** %a, i8*
  %p8 = va_arg i8** %a, i64
  %p9 = va_arg i8** %a, double
  call void @llvm.va_end(i8* nonnull %a8)
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %a8)
  %pf0 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0), i32 %p0)
  %p1.s32 = sext i16 %p1 to i32
  %pf1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i32 %p1.s32)
  %p2.s32 = sext i8 %p2 to i32
  %pf2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i32 %p2.s32)
  %pf3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0), i32 %p3)
  %p4.z32 = zext i16 %p4 to i32
  %pf4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i64 0, i64 0), i32 %p4.z32)
  %p5.z32 = zext i8 %p5 to i32
  %pf5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i32 %p5.z32)
  %pf6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i64 0, i64 0), float %p6)
  %pf7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.7, i64 0, i64 0), i8* %p7)
  %pf8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.8, i64 0, i64 0), i64 %p8)
  %pf9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.9, i64 0, i64 0), double %p9)
  ret i32 0
}

declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture)
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture)
declare void @llvm.va_start(i8*)
declare void @llvm.va_end(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare i32 @printf(i8* nocapture readonly, ...)

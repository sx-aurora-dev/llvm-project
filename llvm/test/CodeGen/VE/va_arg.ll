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

define i32 @func(i32, ...) {
; CHECK-LABEL: func:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  st %s18, 48(,%s9)
; CHECK-NEXT:  st %s19, 56(,%s9)
; CHECK-NEXT:  st %s20, 64(,%s9)
; CHECK-NEXT:  st %s21, 72(,%s9)
; CHECK-NEXT:  st %s22, 80(,%s9)
; CHECK-NEXT:  st %s23, 88(,%s9)
; CHECK-NEXT:  st %s24, 96(,%s9)
; CHECK-NEXT:  st %s25, 104(,%s9)
; CHECK-NEXT:  st %s26, 112(,%s9)
; CHECK-NEXT:  st %s27, 120(,%s9)
; CHECK-NEXT:  st %s28, 128(,%s9)
; CHECK-NEXT:  st %s29, 136(,%s9)
; CHECK-NEXT:  st %s30, 144(,%s9)
; CHECK-NEXT:  st %s31, 152(,%s9)
; CHECK-NEXT:  st %s32, 160(,%s9)
; CHECK-NEXT:  st %s33, 168(,%s9)
; CHECK-NEXT:  lea %s34, 184(%s9)
; CHECK-NEXT:  st %s34, -16(,%s9)
; CHECK-NEXT:  lea %s34, 192(%s9)
; CHECK-NEXT:  st %s34, -8(,%s9)
; CHECK-NEXT:  ldl.sx %s1, 184(,%s9)
; CHECK-NEXT:  lea %s34, 200(%s9)
; CHECK-NEXT:  st %s34, -8(,%s9)
; CHECK-NEXT:  ld2b.sx %s20, 192(,%s9)
; CHECK-NEXT:  lea %s34, 208(%s9)
; CHECK-NEXT:  st %s34, -8(,%s9)
; CHECK-NEXT:  ld1b.sx %s21, 200(,%s9)
; CHECK-NEXT:  lea %s34, 216(%s9)
; CHECK-NEXT:  st %s34, -8(,%s9)
; CHECK-NEXT:  ldl.sx %s22, 208(,%s9)
; CHECK-NEXT:  lea %s34, 224(%s9)
; CHECK-NEXT:  st %s34, -8(,%s9)
; CHECK-NEXT:  ld2b.zx %s23, 216(,%s9)
; CHECK-NEXT:  lea %s34, 232(%s9)
; CHECK-NEXT:  st %s34, -8(,%s9)
; CHECK-NEXT:  ld1b.zx %s24, 224(,%s9)
; CHECK-NEXT:  lea %s34, 240(%s9)
; CHECK-NEXT:  st %s34, -8(,%s9)
; CHECK-NEXT:  ldu %s18, 232(,%s9)
; CHECK-NEXT:  lea %s34, 248(%s9)
; CHECK-NEXT:  st %s34, -8(,%s9)
; CHECK-NEXT:  ld %s26, 240(,%s9)
; CHECK-NEXT:  lea %s34, 256(%s9)
; CHECK-NEXT:  st %s34, -8(,%s9)
; CHECK-NEXT:  ld %s27, 248(,%s9)
; CHECK-NEXT:  lea %s34, 264(%s9)
; CHECK-NEXT:  st %s34, -8(,%s9)
; CHECK-NEXT:  ld %s28, 256(,%s9)
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
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0), i32 %6)
  %17 = sext i16 %7 to i32
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i32 %17)
  %19 = sext i8 %8 to i32
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i32 %19)
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0), i32 %9)
  %22 = zext i16 %10 to i32
  %23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i64 0, i64 0), i32 %22)
  %24 = zext i8 %11 to i32
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i32 %24)
  %26 = fpext float %12 to double
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i64 0, i64 0), double %26)
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.7, i64 0, i64 0), i8* %13)
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.8, i64 0, i64 0), i64 %14)
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.9, i64 0, i64 0), double %15)
  call void @llvm.va_end(i8* nonnull %4)
  %31 = va_arg i8** %3, i32
  %32 = va_arg i8** %3, i16
  %33 = va_arg i8** %3, i8
  %34 = va_arg i8** %3, i32
  %35 = va_arg i8** %3, i16
  %36 = va_arg i8** %3, i8
  %37 = va_arg i8** %3, float
  %38 = va_arg i8** %3, i8*
  %39 = va_arg i8** %3, i64
  %40 = va_arg i8** %3, double
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0), i32 %31)
  %42 = sext i16 %32 to i32
  %43 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i32 %42)
  %44 = sext i8 %33 to i32
  %45 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i32 %44)
  %46 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0), i32 %34)
  %47 = zext i16 %35 to i32
  %48 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i64 0, i64 0), i32 %47)
  %49 = zext i8 %36 to i32
  %50 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i32 %49)
  %51 = fpext float %37 to double
  %52 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i64 0, i64 0), double %51)
  %53 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.7, i64 0, i64 0), i8* %38)
  %54 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.8, i64 0, i64 0), i64 %39)
  %55 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.9, i64 0, i64 0), double %40)
  call void @llvm.va_end(i8* nonnull %5)
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %5)
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %4)
  ret i32 0
}

declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture)
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare i32 @printf(i8* nocapture readonly, ...)
declare void @llvm.va_end(i8*)
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture)

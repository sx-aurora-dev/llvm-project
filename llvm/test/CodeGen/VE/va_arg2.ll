; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

%struct.tag = type { i32, i32 }

@.str = private unnamed_addr constant [7 x i8] c"a=%Lf\0A\00", align 1
@.str.1 = private unnamed_addr constant [8 x i8] c"b.x=%d\0A\00", align 1
@.str.2 = private unnamed_addr constant [7 x i8] c"c=%Lf\0A\00", align 1
@.str.3 = private unnamed_addr constant [7 x i8] c"d=%lf\0A\00", align 1
@.str.4 = private unnamed_addr constant [6 x i8] c"e=%f\0A\00", align 1

; Function Attrs: nounwind
define i32 @func(i32, ...) {
; CHECK-LABEL: func:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK:       lea %s34, 199(%s9)
; CHECK:       and %s34, -16, %s34
; CHECK:       or %s35, 8, %s34
; CHECK:       ld %s2, (,%s35)
; CHECK:       ld %s3, (,%s34)
; CHECK:       ld %s35, 16(,%s34)
; CHECK:       ldl.sx %s19, (,%s35)
; CHECK:       ldl.sx %s21, 4(,%s35)
; CHECK:       ld %s35, 24(,%s34)
; CHECK:       ld %s24, 8(,%s35)
; CHECK:       ld %s25, (,%s35)
; CHECK:       ld %s22, 24(,%s35)
; CHECK:       ld %s23, 16(,%s35)
; CHECK:       ld %s35, 32(,%s34)
; CHECK:       ld %s26, (,%s35)
; CHECK:       ld %s27, 8(,%s35)
; CHECK:       ld %s34, 40(,%s34)
; CHECK:       ldu %s28, (,%s34)
; CHECK:       ldu %s29, 4(,%s34)

  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = bitcast i8** %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %4)
  %5 = bitcast i8** %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %5)
  call void @llvm.va_start(i8* nonnull %4)
  call void @llvm.va_copy(i8* nonnull %5, i8* nonnull %4)
  %6 = va_arg i8** %2, fp128
  %7 = va_arg i8** %2, %struct.tag*
  %8 = getelementptr inbounds %struct.tag, %struct.tag* %7, i64 0, i32 0
  %9 = load i32, i32* %8, align 4
  %10 = getelementptr inbounds %struct.tag, %struct.tag* %7, i64 0, i32 1
  %11 = load i32, i32* %10, align 4
  %12 = va_arg i8** %2, { fp128, fp128 }*
  %13 = getelementptr inbounds { fp128, fp128 }, { fp128, fp128 }* %12, i64 0, i32 0
  %14 = load fp128, fp128* %13, align 16
  %15 = getelementptr inbounds { fp128, fp128 }, { fp128, fp128 }* %12, i64 0, i32 1
  %16 = load fp128, fp128* %15, align 16
  %17 = va_arg i8** %2, { double, double }*
  %18 = getelementptr inbounds { double, double }, { double, double }* %17, i64 0, i32 0
  %19 = load double, double* %18, align 8
  %20 = getelementptr inbounds { double, double }, { double, double }* %17, i64 0, i32 1
  %21 = load double, double* %20, align 8
  %22 = va_arg i8** %2, { float, float }*
  %23 = getelementptr inbounds { float, float }, { float, float }* %22, i64 0, i32 0
  %24 = load float, float* %23, align 4
  %25 = getelementptr inbounds { float, float }, { float, float }* %22, i64 0, i32 1
  %26 = load float, float* %25, align 4
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i64 0, i64 0), fp128 %6)
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i32 %9)
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i32 %11)
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i64 0, i64 0), fp128 %14)
  %31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i64 0, i64 0), fp128 %16)
  %32 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.3, i64 0, i64 0), double %19)
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.3, i64 0, i64 0), double %21)
  %34 = fpext float %24 to double
  %35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i64 0, i64 0), double %34)
  %36 = fpext float %26 to double
  %37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i64 0, i64 0), double %36)
  call void @llvm.va_end(i8* nonnull %4)
  %38 = va_arg i8** %3, fp128
  %39 = va_arg i8** %3, %struct.tag*
  %40 = getelementptr inbounds %struct.tag, %struct.tag* %39, i64 0, i32 0
  %41 = load i32, i32* %40, align 4
  %42 = getelementptr inbounds %struct.tag, %struct.tag* %39, i64 0, i32 1
  %43 = load i32, i32* %42, align 4
  %44 = va_arg i8** %3, { fp128, fp128 }*
  %45 = getelementptr inbounds { fp128, fp128 }, { fp128, fp128 }* %44, i64 0, i32 0
  %46 = load fp128, fp128* %45, align 16
  %47 = getelementptr inbounds { fp128, fp128 }, { fp128, fp128 }* %44, i64 0, i32 1
  %48 = load fp128, fp128* %47, align 16
  %49 = va_arg i8** %3, { double, double }*
  %50 = getelementptr inbounds { double, double }, { double, double }* %49, i64 0, i32 0
  %51 = load double, double* %50, align 8
  %52 = getelementptr inbounds { double, double }, { double, double }* %49, i64 0, i32 1
  %53 = load double, double* %52, align 8
  %54 = va_arg i8** %3, { float, float }*
  %55 = getelementptr inbounds { float, float }, { float, float }* %54, i64 0, i32 0
  %56 = load float, float* %55, align 4
  %57 = getelementptr inbounds { float, float }, { float, float }* %54, i64 0, i32 1
  %58 = load float, float* %57, align 4
  %59 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i64 0, i64 0), fp128 %38)
  %60 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i32 %41)
  %61 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i32 %43)
  %62 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i64 0, i64 0), fp128 %46)
  %63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i64 0, i64 0), fp128 %48)
  %64 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.3, i64 0, i64 0), double %51)
  %65 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.3, i64 0, i64 0), double %53)
  %66 = fpext float %56 to double
  %67 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i64 0, i64 0), double %66)
  %68 = fpext float %58 to double
  %69 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i64 0, i64 0), double %68)
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

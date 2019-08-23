; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define void @test1(i32*, i32*, i32) {
; CHECK-LABEL: test1:
; CHECK:       vfmk.w.ne %vm1,%v2
; CHECK-NEXT:  svm %s16,%vm1,0
; CHECK-NEXT:  st %s16, -32(,%s9)
; CHECK-NEXT:  svm %s16,%vm1,1
; CHECK-NEXT:  st %s16, -24(,%s9)
; CHECK-NEXT:  svm %s16,%vm1,2
; CHECK-NEXT:  st %s16, -16(,%s9)
; CHECK-NEXT:  svm %s16,%vm1,3
; CHECK-NEXT:  st %s16, -8(,%s9)               # 32-byte Folded Spill
; CHECK:       # implicit-def: $vm2
; CHECK-NEXT:  ld %s16, -32(,%s9)
; CHECK-NEXT:  lvm %vm2,0,%s16
; CHECK-NEXT:  ld %s16, -24(,%s9)
; CHECK-NEXT:  lvm %vm2,1,%s16
; CHECK-NEXT:  ld %s16, -16(,%s9)
; CHECK-NEXT:  lvm %vm2,2,%s16
; CHECK-NEXT:  ld %s16, -8(,%s9)               # 32-byte Folded Reload
; CHECK-NEXT:  lvm %vm2,3,%s16
; CHECK-NEXT:  vmrg %v2,%v2,%v3,%vm2
  %4 = shl nsw i32 %2, 1
  %5 = sext i32 %4 to i64
  %6 = shl nsw i64 %5, 2
  %7 = tail call i8* @aligned_alloc(i64 64, i64 %6)
  %8 = bitcast i8* %7 to i32*
  %9 = load i32, i32* %0, align 4, !tbaa !2
  %10 = load i32, i32* %1, align 4, !tbaa !2
  %11 = icmp slt i32 %9, %10
  %12 = add nsw i32 %4, -256
  %13 = icmp sgt i32 %12, 0
  br i1 %13, label %14, label %134

; <label>:14:                                     ; preds = %3
  %15 = select i1 %11, i32* %0, i32* %1
  %16 = bitcast i32* %15 to i8*
  %17 = tail call <256 x double> @llvm.ve.vldlsx.vss(i64 4, i8* %16)
  %18 = select i1 %11, i32 256, i32 0
  %19 = select i1 %11, i32 0, i32 256
  %20 = tail call <256 x double> @llvm.ve.vseq.v()
  %21 = tail call <256 x double> @llvm.ve.vand.vsv(i64 128, <256 x double> %20)
  %22 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 9, <256 x double> %21)
  %23 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 10, <256 x double> %21)
  %24 = tail call <256 x double> @llvm.ve.vand.vsv(i64 64, <256 x double> %20)
  %25 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 9, <256 x double> %24)
  %26 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 10, <256 x double> %24)
  %27 = tail call <256 x double> @llvm.ve.vand.vsv(i64 32, <256 x double> %20)
  %28 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 9, <256 x double> %27)
  %29 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 10, <256 x double> %27)
  %30 = tail call <256 x double> @llvm.ve.vand.vsv(i64 16, <256 x double> %20)
  %31 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 9, <256 x double> %30)
  %32 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 10, <256 x double> %30)
  %33 = tail call <256 x double> @llvm.ve.vand.vsv(i64 8, <256 x double> %20)
  %34 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 9, <256 x double> %33)
  %35 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 10, <256 x double> %33)
  %36 = tail call <256 x double> @llvm.ve.vand.vsv(i64 4, <256 x double> %20)
  %37 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 9, <256 x double> %36)
  %38 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 10, <256 x double> %36)
  %39 = tail call <256 x double> @llvm.ve.vand.vsv(i64 2, <256 x double> %20)
  %40 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 9, <256 x double> %39)
  %41 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 10, <256 x double> %39)
  %42 = tail call <256 x double> @llvm.ve.vand.vsv(i64 1, <256 x double> %20)
  %43 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 9, <256 x double> %42)
  %44 = tail call <4 x i64> @llvm.ve.vfmkw.mcv(i32 10, <256 x double> %42)
  br label %45

; <label>:45:                                     ; preds = %14, %65
  %46 = phi i64 [ 0, %14 ], [ %128, %65 ]
  %47 = phi i32 [ %18, %14 ], [ %69, %65 ]
  %48 = phi i32 [ %19, %14 ], [ %68, %65 ]
  %49 = phi <256 x double> [ %17, %14 ], [ %131, %65 ]
  %50 = icmp eq i32 %48, %2
  br i1 %50, label %61, label %51

; <label>:51:                                     ; preds = %45
  %52 = icmp slt i32 %47, %2
  br i1 %52, label %53, label %63

; <label>:53:                                     ; preds = %51
  %54 = sext i32 %47 to i64
  %55 = getelementptr inbounds i32, i32* %0, i64 %54
  %56 = load i32, i32* %55, align 4, !tbaa !2
  %57 = sext i32 %48 to i64
  %58 = getelementptr inbounds i32, i32* %1, i64 %57
  %59 = load i32, i32* %58, align 4, !tbaa !2
  %60 = icmp slt i32 %56, %59
  br i1 %60, label %61, label %63

; <label>:61:                                     ; preds = %53, %45
  %62 = add nsw i32 %47, 256
  br label %65

; <label>:63:                                     ; preds = %53, %51
  %64 = add nsw i32 %48, 256
  br label %65

; <label>:65:                                     ; preds = %63, %61
  %66 = phi i32 [ %48, %63 ], [ %47, %61 ]
  %67 = phi i32* [ %1, %63 ], [ %0, %61 ]
  %68 = phi i32 [ %64, %63 ], [ %48, %61 ]
  %69 = phi i32 [ %47, %63 ], [ %62, %61 ]
  %70 = add nsw i32 %66, 255
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds i32, i32* %67, i64 %71
  %73 = bitcast i32* %72 to i8*
  %74 = tail call <256 x double> @llvm.ve.vldlsx.vss(i64 -4, i8* %73)
  %75 = tail call <256 x double> @llvm.ve.vminswsx.vvv(<256 x double> %49, <256 x double> %74)
  %76 = tail call <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double> %49, <256 x double> %74)
  %77 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 128, <256 x double> %75)
  %78 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 128, <256 x double> %76)
  %79 = tail call <256 x double> @llvm.ve.vmrg.vvvm(<256 x double> %75, <256 x double> %78, <4 x i64> %22)
  %80 = tail call <256 x double> @llvm.ve.vmrg.vvvm(<256 x double> %76, <256 x double> %77, <4 x i64> %23)
  %81 = tail call <256 x double> @llvm.ve.vminswsx.vvv(<256 x double> %79, <256 x double> %80)
  %82 = tail call <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double> %79, <256 x double> %80)
  %83 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 64, <256 x double> %81)
  %84 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 192, <256 x double> %82)
  %85 = tail call <256 x double> @llvm.ve.vmrg.vvvm(<256 x double> %81, <256 x double> %84, <4 x i64> %25)
  %86 = tail call <256 x double> @llvm.ve.vmrg.vvvm(<256 x double> %82, <256 x double> %83, <4 x i64> %26)
  %87 = tail call <256 x double> @llvm.ve.vminswsx.vvv(<256 x double> %85, <256 x double> %86)
  %88 = tail call <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double> %85, <256 x double> %86)
  %89 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 32, <256 x double> %87)
  %90 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 224, <256 x double> %88)
  %91 = tail call <256 x double> @llvm.ve.vmrg.vvvm(<256 x double> %87, <256 x double> %90, <4 x i64> %28)
  %92 = tail call <256 x double> @llvm.ve.vmrg.vvvm(<256 x double> %88, <256 x double> %89, <4 x i64> %29)
  %93 = tail call <256 x double> @llvm.ve.vminswsx.vvv(<256 x double> %91, <256 x double> %92)
  %94 = tail call <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double> %91, <256 x double> %92)
  %95 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 16, <256 x double> %93)
  %96 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 240, <256 x double> %94)
  %97 = tail call <256 x double> @llvm.ve.vmrg.vvvm(<256 x double> %93, <256 x double> %96, <4 x i64> %31)
  %98 = tail call <256 x double> @llvm.ve.vmrg.vvvm(<256 x double> %94, <256 x double> %95, <4 x i64> %32)
  %99 = tail call <256 x double> @llvm.ve.vminswsx.vvv(<256 x double> %97, <256 x double> %98)
  %100 = tail call <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double> %97, <256 x double> %98)
  %101 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 8, <256 x double> %99)
  %102 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 248, <256 x double> %100)
  %103 = tail call <256 x double> @llvm.ve.vmrg.vvvm(<256 x double> %99, <256 x double> %102, <4 x i64> %34)
  %104 = tail call <256 x double> @llvm.ve.vmrg.vvvm(<256 x double> %100, <256 x double> %101, <4 x i64> %35)
  %105 = tail call <256 x double> @llvm.ve.vminswsx.vvv(<256 x double> %103, <256 x double> %104)
  %106 = tail call <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double> %103, <256 x double> %104)
  %107 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 4, <256 x double> %105)
  %108 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 252, <256 x double> %106)
  %109 = tail call <256 x double> @llvm.ve.vmrg.vvvm(<256 x double> %105, <256 x double> %108, <4 x i64> %37)
  %110 = tail call <256 x double> @llvm.ve.vmrg.vvvm(<256 x double> %106, <256 x double> %107, <4 x i64> %38)
  %111 = tail call <256 x double> @llvm.ve.vminswsx.vvv(<256 x double> %109, <256 x double> %110)
  %112 = tail call <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double> %109, <256 x double> %110)
  %113 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 2, <256 x double> %111)
  %114 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 254, <256 x double> %112)
  %115 = tail call <256 x double> @llvm.ve.vmrg.vvvm(<256 x double> %111, <256 x double> %114, <4 x i64> %40)
  %116 = tail call <256 x double> @llvm.ve.vmrg.vvvm(<256 x double> %112, <256 x double> %113, <4 x i64> %41)
  %117 = tail call <256 x double> @llvm.ve.vminswsx.vvv(<256 x double> %115, <256 x double> %116)
  %118 = tail call <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double> %115, <256 x double> %116)
  %119 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 1, <256 x double> %117)
  %120 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 255, <256 x double> %118)
  %121 = tail call <256 x double> @llvm.ve.vmrg.vvvm(<256 x double> %117, <256 x double> %120, <4 x i64> %43)
  %122 = tail call <256 x double> @llvm.ve.vmrg.vvvm(<256 x double> %118, <256 x double> %119, <4 x i64> %44)
  %123 = getelementptr inbounds i32, i32* %8, i64 %46
  %124 = bitcast i32* %123 to i8*
  tail call void @llvm.ve.vstl.vss(<256 x double> %121, i64 8, i8* %124)
  %125 = or i64 %46, 1
  %126 = getelementptr inbounds i32, i32* %8, i64 %125
  %127 = bitcast i32* %126 to i8*
  tail call void @llvm.ve.vstl.vss(<256 x double> %122, i64 8, i8* nonnull %127)
  %128 = add nuw i64 %46, 256
  %129 = getelementptr inbounds i32, i32* %8, i64 %128
  %130 = bitcast i32* %129 to i8*
  %131 = tail call <256 x double> @llvm.ve.vldlsx.vss(i64 4, i8* nonnull %130)
  %132 = trunc i64 %128 to i32
  %133 = icmp sgt i32 %12, %132
  br i1 %133, label %45, label %134

; <label>:134:                                    ; preds = %65, %3
  tail call void @free(i8* %7)
  ret void
}

declare i8* @aligned_alloc(i64, i64)

; Function Attrs: nounwind readonly
declare <256 x double> @llvm.ve.vldlsx.vss(i64, i8*)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vminswsx.vvv(<256 x double>, <256 x double>)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double>, <256 x double>)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vseq.v()

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vand.vsv(i64, <256 x double>)

; Function Attrs: nounwind readnone
declare <4 x i64> @llvm.ve.vfmkw.mcv(i32, <256 x double>)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vmv.vsv(i32, <256 x double>)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vmrg.vvvm(<256 x double>, <256 x double>, <4 x i64>)

; Function Attrs: nounwind writeonly
declare void @llvm.ve.vstl.vss(<256 x double>, i64, i8*)

; Function Attrs: nounwind
declare void @free(i8* nocapture)

define void @test2(i32*, i32*, i32) {
; CHECK-LABEL: test2:
; CHECK:       pvfmk.w.up.ne %vm2,%v2
; CHECK-NEXT:  vfmk.w.ne %vm3,%v2
; CHECK-NEXT:  svm %s16,%vm3,0
; CHECK-NEXT:  st %s16, -64(,%s9)
; CHECK-NEXT:  svm %s16,%vm3,1
; CHECK-NEXT:  st %s16, -56(,%s9)
; CHECK-NEXT:  svm %s16,%vm3,2
; CHECK-NEXT:  st %s16, -48(,%s9)
; CHECK-NEXT:  svm %s16,%vm3,3
; CHECK-NEXT:  st %s16, -40(,%s9)
; CHECK-NEXT:  svm %s16,%vm2,0
; CHECK-NEXT:  st %s16, -32(,%s9)
; CHECK-NEXT:  svm %s16,%vm2,1
; CHECK-NEXT:  st %s16, -24(,%s9)
; CHECK-NEXT:  svm %s16,%vm2,2
; CHECK-NEXT:  st %s16, -16(,%s9)
; CHECK-NEXT:  svm %s16,%vm2,3
; CHECK-NEXT:  st %s16, -8(,%s9)               # 64-byte Folded Spill
; CHECK:       # implicit-def: $vmp3
; CHECK-NEXT:  ld %s16, -64(,%s9)
; CHECK-NEXT:  lvm %vm7,0,%s16
; CHECK-NEXT:  ld %s16, -56(,%s9)
; CHECK-NEXT:  lvm %vm7,1,%s16
; CHECK-NEXT:  ld %s16, -48(,%s9)
; CHECK-NEXT:  lvm %vm7,2,%s16
; CHECK-NEXT:  ld %s16, -40(,%s9)
; CHECK-NEXT:  lvm %vm7,3,%s16
; CHECK-NEXT:  ld %s16, -32(,%s9)
; CHECK-NEXT:  lvm %vm6,0,%s16
; CHECK-NEXT:  ld %s16, -24(,%s9)
; CHECK-NEXT:  lvm %vm6,1,%s16
; CHECK-NEXT:  ld %s16, -16(,%s9)
; CHECK-NEXT:  lvm %vm6,2,%s16
; CHECK-NEXT:  ld %s16, -8(,%s9)               # 64-byte Folded Reload
; CHECK-NEXT:  lvm %vm6,3,%s16
; CHECK-NEXT:  vmrg.w %v2,%v2,%v3,%vm6
  %4 = shl nsw i32 %2, 1
  %5 = sext i32 %4 to i64
  %6 = shl nsw i64 %5, 2
  %7 = tail call i8* @aligned_alloc(i64 64, i64 %6)
  %8 = bitcast i8* %7 to i32*
  %9 = load i32, i32* %0, align 4, !tbaa !2
  %10 = load i32, i32* %1, align 4, !tbaa !2
  %11 = icmp slt i32 %9, %10
  %12 = add nsw i32 %4, -256
  %13 = icmp sgt i32 %12, 0
  br i1 %13, label %14, label %134

; <label>:14:                                     ; preds = %3
  %15 = select i1 %11, i32* %0, i32* %1
  %16 = bitcast i32* %15 to i8*
  %17 = tail call <256 x double> @llvm.ve.vldlsx.vss(i64 4, i8* %16)
  %18 = select i1 %11, i32 256, i32 0
  %19 = select i1 %11, i32 0, i32 256
  %20 = tail call <256 x double> @llvm.ve.vseq.v()
  %21 = tail call <256 x double> @llvm.ve.vand.vsv(i64 128, <256 x double> %20)
  %22 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 9, <256 x double> %21)
  %23 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 10, <256 x double> %21)
  %24 = tail call <256 x double> @llvm.ve.vand.vsv(i64 64, <256 x double> %20)
  %25 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 9, <256 x double> %24)
  %26 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 10, <256 x double> %24)
  %27 = tail call <256 x double> @llvm.ve.vand.vsv(i64 32, <256 x double> %20)
  %28 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 9, <256 x double> %27)
  %29 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 10, <256 x double> %27)
  %30 = tail call <256 x double> @llvm.ve.vand.vsv(i64 16, <256 x double> %20)
  %31 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 9, <256 x double> %30)
  %32 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 10, <256 x double> %30)
  %33 = tail call <256 x double> @llvm.ve.vand.vsv(i64 8, <256 x double> %20)
  %34 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 9, <256 x double> %33)
  %35 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 10, <256 x double> %33)
  %36 = tail call <256 x double> @llvm.ve.vand.vsv(i64 4, <256 x double> %20)
  %37 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 9, <256 x double> %36)
  %38 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 10, <256 x double> %36)
  %39 = tail call <256 x double> @llvm.ve.vand.vsv(i64 2, <256 x double> %20)
  %40 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 9, <256 x double> %39)
  %41 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 10, <256 x double> %39)
  %42 = tail call <256 x double> @llvm.ve.vand.vsv(i64 1, <256 x double> %20)
  %43 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 9, <256 x double> %42)
  %44 = tail call <8 x i64> @llvm.ve.pvfmkw.Mcv(i32 10, <256 x double> %42)
  br label %45

; <label>:45:                                     ; preds = %14, %65
  %46 = phi i64 [ 0, %14 ], [ %128, %65 ]
  %47 = phi i32 [ %18, %14 ], [ %69, %65 ]
  %48 = phi i32 [ %19, %14 ], [ %68, %65 ]
  %49 = phi <256 x double> [ %17, %14 ], [ %131, %65 ]
  %50 = icmp eq i32 %48, %2
  br i1 %50, label %61, label %51

; <label>:51:                                     ; preds = %45
  %52 = icmp slt i32 %47, %2
  br i1 %52, label %53, label %63

; <label>:53:                                     ; preds = %51
  %54 = sext i32 %47 to i64
  %55 = getelementptr inbounds i32, i32* %0, i64 %54
  %56 = load i32, i32* %55, align 4, !tbaa !2
  %57 = sext i32 %48 to i64
  %58 = getelementptr inbounds i32, i32* %1, i64 %57
  %59 = load i32, i32* %58, align 4, !tbaa !2
  %60 = icmp slt i32 %56, %59
  br i1 %60, label %61, label %63

; <label>:61:                                     ; preds = %53, %45
  %62 = add nsw i32 %47, 256
  br label %65

; <label>:63:                                     ; preds = %53, %51
  %64 = add nsw i32 %48, 256
  br label %65

; <label>:65:                                     ; preds = %63, %61
  %66 = phi i32 [ %48, %63 ], [ %47, %61 ]
  %67 = phi i32* [ %1, %63 ], [ %0, %61 ]
  %68 = phi i32 [ %64, %63 ], [ %48, %61 ]
  %69 = phi i32 [ %47, %63 ], [ %62, %61 ]
  %70 = add nsw i32 %66, 255
  %71 = sext i32 %70 to i64
  %72 = getelementptr inbounds i32, i32* %67, i64 %71
  %73 = bitcast i32* %72 to i8*
  %74 = tail call <256 x double> @llvm.ve.vldlsx.vss(i64 -4, i8* %73)
  %75 = tail call <256 x double> @llvm.ve.vminswsx.vvv(<256 x double> %49, <256 x double> %74)
  %76 = tail call <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double> %49, <256 x double> %74)
  %77 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 128, <256 x double> %75)
  %78 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 128, <256 x double> %76)
  %79 = tail call <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double> %75, <256 x double> %78, <8 x i64> %22)
  %80 = tail call <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double> %76, <256 x double> %77, <8 x i64> %23)
  %81 = tail call <256 x double> @llvm.ve.vminswsx.vvv(<256 x double> %79, <256 x double> %80)
  %82 = tail call <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double> %79, <256 x double> %80)
  %83 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 64, <256 x double> %81)
  %84 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 192, <256 x double> %82)
  %85 = tail call <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double> %81, <256 x double> %84, <8 x i64> %25)
  %86 = tail call <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double> %82, <256 x double> %83, <8 x i64> %26)
  %87 = tail call <256 x double> @llvm.ve.vminswsx.vvv(<256 x double> %85, <256 x double> %86)
  %88 = tail call <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double> %85, <256 x double> %86)
  %89 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 32, <256 x double> %87)
  %90 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 224, <256 x double> %88)
  %91 = tail call <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double> %87, <256 x double> %90, <8 x i64> %28)
  %92 = tail call <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double> %88, <256 x double> %89, <8 x i64> %29)
  %93 = tail call <256 x double> @llvm.ve.vminswsx.vvv(<256 x double> %91, <256 x double> %92)
  %94 = tail call <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double> %91, <256 x double> %92)
  %95 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 16, <256 x double> %93)
  %96 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 240, <256 x double> %94)
  %97 = tail call <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double> %93, <256 x double> %96, <8 x i64> %31)
  %98 = tail call <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double> %94, <256 x double> %95, <8 x i64> %32)
  %99 = tail call <256 x double> @llvm.ve.vminswsx.vvv(<256 x double> %97, <256 x double> %98)
  %100 = tail call <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double> %97, <256 x double> %98)
  %101 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 8, <256 x double> %99)
  %102 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 248, <256 x double> %100)
  %103 = tail call <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double> %99, <256 x double> %102, <8 x i64> %34)
  %104 = tail call <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double> %100, <256 x double> %101, <8 x i64> %35)
  %105 = tail call <256 x double> @llvm.ve.vminswsx.vvv(<256 x double> %103, <256 x double> %104)
  %106 = tail call <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double> %103, <256 x double> %104)
  %107 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 4, <256 x double> %105)
  %108 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 252, <256 x double> %106)
  %109 = tail call <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double> %105, <256 x double> %108, <8 x i64> %37)
  %110 = tail call <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double> %106, <256 x double> %107, <8 x i64> %38)
  %111 = tail call <256 x double> @llvm.ve.vminswsx.vvv(<256 x double> %109, <256 x double> %110)
  %112 = tail call <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double> %109, <256 x double> %110)
  %113 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 2, <256 x double> %111)
  %114 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 254, <256 x double> %112)
  %115 = tail call <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double> %111, <256 x double> %114, <8 x i64> %40)
  %116 = tail call <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double> %112, <256 x double> %113, <8 x i64> %41)
  %117 = tail call <256 x double> @llvm.ve.vminswsx.vvv(<256 x double> %115, <256 x double> %116)
  %118 = tail call <256 x double> @llvm.ve.vmaxswsx.vvv(<256 x double> %115, <256 x double> %116)
  %119 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 1, <256 x double> %117)
  %120 = tail call <256 x double> @llvm.ve.vmv.vsv(i32 255, <256 x double> %118)
  %121 = tail call <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double> %117, <256 x double> %120, <8 x i64> %43)
  %122 = tail call <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double> %118, <256 x double> %119, <8 x i64> %44)
  %123 = getelementptr inbounds i32, i32* %8, i64 %46
  %124 = bitcast i32* %123 to i8*
  tail call void @llvm.ve.vstl.vss(<256 x double> %121, i64 8, i8* %124)
  %125 = or i64 %46, 1
  %126 = getelementptr inbounds i32, i32* %8, i64 %125
  %127 = bitcast i32* %126 to i8*
  tail call void @llvm.ve.vstl.vss(<256 x double> %122, i64 8, i8* nonnull %127)
  %128 = add nuw i64 %46, 256
  %129 = getelementptr inbounds i32, i32* %8, i64 %128
  %130 = bitcast i32* %129 to i8*
  %131 = tail call <256 x double> @llvm.ve.vldlsx.vss(i64 4, i8* nonnull %130)
  %132 = trunc i64 %128 to i32
  %133 = icmp sgt i32 %12, %132
  br i1 %133, label %45, label %134

; <label>:134:                                    ; preds = %65, %3
  tail call void @free(i8* %7)
  ret void
}

; Function Attrs: nounwind readnone
declare <8 x i64> @llvm.ve.pvfmkw.Mcv(i32, <256 x double>)

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vmrgw.vvvM(<256 x double>, <256 x double>, <8 x i64>)

!2 = !{!3, !3, i64 0}
!3 = !{!"int", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C++ TBAA"}

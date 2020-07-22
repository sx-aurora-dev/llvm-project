; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define i32 @brd_v4i32() {
; CHECK-LABEL: brd_v4i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 4, (0)1
; CHECK-NEXT:    or %s1, 2, (0)1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vbrdl %v0,%s1
; CHECK-NEXT:    lea %s0, calc_v4i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v4i32@hi(, %s0)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 2, i32 2, i32 2, i32 2>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

declare <4 x i32> @calc_v4i32(<4 x i32>)

; Function Attrs: nounwind
define i32 @brd_v256i32() {
; CHECK-LABEL: brd_v256i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    or %s1, 2, (0)1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vbrdl %v0,%s1
; CHECK-NEXT:    lea %s0, calc_v256i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v256i32@hi(, %s0)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %call = tail call <256 x i32> @calc_v256i32(<256 x i32>
    <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2,
     i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>)
  %elems.sroa.0.8.vec.extract = extractelement <256 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

declare <256 x i32> @calc_v256i32(<256 x i32>)

; Function Attrs: nounwind
define i32 @vseq_v4i32() {
; CHECK-LABEL: vseq_v4i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, calc_v4i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v4i32@hi(, %s0)
; CHECK-NEXT:    or %s0, 4, (0)1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvseq.lo %v0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 0, i32 1, i32 2, i32 3>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseq_v256i32() {
; CHECK-LABEL: vseq_v256i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, calc_v256i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v256i32@hi(, %s0)
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvseq.lo %v0
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %call = tail call <256 x i32> @calc_v256i32(<256 x i32>
    <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7,
     i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15,
     i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23,
     i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31,
     i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39,
     i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47,
     i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55,
     i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63,
     i32 64, i32 65, i32 66, i32 67, i32 68, i32 69, i32 70, i32 71,
     i32 72, i32 73, i32 74, i32 75, i32 76, i32 77, i32 78, i32 79,
     i32 80, i32 81, i32 82, i32 83, i32 84, i32 85, i32 86, i32 87,
     i32 88, i32 89, i32 90, i32 91, i32 92, i32 93, i32 94, i32 95,
     i32 96, i32 97, i32 98, i32 99, i32 100, i32 101, i32 102, i32 103,
     i32 104, i32 105, i32 106, i32 107, i32 108, i32 109, i32 110, i32 111,
     i32 112, i32 113, i32 114, i32 115, i32 116, i32 117, i32 118, i32 119,
     i32 120, i32 121, i32 122, i32 123, i32 124, i32 125, i32 126, i32 127,
     i32 128, i32 129, i32 130, i32 131, i32 132, i32 133, i32 134, i32 135,
     i32 136, i32 137, i32 138, i32 139, i32 140, i32 141, i32 142, i32 143,
     i32 144, i32 145, i32 146, i32 147, i32 148, i32 149, i32 150, i32 151,
     i32 152, i32 153, i32 154, i32 155, i32 156, i32 157, i32 158, i32 159,
     i32 160, i32 161, i32 162, i32 163, i32 164, i32 165, i32 166, i32 167,
     i32 168, i32 169, i32 170, i32 171, i32 172, i32 173, i32 174, i32 175,
     i32 176, i32 177, i32 178, i32 179, i32 180, i32 181, i32 182, i32 183,
     i32 184, i32 185, i32 186, i32 187, i32 188, i32 189, i32 190, i32 191,
     i32 192, i32 193, i32 194, i32 195, i32 196, i32 197, i32 198, i32 199,
     i32 200, i32 201, i32 202, i32 203, i32 204, i32 205, i32 206, i32 207,
     i32 208, i32 209, i32 210, i32 211, i32 212, i32 213, i32 214, i32 215,
     i32 216, i32 217, i32 218, i32 219, i32 220, i32 221, i32 222, i32 223,
     i32 224, i32 225, i32 226, i32 227, i32 228, i32 229, i32 230, i32 231,
     i32 232, i32 233, i32 234, i32 235, i32 236, i32 237, i32 238, i32 239,
     i32 240, i32 241, i32 242, i32 243, i32 244, i32 245, i32 246, i32 247,
     i32 248, i32 249, i32 250, i32 251, i32 252, i32 253, i32 254, i32 255>)
  %elems.sroa.0.8.vec.extract = extractelement <256 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseq_bad_v4i32() {
; CHECK-LABEL: vseq_bad_v4i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 3, (0)1
; CHECK-NEXT:    or %s1, 2, (0)1
; CHECK-NEXT:    lsv %v0(0),%s1
; CHECK-NEXT:    lsv %v0(1),%s0
; CHECK-NEXT:    or %s0, 4, (0)1
; CHECK-NEXT:    lsv %v0(2),%s0
; CHECK-NEXT:    or %s0, 5, (0)1
; CHECK-NEXT:    lsv %v0(3),%s0
; CHECK-NEXT:    lea %s0, calc_v4i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v4i32@hi(, %s0)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 2, i32 3, i32 4, i32 5>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseq_bad_v256i32() {
; CHECK-LABEL: vseq_bad_v256i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lea %s1, .LCPI5_0@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI5_0@hi(, %s1)
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vldl.zx %v0,4,%s1
; CHECK-NEXT:    lea %s0, calc_v256i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v256i32@hi(, %s0)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %call = tail call <256 x i32> @calc_v256i32(<256 x i32>
    <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15,
     i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23,
     i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31,
     i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39,
     i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47,
     i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55,
     i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63,
     i32 64, i32 65, i32 66, i32 67, i32 68, i32 69, i32 70, i32 71,
     i32 72, i32 73, i32 74, i32 75, i32 76, i32 77, i32 78, i32 79,
     i32 80, i32 81, i32 82, i32 83, i32 84, i32 85, i32 86, i32 87,
     i32 88, i32 89, i32 90, i32 91, i32 92, i32 93, i32 94, i32 95,
     i32 96, i32 97, i32 98, i32 99, i32 100, i32 101, i32 102, i32 103,
     i32 104, i32 105, i32 106, i32 107, i32 108, i32 109, i32 110, i32 111,
     i32 112, i32 113, i32 114, i32 115, i32 116, i32 117, i32 118, i32 119,
     i32 120, i32 121, i32 122, i32 123, i32 124, i32 125, i32 126, i32 127,
     i32 128, i32 129, i32 130, i32 131, i32 132, i32 133, i32 134, i32 135,
     i32 136, i32 137, i32 138, i32 139, i32 140, i32 141, i32 142, i32 143,
     i32 144, i32 145, i32 146, i32 147, i32 148, i32 149, i32 150, i32 151,
     i32 152, i32 153, i32 154, i32 155, i32 156, i32 157, i32 158, i32 159,
     i32 160, i32 161, i32 162, i32 163, i32 164, i32 165, i32 166, i32 167,
     i32 168, i32 169, i32 170, i32 171, i32 172, i32 173, i32 174, i32 175,
     i32 176, i32 177, i32 178, i32 179, i32 180, i32 181, i32 182, i32 183,
     i32 184, i32 185, i32 186, i32 187, i32 188, i32 189, i32 190, i32 191,
     i32 192, i32 193, i32 194, i32 195, i32 196, i32 197, i32 198, i32 199,
     i32 200, i32 201, i32 202, i32 203, i32 204, i32 205, i32 206, i32 207,
     i32 208, i32 209, i32 210, i32 211, i32 212, i32 213, i32 214, i32 215,
     i32 216, i32 217, i32 218, i32 219, i32 220, i32 221, i32 222, i32 223,
     i32 224, i32 225, i32 226, i32 227, i32 228, i32 229, i32 230, i32 231,
     i32 232, i32 233, i32 234, i32 235, i32 236, i32 237, i32 238, i32 239,
     i32 240, i32 241, i32 242, i32 243, i32 244, i32 245, i32 246, i32 247,
     i32 248, i32 249, i32 250, i32 251, i32 252, i32 253, i32 254, i32 255,
     i32 256, i32 257, i32 258, i32 259, i32 260, i32 261, i32 262, i32 263>)
  %elems.sroa.0.8.vec.extract = extractelement <256 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseqmul_v4i32() {
; CHECK-LABEL: vseqmul_v4i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 4, (0)1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvseq.lo %v0
; CHECK-NEXT:    or %s1, 3, (0)1
; CHECK-NEXT:    vmuls.w.sx %v0, %s1, %v0
; CHECK-NEXT:    lea %s0, calc_v4i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v4i32@hi(, %s0)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    or %s11, 0, %s9

entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 0, i32 3, i32 6, i32 9>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseqmul_v256i32() {
; CHECK-LABEL: vseqmul_v256i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvseq.lo %v0
; CHECK-NEXT:    or %s1, 2, (0)1
; CHECK-NEXT:    vmuls.w.sx %v0, %s1, %v0
; CHECK-NEXT:    lea %s0, calc_v256i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v256i32@hi(, %s0)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %call = tail call <256 x i32> @calc_v256i32(<256 x i32>
    <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14,
     i32 16, i32 18, i32 20, i32 22, i32 24, i32 26, i32 28, i32 30,
     i32 32, i32 34, i32 36, i32 38, i32 40, i32 42, i32 44, i32 46,
     i32 48, i32 50, i32 52, i32 54, i32 56, i32 58, i32 60, i32 62,
     i32 64, i32 66, i32 68, i32 70, i32 72, i32 74, i32 76, i32 78,
     i32 80, i32 82, i32 84, i32 86, i32 88, i32 90, i32 92, i32 94,
     i32 96, i32 98, i32 100, i32 102, i32 104, i32 106, i32 108, i32 110,
     i32 112, i32 114, i32 116, i32 118, i32 120, i32 122, i32 124, i32 126,
     i32 128, i32 130, i32 132, i32 134, i32 136, i32 138, i32 140, i32 142,
     i32 144, i32 146, i32 148, i32 150, i32 152, i32 154, i32 156, i32 158,
     i32 160, i32 162, i32 164, i32 166, i32 168, i32 170, i32 172, i32 174,
     i32 176, i32 178, i32 180, i32 182, i32 184, i32 186, i32 188, i32 190,
     i32 192, i32 194, i32 196, i32 198, i32 200, i32 202, i32 204, i32 206,
     i32 208, i32 210, i32 212, i32 214, i32 216, i32 218, i32 220, i32 222,
     i32 224, i32 226, i32 228, i32 230, i32 232, i32 234, i32 236, i32 238,
     i32 240, i32 242, i32 244, i32 246, i32 248, i32 250, i32 252, i32 254,
     i32 256, i32 258, i32 260, i32 262, i32 264, i32 266, i32 268, i32 270,
     i32 272, i32 274, i32 276, i32 278, i32 280, i32 282, i32 284, i32 286,
     i32 288, i32 290, i32 292, i32 294, i32 296, i32 298, i32 300, i32 302,
     i32 304, i32 306, i32 308, i32 310, i32 312, i32 314, i32 316, i32 318,
     i32 320, i32 322, i32 324, i32 326, i32 328, i32 330, i32 332, i32 334,
     i32 336, i32 338, i32 340, i32 342, i32 344, i32 346, i32 348, i32 350,
     i32 352, i32 354, i32 356, i32 358, i32 360, i32 362, i32 364, i32 366,
     i32 368, i32 370, i32 372, i32 374, i32 376, i32 378, i32 380, i32 382,
     i32 384, i32 386, i32 388, i32 390, i32 392, i32 394, i32 396, i32 398,
     i32 400, i32 402, i32 404, i32 406, i32 408, i32 410, i32 412, i32 414,
     i32 416, i32 418, i32 420, i32 422, i32 424, i32 426, i32 428, i32 430,
     i32 432, i32 434, i32 436, i32 438, i32 440, i32 442, i32 444, i32 446,
     i32 448, i32 450, i32 452, i32 454, i32 456, i32 458, i32 460, i32 462,
     i32 464, i32 466, i32 468, i32 470, i32 472, i32 474, i32 476, i32 478,
     i32 480, i32 482, i32 484, i32 486, i32 488, i32 490, i32 492, i32 494,
     i32 496, i32 498, i32 500, i32 502, i32 504, i32 506, i32 508, i32 510>)
  %elems.sroa.0.8.vec.extract = extractelement <256 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseqsrl_v4i32() {
; CHECK-LABEL: vseqsrl_v4i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 4, (0)1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvseq.lo %v0
; CHECK-NEXT:    or %s1, 1, (0)1
; CHECK-NEXT:    pvsrl.lo %v0, %v0, %s1
; CHECK-NEXT:    lea %s0, calc_v4i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v4i32@hi(, %s0)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 0, i32 0, i32 1, i32 1>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseqsrl_v8i32() {
; CHECK-LABEL: vseqsrl_v8i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 8, (0)1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvseq.lo %v0
; CHECK-NEXT:    or %s1, 1, (0)1
; CHECK-NEXT:    pvsrl.lo %v0, %v0, %s1
; CHECK-NEXT:    lea %s0, calc_v8i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v8i32@hi(, %s0)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %call = tail call <8 x i32> @calc_v8i32(<8 x i32> <i32 0, i32 0, i32 1, i32 1, i32 2, i32 2, i32 3, i32 3>)
  %elems.sroa.0.8.vec.extract = extractelement <8 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

declare <8 x i32> @calc_v8i32(<8 x i32>)

; Function Attrs: nounwind
define i32 @vseqsrl_v256i32() {
; CHECK-LABEL: vseqsrl_v256i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvseq.lo %v0
; CHECK-NEXT:    or %s1, 1, (0)1
; CHECK-NEXT:    pvsrl.lo %v0, %v0, %s1
; CHECK-NEXT:    lea %s0, calc_v256i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v256i32@hi(, %s0)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %call = tail call <256 x i32> @calc_v256i32(<256 x i32>
    <i32 0, i32 0, i32 1, i32 1, i32 2, i32 2, i32 3, i32 3,
     i32 4, i32 4, i32 5, i32 5, i32 6, i32 6, i32 7, i32 7,
     i32 8, i32 8, i32 9, i32 9, i32 10, i32 10, i32 11, i32 11,
     i32 12, i32 12, i32 13, i32 13, i32 14, i32 14, i32 15, i32 15,
     i32 16, i32 16, i32 17, i32 17, i32 18, i32 18, i32 19, i32 19,
     i32 20, i32 20, i32 21, i32 21, i32 22, i32 22, i32 23, i32 23,
     i32 24, i32 24, i32 25, i32 25, i32 26, i32 26, i32 27, i32 27,
     i32 28, i32 28, i32 29, i32 29, i32 30, i32 30, i32 31, i32 31,
     i32 32, i32 32, i32 33, i32 33, i32 34, i32 34, i32 35, i32 35,
     i32 36, i32 36, i32 37, i32 37, i32 38, i32 38, i32 39, i32 39,
     i32 40, i32 40, i32 41, i32 41, i32 42, i32 42, i32 43, i32 43,
     i32 44, i32 44, i32 45, i32 45, i32 46, i32 46, i32 47, i32 47,
     i32 48, i32 48, i32 49, i32 49, i32 50, i32 50, i32 51, i32 51,
     i32 52, i32 52, i32 53, i32 53, i32 54, i32 54, i32 55, i32 55,
     i32 56, i32 56, i32 57, i32 57, i32 58, i32 58, i32 59, i32 59,
     i32 60, i32 60, i32 61, i32 61, i32 62, i32 62, i32 63, i32 63,
     i32 64, i32 64, i32 65, i32 65, i32 66, i32 66, i32 67, i32 67,
     i32 68, i32 68, i32 69, i32 69, i32 70, i32 70, i32 71, i32 71,
     i32 72, i32 72, i32 73, i32 73, i32 74, i32 74, i32 75, i32 75,
     i32 76, i32 76, i32 77, i32 77, i32 78, i32 78, i32 79, i32 79,
     i32 80, i32 80, i32 81, i32 81, i32 82, i32 82, i32 83, i32 83,
     i32 84, i32 84, i32 85, i32 85, i32 86, i32 86, i32 87, i32 87,
     i32 88, i32 88, i32 89, i32 89, i32 90, i32 90, i32 91, i32 91,
     i32 92, i32 92, i32 93, i32 93, i32 94, i32 94, i32 95, i32 95,
     i32 96, i32 96, i32 97, i32 97, i32 98, i32 98, i32 99, i32 99,
     i32 100, i32 100, i32 101, i32 101, i32 102, i32 102, i32 103, i32 103,
     i32 104, i32 104, i32 105, i32 105, i32 106, i32 106, i32 107, i32 107,
     i32 108, i32 108, i32 109, i32 109, i32 110, i32 110, i32 111, i32 111,
     i32 112, i32 112, i32 113, i32 113, i32 114, i32 114, i32 115, i32 115,
     i32 116, i32 116, i32 117, i32 117, i32 118, i32 118, i32 119, i32 119,
     i32 120, i32 120, i32 121, i32 121, i32 122, i32 122, i32 123, i32 123,
     i32 124, i32 124, i32 125, i32 125, i32 126, i32 126, i32 127, i32 127>)
  %elems.sroa.0.8.vec.extract = extractelement <256 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseqand_v4i32() {
; CHECK-LABEL: vseqand_v4i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 4, (0)1
; CHECK-NEXT:    or %s1, 1, (0)1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vbrdl %v0,%s1
; CHECK-NEXT:    pvseq.lo %v1
; CHECK-NEXT:    pvand.lo %v0, %v1, %v0
; CHECK-NEXT:    lea %s0, calc_v4i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v4i32@hi(, %s0)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 0, i32 1, i32 0, i32 1>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseqand_v256i32() {
; CHECK-LABEL: vseqand_v256i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    or %s1, 1, (0)1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vbrdl %v0,%s1
; CHECK-NEXT:    pvseq.lo %v1
; CHECK-NEXT:    pvand.lo %v0, %v1, %v0
; CHECK-NEXT:    lea %s0, calc_v256i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v256i32@hi(, %s0)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %call = tail call <256 x i32> @calc_v256i32(<256 x i32>
    <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1,
     i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>)
  %elems.sroa.0.8.vec.extract = extractelement <256 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

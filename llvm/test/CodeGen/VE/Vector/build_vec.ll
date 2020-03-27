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
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
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
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
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
; CHECK-NEXT:    or %s0, 4, (0)1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvseq.lo %v0
; CHECK-NEXT:    lea %s0, calc_v4i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v4i32@hi(, %s0)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
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
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvseq.lo %v0
; CHECK-NEXT:    lea %s0, calc_v256i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v256i32@hi(, %s0)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
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
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
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
; CHECK-NEXT:    or %s0, 9, (0)1
; CHECK-NEXT:    or %s1, 8, (0)1
; CHECK-NEXT:    lsv %v0(0),%s1
; CHECK-NEXT:    lsv %v0(1),%s0
; CHECK-NEXT:    or %s0, 10, (0)1
; CHECK-NEXT:    lsv %v0(2),%s0
; CHECK-NEXT:    or %s0, 11, (0)1
; CHECK-NEXT:    lsv %v0(3),%s0
; CHECK-NEXT:    or %s0, 12, (0)1
; CHECK-NEXT:    lsv %v0(4),%s0
; CHECK-NEXT:    or %s0, 13, (0)1
; CHECK-NEXT:    lsv %v0(5),%s0
; CHECK-NEXT:    or %s0, 14, (0)1
; CHECK-NEXT:    lsv %v0(6),%s0
; CHECK-NEXT:    or %s0, 15, (0)1
; CHECK-NEXT:    lsv %v0(7),%s0
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    lsv %v0(8),%s0
; CHECK-NEXT:    or %s0, 17, (0)1
; CHECK-NEXT:    lsv %v0(9),%s0
; CHECK-NEXT:    or %s0, 18, (0)1
; CHECK-NEXT:    lsv %v0(10),%s0
; CHECK-NEXT:    or %s0, 19, (0)1
; CHECK-NEXT:    lsv %v0(11),%s0
; CHECK-NEXT:    or %s0, 20, (0)1
; CHECK-NEXT:    lsv %v0(12),%s0
; CHECK-NEXT:    or %s0, 21, (0)1
; CHECK-NEXT:    lsv %v0(13),%s0
; CHECK-NEXT:    or %s0, 22, (0)1
; CHECK-NEXT:    lsv %v0(14),%s0
; CHECK-NEXT:    or %s0, 23, (0)1
; CHECK-NEXT:    lsv %v0(15),%s0
; CHECK-NEXT:    or %s0, 24, (0)1
; CHECK-NEXT:    lsv %v0(16),%s0
; CHECK-NEXT:    or %s0, 25, (0)1
; CHECK-NEXT:    lsv %v0(17),%s0
; CHECK-NEXT:    or %s0, 26, (0)1
; CHECK-NEXT:    lsv %v0(18),%s0
; CHECK-NEXT:    or %s0, 27, (0)1
; CHECK-NEXT:    lsv %v0(19),%s0
; CHECK-NEXT:    or %s0, 28, (0)1
; CHECK-NEXT:    lsv %v0(20),%s0
; CHECK-NEXT:    or %s0, 29, (0)1
; CHECK-NEXT:    lsv %v0(21),%s0
; CHECK-NEXT:    or %s0, 30, (0)1
; CHECK-NEXT:    lsv %v0(22),%s0
; CHECK-NEXT:    or %s0, 31, (0)1
; CHECK-NEXT:    lsv %v0(23),%s0
; CHECK-NEXT:    or %s0, 32, (0)1
; CHECK-NEXT:    lsv %v0(24),%s0
; CHECK-NEXT:    or %s0, 33, (0)1
; CHECK-NEXT:    lsv %v0(25),%s0
; CHECK-NEXT:    or %s0, 34, (0)1
; CHECK-NEXT:    lsv %v0(26),%s0
; CHECK-NEXT:    or %s0, 35, (0)1
; CHECK-NEXT:    lsv %v0(27),%s0
; CHECK-NEXT:    or %s0, 36, (0)1
; CHECK-NEXT:    lsv %v0(28),%s0
; CHECK-NEXT:    or %s0, 37, (0)1
; CHECK-NEXT:    lsv %v0(29),%s0
; CHECK-NEXT:    or %s0, 38, (0)1
; CHECK-NEXT:    lsv %v0(30),%s0
; CHECK-NEXT:    or %s0, 39, (0)1
; CHECK-NEXT:    lsv %v0(31),%s0
; CHECK-NEXT:    or %s0, 40, (0)1
; CHECK-NEXT:    lsv %v0(32),%s0
; CHECK-NEXT:    or %s0, 41, (0)1
; CHECK-NEXT:    lsv %v0(33),%s0
; CHECK-NEXT:    or %s0, 42, (0)1
; CHECK-NEXT:    lsv %v0(34),%s0
; CHECK-NEXT:    or %s0, 43, (0)1
; CHECK-NEXT:    lsv %v0(35),%s0
; CHECK-NEXT:    or %s0, 44, (0)1
; CHECK-NEXT:    lsv %v0(36),%s0
; CHECK-NEXT:    or %s0, 45, (0)1
; CHECK-NEXT:    lsv %v0(37),%s0
; CHECK-NEXT:    or %s0, 46, (0)1
; CHECK-NEXT:    lsv %v0(38),%s0
; CHECK-NEXT:    or %s0, 47, (0)1
; CHECK-NEXT:    lsv %v0(39),%s0
; CHECK-NEXT:    or %s0, 48, (0)1
; CHECK-NEXT:    lsv %v0(40),%s0
; CHECK-NEXT:    or %s0, 49, (0)1
; CHECK-NEXT:    lsv %v0(41),%s0
; CHECK-NEXT:    or %s0, 50, (0)1
; CHECK-NEXT:    lsv %v0(42),%s0
; CHECK-NEXT:    or %s0, 51, (0)1
; CHECK-NEXT:    lsv %v0(43),%s0
; CHECK-NEXT:    or %s0, 52, (0)1
; CHECK-NEXT:    lsv %v0(44),%s0
; CHECK-NEXT:    or %s0, 53, (0)1
; CHECK-NEXT:    lsv %v0(45),%s0
; CHECK-NEXT:    or %s0, 54, (0)1
; CHECK-NEXT:    lsv %v0(46),%s0
; CHECK-NEXT:    or %s0, 55, (0)1
; CHECK-NEXT:    lsv %v0(47),%s0
; CHECK-NEXT:    or %s0, 56, (0)1
; CHECK-NEXT:    lsv %v0(48),%s0
; CHECK-NEXT:    or %s0, 57, (0)1
; CHECK-NEXT:    lsv %v0(49),%s0
; CHECK-NEXT:    or %s0, 58, (0)1
; CHECK-NEXT:    lsv %v0(50),%s0
; CHECK-NEXT:    or %s0, 59, (0)1
; CHECK-NEXT:    lsv %v0(51),%s0
; CHECK-NEXT:    or %s0, 60, (0)1
; CHECK-NEXT:    lsv %v0(52),%s0
; CHECK-NEXT:    or %s0, 61, (0)1
; CHECK-NEXT:    lsv %v0(53),%s0
; CHECK-NEXT:    or %s0, 62, (0)1
; CHECK-NEXT:    lsv %v0(54),%s0
; CHECK-NEXT:    or %s0, 63, (0)1
; CHECK-NEXT:    lsv %v0(55),%s0
; CHECK-NEXT:    lea %s0, 64
; CHECK-NEXT:    lsv %v0(56),%s0
; CHECK-NEXT:    lea %s0, 65
; CHECK-NEXT:    lsv %v0(57),%s0
; CHECK-NEXT:    lea %s0, 66
; CHECK-NEXT:    lsv %v0(58),%s0
; CHECK-NEXT:    lea %s0, 67
; CHECK-NEXT:    lsv %v0(59),%s0
; CHECK-NEXT:    lea %s0, 68
; CHECK-NEXT:    lsv %v0(60),%s0
; CHECK-NEXT:    lea %s0, 69
; CHECK-NEXT:    lsv %v0(61),%s0
; CHECK-NEXT:    lea %s0, 70
; CHECK-NEXT:    lsv %v0(62),%s0
; CHECK-NEXT:    lea %s0, 71
; CHECK-NEXT:    lsv %v0(63),%s0
; CHECK-NEXT:    lea %s0, 72
; CHECK-NEXT:    lsv %v0(64),%s0
; CHECK-NEXT:    lea %s0, 73
; CHECK-NEXT:    lsv %v0(65),%s0
; CHECK-NEXT:    lea %s0, 74
; CHECK-NEXT:    lsv %v0(66),%s0
; CHECK-NEXT:    lea %s0, 75
; CHECK-NEXT:    lsv %v0(67),%s0
; CHECK-NEXT:    lea %s0, 76
; CHECK-NEXT:    lsv %v0(68),%s0
; CHECK-NEXT:    lea %s0, 77
; CHECK-NEXT:    lsv %v0(69),%s0
; CHECK-NEXT:    lea %s0, 78
; CHECK-NEXT:    lsv %v0(70),%s0
; CHECK-NEXT:    lea %s0, 79
; CHECK-NEXT:    lsv %v0(71),%s0
; CHECK-NEXT:    lea %s0, 80
; CHECK-NEXT:    lsv %v0(72),%s0
; CHECK-NEXT:    lea %s0, 81
; CHECK-NEXT:    lsv %v0(73),%s0
; CHECK-NEXT:    lea %s0, 82
; CHECK-NEXT:    lsv %v0(74),%s0
; CHECK-NEXT:    lea %s0, 83
; CHECK-NEXT:    lsv %v0(75),%s0
; CHECK-NEXT:    lea %s0, 84
; CHECK-NEXT:    lsv %v0(76),%s0
; CHECK-NEXT:    lea %s0, 85
; CHECK-NEXT:    lsv %v0(77),%s0
; CHECK-NEXT:    lea %s0, 86
; CHECK-NEXT:    lsv %v0(78),%s0
; CHECK-NEXT:    lea %s0, 87
; CHECK-NEXT:    lsv %v0(79),%s0
; CHECK-NEXT:    lea %s0, 88
; CHECK-NEXT:    lsv %v0(80),%s0
; CHECK-NEXT:    lea %s0, 89
; CHECK-NEXT:    lsv %v0(81),%s0
; CHECK-NEXT:    lea %s0, 90
; CHECK-NEXT:    lsv %v0(82),%s0
; CHECK-NEXT:    lea %s0, 91
; CHECK-NEXT:    lsv %v0(83),%s0
; CHECK-NEXT:    lea %s0, 92
; CHECK-NEXT:    lsv %v0(84),%s0
; CHECK-NEXT:    lea %s0, 93
; CHECK-NEXT:    lsv %v0(85),%s0
; CHECK-NEXT:    lea %s0, 94
; CHECK-NEXT:    lsv %v0(86),%s0
; CHECK-NEXT:    lea %s0, 95
; CHECK-NEXT:    lsv %v0(87),%s0
; CHECK-NEXT:    lea %s0, 96
; CHECK-NEXT:    lsv %v0(88),%s0
; CHECK-NEXT:    lea %s0, 97
; CHECK-NEXT:    lsv %v0(89),%s0
; CHECK-NEXT:    lea %s0, 98
; CHECK-NEXT:    lsv %v0(90),%s0
; CHECK-NEXT:    lea %s0, 99
; CHECK-NEXT:    lsv %v0(91),%s0
; CHECK-NEXT:    lea %s0, 100
; CHECK-NEXT:    lsv %v0(92),%s0
; CHECK-NEXT:    lea %s0, 101
; CHECK-NEXT:    lsv %v0(93),%s0
; CHECK-NEXT:    lea %s0, 102
; CHECK-NEXT:    lsv %v0(94),%s0
; CHECK-NEXT:    lea %s0, 103
; CHECK-NEXT:    lsv %v0(95),%s0
; CHECK-NEXT:    lea %s0, 104
; CHECK-NEXT:    lsv %v0(96),%s0
; CHECK-NEXT:    lea %s0, 105
; CHECK-NEXT:    lsv %v0(97),%s0
; CHECK-NEXT:    lea %s0, 106
; CHECK-NEXT:    lsv %v0(98),%s0
; CHECK-NEXT:    lea %s0, 107
; CHECK-NEXT:    lsv %v0(99),%s0
; CHECK-NEXT:    lea %s0, 108
; CHECK-NEXT:    lsv %v0(100),%s0
; CHECK-NEXT:    lea %s0, 109
; CHECK-NEXT:    lsv %v0(101),%s0
; CHECK-NEXT:    lea %s0, 110
; CHECK-NEXT:    lsv %v0(102),%s0
; CHECK-NEXT:    lea %s0, 111
; CHECK-NEXT:    lsv %v0(103),%s0
; CHECK-NEXT:    lea %s0, 112
; CHECK-NEXT:    lsv %v0(104),%s0
; CHECK-NEXT:    lea %s0, 113
; CHECK-NEXT:    lsv %v0(105),%s0
; CHECK-NEXT:    lea %s0, 114
; CHECK-NEXT:    lsv %v0(106),%s0
; CHECK-NEXT:    lea %s0, 115
; CHECK-NEXT:    lsv %v0(107),%s0
; CHECK-NEXT:    lea %s0, 116
; CHECK-NEXT:    lsv %v0(108),%s0
; CHECK-NEXT:    lea %s0, 117
; CHECK-NEXT:    lsv %v0(109),%s0
; CHECK-NEXT:    lea %s0, 118
; CHECK-NEXT:    lsv %v0(110),%s0
; CHECK-NEXT:    lea %s0, 119
; CHECK-NEXT:    lsv %v0(111),%s0
; CHECK-NEXT:    lea %s0, 120
; CHECK-NEXT:    lsv %v0(112),%s0
; CHECK-NEXT:    lea %s0, 121
; CHECK-NEXT:    lsv %v0(113),%s0
; CHECK-NEXT:    lea %s0, 122
; CHECK-NEXT:    lsv %v0(114),%s0
; CHECK-NEXT:    lea %s0, 123
; CHECK-NEXT:    lsv %v0(115),%s0
; CHECK-NEXT:    lea %s0, 124
; CHECK-NEXT:    lsv %v0(116),%s0
; CHECK-NEXT:    lea %s0, 125
; CHECK-NEXT:    lsv %v0(117),%s0
; CHECK-NEXT:    lea %s0, 126
; CHECK-NEXT:    lsv %v0(118),%s0
; CHECK-NEXT:    lea %s0, 127
; CHECK-NEXT:    lsv %v0(119),%s0
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lsv %v0(120),%s0
; CHECK-NEXT:    lea %s0, 129
; CHECK-NEXT:    lsv %v0(121),%s0
; CHECK-NEXT:    lea %s0, 130
; CHECK-NEXT:    lsv %v0(122),%s0
; CHECK-NEXT:    lea %s0, 131
; CHECK-NEXT:    lsv %v0(123),%s0
; CHECK-NEXT:    lea %s0, 132
; CHECK-NEXT:    lsv %v0(124),%s0
; CHECK-NEXT:    lea %s0, 133
; CHECK-NEXT:    lsv %v0(125),%s0
; CHECK-NEXT:    lea %s0, 134
; CHECK-NEXT:    lsv %v0(126),%s0
; CHECK-NEXT:    lea %s0, 135
; CHECK-NEXT:    lsv %v0(127),%s0
; CHECK-NEXT:    lea %s0, 136
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 137
; CHECK-NEXT:    lea %s1, 129
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 138
; CHECK-NEXT:    lea %s1, 130
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 139
; CHECK-NEXT:    lea %s1, 131
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 140
; CHECK-NEXT:    lea %s1, 132
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 141
; CHECK-NEXT:    lea %s1, 133
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 142
; CHECK-NEXT:    lea %s1, 134
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 143
; CHECK-NEXT:    lea %s1, 135
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 144
; CHECK-NEXT:    lea %s1, 136
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 145
; CHECK-NEXT:    lea %s1, 137
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 146
; CHECK-NEXT:    lea %s1, 138
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 147
; CHECK-NEXT:    lea %s1, 139
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 148
; CHECK-NEXT:    lea %s1, 140
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 149
; CHECK-NEXT:    lea %s1, 141
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 150
; CHECK-NEXT:    lea %s1, 142
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 151
; CHECK-NEXT:    lea %s1, 143
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 152
; CHECK-NEXT:    lea %s1, 144
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 153
; CHECK-NEXT:    lea %s1, 145
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 154
; CHECK-NEXT:    lea %s1, 146
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 155
; CHECK-NEXT:    lea %s1, 147
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 156
; CHECK-NEXT:    lea %s1, 148
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 157
; CHECK-NEXT:    lea %s1, 149
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 158
; CHECK-NEXT:    lea %s1, 150
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 159
; CHECK-NEXT:    lea %s1, 151
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 160
; CHECK-NEXT:    lea %s1, 152
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 161
; CHECK-NEXT:    lea %s1, 153
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 162
; CHECK-NEXT:    lea %s1, 154
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 163
; CHECK-NEXT:    lea %s1, 155
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 164
; CHECK-NEXT:    lea %s1, 156
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 165
; CHECK-NEXT:    lea %s1, 157
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 166
; CHECK-NEXT:    lea %s1, 158
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 167
; CHECK-NEXT:    lea %s1, 159
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 168
; CHECK-NEXT:    lea %s1, 160
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 169
; CHECK-NEXT:    lea %s1, 161
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 170
; CHECK-NEXT:    lea %s1, 162
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 171
; CHECK-NEXT:    lea %s1, 163
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 172
; CHECK-NEXT:    lea %s1, 164
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 173
; CHECK-NEXT:    lea %s1, 165
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 174
; CHECK-NEXT:    lea %s1, 166
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 175
; CHECK-NEXT:    lea %s1, 167
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 176
; CHECK-NEXT:    lea %s1, 168
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 177
; CHECK-NEXT:    lea %s1, 169
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 178
; CHECK-NEXT:    lea %s1, 170
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 179
; CHECK-NEXT:    lea %s1, 171
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 180
; CHECK-NEXT:    lea %s1, 172
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 181
; CHECK-NEXT:    lea %s1, 173
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 182
; CHECK-NEXT:    lea %s1, 174
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 183
; CHECK-NEXT:    lea %s1, 175
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 184
; CHECK-NEXT:    lea %s1, 176
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 185
; CHECK-NEXT:    lea %s1, 177
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 186
; CHECK-NEXT:    lea %s1, 178
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 187
; CHECK-NEXT:    lea %s1, 179
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 188
; CHECK-NEXT:    lea %s1, 180
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 189
; CHECK-NEXT:    lea %s1, 181
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 190
; CHECK-NEXT:    lea %s1, 182
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 191
; CHECK-NEXT:    lea %s1, 183
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 192
; CHECK-NEXT:    lea %s1, 184
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 193
; CHECK-NEXT:    lea %s1, 185
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 194
; CHECK-NEXT:    lea %s1, 186
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 195
; CHECK-NEXT:    lea %s1, 187
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 196
; CHECK-NEXT:    lea %s1, 188
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 197
; CHECK-NEXT:    lea %s1, 189
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 198
; CHECK-NEXT:    lea %s1, 190
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 199
; CHECK-NEXT:    lea %s1, 191
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 200
; CHECK-NEXT:    lea %s1, 192
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 201
; CHECK-NEXT:    lea %s1, 193
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 202
; CHECK-NEXT:    lea %s1, 194
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 203
; CHECK-NEXT:    lea %s1, 195
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 204
; CHECK-NEXT:    lea %s1, 196
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 205
; CHECK-NEXT:    lea %s1, 197
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 206
; CHECK-NEXT:    lea %s1, 198
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 207
; CHECK-NEXT:    lea %s1, 199
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 208
; CHECK-NEXT:    lea %s1, 200
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 209
; CHECK-NEXT:    lea %s1, 201
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 210
; CHECK-NEXT:    lea %s1, 202
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 211
; CHECK-NEXT:    lea %s1, 203
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 212
; CHECK-NEXT:    lea %s1, 204
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 213
; CHECK-NEXT:    lea %s1, 205
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 214
; CHECK-NEXT:    lea %s1, 206
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 215
; CHECK-NEXT:    lea %s1, 207
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 216
; CHECK-NEXT:    lea %s1, 208
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 217
; CHECK-NEXT:    lea %s1, 209
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 218
; CHECK-NEXT:    lea %s1, 210
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 219
; CHECK-NEXT:    lea %s1, 211
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 220
; CHECK-NEXT:    lea %s1, 212
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 221
; CHECK-NEXT:    lea %s1, 213
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 222
; CHECK-NEXT:    lea %s1, 214
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 223
; CHECK-NEXT:    lea %s1, 215
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 224
; CHECK-NEXT:    lea %s1, 216
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 225
; CHECK-NEXT:    lea %s1, 217
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 226
; CHECK-NEXT:    lea %s1, 218
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 227
; CHECK-NEXT:    lea %s1, 219
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 228
; CHECK-NEXT:    lea %s1, 220
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 229
; CHECK-NEXT:    lea %s1, 221
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 230
; CHECK-NEXT:    lea %s1, 222
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 231
; CHECK-NEXT:    lea %s1, 223
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 232
; CHECK-NEXT:    lea %s1, 224
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 233
; CHECK-NEXT:    lea %s1, 225
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 234
; CHECK-NEXT:    lea %s1, 226
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 235
; CHECK-NEXT:    lea %s1, 227
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 236
; CHECK-NEXT:    lea %s1, 228
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 237
; CHECK-NEXT:    lea %s1, 229
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 238
; CHECK-NEXT:    lea %s1, 230
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 239
; CHECK-NEXT:    lea %s1, 231
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 240
; CHECK-NEXT:    lea %s1, 232
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 241
; CHECK-NEXT:    lea %s1, 233
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 242
; CHECK-NEXT:    lea %s1, 234
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 243
; CHECK-NEXT:    lea %s1, 235
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 244
; CHECK-NEXT:    lea %s1, 236
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 245
; CHECK-NEXT:    lea %s1, 237
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 246
; CHECK-NEXT:    lea %s1, 238
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 247
; CHECK-NEXT:    lea %s1, 239
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 248
; CHECK-NEXT:    lea %s1, 240
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 249
; CHECK-NEXT:    lea %s1, 241
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 250
; CHECK-NEXT:    lea %s1, 242
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 251
; CHECK-NEXT:    lea %s1, 243
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 252
; CHECK-NEXT:    lea %s1, 244
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 253
; CHECK-NEXT:    lea %s1, 245
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 254
; CHECK-NEXT:    lea %s1, 246
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 255
; CHECK-NEXT:    lea %s1, 247
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lea %s1, 248
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 257
; CHECK-NEXT:    lea %s1, 249
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 258
; CHECK-NEXT:    lea %s1, 250
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 259
; CHECK-NEXT:    lea %s1, 251
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 260
; CHECK-NEXT:    lea %s1, 252
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 261
; CHECK-NEXT:    lea %s1, 253
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 262
; CHECK-NEXT:    lea %s1, 254
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, 263
; CHECK-NEXT:    lea %s1, 255
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    lea %s0, calc_v256i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v256i32@hi(, %s0)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
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
; CHECK-NEXT:    vmuls.w.sx %v0,%s1,%v0
; CHECK-NEXT:    lea %s0, calc_v4i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v4i32@hi(, %s0)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
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
; CHECK-NEXT:    vmuls.w.sx %v0,%s1,%v0
; CHECK-NEXT:    lea %s0, calc_v256i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v256i32@hi(, %s0)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
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
; CHECK-NEXT:    pvsrl.lo %v0,%v0,%s1
; CHECK-NEXT:    lea %s0, calc_v4i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v4i32@hi(, %s0)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
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
; CHECK-NEXT:    pvsrl.lo %v0,%v0,%s1
; CHECK-NEXT:    lea %s0, calc_v8i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v8i32@hi(, %s0)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
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
; CHECK-NEXT:    pvsrl.lo %v0,%v0,%s1
; CHECK-NEXT:    lea %s0, calc_v256i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v256i32@hi(, %s0)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
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
; CHECK-NEXT:    pvand.lo %v0,%v1,%v0
; CHECK-NEXT:    lea %s0, calc_v4i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v4i32@hi(, %s0)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
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
; CHECK-NEXT:    pvand.lo %v0,%v1,%v0
; CHECK-NEXT:    lea %s0, calc_v256i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, calc_v256i32@hi(, %s0)
; CHECK-NEXT:    bsic %lr, (, %s12)
; CHECK-NEXT:    lvs %s0,%v0(2)
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
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

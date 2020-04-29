; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
; Mask(i) = rand(0, 512)
define <256 x i32> @shuffle256_rand_ab(<256 x i32> %A, <256 x i32> %B) {
; CHECK-LABEL: shuffle256_rand_ab:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lea %s1, 176(, %s11)
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vstl %v1,4,%s1
; CHECK-NEXT:    lea %s2, 1200(, %s11)
; CHECK-NEXT:    vstl %v0,4,%s2
; CHECK-NEXT:    lea %s3, .LCPI0_0@lo
; CHECK-NEXT:    and %s3, %s3, (32)0
; CHECK-NEXT:    lea.sl %s3, .LCPI0_0@hi(, %s3)
; CHECK-NEXT:    vld %v0,8,%s3
; CHECK-NEXT:    xorm %vm1,%vm0,%vm0
; CHECK-NEXT:    lea %s3, 1979639787
; CHECK-NEXT:    lvm %vm1,0,%s3
; CHECK-NEXT:    vadds.l %v0,%s1,%v0
; CHECK-NEXT:    vgtl.zx %v1,%v0,0,0
; CHECK-NEXT:    lea %s1, .LCPI0_1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LCPI0_1@hi(, %s1)
; CHECK-NEXT:    lea %s3, 252
; CHECK-NEXT:    lvl %s3
; CHECK-NEXT:    vld %v0,8,%s1
; CHECK-NEXT:    lea %s1, 2111784167
; CHECK-NEXT:    lvm %vm1,1,%s1
; CHECK-NEXT:    lea %s1, -116737345
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.l %v0,%s2,%v0
; CHECK-NEXT:    lvl %s3
; CHECK-NEXT:    vgtl.zx %v0,%v0,0,0
; CHECK-NEXT:    lvm %vm1,2,%s1
; CHECK-NEXT:    lea %s1, -51384867
; CHECK-NEXT:    lvm %vm1,3,%s1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vmrg %v0,%v0,%v1,%vm1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = shufflevector <256 x i32> %A, <256 x i32> %B, <256 x i32>
<i32 357, i32 299, i32 250, i32 368, i32 53, i32 374, i32 233, i32 46, i32 292, i32 441, i32 265, i32 235, i32 253, i32 447, i32 417, i32 401, i32 8, i32 362, i32 300, i32 340, i32 430, i32 277, i32 110, i32 432, i32 49, i32 75, i32 268, i32 14, i32 314, i32 260, i32 390, i32 53, i32 126, i32 194, i32 87, i32 34, i32 229, i32 279, i32 333, i32 336, i32 136, i32 464, i32 136, i32 158, i32 253, i32 460, i32 452, i32 287, i32 151, i32 288, i32 437, i32 501, i32 441, i32 340, i32 283, i32 28, i32 427, i32 200, i32 253, i32 120, i32 197, i32 16, i32 422, i32 112, i32 73, i32 473, i32 50, i32 36, i32 237, i32 460, i32 132, i32 398, i32 18, i32 23, i32 11, i32 109, i32 3, i32 207, i32 445, i32 60, i32 106, i32 278, i32 409, i32 503, i32 90, i32 203, i32 384, i32 112, i32 181, i32 47, i32 510, i32 475, i32 171, i32 476, i32 501, i32 185, i32 474, i32 139, i32 477, i32 5, i32 93, i32 359, i32 391, i32 144, i32 100, i32 153, i32 310, i32 160, i32 83, i32 114, i32 100, i32 229, i32 354, i32 380, i32 24, i32 154, i32 452, i32 93, i32 499, i32 307, i32 265, i32 132, i32 67, i32 340, i32 303, i32 480, i32 385, i32 246, i32 502, i32 372, i32 67, i32 261, i32 118, i32 60, i32 189, i32 427, i32 132, i32 349, i32 26, i32 336, i32 412, i32 35, i32 160, i32 16, i32 54, i32 402, i32 157, i32 226, i32 6, i32 175, i32 126, i32 190, i32 435, i32 131, i32 78, i32 351, i32 469, i32 455, i32 395, i32 311, i32 493, i32 42, i32 379, i32 226, i32 420, i32 279, i32 245, i32 448, i32 241, i32 422, i32 169, i32 480, i32 374, i32 494, i32 14, i32 482, i32 77, i32 369, i32 99, i32 259, i32 179, i32 92, i32 59, i32 127, i32 171, i32 66, i32 195, i32 494, i32 61, i32 185, i32 394, i32 39, i32 321, i32 67, i32 348, i32 359, i32 447, i32 255, i32 420, i32 278, i32 379, i32 157, i32 18, i32 410, i32 80, i32 421, i32 283, i32 127, i32 312, i32 372, i32 358, i32 465, i32 199, i32 169, i32 464, i32 223, i32 102, i32 246, i32 431, i32 324, i32 256, i32 47, i32 263, i32 101, i32 37, i32 170, i32 207, i32 231, i32 394, i32 31, i32 320, i32 35, i32 63, i32 220, i32 411, i32 222, i32 160, i32 136, i32 396, i32 503, i32 437, i32 92, i32 127, i32 275, i32 73, i32 383, i32 242, i32 373, i32 141, i32 175, i32 181, i32 176, i32 456, i32 467, i32 334, i32 478>
  ret <256 x i32> %r
}

; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i8 @p0i8() {
; CHECK-LABEL: p0i8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i8 0
}

define signext i8 @p0si8() {
; CHECK-LABEL: p0si8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i8 0
}

define zeroext i8 @p0zi8() {
; CHECK-LABEL: p0zi8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i8 0
}

define i8 @p128i8() {
; CHECK-LABEL: p128i8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s0, 128
; CHECK-NEXT:  or %s11, 0, %s9
  ret i8 128
}

define signext i8 @p128si8() {
; CHECK-LABEL: p128si8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s0, -128
; CHECK-NEXT:  or %s11, 0, %s9
  ret i8 128
}

define zeroext i8 @p128zi8() {
; CHECK-LABEL: p128zi8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s0, 128
; CHECK-NEXT:  or %s11, 0, %s9
  ret i8 128
}

define i8 @p256i8() {
; CHECK-LABEL: p256i8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i8 256
}

define signext i8 @p256si8() {
; CHECK-LABEL: p256si8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i8 256
}

define zeroext i8 @p256zi8() {
; CHECK-LABEL: p256zi8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i8 256
}

define i16 @p0i16() {
; CHECK-LABEL: p0i16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i16 0
}

define signext i16 @p0si16() {
; CHECK-LABEL: p0si16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i16 0
}

define zeroext i16 @p0zi16() {
; CHECK-LABEL: p0zi16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i16 0
}

define i32 @p0i32() {
; CHECK-LABEL: p0i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i32 0
}

define signext i32 @p0si32() {
; CHECK-LABEL: p0si32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i32 0
}

define zeroext i32 @p0zi32() {
; CHECK-LABEL: p0zi32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i32 0
}

define i32 @p128i32() {
; CHECK-LABEL: p128i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s0, 128
; CHECK-NEXT:  or %s11, 0, %s9
  ret i32 128
}

define signext i32 @p128si32() {
; CHECK-LABEL: p128si32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s0, 128
; CHECK-NEXT:  or %s11, 0, %s9
  ret i32 128
}

define zeroext i32 @p128zi32() {
; CHECK-LABEL: p128zi32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s0, 128
; CHECK-NEXT:  or %s11, 0, %s9
  ret i32 128
}

define i64 @p0i64() {
; CHECK-LABEL: p0i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 0
}

define signext i64 @p0si64() {
; CHECK-LABEL: p0si64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 0
}

define zeroext i64 @p0zi64() {
; CHECK-LABEL: p0zi64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 0
}

define i64 @p128i64() {
; CHECK-LABEL: p128i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s0, 128
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 128
}

define signext i64 @p128si64() {
; CHECK-LABEL: p128si64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s0, 128
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 128
}

define zeroext i64 @p128zi64() {
; CHECK-LABEL: p128zi64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s0, 128
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 128
}

define i64 @p2264924160i64() {
; CHECK-LABEL: p2264924160i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, -2030043136
; CHECK-NEXT:  and %s0, %s34, (32)0
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 2264924160
}

define signext i64 @p2264924160si64() {
; CHECK-LABEL: p2264924160si64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, -2030043136
; CHECK-NEXT:  and %s0, %s34, (32)0
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 2264924160
}

define zeroext i64 @p2264924160zi64() {
; CHECK-LABEL: p2264924160zi64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, -2030043136
; CHECK-NEXT:  and %s0, %s34, (32)0
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 2264924160
}

define i64 @p2147483647i64() {
; CHECK-LABEL: p2147483647i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s0, 2147483647
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 2147483647
}

define signext i64 @p2147483647si64() {
; CHECK-LABEL: p2147483647si64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s0, 2147483647
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 2147483647
}

define zeroext i64 @p2147483647zi64() {
; CHECK-LABEL: p2147483647zi64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s0, 2147483647
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 2147483647
}

define i64 @p15032385535i64() {
; CHECK-LABEL: p15032385535i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 2147483647
; CHECK-NEXT:  lea.sl %s0, 3(%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 15032385535
}

define signext i64 @p15032385535si64() {
; CHECK-LABEL: p15032385535si64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 2147483647
; CHECK-NEXT:  lea.sl %s0, 3(%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 15032385535
}

define zeroext i64 @p15032385535zi64() {
; CHECK-LABEL: p15032385535zi64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 2147483647
; CHECK-NEXT:  lea.sl %s0, 3(%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 15032385535
}

define i64 @p15032385536i64() {
; CHECK-LABEL: p15032385536i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, -2147483648
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s0, 3(%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 15032385536
}

define signext i64 @p15032385536si64() {
; CHECK-LABEL: p15032385536si64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, -2147483648
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s0, 3(%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 15032385536
}

define zeroext i64 @p15032385536zi64() {
; CHECK-LABEL: p15032385536zi64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, -2147483648
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s0, 3(%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 15032385536
}

define float @m5f32() {
; CHECK-LABEL: m5f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea.sl %s34, -1063256064
; CHECK-NEXT:  or %s0, 0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
  ret float -5.000000e+00
}

define double @m5f64() {
; CHECK-LABEL: m5f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea.sl %s0, -1072431104
; CHECK-NEXT:  or %s11, 0, %s9
  ret double -5.000000e+00
}

define fp128 @m5f128() {
; CHECK-LABEL: .LCPI{{[0-9]+}}_0:
; CHECK-NEXT:  .8byte	0                       # fp128 -5
; CHECK-NEXT:  .8byte	-4611334174706499584
; CHECK-LABEL: m5f128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(%s34)
; CHECK-NEXT:  ld %s0, 8(,%s34)
; CHECK-NEXT:  ld %s1, (,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  ret fp128 0xL0000000000000000C001400000000000  ; -5.0
}

define float @p2p3f32() {
; CHECK-LABEL: p2p3f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea.sl %s34, 1075000115
; CHECK-NEXT:  or %s0, 0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
  ret float 0x4002666660000000 ; 2.3
}

define double @p2p3f64() {
; CHECK-LABEL: p2p3f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 1717986918
; CHECK-NEXT:  lea.sl %s0, 1073899110(%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  ret double 2.3
}

define fp128 @p2p3f128() {
; CHECK-LABEL: .LCPI{{[0-9]+}}_0:
; CHECK-NEXT:  .8byte	6917529027641081856     # fp128 2.29999999999999982236431605997495353
; CHECK-NEXT:  .8byte	4611728239673894502
; CHECK-LABEL: p2p3f128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(%s34)
; CHECK-NEXT:  ld %s0, 8(,%s34)
; CHECK-NEXT:  ld %s1, (,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  ret fp128 0xL60000000000000004000266666666666 ; 2.3
}

define float @p128p3f32() {
; CHECK-LABEL: p128p3f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea.sl %s34, 1124093133
; CHECK-NEXT:  or %s0, 0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
  ret float 0x40600999A0000000 ; 128.3
}

define double @p128p3f64() {
; CHECK-LABEL: p128p3f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, -1717986918
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s0, 1080035737(%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  ret double 128.3
}

define fp128 @p128p3f128() {
; CHECK-LABEL: .LCPI{{[0-9]+}}_0:
; CHECK-NEXT:  .8byte  -6917529027641081856    # fp128 128.300000000000011368683772161602974
; CHECK-NEXT:  .8byte  4613375527994628505
; CHECK-LABEL: p128p3f128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, .LCPI{{[0-9]+}}_0@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, .LCPI{{[0-9]+}}_0@hi(%s34)
; CHECK-NEXT:  ld %s0, 8(,%s34)
; CHECK-NEXT:  ld %s1, (,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  ret fp128 0xLA0000000000000004006009999999999 ; 128.3
}


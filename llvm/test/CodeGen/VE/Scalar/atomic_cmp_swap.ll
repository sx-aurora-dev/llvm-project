; RUN: llc < %s -mtriple=ve | FileCheck %s

;;; Test atomic compare and exchange weak for all types and all memory order
;;;
;;; Note:
;;;   - We test i1/i8/i16/i32/i64/i128/u8/u16/u32/u64/u128.
;;;   - We test relaxed, acquire, and seq_cst.
;;;   - We test only exchange with variables since VE doesn't have exchange
;;;     instructions with immediate values.
;;;   - We test against an object, a stack object, and a global variable.

%"struct.std::__1::atomic" = type { %"struct.std::__1::__atomic_base" }
%"struct.std::__1::__atomic_base" = type { %"struct.std::__1::__cxx_atomic_impl" }
%"struct.std::__1::__cxx_atomic_impl" = type { %"struct.std::__1::__cxx_atomic_base_impl" }
%"struct.std::__1::__cxx_atomic_base_impl" = type { i8 }
%"struct.std::__1::atomic.0" = type { %"struct.std::__1::__atomic_base.1" }
%"struct.std::__1::__atomic_base.1" = type { %"struct.std::__1::__atomic_base.2" }
%"struct.std::__1::__atomic_base.2" = type { %"struct.std::__1::__cxx_atomic_impl.3" }
%"struct.std::__1::__cxx_atomic_impl.3" = type { %"struct.std::__1::__cxx_atomic_base_impl.4" }
%"struct.std::__1::__cxx_atomic_base_impl.4" = type { i8 }
%"struct.std::__1::atomic.5" = type { %"struct.std::__1::__atomic_base.6" }
%"struct.std::__1::__atomic_base.6" = type { %"struct.std::__1::__atomic_base.7" }
%"struct.std::__1::__atomic_base.7" = type { %"struct.std::__1::__cxx_atomic_impl.8" }
%"struct.std::__1::__cxx_atomic_impl.8" = type { %"struct.std::__1::__cxx_atomic_base_impl.9" }
%"struct.std::__1::__cxx_atomic_base_impl.9" = type { i8 }
%"struct.std::__1::atomic.10" = type { %"struct.std::__1::__atomic_base.11" }
%"struct.std::__1::__atomic_base.11" = type { %"struct.std::__1::__atomic_base.12" }
%"struct.std::__1::__atomic_base.12" = type { %"struct.std::__1::__cxx_atomic_impl.13" }
%"struct.std::__1::__cxx_atomic_impl.13" = type { %"struct.std::__1::__cxx_atomic_base_impl.14" }
%"struct.std::__1::__cxx_atomic_base_impl.14" = type { i16 }
%"struct.std::__1::atomic.15" = type { %"struct.std::__1::__atomic_base.16" }
%"struct.std::__1::__atomic_base.16" = type { %"struct.std::__1::__atomic_base.17" }
%"struct.std::__1::__atomic_base.17" = type { %"struct.std::__1::__cxx_atomic_impl.18" }
%"struct.std::__1::__cxx_atomic_impl.18" = type { %"struct.std::__1::__cxx_atomic_base_impl.19" }
%"struct.std::__1::__cxx_atomic_base_impl.19" = type { i16 }
%"struct.std::__1::atomic.20" = type { %"struct.std::__1::__atomic_base.21" }
%"struct.std::__1::__atomic_base.21" = type { %"struct.std::__1::__atomic_base.22" }
%"struct.std::__1::__atomic_base.22" = type { %"struct.std::__1::__cxx_atomic_impl.23" }
%"struct.std::__1::__cxx_atomic_impl.23" = type { %"struct.std::__1::__cxx_atomic_base_impl.24" }
%"struct.std::__1::__cxx_atomic_base_impl.24" = type { i32 }
%"struct.std::__1::atomic.25" = type { %"struct.std::__1::__atomic_base.26" }
%"struct.std::__1::__atomic_base.26" = type { %"struct.std::__1::__atomic_base.27" }
%"struct.std::__1::__atomic_base.27" = type { %"struct.std::__1::__cxx_atomic_impl.28" }
%"struct.std::__1::__cxx_atomic_impl.28" = type { %"struct.std::__1::__cxx_atomic_base_impl.29" }
%"struct.std::__1::__cxx_atomic_base_impl.29" = type { i32 }
%"struct.std::__1::atomic.30" = type { %"struct.std::__1::__atomic_base.31" }
%"struct.std::__1::__atomic_base.31" = type { %"struct.std::__1::__atomic_base.32" }
%"struct.std::__1::__atomic_base.32" = type { %"struct.std::__1::__cxx_atomic_impl.33" }
%"struct.std::__1::__cxx_atomic_impl.33" = type { %"struct.std::__1::__cxx_atomic_base_impl.34" }
%"struct.std::__1::__cxx_atomic_base_impl.34" = type { i64 }
%"struct.std::__1::atomic.35" = type { %"struct.std::__1::__atomic_base.36" }
%"struct.std::__1::__atomic_base.36" = type { %"struct.std::__1::__atomic_base.37" }
%"struct.std::__1::__atomic_base.37" = type { %"struct.std::__1::__cxx_atomic_impl.38" }
%"struct.std::__1::__cxx_atomic_impl.38" = type { %"struct.std::__1::__cxx_atomic_base_impl.39" }
%"struct.std::__1::__cxx_atomic_base_impl.39" = type { i64 }
%"struct.std::__1::atomic.40" = type { %"struct.std::__1::__atomic_base.41" }
%"struct.std::__1::__atomic_base.41" = type { %"struct.std::__1::__atomic_base.42" }
%"struct.std::__1::__atomic_base.42" = type { %"struct.std::__1::__cxx_atomic_impl.43" }
%"struct.std::__1::__cxx_atomic_impl.43" = type { %"struct.std::__1::__cxx_atomic_base_impl.44" }
%"struct.std::__1::__cxx_atomic_base_impl.44" = type { i128 }
%"struct.std::__1::atomic.45" = type { %"struct.std::__1::__atomic_base.46" }
%"struct.std::__1::__atomic_base.46" = type { %"struct.std::__1::__atomic_base.47" }
%"struct.std::__1::__atomic_base.47" = type { %"struct.std::__1::__cxx_atomic_impl.48" }
%"struct.std::__1::__cxx_atomic_impl.48" = type { %"struct.std::__1::__cxx_atomic_base_impl.49" }
%"struct.std::__1::__cxx_atomic_base_impl.49" = type { i128 }

@gv_i1 = global %"struct.std::__1::atomic" zeroinitializer, align 4
@gv_i8 = global %"struct.std::__1::atomic.0" zeroinitializer, align 4
@gv_u8 = global %"struct.std::__1::atomic.5" zeroinitializer, align 4
@gv_i16 = global %"struct.std::__1::atomic.10" zeroinitializer, align 4
@gv_u16 = global %"struct.std::__1::atomic.15" zeroinitializer, align 4
@gv_i32 = global %"struct.std::__1::atomic.20" zeroinitializer, align 4
@gv_u32 = global %"struct.std::__1::atomic.25" zeroinitializer, align 4
@gv_i64 = global %"struct.std::__1::atomic.30" zeroinitializer, align 8
@gv_u64 = global %"struct.std::__1::atomic.35" zeroinitializer, align 8
@gv_i128 = global %"struct.std::__1::atomic.40" zeroinitializer, align 16
@gv_u128 = global %"struct.std::__1::atomic.45" zeroinitializer, align 16

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef zeroext i1 @_Z26atomic_cmp_swap_relaxed_i1RNSt3__16atomicIbEERbb(ptr nocapture noundef nonnull align 1 dereferenceable(1) %0, ptr nocapture noundef nonnull align 1 dereferenceable(1) %1, i1 noundef zeroext %2) personality ptr @__gxx_personality_sj0 {
; CHECK-LABEL: _Z26atomic_cmp_swap_relaxed_i1RNSt3__16atomicIbEERbb:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.zx %s4, (, %s1)
; CHECK-NEXT:    and %s3, -4, %s0
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 3
; CHECK-NEXT:    ldl.sx %s5, (, %s3)
; CHECK-NEXT:    sla.w.sx %s6, (56)0, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, %s0
; CHECK-NEXT:    sla.w.sx %s4, %s4, %s0
; CHECK-NEXT:    nnd %s5, %s6, %s5
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    or %s2, %s5, %s2
; CHECK-NEXT:    or %s4, %s5, %s4
; CHECK-NEXT:    cas.w %s2, (%s3), %s4
; CHECK-NEXT:    cmpu.w %s3, %s2, %s4
; CHECK-NEXT:    ldz %s3, %s3
; CHECK-NEXT:    srl %s3, %s3, 6
; CHECK-NEXT:    and %s4, 1, %s3
; CHECK-NEXT:    brne.w 0, %s4, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    srl %s0, %s2, %s0
; CHECK-NEXT:    st1b %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = zext i1 %2 to i8
  %5 = load i8, ptr %1, align 1
  %6 = cmpxchg weak ptr %0, i8 %5, i8 %4 monotonic monotonic, align 1
  %7 = extractvalue { i8, i1 } %6, 1
  br i1 %7, label %10, label %8

8:                                                ; preds = %3
  %9 = extractvalue { i8, i1 } %6, 0
  store i8 %9, ptr %1, align 1
  br label %10

10:                                               ; preds = %8, %3
  ret i1 %7
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef signext i8 @_Z26atomic_cmp_swap_relaxed_i8RNSt3__16atomicIcEERcc(ptr nocapture noundef nonnull align 1 dereferenceable(1) %0, ptr nocapture noundef nonnull align 1 dereferenceable(1) %1, i8 noundef signext %2) {
; CHECK-LABEL: _Z26atomic_cmp_swap_relaxed_i8RNSt3__16atomicIcEERcc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.zx %s4, (, %s1)
; CHECK-NEXT:    and %s3, -4, %s0
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 3
; CHECK-NEXT:    sla.w.sx %s5, (56)0, %s0
; CHECK-NEXT:    ldl.sx %s6, (, %s3)
; CHECK-NEXT:    and %s2, %s2, (56)0
; CHECK-NEXT:    sla.w.sx %s2, %s2, %s0
; CHECK-NEXT:    sla.w.sx %s4, %s4, %s0
; CHECK-NEXT:    nnd %s5, %s5, %s6
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    or %s2, %s5, %s2
; CHECK-NEXT:    or %s4, %s5, %s4
; CHECK-NEXT:    cas.w %s2, (%s3), %s4
; CHECK-NEXT:    cmpu.w %s3, %s2, %s4
; CHECK-NEXT:    ldz %s3, %s3
; CHECK-NEXT:    srl %s3, %s3, 6
; CHECK-NEXT:    and %s4, 1, %s3
; CHECK-NEXT:    brne.w 0, %s4, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    srl %s0, %s2, %s0
; CHECK-NEXT:    st1b %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i8, ptr %1, align 1
  %5 = cmpxchg weak ptr %0, i8 %4, i8 %2 monotonic monotonic, align 1
  %6 = extractvalue { i8, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i8, i1 } %5, 0
  store i8 %8, ptr %1, align 1
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i8
  ret i8 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef zeroext i8 @_Z26atomic_cmp_swap_relaxed_u8RNSt3__16atomicIhEERhh(ptr nocapture noundef nonnull align 1 dereferenceable(1) %0, ptr nocapture noundef nonnull align 1 dereferenceable(1) %1, i8 noundef zeroext %2) {
; CHECK-LABEL: _Z26atomic_cmp_swap_relaxed_u8RNSt3__16atomicIhEERhh:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.zx %s4, (, %s1)
; CHECK-NEXT:    and %s3, -4, %s0
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 3
; CHECK-NEXT:    ldl.sx %s5, (, %s3)
; CHECK-NEXT:    sla.w.sx %s6, (56)0, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, %s0
; CHECK-NEXT:    sla.w.sx %s4, %s4, %s0
; CHECK-NEXT:    nnd %s5, %s6, %s5
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    or %s2, %s5, %s2
; CHECK-NEXT:    or %s4, %s5, %s4
; CHECK-NEXT:    cas.w %s2, (%s3), %s4
; CHECK-NEXT:    cmpu.w %s3, %s2, %s4
; CHECK-NEXT:    ldz %s3, %s3
; CHECK-NEXT:    srl %s3, %s3, 6
; CHECK-NEXT:    and %s4, 1, %s3
; CHECK-NEXT:    brne.w 0, %s4, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    srl %s0, %s2, %s0
; CHECK-NEXT:    st1b %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i8, ptr %1, align 1
  %5 = cmpxchg weak ptr %0, i8 %4, i8 %2 monotonic monotonic, align 1
  %6 = extractvalue { i8, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i8, i1 } %5, 0
  store i8 %8, ptr %1, align 1
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i8
  ret i8 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef signext i16 @_Z27atomic_cmp_swap_relaxed_i16RNSt3__16atomicIsEERss(ptr nocapture noundef nonnull align 2 dereferenceable(2) %0, ptr nocapture noundef nonnull align 2 dereferenceable(2) %1, i16 noundef signext %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_relaxed_i16RNSt3__16atomicIsEERss:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld2b.zx %s4, (, %s1)
; CHECK-NEXT:    and %s3, -4, %s0
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 3
; CHECK-NEXT:    sla.w.sx %s5, (48)0, %s0
; CHECK-NEXT:    ldl.sx %s6, (, %s3)
; CHECK-NEXT:    and %s2, %s2, (48)0
; CHECK-NEXT:    sla.w.sx %s2, %s2, %s0
; CHECK-NEXT:    sla.w.sx %s4, %s4, %s0
; CHECK-NEXT:    nnd %s5, %s5, %s6
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    or %s2, %s5, %s2
; CHECK-NEXT:    or %s4, %s5, %s4
; CHECK-NEXT:    cas.w %s2, (%s3), %s4
; CHECK-NEXT:    cmpu.w %s3, %s2, %s4
; CHECK-NEXT:    ldz %s3, %s3
; CHECK-NEXT:    srl %s3, %s3, 6
; CHECK-NEXT:    and %s4, 1, %s3
; CHECK-NEXT:    brne.w 0, %s4, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    srl %s0, %s2, %s0
; CHECK-NEXT:    st2b %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i16, ptr %1, align 2
  %5 = cmpxchg weak ptr %0, i16 %4, i16 %2 monotonic monotonic, align 2
  %6 = extractvalue { i16, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i16, i1 } %5, 0
  store i16 %8, ptr %1, align 2
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i16
  ret i16 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef zeroext i16 @_Z27atomic_cmp_swap_relaxed_u16RNSt3__16atomicItEERtt(ptr nocapture noundef nonnull align 2 dereferenceable(2) %0, ptr nocapture noundef nonnull align 2 dereferenceable(2) %1, i16 noundef zeroext %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_relaxed_u16RNSt3__16atomicItEERtt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld2b.zx %s4, (, %s1)
; CHECK-NEXT:    and %s3, -4, %s0
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 3
; CHECK-NEXT:    ldl.sx %s5, (, %s3)
; CHECK-NEXT:    sla.w.sx %s6, (48)0, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, %s0
; CHECK-NEXT:    sla.w.sx %s4, %s4, %s0
; CHECK-NEXT:    nnd %s5, %s6, %s5
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    or %s2, %s5, %s2
; CHECK-NEXT:    or %s4, %s5, %s4
; CHECK-NEXT:    cas.w %s2, (%s3), %s4
; CHECK-NEXT:    cmpu.w %s3, %s2, %s4
; CHECK-NEXT:    ldz %s3, %s3
; CHECK-NEXT:    srl %s3, %s3, 6
; CHECK-NEXT:    and %s4, 1, %s3
; CHECK-NEXT:    brne.w 0, %s4, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    srl %s0, %s2, %s0
; CHECK-NEXT:    st2b %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i16, ptr %1, align 2
  %5 = cmpxchg weak ptr %0, i16 %4, i16 %2 monotonic monotonic, align 2
  %6 = extractvalue { i16, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i16, i1 } %5, 0
  store i16 %8, ptr %1, align 2
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i16
  ret i16 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef signext i32 @_Z27atomic_cmp_swap_relaxed_i32RNSt3__16atomicIiEERii(ptr nocapture noundef nonnull align 4 dereferenceable(4) %0, ptr nocapture noundef nonnull align 4 dereferenceable(4) %1, i32 noundef signext %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_relaxed_i32RNSt3__16atomicIiEERii:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.sx %s3, (, %s1)
; CHECK-NEXT:    cas.w %s2, (%s0), %s3
; CHECK-NEXT:    cmpu.w %s0, %s2, %s3
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    breq.w %s2, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    stl %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i32, ptr %1, align 4
  %5 = cmpxchg weak ptr %0, i32 %4, i32 %2 monotonic monotonic, align 4
  %6 = extractvalue { i32, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i32, i1 } %5, 0
  store i32 %8, ptr %1, align 4
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i32
  ret i32 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef zeroext i32 @_Z27atomic_cmp_swap_relaxed_u32RNSt3__16atomicIjEERjj(ptr nocapture noundef nonnull align 4 dereferenceable(4) %0, ptr nocapture noundef nonnull align 4 dereferenceable(4) %1, i32 noundef zeroext %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_relaxed_u32RNSt3__16atomicIjEERjj:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.sx %s3, (, %s1)
; CHECK-NEXT:    cas.w %s2, (%s0), %s3
; CHECK-NEXT:    cmpu.w %s0, %s2, %s3
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    breq.w %s2, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    stl %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i32, ptr %1, align 4
  %5 = cmpxchg weak ptr %0, i32 %4, i32 %2 monotonic monotonic, align 4
  %6 = extractvalue { i32, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i32, i1 } %5, 0
  store i32 %8, ptr %1, align 4
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i32
  ret i32 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef i64 @_Z27atomic_cmp_swap_relaxed_i64RNSt3__16atomicIlEERll(ptr nocapture noundef nonnull align 8 dereferenceable(8) %0, ptr nocapture noundef nonnull align 8 dereferenceable(8) %1, i64 noundef %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_relaxed_i64RNSt3__16atomicIlEERll:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s3, (, %s1)
; CHECK-NEXT:    cas.l %s2, (%s0), %s3
; CHECK-NEXT:    cmpu.l %s0, %s2, %s3
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    breq.l %s2, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i64, ptr %1, align 8
  %5 = cmpxchg weak ptr %0, i64 %4, i64 %2 monotonic monotonic, align 8
  %6 = extractvalue { i64, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i64, i1 } %5, 0
  store i64 %8, ptr %1, align 8
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i64
  ret i64 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef i64 @_Z27atomic_cmp_swap_relaxed_u64RNSt3__16atomicImEERmm(ptr nocapture noundef nonnull align 8 dereferenceable(8) %0, ptr nocapture noundef nonnull align 8 dereferenceable(8) %1, i64 noundef %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_relaxed_u64RNSt3__16atomicImEERmm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s3, (, %s1)
; CHECK-NEXT:    cas.l %s2, (%s0), %s3
; CHECK-NEXT:    cmpu.l %s0, %s2, %s3
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    breq.l %s2, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i64, ptr %1, align 8
  %5 = cmpxchg weak ptr %0, i64 %4, i64 %2 monotonic monotonic, align 8
  %6 = extractvalue { i64, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i64, i1 } %5, 0
  store i64 %8, ptr %1, align 8
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i64
  ret i64 %10
}

; Function Attrs: mustprogress nounwind willreturn
define noundef i128 @_Z28atomic_cmp_swap_relaxed_i128RNSt3__16atomicInEERnn(ptr noundef nonnull align 16 dereferenceable(16) %0, ptr noundef nonnull align 16 dereferenceable(16) %1, i128 noundef %2) {
; CHECK-LABEL: _Z28atomic_cmp_swap_relaxed_i128RNSt3__16atomicInEERnn:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s6, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    st %s3, -8(, %s9)
; CHECK-NEXT:    st %s2, -16(, %s9)
; CHECK-NEXT:    lea %s0, __atomic_compare_exchange@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_compare_exchange@hi(, %s0)
; CHECK-NEXT:    lea %s3, -16(, %s9)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    or %s2, 0, %s6
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %4 = alloca i128, align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %4)
  store i128 %2, ptr %4, align 16, !tbaa !3
  %5 = call noundef zeroext i1 @__atomic_compare_exchange(i64 noundef 16, ptr noundef nonnull %0, ptr noundef nonnull %1, ptr noundef nonnull %4, i32 noundef signext 0, i32 noundef signext 0)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %4)
  %6 = zext i1 %5 to i128
  ret i128 %6
}

; Function Attrs: mustprogress nounwind willreturn
define noundef i128 @_Z28atomic_cmp_swap_relaxed_u128RNSt3__16atomicIoEERoo(ptr noundef nonnull align 16 dereferenceable(16) %0, ptr noundef nonnull align 16 dereferenceable(16) %1, i128 noundef %2) {
; CHECK-LABEL: _Z28atomic_cmp_swap_relaxed_u128RNSt3__16atomicIoEERoo:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s6, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    st %s3, -8(, %s9)
; CHECK-NEXT:    st %s2, -16(, %s9)
; CHECK-NEXT:    lea %s0, __atomic_compare_exchange@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_compare_exchange@hi(, %s0)
; CHECK-NEXT:    lea %s3, -16(, %s9)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    or %s2, 0, %s6
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %4 = alloca i128, align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %4)
  store i128 %2, ptr %4, align 16, !tbaa !3
  %5 = call noundef zeroext i1 @__atomic_compare_exchange(i64 noundef 16, ptr noundef nonnull %0, ptr noundef nonnull %1, ptr noundef nonnull %4, i32 noundef signext 0, i32 noundef signext 0)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %4)
  %6 = zext i1 %5 to i128
  ret i128 %6
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef zeroext i1 @_Z26atomic_cmp_swap_acquire_i1RNSt3__16atomicIbEERbb(ptr nocapture noundef nonnull align 1 dereferenceable(1) %0, ptr nocapture noundef nonnull align 1 dereferenceable(1) %1, i1 noundef zeroext %2) personality ptr @__gxx_personality_sj0 {
; CHECK-LABEL: _Z26atomic_cmp_swap_acquire_i1RNSt3__16atomicIbEERbb:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.zx %s4, (, %s1)
; CHECK-NEXT:    and %s3, -4, %s0
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 3
; CHECK-NEXT:    ldl.sx %s5, (, %s3)
; CHECK-NEXT:    sla.w.sx %s6, (56)0, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, %s0
; CHECK-NEXT:    sla.w.sx %s4, %s4, %s0
; CHECK-NEXT:    nnd %s5, %s6, %s5
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    or %s2, %s5, %s2
; CHECK-NEXT:    or %s4, %s5, %s4
; CHECK-NEXT:    cas.w %s2, (%s3), %s4
; CHECK-NEXT:    cmpu.w %s3, %s2, %s4
; CHECK-NEXT:    ldz %s3, %s3
; CHECK-NEXT:    srl %s3, %s3, 6
; CHECK-NEXT:    and %s4, 1, %s3
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    brne.w 0, %s4, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    srl %s0, %s2, %s0
; CHECK-NEXT:    st1b %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = zext i1 %2 to i8
  %5 = load i8, ptr %1, align 1
  %6 = cmpxchg weak ptr %0, i8 %5, i8 %4 acquire acquire, align 1
  %7 = extractvalue { i8, i1 } %6, 1
  br i1 %7, label %10, label %8

8:                                                ; preds = %3
  %9 = extractvalue { i8, i1 } %6, 0
  store i8 %9, ptr %1, align 1
  br label %10

10:                                               ; preds = %8, %3
  ret i1 %7
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef signext i8 @_Z26atomic_cmp_swap_acquire_i8RNSt3__16atomicIcEERcc(ptr nocapture noundef nonnull align 1 dereferenceable(1) %0, ptr nocapture noundef nonnull align 1 dereferenceable(1) %1, i8 noundef signext %2) {
; CHECK-LABEL: _Z26atomic_cmp_swap_acquire_i8RNSt3__16atomicIcEERcc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.zx %s4, (, %s1)
; CHECK-NEXT:    and %s3, -4, %s0
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 3
; CHECK-NEXT:    sla.w.sx %s5, (56)0, %s0
; CHECK-NEXT:    ldl.sx %s6, (, %s3)
; CHECK-NEXT:    and %s2, %s2, (56)0
; CHECK-NEXT:    sla.w.sx %s2, %s2, %s0
; CHECK-NEXT:    sla.w.sx %s4, %s4, %s0
; CHECK-NEXT:    nnd %s5, %s5, %s6
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    or %s2, %s5, %s2
; CHECK-NEXT:    or %s4, %s5, %s4
; CHECK-NEXT:    cas.w %s2, (%s3), %s4
; CHECK-NEXT:    cmpu.w %s3, %s2, %s4
; CHECK-NEXT:    ldz %s3, %s3
; CHECK-NEXT:    srl %s3, %s3, 6
; CHECK-NEXT:    and %s4, 1, %s3
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    brne.w 0, %s4, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    srl %s0, %s2, %s0
; CHECK-NEXT:    st1b %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i8, ptr %1, align 1
  %5 = cmpxchg weak ptr %0, i8 %4, i8 %2 acquire acquire, align 1
  %6 = extractvalue { i8, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i8, i1 } %5, 0
  store i8 %8, ptr %1, align 1
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i8
  ret i8 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef zeroext i8 @_Z26atomic_cmp_swap_acquire_u8RNSt3__16atomicIhEERhh(ptr nocapture noundef nonnull align 1 dereferenceable(1) %0, ptr nocapture noundef nonnull align 1 dereferenceable(1) %1, i8 noundef zeroext %2) {
; CHECK-LABEL: _Z26atomic_cmp_swap_acquire_u8RNSt3__16atomicIhEERhh:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.zx %s4, (, %s1)
; CHECK-NEXT:    and %s3, -4, %s0
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 3
; CHECK-NEXT:    ldl.sx %s5, (, %s3)
; CHECK-NEXT:    sla.w.sx %s6, (56)0, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, %s0
; CHECK-NEXT:    sla.w.sx %s4, %s4, %s0
; CHECK-NEXT:    nnd %s5, %s6, %s5
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    or %s2, %s5, %s2
; CHECK-NEXT:    or %s4, %s5, %s4
; CHECK-NEXT:    cas.w %s2, (%s3), %s4
; CHECK-NEXT:    cmpu.w %s3, %s2, %s4
; CHECK-NEXT:    ldz %s3, %s3
; CHECK-NEXT:    srl %s3, %s3, 6
; CHECK-NEXT:    and %s4, 1, %s3
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    brne.w 0, %s4, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    srl %s0, %s2, %s0
; CHECK-NEXT:    st1b %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i8, ptr %1, align 1
  %5 = cmpxchg weak ptr %0, i8 %4, i8 %2 acquire acquire, align 1
  %6 = extractvalue { i8, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i8, i1 } %5, 0
  store i8 %8, ptr %1, align 1
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i8
  ret i8 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef signext i16 @_Z27atomic_cmp_swap_acquire_i16RNSt3__16atomicIsEERss(ptr nocapture noundef nonnull align 2 dereferenceable(2) %0, ptr nocapture noundef nonnull align 2 dereferenceable(2) %1, i16 noundef signext %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_acquire_i16RNSt3__16atomicIsEERss:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld2b.zx %s4, (, %s1)
; CHECK-NEXT:    and %s3, -4, %s0
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 3
; CHECK-NEXT:    sla.w.sx %s5, (48)0, %s0
; CHECK-NEXT:    ldl.sx %s6, (, %s3)
; CHECK-NEXT:    and %s2, %s2, (48)0
; CHECK-NEXT:    sla.w.sx %s2, %s2, %s0
; CHECK-NEXT:    sla.w.sx %s4, %s4, %s0
; CHECK-NEXT:    nnd %s5, %s5, %s6
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    or %s2, %s5, %s2
; CHECK-NEXT:    or %s4, %s5, %s4
; CHECK-NEXT:    cas.w %s2, (%s3), %s4
; CHECK-NEXT:    cmpu.w %s3, %s2, %s4
; CHECK-NEXT:    ldz %s3, %s3
; CHECK-NEXT:    srl %s3, %s3, 6
; CHECK-NEXT:    and %s4, 1, %s3
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    brne.w 0, %s4, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    srl %s0, %s2, %s0
; CHECK-NEXT:    st2b %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i16, ptr %1, align 2
  %5 = cmpxchg weak ptr %0, i16 %4, i16 %2 acquire acquire, align 2
  %6 = extractvalue { i16, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i16, i1 } %5, 0
  store i16 %8, ptr %1, align 2
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i16
  ret i16 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef zeroext i16 @_Z27atomic_cmp_swap_acquire_u16RNSt3__16atomicItEERtt(ptr nocapture noundef nonnull align 2 dereferenceable(2) %0, ptr nocapture noundef nonnull align 2 dereferenceable(2) %1, i16 noundef zeroext %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_acquire_u16RNSt3__16atomicItEERtt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld2b.zx %s4, (, %s1)
; CHECK-NEXT:    and %s3, -4, %s0
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 3
; CHECK-NEXT:    ldl.sx %s5, (, %s3)
; CHECK-NEXT:    sla.w.sx %s6, (48)0, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, %s0
; CHECK-NEXT:    sla.w.sx %s4, %s4, %s0
; CHECK-NEXT:    nnd %s5, %s6, %s5
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    or %s2, %s5, %s2
; CHECK-NEXT:    or %s4, %s5, %s4
; CHECK-NEXT:    cas.w %s2, (%s3), %s4
; CHECK-NEXT:    cmpu.w %s3, %s2, %s4
; CHECK-NEXT:    ldz %s3, %s3
; CHECK-NEXT:    srl %s3, %s3, 6
; CHECK-NEXT:    and %s4, 1, %s3
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    brne.w 0, %s4, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    srl %s0, %s2, %s0
; CHECK-NEXT:    st2b %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i16, ptr %1, align 2
  %5 = cmpxchg weak ptr %0, i16 %4, i16 %2 acquire acquire, align 2
  %6 = extractvalue { i16, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i16, i1 } %5, 0
  store i16 %8, ptr %1, align 2
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i16
  ret i16 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef signext i32 @_Z27atomic_cmp_swap_acquire_i32RNSt3__16atomicIiEERii(ptr nocapture noundef nonnull align 4 dereferenceable(4) %0, ptr nocapture noundef nonnull align 4 dereferenceable(4) %1, i32 noundef signext %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_acquire_i32RNSt3__16atomicIiEERii:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.sx %s3, (, %s1)
; CHECK-NEXT:    cas.w %s2, (%s0), %s3
; CHECK-NEXT:    cmpu.w %s0, %s2, %s3
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    breq.w %s2, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    stl %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i32, ptr %1, align 4
  %5 = cmpxchg weak ptr %0, i32 %4, i32 %2 acquire acquire, align 4
  %6 = extractvalue { i32, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i32, i1 } %5, 0
  store i32 %8, ptr %1, align 4
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i32
  ret i32 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef zeroext i32 @_Z27atomic_cmp_swap_acquire_u32RNSt3__16atomicIjEERjj(ptr nocapture noundef nonnull align 4 dereferenceable(4) %0, ptr nocapture noundef nonnull align 4 dereferenceable(4) %1, i32 noundef zeroext %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_acquire_u32RNSt3__16atomicIjEERjj:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.sx %s3, (, %s1)
; CHECK-NEXT:    cas.w %s2, (%s0), %s3
; CHECK-NEXT:    cmpu.w %s0, %s2, %s3
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    breq.w %s2, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    stl %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i32, ptr %1, align 4
  %5 = cmpxchg weak ptr %0, i32 %4, i32 %2 acquire acquire, align 4
  %6 = extractvalue { i32, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i32, i1 } %5, 0
  store i32 %8, ptr %1, align 4
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i32
  ret i32 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef i64 @_Z27atomic_cmp_swap_acquire_i64RNSt3__16atomicIlEERll(ptr nocapture noundef nonnull align 8 dereferenceable(8) %0, ptr nocapture noundef nonnull align 8 dereferenceable(8) %1, i64 noundef %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_acquire_i64RNSt3__16atomicIlEERll:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s3, (, %s1)
; CHECK-NEXT:    cas.l %s2, (%s0), %s3
; CHECK-NEXT:    cmpu.l %s0, %s2, %s3
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    breq.l %s2, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i64, ptr %1, align 8
  %5 = cmpxchg weak ptr %0, i64 %4, i64 %2 acquire acquire, align 8
  %6 = extractvalue { i64, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i64, i1 } %5, 0
  store i64 %8, ptr %1, align 8
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i64
  ret i64 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef i64 @_Z27atomic_cmp_swap_acquire_u64RNSt3__16atomicImEERmm(ptr nocapture noundef nonnull align 8 dereferenceable(8) %0, ptr nocapture noundef nonnull align 8 dereferenceable(8) %1, i64 noundef %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_acquire_u64RNSt3__16atomicImEERmm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s3, (, %s1)
; CHECK-NEXT:    cas.l %s2, (%s0), %s3
; CHECK-NEXT:    cmpu.l %s0, %s2, %s3
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    breq.l %s2, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i64, ptr %1, align 8
  %5 = cmpxchg weak ptr %0, i64 %4, i64 %2 acquire acquire, align 8
  %6 = extractvalue { i64, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i64, i1 } %5, 0
  store i64 %8, ptr %1, align 8
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i64
  ret i64 %10
}

; Function Attrs: mustprogress nounwind willreturn
define noundef i128 @_Z28atomic_cmp_swap_acquire_i128RNSt3__16atomicInEERnn(ptr noundef nonnull align 16 dereferenceable(16) %0, ptr noundef nonnull align 16 dereferenceable(16) %1, i128 noundef %2) {
; CHECK-LABEL: _Z28atomic_cmp_swap_acquire_i128RNSt3__16atomicInEERnn:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s6, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    st %s3, -8(, %s9)
; CHECK-NEXT:    st %s2, -16(, %s9)
; CHECK-NEXT:    lea %s0, __atomic_compare_exchange@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_compare_exchange@hi(, %s0)
; CHECK-NEXT:    lea %s3, -16(, %s9)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s4, 2, (0)1
; CHECK-NEXT:    or %s5, 2, (0)1
; CHECK-NEXT:    or %s2, 0, %s6
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %4 = alloca i128, align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %4)
  store i128 %2, ptr %4, align 16, !tbaa !3
  %5 = call noundef zeroext i1 @__atomic_compare_exchange(i64 noundef 16, ptr noundef nonnull %0, ptr noundef nonnull %1, ptr noundef nonnull %4, i32 noundef signext 2, i32 noundef signext 2)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %4)
  %6 = zext i1 %5 to i128
  ret i128 %6
}

; Function Attrs: mustprogress nounwind willreturn
define noundef i128 @_Z28atomic_cmp_swap_acquire_u128RNSt3__16atomicIoEERoo(ptr noundef nonnull align 16 dereferenceable(16) %0, ptr noundef nonnull align 16 dereferenceable(16) %1, i128 noundef %2) {
; CHECK-LABEL: _Z28atomic_cmp_swap_acquire_u128RNSt3__16atomicIoEERoo:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s6, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    st %s3, -8(, %s9)
; CHECK-NEXT:    st %s2, -16(, %s9)
; CHECK-NEXT:    lea %s0, __atomic_compare_exchange@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_compare_exchange@hi(, %s0)
; CHECK-NEXT:    lea %s3, -16(, %s9)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s4, 2, (0)1
; CHECK-NEXT:    or %s5, 2, (0)1
; CHECK-NEXT:    or %s2, 0, %s6
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %4 = alloca i128, align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %4)
  store i128 %2, ptr %4, align 16, !tbaa !3
  %5 = call noundef zeroext i1 @__atomic_compare_exchange(i64 noundef 16, ptr noundef nonnull %0, ptr noundef nonnull %1, ptr noundef nonnull %4, i32 noundef signext 2, i32 noundef signext 2)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %4)
  %6 = zext i1 %5 to i128
  ret i128 %6
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef zeroext i1 @_Z26atomic_cmp_swap_seq_cst_i1RNSt3__16atomicIbEERbb(ptr nocapture noundef nonnull align 1 dereferenceable(1) %0, ptr nocapture noundef nonnull align 1 dereferenceable(1) %1, i1 noundef zeroext %2) personality ptr @__gxx_personality_sj0 {
; CHECK-LABEL: _Z26atomic_cmp_swap_seq_cst_i1RNSt3__16atomicIbEERbb:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.zx %s4, (, %s1)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    and %s3, -4, %s0
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 3
; CHECK-NEXT:    ldl.sx %s5, (, %s3)
; CHECK-NEXT:    sla.w.sx %s6, (56)0, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, %s0
; CHECK-NEXT:    sla.w.sx %s4, %s4, %s0
; CHECK-NEXT:    nnd %s5, %s6, %s5
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    or %s2, %s5, %s2
; CHECK-NEXT:    or %s4, %s5, %s4
; CHECK-NEXT:    cas.w %s2, (%s3), %s4
; CHECK-NEXT:    cmpu.w %s3, %s2, %s4
; CHECK-NEXT:    ldz %s3, %s3
; CHECK-NEXT:    srl %s3, %s3, 6
; CHECK-NEXT:    and %s4, 1, %s3
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    brne.w 0, %s4, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    srl %s0, %s2, %s0
; CHECK-NEXT:    st1b %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = zext i1 %2 to i8
  %5 = load i8, ptr %1, align 1
  %6 = cmpxchg weak ptr %0, i8 %5, i8 %4 seq_cst seq_cst, align 1
  %7 = extractvalue { i8, i1 } %6, 1
  br i1 %7, label %10, label %8

8:                                                ; preds = %3
  %9 = extractvalue { i8, i1 } %6, 0
  store i8 %9, ptr %1, align 1
  br label %10

10:                                               ; preds = %8, %3
  ret i1 %7
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef signext i8 @_Z26atomic_cmp_swap_seq_cst_i8RNSt3__16atomicIcEERcc(ptr nocapture noundef nonnull align 1 dereferenceable(1) %0, ptr nocapture noundef nonnull align 1 dereferenceable(1) %1, i8 noundef signext %2) {
; CHECK-LABEL: _Z26atomic_cmp_swap_seq_cst_i8RNSt3__16atomicIcEERcc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.zx %s4, (, %s1)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    and %s3, -4, %s0
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 3
; CHECK-NEXT:    sla.w.sx %s5, (56)0, %s0
; CHECK-NEXT:    ldl.sx %s6, (, %s3)
; CHECK-NEXT:    and %s2, %s2, (56)0
; CHECK-NEXT:    sla.w.sx %s2, %s2, %s0
; CHECK-NEXT:    sla.w.sx %s4, %s4, %s0
; CHECK-NEXT:    nnd %s5, %s5, %s6
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    or %s2, %s5, %s2
; CHECK-NEXT:    or %s4, %s5, %s4
; CHECK-NEXT:    cas.w %s2, (%s3), %s4
; CHECK-NEXT:    cmpu.w %s3, %s2, %s4
; CHECK-NEXT:    ldz %s3, %s3
; CHECK-NEXT:    srl %s3, %s3, 6
; CHECK-NEXT:    and %s4, 1, %s3
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    brne.w 0, %s4, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    srl %s0, %s2, %s0
; CHECK-NEXT:    st1b %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i8, ptr %1, align 1
  %5 = cmpxchg weak ptr %0, i8 %4, i8 %2 seq_cst seq_cst, align 1
  %6 = extractvalue { i8, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i8, i1 } %5, 0
  store i8 %8, ptr %1, align 1
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i8
  ret i8 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef zeroext i8 @_Z26atomic_cmp_swap_seq_cst_u8RNSt3__16atomicIhEERhh(ptr nocapture noundef nonnull align 1 dereferenceable(1) %0, ptr nocapture noundef nonnull align 1 dereferenceable(1) %1, i8 noundef zeroext %2) {
; CHECK-LABEL: _Z26atomic_cmp_swap_seq_cst_u8RNSt3__16atomicIhEERhh:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.zx %s4, (, %s1)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    and %s3, -4, %s0
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 3
; CHECK-NEXT:    ldl.sx %s5, (, %s3)
; CHECK-NEXT:    sla.w.sx %s6, (56)0, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, %s0
; CHECK-NEXT:    sla.w.sx %s4, %s4, %s0
; CHECK-NEXT:    nnd %s5, %s6, %s5
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    or %s2, %s5, %s2
; CHECK-NEXT:    or %s4, %s5, %s4
; CHECK-NEXT:    cas.w %s2, (%s3), %s4
; CHECK-NEXT:    cmpu.w %s3, %s2, %s4
; CHECK-NEXT:    ldz %s3, %s3
; CHECK-NEXT:    srl %s3, %s3, 6
; CHECK-NEXT:    and %s4, 1, %s3
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    brne.w 0, %s4, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    srl %s0, %s2, %s0
; CHECK-NEXT:    st1b %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i8, ptr %1, align 1
  %5 = cmpxchg weak ptr %0, i8 %4, i8 %2 seq_cst seq_cst, align 1
  %6 = extractvalue { i8, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i8, i1 } %5, 0
  store i8 %8, ptr %1, align 1
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i8
  ret i8 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef signext i16 @_Z27atomic_cmp_swap_seq_cst_i16RNSt3__16atomicIsEERss(ptr nocapture noundef nonnull align 2 dereferenceable(2) %0, ptr nocapture noundef nonnull align 2 dereferenceable(2) %1, i16 noundef signext %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_seq_cst_i16RNSt3__16atomicIsEERss:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld2b.zx %s4, (, %s1)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    and %s3, -4, %s0
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 3
; CHECK-NEXT:    sla.w.sx %s5, (48)0, %s0
; CHECK-NEXT:    ldl.sx %s6, (, %s3)
; CHECK-NEXT:    and %s2, %s2, (48)0
; CHECK-NEXT:    sla.w.sx %s2, %s2, %s0
; CHECK-NEXT:    sla.w.sx %s4, %s4, %s0
; CHECK-NEXT:    nnd %s5, %s5, %s6
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    or %s2, %s5, %s2
; CHECK-NEXT:    or %s4, %s5, %s4
; CHECK-NEXT:    cas.w %s2, (%s3), %s4
; CHECK-NEXT:    cmpu.w %s3, %s2, %s4
; CHECK-NEXT:    ldz %s3, %s3
; CHECK-NEXT:    srl %s3, %s3, 6
; CHECK-NEXT:    and %s4, 1, %s3
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    brne.w 0, %s4, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    srl %s0, %s2, %s0
; CHECK-NEXT:    st2b %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i16, ptr %1, align 2
  %5 = cmpxchg weak ptr %0, i16 %4, i16 %2 seq_cst seq_cst, align 2
  %6 = extractvalue { i16, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i16, i1 } %5, 0
  store i16 %8, ptr %1, align 2
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i16
  ret i16 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef zeroext i16 @_Z27atomic_cmp_swap_seq_cst_u16RNSt3__16atomicItEERtt(ptr nocapture noundef nonnull align 2 dereferenceable(2) %0, ptr nocapture noundef nonnull align 2 dereferenceable(2) %1, i16 noundef zeroext %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_seq_cst_u16RNSt3__16atomicItEERtt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld2b.zx %s4, (, %s1)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    and %s3, -4, %s0
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 3
; CHECK-NEXT:    ldl.sx %s5, (, %s3)
; CHECK-NEXT:    sla.w.sx %s6, (48)0, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, %s0
; CHECK-NEXT:    sla.w.sx %s4, %s4, %s0
; CHECK-NEXT:    nnd %s5, %s6, %s5
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    or %s2, %s5, %s2
; CHECK-NEXT:    or %s4, %s5, %s4
; CHECK-NEXT:    cas.w %s2, (%s3), %s4
; CHECK-NEXT:    cmpu.w %s3, %s2, %s4
; CHECK-NEXT:    ldz %s3, %s3
; CHECK-NEXT:    srl %s3, %s3, 6
; CHECK-NEXT:    and %s4, 1, %s3
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    brne.w 0, %s4, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    srl %s0, %s2, %s0
; CHECK-NEXT:    st2b %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s3
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i16, ptr %1, align 2
  %5 = cmpxchg weak ptr %0, i16 %4, i16 %2 seq_cst seq_cst, align 2
  %6 = extractvalue { i16, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i16, i1 } %5, 0
  store i16 %8, ptr %1, align 2
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i16
  ret i16 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef signext i32 @_Z27atomic_cmp_swap_seq_cst_i32RNSt3__16atomicIiEERii(ptr nocapture noundef nonnull align 4 dereferenceable(4) %0, ptr nocapture noundef nonnull align 4 dereferenceable(4) %1, i32 noundef signext %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_seq_cst_i32RNSt3__16atomicIiEERii:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.sx %s3, (, %s1)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    cas.w %s2, (%s0), %s3
; CHECK-NEXT:    cmpu.w %s0, %s2, %s3
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    breq.w %s2, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    stl %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i32, ptr %1, align 4
  %5 = cmpxchg weak ptr %0, i32 %4, i32 %2 seq_cst seq_cst, align 4
  %6 = extractvalue { i32, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i32, i1 } %5, 0
  store i32 %8, ptr %1, align 4
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i32
  ret i32 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef zeroext i32 @_Z27atomic_cmp_swap_seq_cst_u32RNSt3__16atomicIjEERjj(ptr nocapture noundef nonnull align 4 dereferenceable(4) %0, ptr nocapture noundef nonnull align 4 dereferenceable(4) %1, i32 noundef zeroext %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_seq_cst_u32RNSt3__16atomicIjEERjj:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.sx %s3, (, %s1)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    cas.w %s2, (%s0), %s3
; CHECK-NEXT:    cmpu.w %s0, %s2, %s3
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    breq.w %s2, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    stl %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i32, ptr %1, align 4
  %5 = cmpxchg weak ptr %0, i32 %4, i32 %2 seq_cst seq_cst, align 4
  %6 = extractvalue { i32, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i32, i1 } %5, 0
  store i32 %8, ptr %1, align 4
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i32
  ret i32 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef i64 @_Z27atomic_cmp_swap_seq_cst_i64RNSt3__16atomicIlEERll(ptr nocapture noundef nonnull align 8 dereferenceable(8) %0, ptr nocapture noundef nonnull align 8 dereferenceable(8) %1, i64 noundef %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_seq_cst_i64RNSt3__16atomicIlEERll:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s3, (, %s1)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    cas.l %s2, (%s0), %s3
; CHECK-NEXT:    cmpu.l %s0, %s2, %s3
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    breq.l %s2, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i64, ptr %1, align 8
  %5 = cmpxchg weak ptr %0, i64 %4, i64 %2 seq_cst seq_cst, align 8
  %6 = extractvalue { i64, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i64, i1 } %5, 0
  store i64 %8, ptr %1, align 8
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i64
  ret i64 %10
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
define noundef i64 @_Z27atomic_cmp_swap_seq_cst_u64RNSt3__16atomicImEERmm(ptr nocapture noundef nonnull align 8 dereferenceable(8) %0, ptr nocapture noundef nonnull align 8 dereferenceable(8) %1, i64 noundef %2) {
; CHECK-LABEL: _Z27atomic_cmp_swap_seq_cst_u64RNSt3__16atomicImEERmm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s3, (, %s1)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    cas.l %s2, (%s0), %s3
; CHECK-NEXT:    cmpu.l %s0, %s2, %s3
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    breq.l %s2, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = load i64, ptr %1, align 8
  %5 = cmpxchg weak ptr %0, i64 %4, i64 %2 seq_cst seq_cst, align 8
  %6 = extractvalue { i64, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %3
  %8 = extractvalue { i64, i1 } %5, 0
  store i64 %8, ptr %1, align 8
  br label %9

9:                                                ; preds = %7, %3
  %10 = zext i1 %6 to i64
  ret i64 %10
}

; Function Attrs: mustprogress nounwind willreturn
define noundef i128 @_Z28atomic_cmp_swap_seq_cst_i128RNSt3__16atomicInEERnn(ptr noundef nonnull align 16 dereferenceable(16) %0, ptr noundef nonnull align 16 dereferenceable(16) %1, i128 noundef %2) {
; CHECK-LABEL: _Z28atomic_cmp_swap_seq_cst_i128RNSt3__16atomicInEERnn:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s6, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    st %s3, -8(, %s9)
; CHECK-NEXT:    st %s2, -16(, %s9)
; CHECK-NEXT:    lea %s0, __atomic_compare_exchange@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_compare_exchange@hi(, %s0)
; CHECK-NEXT:    lea %s3, -16(, %s9)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s4, 5, (0)1
; CHECK-NEXT:    or %s5, 5, (0)1
; CHECK-NEXT:    or %s2, 0, %s6
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %4 = alloca i128, align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %4)
  store i128 %2, ptr %4, align 16, !tbaa !3
  %5 = call noundef zeroext i1 @__atomic_compare_exchange(i64 noundef 16, ptr noundef nonnull %0, ptr noundef nonnull %1, ptr noundef nonnull %4, i32 noundef signext 5, i32 noundef signext 5)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %4)
  %6 = zext i1 %5 to i128
  ret i128 %6
}

; Function Attrs: mustprogress nounwind willreturn
define noundef i128 @_Z28atomic_cmp_swap_seq_cst_u128RNSt3__16atomicIoEERoo(ptr noundef nonnull align 16 dereferenceable(16) %0, ptr noundef nonnull align 16 dereferenceable(16) %1, i128 noundef %2) {
; CHECK-LABEL: _Z28atomic_cmp_swap_seq_cst_u128RNSt3__16atomicIoEERoo:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s6, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    st %s3, -8(, %s9)
; CHECK-NEXT:    st %s2, -16(, %s9)
; CHECK-NEXT:    lea %s0, __atomic_compare_exchange@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_compare_exchange@hi(, %s0)
; CHECK-NEXT:    lea %s3, -16(, %s9)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s4, 5, (0)1
; CHECK-NEXT:    or %s5, 5, (0)1
; CHECK-NEXT:    or %s2, 0, %s6
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %4 = alloca i128, align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %4)
  store i128 %2, ptr %4, align 16, !tbaa !3
  %5 = call noundef zeroext i1 @__atomic_compare_exchange(i64 noundef 16, ptr noundef nonnull %0, ptr noundef nonnull %1, ptr noundef nonnull %4, i32 noundef signext 5, i32 noundef signext 5)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %4)
  %6 = zext i1 %5 to i128
  ret i128 %6
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite)
define noundef zeroext i1 @_Z30atomic_cmp_swap_relaxed_stk_i1Rbb(ptr nocapture noundef nonnull align 1 dereferenceable(1) %0, i1 noundef zeroext %1) {
; CHECK-LABEL: _Z30atomic_cmp_swap_relaxed_stk_i1Rbb:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:    ld1b.zx %s3, (, %s0)
; CHECK-NEXT:    ldl.zx %s4, 8(, %s11)
; CHECK-NEXT:    lea %s2, 8(, %s11)
; CHECK-NEXT:    lea %s5, -256
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    and %s4, %s4, %s5
; CHECK-NEXT:    or %s1, %s4, %s1
; CHECK-NEXT:    or %s3, %s4, %s3
; CHECK-NEXT:    cas.w %s1, (%s2), %s3
; CHECK-NEXT:    cmpu.w %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    and %s3, 1, %s2
; CHECK-NEXT:    brne.w 0, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st1b %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = alloca %"struct.std::__1::atomic", align 1
  call void @llvm.lifetime.start.p0(i64 1, ptr nonnull %3)
  %4 = zext i1 %1 to i8
  %5 = load i8, ptr %0, align 1
  %6 = cmpxchg weak volatile ptr %3, i8 %5, i8 %4 monotonic monotonic, align 1
  %7 = extractvalue { i8, i1 } %6, 1
  br i1 %7, label %10, label %8

8:                                                ; preds = %2
  %9 = extractvalue { i8, i1 } %6, 0
  store i8 %9, ptr %0, align 1
  br label %10

10:                                               ; preds = %8, %2
  call void @llvm.lifetime.end.p0(i64 1, ptr nonnull %3)
  ret i1 %7
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture)

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture)

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite)
define noundef signext i8 @_Z30atomic_cmp_swap_relaxed_stk_i8Rcc(ptr nocapture noundef nonnull align 1 dereferenceable(1) %0, i8 noundef signext %1) {
; CHECK-LABEL: _Z30atomic_cmp_swap_relaxed_stk_i8Rcc:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:    ld1b.zx %s3, (, %s0)
; CHECK-NEXT:    lea %s2, 8(, %s11)
; CHECK-NEXT:    ldl.zx %s4, 8(, %s11)
; CHECK-NEXT:    and %s1, %s1, (56)0
; CHECK-NEXT:    lea %s5, -256
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    and %s4, %s4, %s5
; CHECK-NEXT:    or %s1, %s4, %s1
; CHECK-NEXT:    or %s3, %s4, %s3
; CHECK-NEXT:    cas.w %s1, (%s2), %s3
; CHECK-NEXT:    cmpu.w %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    and %s3, 1, %s2
; CHECK-NEXT:    brne.w 0, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st1b %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = alloca %"struct.std::__1::atomic.0", align 1
  call void @llvm.lifetime.start.p0(i64 1, ptr nonnull %3)
  %4 = load i8, ptr %0, align 1
  %5 = cmpxchg weak volatile ptr %3, i8 %4, i8 %1 monotonic monotonic, align 1
  %6 = extractvalue { i8, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %2
  %8 = extractvalue { i8, i1 } %5, 0
  store i8 %8, ptr %0, align 1
  br label %9

9:                                                ; preds = %7, %2
  %10 = zext i1 %6 to i8
  call void @llvm.lifetime.end.p0(i64 1, ptr nonnull %3)
  ret i8 %10
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite)
define noundef zeroext i8 @_Z30atomic_cmp_swap_relaxed_stk_u8Rhh(ptr nocapture noundef nonnull align 1 dereferenceable(1) %0, i8 noundef zeroext %1) {
; CHECK-LABEL: _Z30atomic_cmp_swap_relaxed_stk_u8Rhh:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:    ld1b.zx %s3, (, %s0)
; CHECK-NEXT:    ldl.zx %s4, 8(, %s11)
; CHECK-NEXT:    lea %s2, 8(, %s11)
; CHECK-NEXT:    lea %s5, -256
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    and %s4, %s4, %s5
; CHECK-NEXT:    or %s1, %s4, %s1
; CHECK-NEXT:    or %s3, %s4, %s3
; CHECK-NEXT:    cas.w %s1, (%s2), %s3
; CHECK-NEXT:    cmpu.w %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    and %s3, 1, %s2
; CHECK-NEXT:    brne.w 0, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st1b %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = alloca %"struct.std::__1::atomic.5", align 1
  call void @llvm.lifetime.start.p0(i64 1, ptr nonnull %3)
  %4 = load i8, ptr %0, align 1
  %5 = cmpxchg weak volatile ptr %3, i8 %4, i8 %1 monotonic monotonic, align 1
  %6 = extractvalue { i8, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %2
  %8 = extractvalue { i8, i1 } %5, 0
  store i8 %8, ptr %0, align 1
  br label %9

9:                                                ; preds = %7, %2
  %10 = zext i1 %6 to i8
  call void @llvm.lifetime.end.p0(i64 1, ptr nonnull %3)
  ret i8 %10
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite)
define noundef signext i16 @_Z31atomic_cmp_swap_relaxed_stk_i16Rss(ptr nocapture noundef nonnull align 2 dereferenceable(2) %0, i16 noundef signext %1) {
; CHECK-LABEL: _Z31atomic_cmp_swap_relaxed_stk_i16Rss:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:    ld2b.zx %s3, (, %s0)
; CHECK-NEXT:    lea %s2, 8(, %s11)
; CHECK-NEXT:    ldl.zx %s4, 8(, %s11)
; CHECK-NEXT:    and %s1, %s1, (48)0
; CHECK-NEXT:    lea %s5, -65536
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    and %s4, %s4, %s5
; CHECK-NEXT:    or %s1, %s4, %s1
; CHECK-NEXT:    or %s3, %s4, %s3
; CHECK-NEXT:    cas.w %s1, (%s2), %s3
; CHECK-NEXT:    cmpu.w %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    and %s3, 1, %s2
; CHECK-NEXT:    brne.w 0, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st2b %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = alloca %"struct.std::__1::atomic.10", align 2
  call void @llvm.lifetime.start.p0(i64 2, ptr nonnull %3)
  %4 = load i16, ptr %0, align 2
  %5 = cmpxchg weak volatile ptr %3, i16 %4, i16 %1 monotonic monotonic, align 2
  %6 = extractvalue { i16, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %2
  %8 = extractvalue { i16, i1 } %5, 0
  store i16 %8, ptr %0, align 2
  br label %9

9:                                                ; preds = %7, %2
  %10 = zext i1 %6 to i16
  call void @llvm.lifetime.end.p0(i64 2, ptr nonnull %3)
  ret i16 %10
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite)
define noundef zeroext i16 @_Z31atomic_cmp_swap_relaxed_stk_u16Rtt(ptr nocapture noundef nonnull align 2 dereferenceable(2) %0, i16 noundef zeroext %1) {
; CHECK-LABEL: _Z31atomic_cmp_swap_relaxed_stk_u16Rtt:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:    ld2b.zx %s3, (, %s0)
; CHECK-NEXT:    ldl.zx %s4, 8(, %s11)
; CHECK-NEXT:    lea %s2, 8(, %s11)
; CHECK-NEXT:    lea %s5, -65536
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    and %s4, %s4, %s5
; CHECK-NEXT:    or %s1, %s4, %s1
; CHECK-NEXT:    or %s3, %s4, %s3
; CHECK-NEXT:    cas.w %s1, (%s2), %s3
; CHECK-NEXT:    cmpu.w %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    and %s3, 1, %s2
; CHECK-NEXT:    brne.w 0, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st2b %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = alloca %"struct.std::__1::atomic.15", align 2
  call void @llvm.lifetime.start.p0(i64 2, ptr nonnull %3)
  %4 = load i16, ptr %0, align 2
  %5 = cmpxchg weak volatile ptr %3, i16 %4, i16 %1 monotonic monotonic, align 2
  %6 = extractvalue { i16, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %2
  %8 = extractvalue { i16, i1 } %5, 0
  store i16 %8, ptr %0, align 2
  br label %9

9:                                                ; preds = %7, %2
  %10 = zext i1 %6 to i16
  call void @llvm.lifetime.end.p0(i64 2, ptr nonnull %3)
  ret i16 %10
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite)
define noundef signext i32 @_Z31atomic_cmp_swap_relaxed_stk_i32Rii(ptr nocapture noundef nonnull align 4 dereferenceable(4) %0, i32 noundef signext %1) {
; CHECK-LABEL: _Z31atomic_cmp_swap_relaxed_stk_i32Rii:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:    ldl.sx %s3, (, %s0)
; CHECK-NEXT:    cas.w %s1, 8(%s11), %s3
; CHECK-NEXT:    cmpu.w %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    breq.w %s1, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    stl %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = alloca %"struct.std::__1::atomic.20", align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %3)
  %4 = load i32, ptr %0, align 4
  %5 = cmpxchg weak volatile ptr %3, i32 %4, i32 %1 monotonic monotonic, align 4
  %6 = extractvalue { i32, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %2
  %8 = extractvalue { i32, i1 } %5, 0
  store i32 %8, ptr %0, align 4
  br label %9

9:                                                ; preds = %7, %2
  %10 = zext i1 %6 to i32
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %3)
  ret i32 %10
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite)
define noundef zeroext i32 @_Z31atomic_cmp_swap_relaxed_stk_u32Rjj(ptr nocapture noundef nonnull align 4 dereferenceable(4) %0, i32 noundef zeroext %1) {
; CHECK-LABEL: _Z31atomic_cmp_swap_relaxed_stk_u32Rjj:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:    ldl.sx %s3, (, %s0)
; CHECK-NEXT:    cas.w %s1, 8(%s11), %s3
; CHECK-NEXT:    cmpu.w %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    breq.w %s1, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    stl %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = alloca %"struct.std::__1::atomic.25", align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %3)
  %4 = load i32, ptr %0, align 4
  %5 = cmpxchg weak volatile ptr %3, i32 %4, i32 %1 monotonic monotonic, align 4
  %6 = extractvalue { i32, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %2
  %8 = extractvalue { i32, i1 } %5, 0
  store i32 %8, ptr %0, align 4
  br label %9

9:                                                ; preds = %7, %2
  %10 = zext i1 %6 to i32
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %3)
  ret i32 %10
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite)
define noundef i64 @_Z31atomic_cmp_swap_relaxed_stk_i64Rll(ptr nocapture noundef nonnull align 8 dereferenceable(8) %0, i64 noundef %1) {
; CHECK-LABEL: _Z31atomic_cmp_swap_relaxed_stk_i64Rll:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:    ld %s3, (, %s0)
; CHECK-NEXT:    cas.l %s1, 8(%s11), %s3
; CHECK-NEXT:    cmpu.l %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    breq.l %s1, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = alloca %"struct.std::__1::atomic.30", align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %3)
  %4 = load i64, ptr %0, align 8
  %5 = cmpxchg weak volatile ptr %3, i64 %4, i64 %1 monotonic monotonic, align 8
  %6 = extractvalue { i64, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %2
  %8 = extractvalue { i64, i1 } %5, 0
  store i64 %8, ptr %0, align 8
  br label %9

9:                                                ; preds = %7, %2
  %10 = zext i1 %6 to i64
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %3)
  ret i64 %10
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite)
define noundef i64 @_Z31atomic_cmp_swap_relaxed_stk_u64Rmm(ptr nocapture noundef nonnull align 8 dereferenceable(8) %0, i64 noundef %1) {
; CHECK-LABEL: _Z31atomic_cmp_swap_relaxed_stk_u64Rmm:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:    ld %s3, (, %s0)
; CHECK-NEXT:    cas.l %s1, 8(%s11), %s3
; CHECK-NEXT:    cmpu.l %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    breq.l %s1, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    adds.l %s11, 16, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = alloca %"struct.std::__1::atomic.35", align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %3)
  %4 = load i64, ptr %0, align 8
  %5 = cmpxchg weak volatile ptr %3, i64 %4, i64 %1 monotonic monotonic, align 8
  %6 = extractvalue { i64, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %2
  %8 = extractvalue { i64, i1 } %5, 0
  store i64 %8, ptr %0, align 8
  br label %9

9:                                                ; preds = %7, %2
  %10 = zext i1 %6 to i64
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %3)
  ret i64 %10
}

; Function Attrs: mustprogress nounwind willreturn
define noundef i128 @_Z32atomic_cmp_swap_relaxed_stk_i128Rnn(ptr noundef nonnull align 16 dereferenceable(16) %0, i128 noundef %1) {
; CHECK-LABEL: _Z32atomic_cmp_swap_relaxed_stk_i128Rnn:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s6, 0, %s0
; CHECK-NEXT:    st %s2, -8(, %s9)
; CHECK-NEXT:    st %s1, -16(, %s9)
; CHECK-NEXT:    lea %s0, __atomic_compare_exchange@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_compare_exchange@hi(, %s0)
; CHECK-NEXT:    lea %s1, -32(, %s9)
; CHECK-NEXT:    lea %s3, -16(, %s9)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    or %s2, 0, %s6
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = alloca i128, align 16
  %4 = alloca %"struct.std::__1::atomic.40", align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %4)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %3)
  store i128 %1, ptr %3, align 16, !tbaa !3
  %5 = call noundef zeroext i1 @__atomic_compare_exchange(i64 noundef 16, ptr noundef nonnull %4, ptr noundef nonnull %0, ptr noundef nonnull %3, i32 noundef signext 0, i32 noundef signext 0)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %3)
  %6 = zext i1 %5 to i128
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %4)
  ret i128 %6
}

; Function Attrs: mustprogress nounwind willreturn
define noundef i128 @_Z32atomic_cmp_swap_relaxed_stk_u128Roo(ptr noundef nonnull align 16 dereferenceable(16) %0, i128 noundef %1) {
; CHECK-LABEL: _Z32atomic_cmp_swap_relaxed_stk_u128Roo:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s6, 0, %s0
; CHECK-NEXT:    st %s2, -8(, %s9)
; CHECK-NEXT:    st %s1, -16(, %s9)
; CHECK-NEXT:    lea %s0, __atomic_compare_exchange@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_compare_exchange@hi(, %s0)
; CHECK-NEXT:    lea %s1, -32(, %s9)
; CHECK-NEXT:    lea %s3, -16(, %s9)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    or %s2, 0, %s6
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = alloca i128, align 16
  %4 = alloca %"struct.std::__1::atomic.45", align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %4)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %3)
  store i128 %1, ptr %3, align 16, !tbaa !3
  %5 = call noundef zeroext i1 @__atomic_compare_exchange(i64 noundef 16, ptr noundef nonnull %4, ptr noundef nonnull %0, ptr noundef nonnull %3, i32 noundef signext 0, i32 noundef signext 0)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %3)
  %6 = zext i1 %5 to i128
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %4)
  ret i128 %6
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(readwrite, inaccessiblemem: none)
define noundef zeroext i1 @_Z29atomic_cmp_swap_relaxed_gv_i1Rbb(ptr nocapture noundef nonnull align 1 dereferenceable(1) %0, i1 noundef zeroext %1) personality ptr @__gxx_personality_sj0 {
; CHECK-LABEL: _Z29atomic_cmp_swap_relaxed_gv_i1Rbb:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s2, gv_i1@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, gv_i1@hi(, %s2)
; CHECK-NEXT:    and %s2, -4, %s2
; CHECK-NEXT:    ldl.zx %s4, (, %s2)
; CHECK-NEXT:    ld1b.zx %s3, (, %s0)
; CHECK-NEXT:    lea %s5, -256
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    and %s4, %s4, %s5
; CHECK-NEXT:    or %s1, %s4, %s1
; CHECK-NEXT:    or %s3, %s4, %s3
; CHECK-NEXT:    cas.w %s1, (%s2), %s3
; CHECK-NEXT:    cmpu.w %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    and %s3, 1, %s2
; CHECK-NEXT:    brne.w 0, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st1b %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = zext i1 %1 to i8
  %4 = load i8, ptr %0, align 1
  %5 = cmpxchg weak ptr @gv_i1, i8 %4, i8 %3 monotonic monotonic, align 1
  %6 = extractvalue { i8, i1 } %5, 1
  br i1 %6, label %9, label %7

7:                                                ; preds = %2
  %8 = extractvalue { i8, i1 } %5, 0
  store i8 %8, ptr %0, align 1
  br label %9

9:                                                ; preds = %7, %2
  ret i1 %6
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(readwrite, inaccessiblemem: none)
define noundef signext i8 @_Z29atomic_cmp_swap_relaxed_gv_i8Rcc(ptr nocapture noundef nonnull align 1 dereferenceable(1) %0, i8 noundef signext %1) {
; CHECK-LABEL: _Z29atomic_cmp_swap_relaxed_gv_i8Rcc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld1b.zx %s2, (, %s0)
; CHECK-NEXT:    lea %s3, gv_i8@lo
; CHECK-NEXT:    and %s3, %s3, (32)0
; CHECK-NEXT:    lea.sl %s3, gv_i8@hi(, %s3)
; CHECK-NEXT:    and %s3, -4, %s3
; CHECK-NEXT:    ldl.zx %s4, (, %s3)
; CHECK-NEXT:    and %s1, %s1, (56)0
; CHECK-NEXT:    lea %s5, -256
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    and %s4, %s4, %s5
; CHECK-NEXT:    or %s1, %s4, %s1
; CHECK-NEXT:    or %s2, %s4, %s2
; CHECK-NEXT:    cas.w %s1, (%s3), %s2
; CHECK-NEXT:    cmpu.w %s2, %s1, %s2
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    and %s3, 1, %s2
; CHECK-NEXT:    brne.w 0, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st1b %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = load i8, ptr %0, align 1
  %4 = cmpxchg weak ptr @gv_i8, i8 %3, i8 %1 monotonic monotonic, align 1
  %5 = extractvalue { i8, i1 } %4, 1
  br i1 %5, label %8, label %6

6:                                                ; preds = %2
  %7 = extractvalue { i8, i1 } %4, 0
  store i8 %7, ptr %0, align 1
  br label %8

8:                                                ; preds = %6, %2
  %9 = zext i1 %5 to i8
  ret i8 %9
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(readwrite, inaccessiblemem: none)
define noundef zeroext i8 @_Z29atomic_cmp_swap_relaxed_gv_u8Rhh(ptr nocapture noundef nonnull align 1 dereferenceable(1) %0, i8 noundef zeroext %1) {
; CHECK-LABEL: _Z29atomic_cmp_swap_relaxed_gv_u8Rhh:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s2, gv_u8@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, gv_u8@hi(, %s2)
; CHECK-NEXT:    and %s2, -4, %s2
; CHECK-NEXT:    ldl.zx %s4, (, %s2)
; CHECK-NEXT:    ld1b.zx %s3, (, %s0)
; CHECK-NEXT:    lea %s5, -256
; CHECK-NEXT:    and %s5, %s5, (32)0
; CHECK-NEXT:    and %s4, %s4, %s5
; CHECK-NEXT:    or %s1, %s4, %s1
; CHECK-NEXT:    or %s3, %s4, %s3
; CHECK-NEXT:    cas.w %s1, (%s2), %s3
; CHECK-NEXT:    cmpu.w %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    and %s3, 1, %s2
; CHECK-NEXT:    brne.w 0, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st1b %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = load i8, ptr %0, align 1
  %4 = cmpxchg weak ptr @gv_u8, i8 %3, i8 %1 monotonic monotonic, align 1
  %5 = extractvalue { i8, i1 } %4, 1
  br i1 %5, label %8, label %6

6:                                                ; preds = %2
  %7 = extractvalue { i8, i1 } %4, 0
  store i8 %7, ptr %0, align 1
  br label %8

8:                                                ; preds = %6, %2
  %9 = zext i1 %5 to i8
  ret i8 %9
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(readwrite, inaccessiblemem: none)
define noundef signext i16 @_Z30atomic_cmp_swap_relaxed_gv_i16Rss(ptr nocapture noundef nonnull align 2 dereferenceable(2) %0, i16 noundef signext %1) {
; CHECK-LABEL: _Z30atomic_cmp_swap_relaxed_gv_i16Rss:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s2, gv_i16@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, gv_i16@hi(, %s2)
; CHECK-NEXT:    and %s2, -4, %s2
; CHECK-NEXT:    ld2b.zx %s4, 2(, %s2)
; CHECK-NEXT:    ld2b.zx %s3, (, %s0)
; CHECK-NEXT:    and %s1, %s1, (48)0
; CHECK-NEXT:    sla.w.sx %s4, %s4, 16
; CHECK-NEXT:    or %s1, %s4, %s1
; CHECK-NEXT:    or %s3, %s4, %s3
; CHECK-NEXT:    cas.w %s1, (%s2), %s3
; CHECK-NEXT:    cmpu.w %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    and %s3, 1, %s2
; CHECK-NEXT:    brne.w 0, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st2b %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = load i16, ptr %0, align 2
  %4 = cmpxchg weak ptr @gv_i16, i16 %3, i16 %1 monotonic monotonic, align 2
  %5 = extractvalue { i16, i1 } %4, 1
  br i1 %5, label %8, label %6

6:                                                ; preds = %2
  %7 = extractvalue { i16, i1 } %4, 0
  store i16 %7, ptr %0, align 2
  br label %8

8:                                                ; preds = %6, %2
  %9 = zext i1 %5 to i16
  ret i16 %9
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(readwrite, inaccessiblemem: none)
define noundef zeroext i16 @_Z30atomic_cmp_swap_relaxed_gv_u16Rtt(ptr nocapture noundef nonnull align 2 dereferenceable(2) %0, i16 noundef zeroext %1) {
; CHECK-LABEL: _Z30atomic_cmp_swap_relaxed_gv_u16Rtt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s2, gv_u16@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, gv_u16@hi(, %s2)
; CHECK-NEXT:    and %s2, -4, %s2
; CHECK-NEXT:    ld2b.zx %s4, 2(, %s2)
; CHECK-NEXT:    ld2b.zx %s3, (, %s0)
; CHECK-NEXT:    sla.w.sx %s4, %s4, 16
; CHECK-NEXT:    or %s1, %s4, %s1
; CHECK-NEXT:    or %s3, %s4, %s3
; CHECK-NEXT:    cas.w %s1, (%s2), %s3
; CHECK-NEXT:    cmpu.w %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    and %s3, 1, %s2
; CHECK-NEXT:    brne.w 0, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st2b %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = load i16, ptr %0, align 2
  %4 = cmpxchg weak ptr @gv_u16, i16 %3, i16 %1 monotonic monotonic, align 2
  %5 = extractvalue { i16, i1 } %4, 1
  br i1 %5, label %8, label %6

6:                                                ; preds = %2
  %7 = extractvalue { i16, i1 } %4, 0
  store i16 %7, ptr %0, align 2
  br label %8

8:                                                ; preds = %6, %2
  %9 = zext i1 %5 to i16
  ret i16 %9
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(readwrite, inaccessiblemem: none)
define noundef signext i32 @_Z30atomic_cmp_swap_relaxed_gv_i32Rii(ptr nocapture noundef nonnull align 4 dereferenceable(4) %0, i32 noundef signext %1) {
; CHECK-LABEL: _Z30atomic_cmp_swap_relaxed_gv_i32Rii:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.sx %s3, (, %s0)
; CHECK-NEXT:    lea %s2, gv_i32@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, gv_i32@hi(, %s2)
; CHECK-NEXT:    cas.w %s1, (%s2), %s3
; CHECK-NEXT:    cmpu.w %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    breq.w %s1, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    stl %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = load i32, ptr %0, align 4
  %4 = cmpxchg weak ptr @gv_i32, i32 %3, i32 %1 monotonic monotonic, align 4
  %5 = extractvalue { i32, i1 } %4, 1
  br i1 %5, label %8, label %6

6:                                                ; preds = %2
  %7 = extractvalue { i32, i1 } %4, 0
  store i32 %7, ptr %0, align 4
  br label %8

8:                                                ; preds = %6, %2
  %9 = zext i1 %5 to i32
  ret i32 %9
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(readwrite, inaccessiblemem: none)
define noundef zeroext i32 @_Z30atomic_cmp_swap_relaxed_gv_u32Rjj(ptr nocapture noundef nonnull align 4 dereferenceable(4) %0, i32 noundef zeroext %1) {
; CHECK-LABEL: _Z30atomic_cmp_swap_relaxed_gv_u32Rjj:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ldl.sx %s3, (, %s0)
; CHECK-NEXT:    lea %s2, gv_u32@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, gv_u32@hi(, %s2)
; CHECK-NEXT:    cas.w %s1, (%s2), %s3
; CHECK-NEXT:    cmpu.w %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    breq.w %s1, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    stl %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = load i32, ptr %0, align 4
  %4 = cmpxchg weak ptr @gv_u32, i32 %3, i32 %1 monotonic monotonic, align 4
  %5 = extractvalue { i32, i1 } %4, 1
  br i1 %5, label %8, label %6

6:                                                ; preds = %2
  %7 = extractvalue { i32, i1 } %4, 0
  store i32 %7, ptr %0, align 4
  br label %8

8:                                                ; preds = %6, %2
  %9 = zext i1 %5 to i32
  ret i32 %9
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(readwrite, inaccessiblemem: none)
define noundef i64 @_Z30atomic_cmp_swap_relaxed_gv_i64Rll(ptr nocapture noundef nonnull align 8 dereferenceable(8) %0, i64 noundef %1) {
; CHECK-LABEL: _Z30atomic_cmp_swap_relaxed_gv_i64Rll:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s3, (, %s0)
; CHECK-NEXT:    lea %s2, gv_i64@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, gv_i64@hi(, %s2)
; CHECK-NEXT:    cas.l %s1, (%s2), %s3
; CHECK-NEXT:    cmpu.l %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    breq.l %s1, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = load i64, ptr %0, align 8
  %4 = cmpxchg weak ptr @gv_i64, i64 %3, i64 %1 monotonic monotonic, align 8
  %5 = extractvalue { i64, i1 } %4, 1
  br i1 %5, label %8, label %6

6:                                                ; preds = %2
  %7 = extractvalue { i64, i1 } %4, 0
  store i64 %7, ptr %0, align 8
  br label %8

8:                                                ; preds = %6, %2
  %9 = zext i1 %5 to i64
  ret i64 %9
}

; Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(readwrite, inaccessiblemem: none)
define noundef i64 @_Z30atomic_cmp_swap_relaxed_gv_u64Rmm(ptr nocapture noundef nonnull align 8 dereferenceable(8) %0, i64 noundef %1) {
; CHECK-LABEL: _Z30atomic_cmp_swap_relaxed_gv_u64Rmm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s3, (, %s0)
; CHECK-NEXT:    lea %s2, gv_u64@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, gv_u64@hi(, %s2)
; CHECK-NEXT:    cas.l %s1, (%s2), %s3
; CHECK-NEXT:    cmpu.l %s2, %s1, %s3
; CHECK-NEXT:    ldz %s2, %s2
; CHECK-NEXT:    srl %s2, %s2, 6
; CHECK-NEXT:    breq.l %s1, %s3, .LBB{{[0-9]+}}_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    st %s1, (, %s0)
; CHECK-NEXT:  .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = load i64, ptr %0, align 8
  %4 = cmpxchg weak ptr @gv_u64, i64 %3, i64 %1 monotonic monotonic, align 8
  %5 = extractvalue { i64, i1 } %4, 1
  br i1 %5, label %8, label %6

6:                                                ; preds = %2
  %7 = extractvalue { i64, i1 } %4, 0
  store i64 %7, ptr %0, align 8
  br label %8

8:                                                ; preds = %6, %2
  %9 = zext i1 %5 to i64
  ret i64 %9
}

; Function Attrs: mustprogress nounwind willreturn
define noundef i128 @_Z31atomic_cmp_swap_relaxed_gv_i128Rnn(ptr noundef nonnull align 16 dereferenceable(16) %0, i128 noundef %1) {
; CHECK-LABEL: _Z31atomic_cmp_swap_relaxed_gv_i128Rnn:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s6, 0, %s0
; CHECK-NEXT:    st %s2, -8(, %s9)
; CHECK-NEXT:    st %s1, -16(, %s9)
; CHECK-NEXT:    lea %s0, __atomic_compare_exchange@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_compare_exchange@hi(, %s0)
; CHECK-NEXT:    lea %s0, gv_i128@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, gv_i128@hi(, %s0)
; CHECK-NEXT:    lea %s3, -16(, %s9)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    or %s2, 0, %s6
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = alloca i128, align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %3)
  store i128 %1, ptr %3, align 16, !tbaa !3
  %4 = call noundef zeroext i1 @__atomic_compare_exchange(i64 noundef 16, ptr noundef nonnull @gv_i128, ptr noundef nonnull %0, ptr noundef nonnull %3, i32 noundef signext 0, i32 noundef signext 0)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %3)
  %5 = zext i1 %4 to i128
  ret i128 %5
}

; Function Attrs: mustprogress nounwind willreturn
define noundef i128 @_Z31atomic_cmp_swap_relaxed_gv_u128Roo(ptr noundef nonnull align 16 dereferenceable(16) %0, i128 noundef %1) {
; CHECK-LABEL: _Z31atomic_cmp_swap_relaxed_gv_u128Roo:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s6, 0, %s0
; CHECK-NEXT:    st %s2, -8(, %s9)
; CHECK-NEXT:    st %s1, -16(, %s9)
; CHECK-NEXT:    lea %s0, __atomic_compare_exchange@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_compare_exchange@hi(, %s0)
; CHECK-NEXT:    lea %s0, gv_u128@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, gv_u128@hi(, %s0)
; CHECK-NEXT:    lea %s3, -16(, %s9)
; CHECK-NEXT:    or %s0, 16, (0)1
; CHECK-NEXT:    or %s4, 0, (0)1
; CHECK-NEXT:    or %s5, 0, (0)1
; CHECK-NEXT:    or %s2, 0, %s6
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = alloca i128, align 16
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %3)
  store i128 %1, ptr %3, align 16, !tbaa !3
  %4 = call noundef zeroext i1 @__atomic_compare_exchange(i64 noundef 16, ptr noundef nonnull @gv_u128, ptr noundef nonnull %0, ptr noundef nonnull %3, i32 noundef signext 0, i32 noundef signext 0)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %3)
  %5 = zext i1 %4 to i128
  ret i128 %5
}

declare i32 @__gxx_personality_sj0(...)

; Function Attrs: mustprogress nounwind willreturn
declare i1 @__atomic_compare_exchange(i64, ptr, ptr, ptr, i32, i32)

!3 = !{!4, !4, i64 0}
!4 = !{!"__int128", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}

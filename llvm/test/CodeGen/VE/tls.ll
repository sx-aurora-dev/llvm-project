; FIXME: doesn't check NOPIC code since nld doesn't work with this.
;        llc -mtriple ve < %s | FileCheck %s -check-prefix=NOPIC
; RUN: llc -mtriple ve -relocation-model=pic < %s | FileCheck %s -check-prefix=PIC

@x = external thread_local global i32, align 4
@y = internal thread_local global i32 0, align 4

; Function Attrs: norecurse nounwind readnone
define nonnull i32* @get_global() {
; PIC-LABEL:   get_global:
; PIC:         .LBB{{[0-9]+}}_2:
; PIC-NEXT:    lea %s0, x@tls_gd_lo(-24)
; PIC-NEXT:    and %s0, %s0, (32)0
; PIC-NEXT:    sic %s10
; PIC-NEXT:    lea.sl %s0, x@tls_gd_hi(%s10, %s0)
; PIC-NEXT:    lea %s12, __tls_get_addr@plt_lo(8)
; PIC-NEXT:    and %s12, %s12, (32)0
; PIC-NEXT:    lea.sl %s12, __tls_get_addr@plt_hi(%s10, %s12)
; PIC-NEXT:    bsic %s10, (, %s12)
; PIC-NEXT:    or %s11, 0, %s9
; NOPIC-LABEL: get_global:
; NOPIC:       .LBB{{[0-9]+}}_2:
; NOPIC-NEXT:  lea %s34, x@tpoff_lo
; NOPIC-NEXT:  and %s34, %s34, (32)0
; NOPIC-NEXT:  lea.sl %s34, x@tpoff_hi(%s34)
; NOPIC-NEXT:  adds.l %s0, %s14, %s34
; NOPIC-NEXT:  or %s11, 0, %s9
entry:
  ret i32* @x
}

; Function Attrs: norecurse nounwind readnone
define nonnull i32* @get_local() {
; PIC-LABEL:   get_local:
; PIC:         .LBB{{[0-9]+}}_2:
; PIC-NEXT:    lea %s0, y@tls_gd_lo(-24)
; PIC-NEXT:    and %s0, %s0, (32)0
; PIC-NEXT:    sic %s10
; PIC-NEXT:    lea.sl %s0, y@tls_gd_hi(%s10, %s0)
; PIC-NEXT:    lea %s12, __tls_get_addr@plt_lo(8)
; PIC-NEXT:    and %s12, %s12, (32)0
; PIC-NEXT:    lea.sl %s12, __tls_get_addr@plt_hi(%s10, %s12)
; PIC-NEXT:    bsic %s10, (, %s12)
; PIC-NEXT:    or %s11, 0, %s9
; NOPIC-LABEL: get_local:
; NOPIC:       .LBB{{[0-9]+}}_2:
; NOPIC-NEXT:  lea %s34, y@tpoff_lo
; NOPIC-NEXT:  and %s34, %s34, (32)0
; NOPIC-NEXT:  lea.sl %s34, y@tpoff_hi(%s34)
; NOPIC-NEXT:  adds.l %s0, %s14, %s34
; NOPIC-NEXT:  or %s11, 0, %s9
entry:
  ret i32* @y
}

; Function Attrs: norecurse nounwind
define void @set_global(i32 %v) {
; PIC-LABEL:   set_global:
; PIC:         .LBB{{[0-9]+}}_2:
; PIC-NEXT:    st %s18, 48(,%s9)
; PIC-NEXT:    or %s18, 0, %s0
; PIC-NEXT:    lea %s0, x@tls_gd_lo(-24)
; PIC-NEXT:    and %s0, %s0, (32)0
; PIC-NEXT:    sic %s10
; PIC-NEXT:    lea.sl %s0, x@tls_gd_hi(%s10, %s0)
; PIC-NEXT:    lea %s12, __tls_get_addr@plt_lo(8)
; PIC-NEXT:    and %s12, %s12, (32)0
; PIC-NEXT:    lea.sl %s12, __tls_get_addr@plt_hi(%s10, %s12)
; PIC-NEXT:    bsic %s10, (, %s12)
; PIC-NEXT:    stl %s18, (,%s0)
; PIC-NEXT:    ld %s18, 48(,%s9)
; PIC-NEXT:    or %s11, 0, %s9
; NOPIC-LABEL: set_global:
; NOPIC:       .LBB{{[0-9]+}}_2:
; NOPIC-NEXT:  lea %s34, x@tpoff_lo
; NOPIC-NEXT:  and %s34, %s34, (32)0
; NOPIC-NEXT:  lea.sl %s34, x@tpoff_hi(%s34)
; NOPIC-NEXT:  adds.l %s34, %s14, %s34
; NOPIC-NEXT:  stl %s0, (,%s34)
; NOPIC-NEXT:  or %s11, 0, %s9
entry:
  store i32 %v, i32* @x, align 4, !tbaa !3
  ret void
}

; Function Attrs: norecurse nounwind
define void @set_local(i32 %v) {
; PIC-LABEL:   set_local:
; PIC:         .LBB{{[0-9]+}}_2:
; PIC-NEXT:    st %s18, 48(,%s9)
; PIC-NEXT:    or %s18, 0, %s0
; PIC-NEXT:    lea %s0, y@tls_gd_lo(-24)
; PIC-NEXT:    and %s0, %s0, (32)0
; PIC-NEXT:    sic %s10
; PIC-NEXT:    lea.sl %s0, y@tls_gd_hi(%s10, %s0)
; PIC-NEXT:    lea %s12, __tls_get_addr@plt_lo(8)
; PIC-NEXT:    and %s12, %s12, (32)0
; PIC-NEXT:    lea.sl %s12, __tls_get_addr@plt_hi(%s10, %s12)
; PIC-NEXT:    bsic %s10, (, %s12)
; PIC-NEXT:    stl %s18, (,%s0)
; PIC-NEXT:    ld %s18, 48(,%s9)
; PIC-NEXT:    or %s11, 0, %s9
; NOPIC-LABEL: set_local:
; NOPIC:       .LBB{{[0-9]+}}_2:
; NOPIC-NEXT:  lea %s34, y@tpoff_lo
; NOPIC-NEXT:  and %s34, %s34, (32)0
; NOPIC-NEXT:  lea.sl %s34, y@tpoff_hi(%s34)
; NOPIC-NEXT:  adds.l %s34, %s14, %s34
; NOPIC-NEXT:  stl %s0, (,%s34)
; NOPIC-NEXT:  or %s11, 0, %s9
entry:
  store i32 %v, i32* @y, align 4, !tbaa !3
  ret void
}

!2 = !{!"clang version 8.0.0 (https://github.com/llvm-mirror/clang.git 3b98372866ea8dd6c83dd461fdd1bff7ac3658ba) (https://github.com/llvm-mirror/llvm.git 404e99265b881e4259763b7780aaf824581ff160)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}

; RUN: llc -mtriple=amdgcn -mcpu=verde -verify-machineinstrs < %s | FileCheck -check-prefix=GCN -check-prefix=SI %s
; RUN: llc -mtriple=amdgcn -mcpu=tonga -verify-machineinstrs < %s | FileCheck -check-prefix=GCN -check-prefix=VI %s

; GCN-LABEL: {{^}}mbcnt_intrinsics:
; GCN: v_mbcnt_lo_u32_b32{{(_e64)*}} [[LO:v[0-9]+]], -1, 0
; SI: v_mbcnt_hi_u32_b32_e32 {{v[0-9]+}}, -1, [[LO]]
; VI: v_mbcnt_hi_u32_b32 {{v[0-9]+}}, -1, [[LO]]
define amdgpu_ps void @mbcnt_intrinsics(ptr addrspace(4) inreg %arg, ptr addrspace(4) inreg %arg1, ptr addrspace(4) inreg %arg2, i32 inreg %arg3) {
main_body:
  %lo = call i32 @llvm.amdgcn.mbcnt.lo(i32 -1, i32 0) #0
  %hi = call i32 @llvm.amdgcn.mbcnt.hi(i32 -1, i32 %lo) #0
  %tmp = bitcast i32 %hi to float
  call void @llvm.amdgcn.exp.f32(i32 0, i32 15, float %tmp, float %tmp, float %tmp, float %tmp, i1 true, i1 true) #1
  ret void
}

; GCN-LABEL: {{^}}mbcnt_lo_known_bits_1:
; GCN: v_mbcnt_lo_u32_b32
; GCN: v_and_b32_e32
define i32 @mbcnt_lo_known_bits_1(i32 %x, i32 %y) #0 {
  %lo = call i32 @llvm.amdgcn.mbcnt.lo(i32 %x, i32 %y)
  %mask = and i32 %lo, 63
  ret i32 %mask
}

; GCN-LABEL: {{^}}mbcnt_lo_known_bits_2:
; GCN: v_mbcnt_lo_u32_b32
; GCN-NOT: and
define i32 @mbcnt_lo_known_bits_2(i32 %x) #0 {
  %lo = call i32 @llvm.amdgcn.mbcnt.lo(i32 %x, i32 0)
  %mask = and i32 %lo, 63
  ret i32 %mask
}

; GCN-LABEL: {{^}}mbcnt_lo_known_bits_3:
; GCN: v_mbcnt_lo_u32_b32
; GCN-NOT: and
define i32 @mbcnt_lo_known_bits_3(i32 %x) #0 {
  %lo = call i32 @llvm.amdgcn.mbcnt.lo(i32 %x, i32 15)
  %mask = and i32 %lo, 127
  ret i32 %mask
}

; GCN-LABEL: {{^}}mbcnt_lo_known_bits_4:
; GCN: v_mbcnt_lo_u32_b32
; GCN: v_and_b32_e32
define i32 @mbcnt_lo_known_bits_4(i32 %x) #0 {
  %lo = call i32 @llvm.amdgcn.mbcnt.lo(i32 %x, i32 15)
  %mask = and i32 %lo, 63
  ret i32 %mask
}


; GCN-LABEL: {{^}}mbcnt_hi_known_bits_1:
; GCN: v_mbcnt_hi_u32_b32
; GCN: v_and_b32_e32
define i32 @mbcnt_hi_known_bits_1(i32 %x, i32 %y) #0 {
  %hi = call i32 @llvm.amdgcn.mbcnt.hi(i32 %x, i32 %y)
  %mask = and i32 %hi, 63
  ret i32 %mask
}

; GCN-LABEL: {{^}}mbcnt_hi_known_bits_2:
; GCN: v_mbcnt_hi_u32_b32
; GCN-NOT: and
define i32 @mbcnt_hi_known_bits_2(i32 %x) #0 {
  %hi = call i32 @llvm.amdgcn.mbcnt.hi(i32 %x, i32 0)
  %mask = and i32 %hi, 63
  ret i32 %mask
}

; GCN-LABEL: {{^}}mbcnt_hi_known_bits_3:
; GCN: v_mbcnt_hi_u32_b32
; GCN-NOT: and
define i32 @mbcnt_hi_known_bits_3(i32 %x) #0 {
  %hi = call i32 @llvm.amdgcn.mbcnt.hi(i32 %x, i32 15)
  %mask = and i32 %hi, 127
  ret i32 %mask
}

; GCN-LABEL: {{^}}mbcnt_hi_known_bits_4:
; GCN: v_mbcnt_hi_u32_b32
; GCN: v_and_b32_e32
define i32 @mbcnt_hi_known_bits_4(i32 %x) #0 {
  %hi = call i32 @llvm.amdgcn.mbcnt.hi(i32 %x, i32 15)
  %mask = and i32 %hi, 63
  ret i32 %mask
}

declare i32 @llvm.amdgcn.mbcnt.lo(i32, i32) #0
declare i32 @llvm.amdgcn.mbcnt.hi(i32, i32) #0
declare void @llvm.amdgcn.exp.f32(i32, i32, float, float, float, float, i1, i1) #1

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind }

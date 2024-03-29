; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc %s -o - -mtriple=amdgcn -mcpu=gfx900 -verify-machineinstrs | FileCheck --check-prefix=NOHSA-TRAP-GFX900 %s
; RUN: llc %s -o - -mtriple=amdgcn-amd-amdhsa -mcpu=gfx803 -verify-machineinstrs | FileCheck --check-prefix=HSA-TRAP-GFX803 %s
; RUN: llc %s -o - -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -verify-machineinstrs | FileCheck --check-prefix=HSA-TRAP-GFX900 %s
; RUN: llc %s -o - -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -mattr=-trap-handler -verify-machineinstrs | FileCheck --check-prefix=HSA-NOTRAP-GFX900 %s

declare void @llvm.trap() #0
declare void @llvm.debugtrap() #1

define amdgpu_kernel void @trap(ptr addrspace(1) nocapture readonly %arg0) {
; NOHSA-TRAP-GFX900-LABEL: trap:
; NOHSA-TRAP-GFX900:       ; %bb.0:
; NOHSA-TRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x24
; NOHSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; NOHSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 1
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    s_endpgm
;
; HSA-TRAP-GFX803-LABEL: trap:
; HSA-TRAP-GFX803:       ; %bb.0:
; HSA-TRAP-GFX803-NEXT:    s_load_dwordx2 s[2:3], s[6:7], 0x0
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v2, 1
; HSA-TRAP-GFX803-NEXT:    s_mov_b64 s[0:1], s[4:5]
; HSA-TRAP-GFX803-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v0, s2
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v1, s3
; HSA-TRAP-GFX803-NEXT:    flat_store_dword v[0:1], v2
; HSA-TRAP-GFX803-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX803-NEXT:    s_trap 2
;
; HSA-TRAP-GFX900-LABEL: trap:
; HSA-TRAP-GFX900:       ; %bb.0:
; HSA-TRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; HSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; HSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 1
; HSA-TRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; HSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX900-NEXT:    s_trap 2
;
; HSA-NOTRAP-GFX900-LABEL: trap:
; HSA-NOTRAP-GFX900:       ; %bb.0:
; HSA-NOTRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; HSA-NOTRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; HSA-NOTRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 1
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    s_endpgm
  store volatile i32 1, ptr addrspace(1) %arg0
  call void @llvm.trap()
  unreachable
  store volatile i32 2, ptr addrspace(1) %arg0
  ret void
}

define amdgpu_kernel void @non_entry_trap(ptr addrspace(1) nocapture readonly %arg0) local_unnamed_addr {
; NOHSA-TRAP-GFX900-LABEL: non_entry_trap:
; NOHSA-TRAP-GFX900:       ; %bb.0: ; %entry
; NOHSA-TRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x24
; NOHSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    global_load_dword v1, v0, s[0:1] glc
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    v_cmp_eq_u32_e32 vcc, -1, v1
; NOHSA-TRAP-GFX900-NEXT:    s_cbranch_vccz .LBB1_2
; NOHSA-TRAP-GFX900-NEXT:  ; %bb.1: ; %ret
; NOHSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 3
; NOHSA-TRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    s_endpgm
; NOHSA-TRAP-GFX900-NEXT:  .LBB1_2: ; %trap
; NOHSA-TRAP-GFX900-NEXT:    s_endpgm
;
; HSA-TRAP-GFX803-LABEL: non_entry_trap:
; HSA-TRAP-GFX803:       ; %bb.0: ; %entry
; HSA-TRAP-GFX803-NEXT:    s_load_dwordx2 s[0:1], s[6:7], 0x0
; HSA-TRAP-GFX803-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v0, s0
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v1, s1
; HSA-TRAP-GFX803-NEXT:    flat_load_dword v0, v[0:1] glc
; HSA-TRAP-GFX803-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX803-NEXT:    v_cmp_eq_u32_e32 vcc, -1, v0
; HSA-TRAP-GFX803-NEXT:    s_cbranch_vccz .LBB1_2
; HSA-TRAP-GFX803-NEXT:  ; %bb.1: ; %ret
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v0, s0
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v2, 3
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v1, s1
; HSA-TRAP-GFX803-NEXT:    flat_store_dword v[0:1], v2
; HSA-TRAP-GFX803-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX803-NEXT:    s_endpgm
; HSA-TRAP-GFX803-NEXT:  .LBB1_2: ; %trap
; HSA-TRAP-GFX803-NEXT:    s_mov_b64 s[0:1], s[4:5]
; HSA-TRAP-GFX803-NEXT:    s_trap 2
;
; HSA-TRAP-GFX900-LABEL: non_entry_trap:
; HSA-TRAP-GFX900:       ; %bb.0: ; %entry
; HSA-TRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; HSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; HSA-TRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX900-NEXT:    global_load_dword v1, v0, s[0:1] glc
; HSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX900-NEXT:    v_cmp_eq_u32_e32 vcc, -1, v1
; HSA-TRAP-GFX900-NEXT:    s_cbranch_vccz .LBB1_2
; HSA-TRAP-GFX900-NEXT:  ; %bb.1: ; %ret
; HSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 3
; HSA-TRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; HSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX900-NEXT:    s_endpgm
; HSA-TRAP-GFX900-NEXT:  .LBB1_2: ; %trap
; HSA-TRAP-GFX900-NEXT:    s_trap 2
;
; HSA-NOTRAP-GFX900-LABEL: non_entry_trap:
; HSA-NOTRAP-GFX900:       ; %bb.0: ; %entry
; HSA-NOTRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; HSA-NOTRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    global_load_dword v1, v0, s[0:1] glc
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    v_cmp_eq_u32_e32 vcc, -1, v1
; HSA-NOTRAP-GFX900-NEXT:    s_cbranch_vccz .LBB1_2
; HSA-NOTRAP-GFX900-NEXT:  ; %bb.1: ; %ret
; HSA-NOTRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 3
; HSA-NOTRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    s_endpgm
; HSA-NOTRAP-GFX900-NEXT:  .LBB1_2: ; %trap
; HSA-NOTRAP-GFX900-NEXT:    s_endpgm
entry:
  %tmp29 = load volatile i32, ptr addrspace(1) %arg0
  %cmp = icmp eq i32 %tmp29, -1
  br i1 %cmp, label %ret, label %trap

trap:
  call void @llvm.trap()
  unreachable

ret:
  store volatile i32 3, ptr addrspace(1) %arg0
  ret void
}

define amdgpu_kernel void @debugtrap(ptr addrspace(1) nocapture readonly %arg0) {
; NOHSA-TRAP-GFX900-LABEL: debugtrap:
; NOHSA-TRAP-GFX900:       ; %bb.0:
; NOHSA-TRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x24
; NOHSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; NOHSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 1
; NOHSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v2, 2
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    global_store_dword v0, v2, s[0:1]
; NOHSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; NOHSA-TRAP-GFX900-NEXT:    s_endpgm
;
; HSA-TRAP-GFX803-LABEL: debugtrap:
; HSA-TRAP-GFX803:       ; %bb.0:
; HSA-TRAP-GFX803-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v2, 1
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v3, 2
; HSA-TRAP-GFX803-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v0, s0
; HSA-TRAP-GFX803-NEXT:    v_mov_b32_e32 v1, s1
; HSA-TRAP-GFX803-NEXT:    flat_store_dword v[0:1], v2
; HSA-TRAP-GFX803-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX803-NEXT:    s_trap 3
; HSA-TRAP-GFX803-NEXT:    flat_store_dword v[0:1], v3
; HSA-TRAP-GFX803-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX803-NEXT:    s_endpgm
;
; HSA-TRAP-GFX900-LABEL: debugtrap:
; HSA-TRAP-GFX900:       ; %bb.0:
; HSA-TRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; HSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; HSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 1
; HSA-TRAP-GFX900-NEXT:    v_mov_b32_e32 v2, 2
; HSA-TRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-TRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; HSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX900-NEXT:    s_trap 3
; HSA-TRAP-GFX900-NEXT:    global_store_dword v0, v2, s[0:1]
; HSA-TRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-TRAP-GFX900-NEXT:    s_endpgm
;
; HSA-NOTRAP-GFX900-LABEL: debugtrap:
; HSA-NOTRAP-GFX900:       ; %bb.0:
; HSA-NOTRAP-GFX900-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; HSA-NOTRAP-GFX900-NEXT:    v_mov_b32_e32 v0, 0
; HSA-NOTRAP-GFX900-NEXT:    v_mov_b32_e32 v1, 1
; HSA-NOTRAP-GFX900-NEXT:    v_mov_b32_e32 v2, 2
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt lgkmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    global_store_dword v0, v1, s[0:1]
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    global_store_dword v0, v2, s[0:1]
; HSA-NOTRAP-GFX900-NEXT:    s_waitcnt vmcnt(0)
; HSA-NOTRAP-GFX900-NEXT:    s_endpgm
  store volatile i32 1, ptr addrspace(1) %arg0
  call void @llvm.debugtrap()
  store volatile i32 2, ptr addrspace(1) %arg0
  ret void
}

attributes #0 = { nounwind noreturn }
attributes #1 = { nounwind }

!llvm.module.flags = !{!0}
!0 = !{i32 1, !"amdhsa_code_object_version", i32 400}

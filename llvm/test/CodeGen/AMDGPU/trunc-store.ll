; RUN: llc -mtriple=amdgcn -mcpu=verde -verify-machineinstrs < %s | FileCheck -check-prefix=SI -check-prefix=FUNC %s
; RUN: llc -mtriple=amdgcn -mcpu=tonga -mattr=-flat-for-global -verify-machineinstrs < %s | FileCheck -check-prefix=SI -check-prefix=FUNC %s

; FUNC-LABEL: {{^}}truncstore_arg_v16i32_to_v16i8:
; SI: buffer_store_dwordx4
define amdgpu_kernel void @truncstore_arg_v16i32_to_v16i8(ptr addrspace(1) %out, <16 x i32> %in) {
  %trunc = trunc <16 x i32> %in to <16 x i8>
  store <16 x i8> %trunc, ptr addrspace(1) %out
  ret void
}

; FUNC-LABEL: {{^}}truncstore_arg_v16i64_to_v16i8:
; SI: buffer_store_dwordx4
define amdgpu_kernel void @truncstore_arg_v16i64_to_v16i8(ptr addrspace(1) %out, <16 x i64> %in) {
  %trunc = trunc <16 x i64> %in to <16 x i8>
  store <16 x i8> %trunc, ptr addrspace(1) %out
  ret void
}

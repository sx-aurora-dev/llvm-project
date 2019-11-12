; RUN: not llvm-as %s -o /dev/null 2>&1 | FileCheck %s

declare void @a(<16 x i1> mask %a, <16 x i1> mask %b)
; CHECK: Cannot have multiple 'mask' parameters!

declare void @b(<16 x i1> mask %a, i32 vlen %x, i32 vlen %y)
; CHECK: Cannot have multiple 'vlen' parameters!

declare <16 x double> @c(<16 x double> passthru %a)
; CHECK: Cannot have 'passthru' parameter without 'mask' parameter!

declare <16 x double> @d(<16 x double> passthru %a, <16 x i1> mask %M, <16 x double> passthru %b)
; CHECK: Cannot have multiple 'passthru' parameters!

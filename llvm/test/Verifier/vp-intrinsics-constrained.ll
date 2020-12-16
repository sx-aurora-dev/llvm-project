; RUN: not opt -S < %s |& FileCheck %s
; CHECK: VP intrinsics only support the default fp environment for now (round.tonearest; fpexcept.ignore).
; CHECK: error: input module is broken!

define void @test_vp_strictfp(<8 x double> %f0, <8 x double> %f1, <8 x double> %f2, <8 x double> %f3, <8 x i1> %m, i32 %n) #0 {
  %r0 = call <8 x double> @llvm.vp.fadd.v8f64(<8 x double> %f0, <8 x double> %f1, <8 x i1> %m, i32 %n) ["cfp-round"(metadata !"round.tonearest"), "cfp-except"(metadata !"fpexcept.strict")
  ret void
}

define void @test_vp_rounding(<8 x double> %f0, <8 x double> %f1, <8 x double> %f2, <8 x double> %f3, <8 x i1> %m, i32 %n) #0 {
  %r0 = call <8 x double> @llvm.vp.fadd.v8f64(<8 x double> %f0, <8 x double> %f1, <8 x i1> %m, i32 %n) [ "cfp-round"(metadata !"round.tozero"), "cfp-except"(metadata !"fpexcept.ignore") ]
  ret void
}

declare <8 x double> @llvm.vp.fadd.v8f64(<8 x double>, <8 x double>, <8 x i1> mask, i32 vlen)

attributes #0 = { strictfp }

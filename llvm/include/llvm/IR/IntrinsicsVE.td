let TargetPrefix = "ve" in {
  def int_ve_lvl : GCCBuiltin<"__builtin_ve_lvl">, Intrinsic<[], [llvm_i32_ty]>;

  def int_ve_vld : GCCBuiltin<"__builtin_ve_vld">, 
        Intrinsic<[LLVMType<v256f64>], [llvm_ptr_ty]>;

  def int_ve_vst : GCCBuiltin<"__builtin_ve_vst">, 
        Intrinsic<[], [llvm_ptr_ty, LLVMType<v256f64>]>;

  def int_ve_vfadd : GCCBuiltin<"__builtin_ve_vfadd">, 
        Intrinsic<[LLVMType<v256f64>], [LLVMType<v256f64>, LLVMType<v256f64>]>;

  def int_ve_pvfadd : GCCBuiltin<"__builtin_ve_pvfadd">, 
        Intrinsic<[LLVMType<v256f64>], [LLVMType<v256f64>, LLVMType<v256f64>]>;
}

// vim::set sw=2:

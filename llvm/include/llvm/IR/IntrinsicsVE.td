let TargetPrefix = "ve" in {
  def int_ve_lvl : GCCBuiltin<"__builtin_ve_lvl">, Intrinsic<[], [llvm_i32_ty]>;

  def int_ve_lvm_MMss : GCCBuiltin<"__builtin_ve_lvm_MMss">, Intrinsic<[LLVMType<v8i64>], [LLVMType<v8i64>, LLVMType<i64>, LLVMType<i64>], [IntrNoMem]>;
  def int_ve_svm_sMs : GCCBuiltin<"__builtin_ve_svm_sMs">, Intrinsic<[LLVMType<i64>], [LLVMType<v8i64>, LLVMType<i64>], [IntrNoMem]>;

  def int_ve_pack_f32p : GCCBuiltin<"__builtin_ve_pack_f32p">,
        Intrinsic<[llvm_i64_ty], [llvm_ptr_ty, llvm_ptr_ty], [IntrReadMem]>;

  def int_ve_pack_f32a : GCCBuiltin<"__builtin_ve_pack_f32a">,
        Intrinsic<[llvm_i64_ty], [llvm_ptr_ty], [IntrReadMem]>;

  def int_ve_vec_call: GCCBuiltin<"__builtin_ve_vec_call">,
        Intrinsic<[LLVMType<v256f64>], [LLVMType<v256f64>, llvm_ptr_ty], [IntrNoMem]>;
}


include "llvm/IR/IntrinsicsVE2.td"

// vim::set sw=2:

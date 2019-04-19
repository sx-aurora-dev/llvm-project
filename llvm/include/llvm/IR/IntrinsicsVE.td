let TargetPrefix = "ve" in {
  def int_ve_lvl : GCCBuiltin<"__builtin_ve_lvl">, Intrinsic<[], [llvm_i32_ty]>;
  def int_ve_svob : GCCBuiltin<"__builtin_ve_svob">, Intrinsic<[], [], [IntrHasSideEffects]>;

  def int_ve_pack_f32p : GCCBuiltin<"__builtin_ve_pack_f32p">,
        Intrinsic<[llvm_i64_ty], [llvm_ptr_ty, llvm_ptr_ty], [IntrReadMem]>;

  def int_ve_pack_f32a : GCCBuiltin<"__builtin_ve_pack_f32a">,
        Intrinsic<[llvm_i64_ty], [llvm_ptr_ty], [IntrReadMem]>;

  def int_ve_vec_call: GCCBuiltin<"__builtin_ve_vec_call">,
        Intrinsic<[LLVMType<v256f64>], [LLVMType<v256f64>, llvm_ptr_ty], [IntrNoMem]>;

  // fencem instructions
  def int_ve_fencem1 : Intrinsic<[], [], []>;
  def int_ve_fencem2 : Intrinsic<[], [], []>;
  def int_ve_fencem3 : Intrinsic<[], [], []>;

  def int_ve_extract_vm512u : GCCBuiltin<"__builtin_ve_extract_vm512u">,
        Intrinsic<[LLVMType<v4i64>], [LLVMType<v8i64>], [IntrNoMem]>;

  def int_ve_extract_vm512l : GCCBuiltin<"__builtin_ve_extract_vm512l">,
        Intrinsic<[LLVMType<v4i64>], [LLVMType<v8i64>], [IntrNoMem]>;

  def int_ve_insert_vm512u : GCCBuiltin<"__builtin_ve_insert_vm512u">,
        Intrinsic<[LLVMType<v8i64>], [LLVMType<v8i64>, LLVMType<v4i64>], [IntrNoMem]>;

  def int_ve_insert_vm512l : GCCBuiltin<"__builtin_ve_insert_vm512l">,
        Intrinsic<[LLVMType<v8i64>], [LLVMType<v8i64>, LLVMType<v4i64>], [IntrNoMem]>;
}


include "llvm/IR/IntrinsicsVE2.td"
include "llvm/IR/IntrinsicsVEVL.td"

// vim::set sw=2:

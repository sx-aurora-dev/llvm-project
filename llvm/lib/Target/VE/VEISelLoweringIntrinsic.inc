case Intrinsic::ve_vscuot_vvm: return LowerIntrinsicWithMaskAndVL(Op, DAG, Subtarget, VE::VSCUotvm);
case Intrinsic::ve_vsclot_vvm: return LowerIntrinsicWithMaskAndVL(Op, DAG, Subtarget, VE::VSCLotvm);
case Intrinsic::ve_vscot_vvm: return LowerIntrinsicWithMaskAndVL(Op, DAG, Subtarget, VE::VSCotvm);

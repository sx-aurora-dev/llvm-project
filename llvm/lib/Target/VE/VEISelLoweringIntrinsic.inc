#if 0
case Intrinsic::ve_vcvtwdsx_vvmv: return LowerIntrinsicWithMask(Op, DAG, VE::VFIXdsxvm);
case Intrinsic::ve_vcvtwdsxrz_vvmv: return LowerIntrinsicWithMask(Op, DAG, VE::VFIXdsxrzvm);
case Intrinsic::ve_vcvtwdzx_vvmv: return LowerIntrinsicWithMask(Op, DAG, VE::VFIXdzxvm);
case Intrinsic::ve_vcvtwdzxrz_vvmv: return LowerIntrinsicWithMask(Op, DAG, VE::VFIXdzxrzvm);
case Intrinsic::ve_vcvtwssx_vvmv: return LowerIntrinsicWithMask(Op, DAG, VE::VFIXssxvm);
case Intrinsic::ve_vcvtwssxrz_vvmv: return LowerIntrinsicWithMask(Op, DAG, VE::VFIXssxrzvm);
case Intrinsic::ve_vcvtwszx_vvmv: return LowerIntrinsicWithMask(Op, DAG, VE::VFIXszxvm);
case Intrinsic::ve_vcvtwszxrz_vvmv: return LowerIntrinsicWithMask(Op, DAG, VE::VFIXszxrzvm);
case Intrinsic::ve_pvcvtws_vvMv: return LowerIntrinsicWithMask(Op, DAG, VE::VFIXpvm);
case Intrinsic::ve_pvcvtwsrz_vvMv: return LowerIntrinsicWithMask(Op, DAG, VE::VFIXprzvm);
case Intrinsic::ve_vcvtld_vvmv: return LowerIntrinsicWithMask(Op, DAG, VE::VFIXXvm);
case Intrinsic::ve_vcvtldrz_vvmv: return LowerIntrinsicWithMask(Op, DAG, VE::VFIXXrzvm);
#endif
case Intrinsic::ve_vsumwsx_vvm: return LowerIntrinsicWithMask(Op, DAG, VE::VSUMSsxvm);
case Intrinsic::ve_vsumwzx_vvm: return LowerIntrinsicWithMask(Op, DAG, VE::VSUMSzxvm);
case Intrinsic::ve_vsuml_vvm: return LowerIntrinsicWithMask(Op, DAG, VE::VSUMXvm);
case Intrinsic::ve_vfsumd_vvm: return LowerIntrinsicWithMask(Op, DAG, VE::VFSUMdvm);
case Intrinsic::ve_vfsums_vvm: return LowerIntrinsicWithMask(Op, DAG, VE::VFSUMsvm);

// VLD vld vld_vssvl
def vldvssvl : RV<0x81, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vld $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD vld vld_vIsvl
def vldvIsvl : RV<0x81, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vld $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU vldu vldu_vssvl
def vlduvssvl : RV<0x82, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldu $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU vldu vldu_vIsvl
def vlduvIsvl : RV<0x82, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldu $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.sx vldlsx_vssvl
def vldlsxvssvl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl.sx $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.sx vldlsx_vIsvl
def vldlsxvIsvl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl.sx $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.zx vldlzx_vssvl
def vldlzxvssvl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl.zx $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.zx vldlzx_vIsvl
def vldlzxvIsvl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl.zx $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD2D vld2d vld2d_vssvl
def vld2dvssvl : RV<0xc1, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vld2d $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD2D vld2d vld2d_vIsvl
def vld2dvIsvl : RV<0xc1, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vld2d $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU2D vldu2d vldu2d_vssvl
def vldu2dvssvl : RV<0xc2, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldu2d $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU2D vldu2d vldu2d_vIsvl
def vldu2dvIsvl : RV<0xc2, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldu2d $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.sx vldl2dsx_vssvl
def vldl2dsxvssvl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.sx $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.sx vldl2dsx_vIsvl
def vldl2dsxvIsvl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.sx $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.zx vldl2dzx_vssvl
def vldl2dzxvssvl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.zx $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.zx vldl2dzx_vIsvl
def vldl2dzxvIsvl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.zx $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst vst_vssl
def vstvssl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst vst_vIsl
def vstvIsl : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst.ot vstot_vssl
def vstotvssl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst.ot vstot_vIsl
def vstotvIsl : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu vstu_vssl
def vstuvssl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu vstu_vIsl
def vstuvIsl : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu.ot vstuot_vssl
def vstuotvssl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu.ot vstuot_vIsl
def vstuotvIsl : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl vstl_vssl
def vstlvssl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl vstl_vIsl
def vstlvIsl : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl.ot vstlot_vssl
def vstlotvssl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl.ot vstlot_vIsl
def vstlotvIsl : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d vst2d_vssl
def vst2dvssl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst2d $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d vst2d_vIsl
def vst2dvIsl : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d.ot vst2dot_vssl
def vst2dotvssl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d.ot vst2dot_vIsl
def vst2dotvIsl : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d vstu2d_vssl
def vstu2dvssl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu2d $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d vstu2d_vIsl
def vstu2dvIsl : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d.ot vstu2dot_vssl
def vstu2dotvssl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d.ot vstu2dot_vIsl
def vstu2dotvIsl : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d vstl2d_vssl
def vstl2dvssl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl2d $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d vstl2d_vIsl
def vstl2dvIsl : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d.ot vstl2dot_vssl
def vstl2dotvssl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d.ot vstl2dot_vIsl
def vstl2dotvIsl : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// PFCHV pfchv pfchv_ssl
def pfchvssl : RV<0x80, (outs ), (ins I64:$sy, I64:$sz, I32:$vl),
       "pfchv $sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// PFCHV pfchv pfchv_Isl
def pfchvIsl : RV<0x80, (outs ), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "pfchv $I,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// LSV lsv lsv_vvss
def lsvvvss : RV<0x8e, (outs V64:$vx), (ins V64:$vd, I32:$sy, I64:$sz),
       "lsv $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// LVS lvs lvsl_svs
def lvslsvs : RV<0x9e, (outs I64:$sx), (ins V64:$vx, I32:$sy),
       "lvs $sx,$vx,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// LVS lvs lvss_svs
def lvsssvs : RV<0x9e, (outs F32:$sx), (ins V64:$vx, I32:$sy),
       "lvs $sx,$vx,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// LVM lvm lvm_mmss
def lvmmmss : RV<0xb7, (outs VM_:$vmx), (ins VM_:$vmd, I64:$sy, I64:$sz),
       "lvm $vmx,$vmd,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vmx = $vmd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// LVM lvm lvm_mmIs
def lvmmmIs : RV<0xb7, (outs VM_:$vmx), (ins VM_:$vmd, simm7Op64:$N, I64:$sz),
       "lvm $vmx,$vmd,$N,$sz", [], NoItinerary>
{
  let Constraints = "$vmx = $vmd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// LVM lvm lvm_MMss
def lvmMMss : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmd, I64:$sy, I64:$sz),
       "# lvm $vmx,$vmd,$sy,$sz", []>
{
  let Constraints = "$vmx = $vmd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// LVM lvm lvm_MMIs
def lvmMMIs : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmd, simm7Op64:$N, I64:$sz),
       "# lvm $vmx,$vmd,$N,$sz", []>
{
  let Constraints = "$vmx = $vmd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// SVM svm svm_sms
def svmsms : RV<0xa7, (outs I64:$sx), (ins VM_:$vmz, I64:$sy),
       "svm $sx,$vmz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// SVM svm svm_smI
def svmsmI : RV<0xa7, (outs I64:$sx), (ins VM_:$vmz, simm7Op64:$N),
       "svm $sx,$vmz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// SVM svm svm_sMs
def svmsMs : Pseudo<(outs I64:$sx), (ins VM512_:$vmz, I64:$sy),
       "# svm $sx,$vmz,$sy", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// SVM svm svm_sMI
def svmsMI : Pseudo<(outs I64:$sx), (ins VM512_:$vmz, simm7Op64:$N),
       "# svm $sx,$vmz,$N", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// VBRD vbrd vbrdl_vsvl
def vbrdvsvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, V64:$vd, I32:$vl),
       "vbrd $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrd vbrdl_vsmvl
def vbrdvsmvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vbrd $vx,$sy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrd vbrdl_vIvl
def vbrdvIvl : RV<0x8c, (outs V64:$vx), (ins simm7Op64:$I, V64:$vd, I32:$vl),
       "vbrd $vx,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrd vbrdl_vImvl
def vbrdvImvl : RV<0x8c, (outs V64:$vx), (ins simm7Op64:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vbrd $vx,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrdu vbrds_vsvl
def vbrduvsvl : RV<0x8c, (outs V64:$vx), (ins F32:$sy, V64:$vd, I32:$vl),
       "vbrdu $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrdu vbrds_vsmvl
def vbrduvsmvl : RV<0x8c, (outs V64:$vx), (ins F32:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vbrdu $vx,$sy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrdl vbrdw_vsvl
def vbrdlvsvl : RV<0x8c, (outs V64:$vx), (ins I32:$sy, V64:$vd, I32:$vl),
       "vbrdl $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrdl vbrdw_vsmvl
def vbrdlvsmvl : RV<0x8c, (outs V64:$vx), (ins I32:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vbrdl $vx,$sy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrdl vbrdw_vIvl
def vbrdlvIvl : RV<0x8c, (outs V64:$vx), (ins simm7Op32:$I, V64:$vd, I32:$vl),
       "vbrdl $vx,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrdl vbrdw_vImvl
def vbrdlvImvl : RV<0x8c, (outs V64:$vx), (ins simm7Op32:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vbrdl $vx,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD pvbrd pvbrd_vsvl
def pvbrdvsvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, V64:$vd, I32:$vl),
       "pvbrd $vx,$sy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD pvbrd pvbrd_vsMvl
def pvbrdvsMvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvbrd $vx,$sy,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMV vmv vmv_vsvvl
def vmvvsvvl : RV<0x9c, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmv $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMV vmv vmv_vIvvl
def vmvvIvvl : RV<0x9c, (outs V64:$vx), (ins simm7Op32:$N, V64:$vz, V64:$vd, I32:$vl),
       "vmv $vx,$N,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.l vaddul_vvvvl
def vaddulvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.l vaddul_vsvvl
def vaddulvsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.l vaddul_vIvvl
def vaddulvIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.l vaddul_vvvmvl
def vaddulvvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.l vaddul_vsvmvl
def vaddulvsvmvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.l vaddul_vIvmvl
def vaddulvIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.w vadduw_vvvvl
def vadduwvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.w vadduw_vsvvl
def vadduwvsvvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.w vadduw_vIvvl
def vadduwvIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.w vadduw_vvvmvl
def vadduwvvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.w vadduw_vsvmvl
def vadduwvsvmvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.w vadduw_vIvmvl
def vadduwvIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD pvaddu pvaddu_vvvvl
def pvadduvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvaddu $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD pvaddu pvaddu_vsvvl
def pvadduvsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvaddu $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD pvaddu pvaddu_vvvMvl
def pvadduvvvMvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvaddu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD pvaddu pvaddu_vsvMvl
def pvadduvsvMvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvaddu $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx vaddswsx_vvvvl
def vaddswsxvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx vaddswsx_vsvvl
def vaddswsxvsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx vaddswsx_vIvvl
def vaddswsxvIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx vaddswsx_vvvmvl
def vaddswsxvvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx vaddswsx_vsvmvl
def vaddswsxvsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx vaddswsx_vIvmvl
def vaddswsxvIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx vaddswzx_vvvvl
def vaddswzxvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx vaddswzx_vsvvl
def vaddswzxvsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx vaddswzx_vIvvl
def vaddswzxvIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx vaddswzx_vvvmvl
def vaddswzxvvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx vaddswzx_vsvmvl
def vaddswzxvsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx vaddswzx_vIvmvl
def vaddswzxvIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS pvadds pvadds_vvvvl
def pvaddsvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvadds $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS pvadds pvadds_vsvvl
def pvaddsvsvvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvadds $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS pvadds pvadds_vvvMvl
def pvaddsvvvMvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvadds $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS pvadds pvadds_vsvMvl
def pvaddsvsvMvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvadds $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADX vadds.l vaddsl_vvvvl
def vaddslvvvvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADX vadds.l vaddsl_vsvvl
def vaddslvsvvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADX vadds.l vaddsl_vIvvl
def vaddslvIvvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vadds.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADX vadds.l vaddsl_vvvmvl
def vaddslvvvmvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADX vadds.l vaddsl_vsvmvl
def vaddslvsvmvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADX vadds.l vaddsl_vIvmvl
def vaddslvIvmvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l vsubul_vvvvl
def vsubulvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l vsubul_vsvvl
def vsubulvsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l vsubul_vIvvl
def vsubulvIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l vsubul_vvvmvl
def vsubulvvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l vsubul_vsvmvl
def vsubulvsvmvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l vsubul_vIvmvl
def vsubulvIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w vsubuw_vvvvl
def vsubuwvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w vsubuw_vsvvl
def vsubuwvsvvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w vsubuw_vIvvl
def vsubuwvIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w vsubuw_vvvmvl
def vsubuwvvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w vsubuw_vsvmvl
def vsubuwvsvmvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w vsubuw_vIvmvl
def vsubuwvIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB pvsubu pvsubu_vvvvl
def pvsubuvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvsubu $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB pvsubu pvsubu_vsvvl
def pvsubuvsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvsubu $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB pvsubu pvsubu_vvvMvl
def pvsubuvvvMvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsubu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB pvsubu pvsubu_vsvMvl
def pvsubuvsvMvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsubu $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx vsubswsx_vvvvl
def vsubswsxvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx vsubswsx_vsvvl
def vsubswsxvsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx vsubswsx_vIvvl
def vsubswsxvIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx vsubswsx_vvvmvl
def vsubswsxvvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx vsubswsx_vsvmvl
def vsubswsxvsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx vsubswsx_vIvmvl
def vsubswsxvIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx vsubswzx_vvvvl
def vsubswzxvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx vsubswzx_vsvvl
def vsubswzxvsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx vsubswzx_vIvvl
def vsubswzxvIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx vsubswzx_vvvmvl
def vsubswzxvvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx vsubswzx_vsvmvl
def vsubswzxvsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx vsubswzx_vIvmvl
def vsubswzxvIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS pvsubs pvsubs_vvvvl
def pvsubsvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvsubs $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS pvsubs pvsubs_vsvvl
def pvsubsvsvvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvsubs $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS pvsubs pvsubs_vvvMvl
def pvsubsvvvMvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsubs $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS pvsubs pvsubs_vsvMvl
def pvsubsvsvMvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsubs $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l vsubsl_vvvvl
def vsubslvvvvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l vsubsl_vsvvl
def vsubslvsvvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l vsubsl_vIvvl
def vsubslvIvvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l vsubsl_vvvmvl
def vsubslvvvmvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l vsubsl_vsvmvl
def vsubslvsvmvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l vsubsl_vIvmvl
def vsubslvIvmvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l vmulul_vvvvl
def vmululvvvvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l vmulul_vsvvl
def vmululvsvvl : RV<0xc9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l vmulul_vIvvl
def vmululvIvvl : RV<0xc9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l vmulul_vvvmvl
def vmululvvvmvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l vmulul_vsvmvl
def vmululvsvmvl : RV<0xc9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l vmulul_vIvmvl
def vmululvIvmvl : RV<0xc9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w vmuluw_vvvvl
def vmuluwvvvvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w vmuluw_vsvvl
def vmuluwvsvvl : RV<0xc9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w vmuluw_vIvvl
def vmuluwvIvvl : RV<0xc9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w vmuluw_vvvmvl
def vmuluwvvvmvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w vmuluw_vsvmvl
def vmuluwvsvmvl : RV<0xc9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w vmuluw_vIvmvl
def vmuluwvIvmvl : RV<0xc9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx vmulswsx_vvvvl
def vmulswsxvvvvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx vmulswsx_vsvvl
def vmulswsxvsvvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx vmulswsx_vIvvl
def vmulswsxvIvvl : RV<0xcb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx vmulswsx_vvvmvl
def vmulswsxvvvmvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx vmulswsx_vsvmvl
def vmulswsxvsvmvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx vmulswsx_vIvmvl
def vmulswsxvIvmvl : RV<0xcb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx vmulswzx_vvvvl
def vmulswzxvvvvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx vmulswzx_vsvvl
def vmulswzxvsvvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx vmulswzx_vIvvl
def vmulswzxvIvvl : RV<0xcb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx vmulswzx_vvvmvl
def vmulswzxvvvmvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx vmulswzx_vsvmvl
def vmulswzxvsvmvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx vmulswzx_vIvmvl
def vmulswzxvIvmvl : RV<0xcb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l vmulsl_vvvvl
def vmulslvvvvl : RV<0xdb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l vmulsl_vsvvl
def vmulslvsvvl : RV<0xdb, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l vmulsl_vIvvl
def vmulslvIvvl : RV<0xdb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l vmulsl_vvvmvl
def vmulslvvvmvl : RV<0xdb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l vmulsl_vsvmvl
def vmulslvsvmvl : RV<0xdb, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l vmulsl_vIvmvl
def vmulslvIvmvl : RV<0xdb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPD vmuls.l.w vmulslw_vvvvl
def vmulslwvvvvl : RV<0xd9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPD vmuls.l.w vmulslw_vsvvl
def vmulslwvsvvl : RV<0xd9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPD vmuls.l.w vmulslw_vIvvl
def vmulslwvIvvl : RV<0xd9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vvvvl
def vdivulvvvvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vsvvl
def vdivulvsvvl : RV<0xe9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vIvvl
def vdivulvIvvl : RV<0xe9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vvvmvl
def vdivulvvvmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vsvmvl
def vdivulvsvmvl : RV<0xe9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vIvmvl
def vdivulvIvmvl : RV<0xe9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vvvvl
def vdivuwvvvvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vsvvl
def vdivuwvsvvl : RV<0xe9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vIvvl
def vdivuwvIvvl : RV<0xe9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vvvmvl
def vdivuwvvvmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vsvmvl
def vdivuwvsvmvl : RV<0xe9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vIvmvl
def vdivuwvIvmvl : RV<0xe9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vvsvl
def vdivulvvsvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vvIvl
def vdivulvvIvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vvsmvl
def vdivulvvsmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vvImvl
def vdivulvvImvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vvsvl
def vdivuwvvsvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I32:$sy, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vvIvl
def vdivuwvvIvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vvsmvl
def vdivuwvvsmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vvImvl
def vdivuwvvImvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vvvvl
def vdivswsxvvvvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vsvvl
def vdivswsxvsvvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vIvvl
def vdivswsxvIvvl : RV<0xeb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vvvmvl
def vdivswsxvvvmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vsvmvl
def vdivswsxvsvmvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vIvmvl
def vdivswsxvIvmvl : RV<0xeb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vvvvl
def vdivswzxvvvvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vsvvl
def vdivswzxvsvvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vIvvl
def vdivswzxvIvvl : RV<0xeb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vvvmvl
def vdivswzxvvvmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vsvmvl
def vdivswzxvsvmvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vIvmvl
def vdivswzxvIvmvl : RV<0xeb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vvsvl
def vdivswsxvvsvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vvIvl
def vdivswsxvvIvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vvsmvl
def vdivswsxvvsmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vvImvl
def vdivswsxvvImvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vvsvl
def vdivswzxvvsvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vvIvl
def vdivswzxvvIvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vvsmvl
def vdivswzxvvsmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vvImvl
def vdivswzxvvImvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vvvvl
def vdivslvvvvl : RV<0xfb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vsvvl
def vdivslvsvvl : RV<0xfb, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vIvvl
def vdivslvIvvl : RV<0xfb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vvvmvl
def vdivslvvvmvl : RV<0xfb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vsvmvl
def vdivslvsvmvl : RV<0xfb, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vIvmvl
def vdivslvIvmvl : RV<0xfb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vvsvl
def vdivslvvsvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vvIvl
def vdivslvvIvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vvsmvl
def vdivslvvsmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vvImvl
def vdivslvvImvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l vcmpul_vvvvl
def vcmpulvvvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l vcmpul_vsvvl
def vcmpulvsvvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l vcmpul_vIvvl
def vcmpulvIvvl : RV<0xb9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l vcmpul_vvvmvl
def vcmpulvvvmvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l vcmpul_vsvmvl
def vcmpulvsvmvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l vcmpul_vIvmvl
def vcmpulvIvmvl : RV<0xb9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w vcmpuw_vvvvl
def vcmpuwvvvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w vcmpuw_vsvvl
def vcmpuwvsvvl : RV<0xb9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w vcmpuw_vIvvl
def vcmpuwvIvvl : RV<0xb9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w vcmpuw_vvvmvl
def vcmpuwvvvmvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w vcmpuw_vsvmvl
def vcmpuwvsvmvl : RV<0xb9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w vcmpuw_vIvmvl
def vcmpuwvIvmvl : RV<0xb9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP pvcmpu pvcmpu_vvvvl
def pvcmpuvvvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvcmpu $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP pvcmpu pvcmpu_vsvvl
def pvcmpuvsvvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvcmpu $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP pvcmpu pvcmpu_vvvMvl
def pvcmpuvvvMvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcmpu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP pvcmpu pvcmpu_vsvMvl
def pvcmpuvsvMvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcmpu $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx vcmpswsx_vvvvl
def vcmpswsxvvvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx vcmpswsx_vsvvl
def vcmpswsxvsvvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx vcmpswsx_vIvvl
def vcmpswsxvIvvl : RV<0xfa, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx vcmpswsx_vvvmvl
def vcmpswsxvvvmvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx vcmpswsx_vsvmvl
def vcmpswsxvsvmvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx vcmpswsx_vIvmvl
def vcmpswsxvIvmvl : RV<0xfa, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx vcmpswzx_vvvvl
def vcmpswzxvvvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx vcmpswzx_vsvvl
def vcmpswzxvsvvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx vcmpswzx_vIvvl
def vcmpswzxvIvvl : RV<0xfa, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx vcmpswzx_vvvmvl
def vcmpswzxvvvmvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx vcmpswzx_vsvmvl
def vcmpswzxvsvmvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx vcmpswzx_vIvmvl
def vcmpswzxvIvmvl : RV<0xfa, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS pvcmps pvcmps_vvvvl
def pvcmpsvvvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvcmps $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS pvcmps pvcmps_vsvvl
def pvcmpsvsvvl : RV<0xfa, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvcmps $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS pvcmps pvcmps_vvvMvl
def pvcmpsvvvMvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcmps $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS pvcmps pvcmps_vsvMvl
def pvcmpsvsvMvl : RV<0xfa, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcmps $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l vcmpsl_vvvvl
def vcmpslvvvvl : RV<0xba, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l vcmpsl_vsvvl
def vcmpslvsvvl : RV<0xba, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l vcmpsl_vIvvl
def vcmpslvIvvl : RV<0xba, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l vcmpsl_vvvmvl
def vcmpslvvvmvl : RV<0xba, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l vcmpsl_vsvmvl
def vcmpslvsvmvl : RV<0xba, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l vcmpsl_vIvmvl
def vcmpslvIvmvl : RV<0xba, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx vmaxswsx_vvvvl
def vmaxswsxvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx vmaxswsx_vsvvl
def vmaxswsxvsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx vmaxswsx_vIvvl
def vmaxswsxvIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx vmaxswsx_vvvmvl
def vmaxswsxvvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx vmaxswsx_vsvmvl
def vmaxswsxvsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx vmaxswsx_vIvmvl
def vmaxswsxvIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx vmaxswzx_vvvvl
def vmaxswzxvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx vmaxswzx_vsvvl
def vmaxswzxvsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx vmaxswzx_vIvvl
def vmaxswzxvIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx vmaxswzx_vvvmvl
def vmaxswzxvvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx vmaxswzx_vsvmvl
def vmaxswzxvsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx vmaxswzx_vIvmvl
def vmaxswzxvIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmaxs pvmaxs_vvvvl
def pvmaxsvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvmaxs $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmaxs pvmaxs_vsvvl
def pvmaxsvsvvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvmaxs $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmaxs pvmaxs_vvvMvl
def pvmaxsvvvMvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvmaxs $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmaxs pvmaxs_vsvMvl
def pvmaxsvsvMvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvmaxs $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx vminswsx_vvvvl
def vminswsxvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx vminswsx_vsvvl
def vminswsxvsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx vminswsx_vIvvl
def vminswsxvIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx vminswsx_vvvmvl
def vminswsxvvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx vminswsx_vsvmvl
def vminswsxvsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx vminswsx_vIvmvl
def vminswsxvIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx vminswzx_vvvvl
def vminswzxvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx vminswzx_vsvvl
def vminswzxvsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx vminswzx_vIvvl
def vminswzxvIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx vminswzx_vvvmvl
def vminswzxvvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx vminswzx_vsvmvl
def vminswzxvsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx vminswzx_vIvmvl
def vminswzxvIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmins pvmins_vvvvl
def pvminsvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvmins $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmins pvmins_vsvvl
def pvminsvsvvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvmins $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmins pvmins_vvvMvl
def pvminsvvvMvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvmins $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmins pvmins_vsvMvl
def pvminsvsvMvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvmins $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l vmaxsl_vvvvl
def vmaxslvvvvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l vmaxsl_vsvvl
def vmaxslvsvvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l vmaxsl_vIvvl
def vmaxslvIvvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l vmaxsl_vvvmvl
def vmaxslvvvmvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l vmaxsl_vsvmvl
def vmaxslvsvmvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l vmaxsl_vIvmvl
def vmaxslvIvmvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmins.l vminsl_vvvvl
def vminslvvvvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmins.l vminsl_vsvvl
def vminslvsvvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmins.l vminsl_vIvvl
def vminslvIvvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmins.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmins.l vminsl_vvvmvl
def vminslvvvmvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmins.l vminsl_vsvmvl
def vminslvsvmvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmins.l vminsl_vIvmvl
def vminslvIvmvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND vand vand_vvvvl
def vandvvvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vand $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND vand vand_vsvvl
def vandvsvvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vand $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND vand vand_vvvmvl
def vandvvvmvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vand $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND vand vand_vsvmvl
def vandvsvmvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vand $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND pvand pvand_vvvvl
def pvandvvvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvand $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND pvand pvand_vsvvl
def pvandvsvvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvand $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND pvand pvand_vvvMvl
def pvandvvvMvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvand $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND pvand pvand_vsvMvl
def pvandvsvMvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvand $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR vor vor_vvvvl
def vorvvvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR vor vor_vsvvl
def vorvsvvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR vor vor_vvvmvl
def vorvvvmvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR vor vor_vsvmvl
def vorvsvmvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR pvor pvor_vvvvl
def pvorvvvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvor $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR pvor pvor_vsvvl
def pvorvsvvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvor $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR pvor pvor_vvvMvl
def pvorvvvMvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR pvor pvor_vsvMvl
def pvorvsvMvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR vxor vxor_vvvvl
def vxorvvvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vxor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR vxor vxor_vsvvl
def vxorvsvvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vxor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR vxor vxor_vvvmvl
def vxorvvvmvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vxor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR vxor vxor_vsvmvl
def vxorvsvmvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vxor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR pvxor pvxor_vvvvl
def pvxorvvvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvxor $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR pvxor pvxor_vsvvl
def pvxorvsvvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvxor $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR pvxor pvxor_vvvMvl
def pvxorvvvMvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvxor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR pvxor pvxor_vsvMvl
def pvxorvsvMvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvxor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV veqv veqv_vvvvl
def veqvvvvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "veqv $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV veqv veqv_vsvvl
def veqvvsvvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "veqv $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV veqv veqv_vvvmvl
def veqvvvvmvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "veqv $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV veqv veqv_vsvmvl
def veqvvsvmvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "veqv $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV pveqv pveqv_vvvvl
def pveqvvvvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pveqv $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV pveqv pveqv_vsvvl
def pveqvvsvvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pveqv $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV pveqv pveqv_vvvMvl
def pveqvvvvMvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pveqv $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV pveqv pveqv_vsvMvl
def pveqvvsvMvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pveqv $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSEQ vseq vseq_vvl
def vseqvvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, I32:$vl),
       "vseq $vx", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSEQ pvseq.lo pvseqlo_vvl
def pvseqlovvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, I32:$vl),
       "pvseq.lo $vx", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSEQ pvseq.up pvsequp_vvl
def pvsequpvvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, I32:$vl),
       "pvseq.up $vx", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSEQ pvseq pvseq_vvl
def pvseqvvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, I32:$vl),
       "pvseq $vx", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL vsll vsll_vvvvl
def vsllvvvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL vsll vsll_vvsvl
def vsllvvsvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL vsll vsll_vvIvl
def vsllvvIvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL vsll vsll_vvvmvl
def vsllvvvmvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL vsll vsll_vvsmvl
def vsllvvsmvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL vsll vsll_vvImvl
def vsllvvImvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL pvsll pvsll_vvvvl
def pvsllvvvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "pvsll $vx,$vz,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL pvsll pvsll_vvsvl
def pvsllvvsvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "pvsll $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL pvsll pvsll_vvvMvl
def pvsllvvvMvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsll $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL pvsll pvsll_vvsMvl
def pvsllvvsMvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsll $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL vsrl vsrl_vvvvl
def vsrlvvvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL vsrl vsrl_vvsvl
def vsrlvvsvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL vsrl vsrl_vvIvl
def vsrlvvIvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL vsrl vsrl_vvvmvl
def vsrlvvvmvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL vsrl vsrl_vvsmvl
def vsrlvvsmvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL vsrl vsrl_vvImvl
def vsrlvvImvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL pvsrl pvsrl_vvvvl
def pvsrlvvvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "pvsrl $vx,$vz,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL pvsrl pvsrl_vvsvl
def pvsrlvvsvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "pvsrl $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL pvsrl pvsrl_vvvMvl
def pvsrlvvvMvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsrl $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL pvsrl pvsrl_vvsMvl
def pvsrlvvsMvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsrl $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA vsla.w vslaw_vvvvl
def vslawvvvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA vsla.w vslaw_vvsvl
def vslawvvsvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA vsla.w vslaw_vvIvl
def vslawvvIvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA vsla.w vslaw_vvvmvl
def vslawvvvmvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA vsla.w vslaw_vvsmvl
def vslawvvsmvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA vsla.w vslaw_vvImvl
def vslawvvImvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA pvsla pvsla_vvvvl
def pvslavvvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "pvsla $vx,$vz,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA pvsla pvsla_vvsvl
def pvslavvsvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "pvsla $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA pvsla pvsla_vvvMvl
def pvslavvvMvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsla $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA pvsla pvsla_vvsMvl
def pvslavvsMvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsla $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l vslal_vvvvl
def vslalvvvvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l vslal_vvsvl
def vslalvvsvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l vslal_vvIvl
def vslalvvIvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l vslal_vvvmvl
def vslalvvvmvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l vslal_vvsmvl
def vslalvvsmvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l vslal_vvImvl
def vslalvvImvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA vsra.w vsraw_vvvvl
def vsrawvvvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA vsra.w vsraw_vvsvl
def vsrawvvsvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA vsra.w vsraw_vvIvl
def vsrawvvIvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA vsra.w vsraw_vvvmvl
def vsrawvvvmvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA vsra.w vsraw_vvsmvl
def vsrawvvsmvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA vsra.w vsraw_vvImvl
def vsrawvvImvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA pvsra pvsra_vvvvl
def pvsravvvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "pvsra $vx,$vz,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA pvsra pvsra_vvsvl
def pvsravvsvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "pvsra $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA pvsra pvsra_vvvMvl
def pvsravvvMvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsra $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA pvsra pvsra_vvsMvl
def pvsravvsMvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsra $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l vsral_vvvvl
def vsralvvvvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l vsral_vvsvl
def vsralvvsvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l vsral_vvIvl
def vsralvvIvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l vsral_vvvmvl
def vsralvvvmvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l vsral_vvsmvl
def vsralvvsmvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l vsral_vvImvl
def vsralvvImvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSFA vsfa vsfa_vvssvl
def vsfavvssvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vsfa $vx,$vz,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSFA vsfa vsfa_vvIsvl
def vsfavvIsvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vsfa $vx,$vz,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSFA vsfa vsfa_vvssmvl
def vsfavvssmvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vsfa $vx,$vz,$sy,$sz,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSFA vsfa vsfa_vvIsmvl
def vsfavvIsmvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vsfa $vx,$vz,$I,$sz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.d vfaddd_vvvvl
def vfadddvvvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfadd.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.d vfaddd_vsvvl
def vfadddvsvvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfadd.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.d vfaddd_vvvmvl
def vfadddvvvmvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfadd.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.d vfaddd_vsvmvl
def vfadddvsvmvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfadd.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.s vfadds_vvvvl
def vfaddsvvvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfadd.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.s vfadds_vsvvl
def vfaddsvsvvl : RV<0xcc, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfadd.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.s vfadds_vvvmvl
def vfaddsvvvmvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfadd.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.s vfadds_vsvmvl
def vfaddsvsvmvl : RV<0xcc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfadd.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD pvfadd pvfadd_vvvvl
def pvfaddvvvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfadd $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD pvfadd pvfadd_vsvvl
def pvfaddvsvvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfadd $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD pvfadd pvfadd_vvvMvl
def pvfaddvvvMvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfadd $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD pvfadd pvfadd_vsvMvl
def pvfaddvsvMvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfadd $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.d vfsubd_vvvvl
def vfsubdvvvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfsub.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.d vfsubd_vsvvl
def vfsubdvsvvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfsub.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.d vfsubd_vvvmvl
def vfsubdvvvmvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfsub.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.d vfsubd_vsvmvl
def vfsubdvsvmvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfsub.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.s vfsubs_vvvvl
def vfsubsvvvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfsub.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.s vfsubs_vsvvl
def vfsubsvsvvl : RV<0xdc, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfsub.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.s vfsubs_vvvmvl
def vfsubsvvvmvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfsub.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.s vfsubs_vsvmvl
def vfsubsvsvmvl : RV<0xdc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfsub.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB pvfsub pvfsub_vvvvl
def pvfsubvvvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfsub $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB pvfsub pvfsub_vsvvl
def pvfsubvsvvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfsub $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB pvfsub pvfsub_vvvMvl
def pvfsubvvvMvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfsub $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB pvfsub pvfsub_vsvMvl
def pvfsubvsvMvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfsub $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.d vfmuld_vvvvl
def vfmuldvvvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmul.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.d vfmuld_vsvvl
def vfmuldvsvvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmul.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.d vfmuld_vvvmvl
def vfmuldvvvmvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmul.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.d vfmuld_vsvmvl
def vfmuldvsvmvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmul.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.s vfmuls_vvvvl
def vfmulsvvvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmul.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.s vfmuls_vsvvl
def vfmulsvsvvl : RV<0xcd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmul.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.s vfmuls_vvvmvl
def vfmulsvvvmvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmul.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.s vfmuls_vsvmvl
def vfmulsvsvmvl : RV<0xcd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmul.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP pvfmul pvfmul_vvvvl
def pvfmulvvvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmul $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP pvfmul pvfmul_vsvvl
def pvfmulvsvvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmul $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP pvfmul pvfmul_vvvMvl
def pvfmulvvvMvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmul $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP pvfmul pvfmul_vsvMvl
def pvfmulvsvMvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmul $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.d vfdivd_vvvvl
def vfdivdvvvvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfdiv.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.d vfdivd_vsvvl
def vfdivdvsvvl : RV<0xdd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfdiv.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.d vfdivd_vvvmvl
def vfdivdvvvmvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfdiv.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.d vfdivd_vsvmvl
def vfdivdvsvmvl : RV<0xdd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfdiv.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.s vfdivs_vvvvl
def vfdivsvvvvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfdiv.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.s vfdivs_vsvvl
def vfdivsvsvvl : RV<0xdd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfdiv.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.s vfdivs_vvvmvl
def vfdivsvvvmvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfdiv.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.s vfdivs_vsvmvl
def vfdivsvsvmvl : RV<0xdd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfdiv.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSQRT vfsqrt.d vfsqrtd_vvvl
def vfsqrtdvvvl : RV<0xed, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfsqrt.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSQRT vfsqrt.s vfsqrts_vvvl
def vfsqrtsvvvl : RV<0xed, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfsqrt.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.d vfcmpd_vvvvl
def vfcmpdvvvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfcmp.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.d vfcmpd_vsvvl
def vfcmpdvsvvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfcmp.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.d vfcmpd_vvvmvl
def vfcmpdvvvmvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfcmp.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.d vfcmpd_vsvmvl
def vfcmpdvsvmvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfcmp.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.s vfcmps_vvvvl
def vfcmpsvvvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfcmp.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.s vfcmps_vsvvl
def vfcmpsvsvvl : RV<0xfc, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfcmp.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.s vfcmps_vvvmvl
def vfcmpsvvvmvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfcmp.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.s vfcmps_vsvmvl
def vfcmpsvsvmvl : RV<0xfc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfcmp.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP pvfcmp pvfcmp_vvvvl
def pvfcmpvvvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfcmp $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP pvfcmp pvfcmp_vsvvl
def pvfcmpvsvvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfcmp $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP pvfcmp pvfcmp_vvvMvl
def pvfcmpvvvMvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfcmp $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP pvfcmp pvfcmp_vsvMvl
def pvfcmpvsvMvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfcmp $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.d vfmaxd_vvvvl
def vfmaxdvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmax.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.d vfmaxd_vsvvl
def vfmaxdvsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmax.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.d vfmaxd_vvvmvl
def vfmaxdvvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmax.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.d vfmaxd_vsvmvl
def vfmaxdvsvmvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmax.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.s vfmaxs_vvvvl
def vfmaxsvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmax.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.s vfmaxs_vsvvl
def vfmaxsvsvvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmax.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.s vfmaxs_vvvmvl
def vfmaxsvvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmax.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.s vfmaxs_vsvmvl
def vfmaxsvsvmvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmax.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmax pvfmax_vvvvl
def pvfmaxvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmax $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmax pvfmax_vsvvl
def pvfmaxvsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmax $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmax pvfmax_vvvMvl
def pvfmaxvvvMvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmax $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmax pvfmax_vsvMvl
def pvfmaxvsvMvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmax $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.d vfmind_vvvvl
def vfmindvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmin.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.d vfmind_vsvvl
def vfmindvsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmin.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.d vfmind_vvvmvl
def vfmindvvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmin.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.d vfmind_vsvmvl
def vfmindvsvmvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmin.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.s vfmins_vvvvl
def vfminsvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmin.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.s vfmins_vsvvl
def vfminsvsvvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmin.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.s vfmins_vvvmvl
def vfminsvvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmin.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.s vfmins_vsvmvl
def vfminsvsvmvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmin.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmin pvfmin_vvvvl
def pvfminvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmin $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmin pvfmin_vsvvl
def pvfminvsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmin $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmin pvfmin_vvvMvl
def pvfminvvvMvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmin $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmin pvfmin_vsvMvl
def pvfminvsvMvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmin $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d vfmadd_vvvvvl
def vfmaddvvvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d vfmadd_vsvvvl
def vfmaddvsvvvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d vfmadd_vvsvvl
def vfmaddvvsvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d vfmadd_vvvvmvl
def vfmaddvvvvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d vfmadd_vsvvmvl
def vfmaddvsvvmvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d vfmadd_vvsvmvl
def vfmaddvvsvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s vfmads_vvvvvl
def vfmadsvvvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s vfmads_vsvvvl
def vfmadsvsvvvl : RV<0xe2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s vfmads_vvsvvl
def vfmadsvvsvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s vfmads_vvvvmvl
def vfmadsvvvvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s vfmads_vsvvmvl
def vfmadsvsvvmvl : RV<0xe2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s vfmads_vvsvmvl
def vfmadsvvsvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad pvfmad_vvvvvl
def pvfmadvvvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad pvfmad_vsvvvl
def pvfmadvsvvvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad pvfmad_vvsvvl
def pvfmadvvsvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "pvfmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad pvfmad_vvvvMvl
def pvfmadvvvvMvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmad $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad pvfmad_vsvvMvl
def pvfmadvsvvMvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmad $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad pvfmad_vvsvMvl
def pvfmadvvsvMvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmad $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d vfmsbd_vvvvvl
def vfmsbdvvvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d vfmsbd_vsvvvl
def vfmsbdvsvvvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d vfmsbd_vvsvvl
def vfmsbdvvsvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d vfmsbd_vvvvmvl
def vfmsbdvvvvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d vfmsbd_vsvvmvl
def vfmsbdvsvvmvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d vfmsbd_vvsvmvl
def vfmsbdvvsvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s vfmsbs_vvvvvl
def vfmsbsvvvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s vfmsbs_vsvvvl
def vfmsbsvsvvvl : RV<0xf2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s vfmsbs_vvsvvl
def vfmsbsvvsvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s vfmsbs_vvvvmvl
def vfmsbsvvvvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s vfmsbs_vsvvmvl
def vfmsbsvsvvmvl : RV<0xf2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s vfmsbs_vvsvmvl
def vfmsbsvvsvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb pvfmsb_vvvvvl
def pvfmsbvvvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb pvfmsb_vsvvvl
def pvfmsbvsvvvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb pvfmsb_vvsvvl
def pvfmsbvvsvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "pvfmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb pvfmsb_vvvvMvl
def pvfmsbvvvvMvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmsb $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb pvfmsb_vsvvMvl
def pvfmsbvsvvMvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmsb $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb pvfmsb_vvsvMvl
def pvfmsbvvsvMvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmsb $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d vfnmadd_vvvvvl
def vfnmaddvvvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d vfnmadd_vsvvvl
def vfnmaddvsvvvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d vfnmadd_vvsvvl
def vfnmaddvvsvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d vfnmadd_vvvvmvl
def vfnmaddvvvvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d vfnmadd_vsvvmvl
def vfnmaddvsvvmvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d vfnmadd_vvsvmvl
def vfnmaddvvsvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s vfnmads_vvvvvl
def vfnmadsvvvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s vfnmads_vsvvvl
def vfnmadsvsvvvl : RV<0xe3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s vfnmads_vvsvvl
def vfnmadsvvsvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s vfnmads_vvvvmvl
def vfnmadsvvvvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s vfnmads_vsvvmvl
def vfnmadsvsvvmvl : RV<0xe3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s vfnmads_vvsvmvl
def vfnmadsvvsvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad pvfnmad_vvvvvl
def pvfnmadvvvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad pvfnmad_vsvvvl
def pvfnmadvsvvvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad pvfnmad_vvsvvl
def pvfnmadvvsvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad pvfnmad_vvvvMvl
def pvfnmadvvvvMvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmad $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad pvfnmad_vsvvMvl
def pvfnmadvsvvMvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmad $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad pvfnmad_vvsvMvl
def pvfnmadvvsvMvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmad $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d vfnmsbd_vvvvvl
def vfnmsbdvvvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d vfnmsbd_vsvvvl
def vfnmsbdvsvvvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d vfnmsbd_vvsvvl
def vfnmsbdvvsvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d vfnmsbd_vvvvmvl
def vfnmsbdvvvvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d vfnmsbd_vsvvmvl
def vfnmsbdvsvvmvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d vfnmsbd_vvsvmvl
def vfnmsbdvvsvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s vfnmsbs_vvvvvl
def vfnmsbsvvvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s vfnmsbs_vsvvvl
def vfnmsbsvsvvvl : RV<0xf3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s vfnmsbs_vvsvvl
def vfnmsbsvvsvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s vfnmsbs_vvvvmvl
def vfnmsbsvvvvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s vfnmsbs_vsvvmvl
def vfnmsbsvsvvmvl : RV<0xf3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s vfnmsbs_vvsvmvl
def vfnmsbsvvsvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb pvfnmsb_vvvvvl
def pvfnmsbvvvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb pvfnmsb_vsvvvl
def pvfnmsbvsvvvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb pvfnmsb_vvsvvl
def pvfnmsbvvsvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb pvfnmsb_vvvvMvl
def pvfnmsbvvvvMvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb pvfnmsb_vsvvMvl
def pvfnmsbvsvvMvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb pvfnmsb_vvsvMvl
def pvfnmsbvvsvMvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRCP vrcp.d vrcpd_vvvl
def vrcpdvvvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrcp.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRCP vrcp.s vrcps_vvvl
def vrcpsvvvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrcp.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRCP pvrcp pvrcp_vvvl
def pvrcpvvvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvrcp $vx,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRSQRT vrsqrt.d vrsqrtd_vvvl
def vrsqrtdvvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrsqrt.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRSQRT vrsqrt.s vrsqrts_vvvl
def vrsqrtsvvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrsqrt.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRSQRT pvrsqrt pvrsqrt_vvvl
def pvrsqrtvvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvrsqrt $vx,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.sx vcvtwdsx_vvvl
def vcvtwdsxvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.d.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.sx vcvtwdsx_vvmvl
def vcvtwdsxvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.d.sx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.sx.rz vcvtwdsxrz_vvvl
def vcvtwdsxrzvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.d.sx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.sx.rz vcvtwdsxrz_vvmvl
def vcvtwdsxrzvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.d.sx.rz $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.zx vcvtwdzx_vvvl
def vcvtwdzxvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.d.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.zx vcvtwdzx_vvmvl
def vcvtwdzxvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.d.zx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.zx.rz vcvtwdzxrz_vvvl
def vcvtwdzxrzvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.d.zx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.zx.rz vcvtwdzxrz_vvmvl
def vcvtwdzxrzvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.d.zx.rz $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.sx vcvtwssx_vvvl
def vcvtwssxvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.s.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.sx vcvtwssx_vvmvl
def vcvtwssxvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.s.sx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.sx.rz vcvtwssxrz_vvvl
def vcvtwssxrzvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.s.sx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.sx.rz vcvtwssxrz_vvmvl
def vcvtwssxrzvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.s.sx.rz $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.zx vcvtwszx_vvvl
def vcvtwszxvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.s.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.zx vcvtwszx_vvmvl
def vcvtwszxvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.s.zx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.zx.rz vcvtwszxrz_vvvl
def vcvtwszxrzvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.s.zx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.zx.rz vcvtwszxrz_vvmvl
def vcvtwszxrzvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.s.zx.rz $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX pvcvt.w.s pvcvtws_vvvl
def pvcvtwsvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvcvt.w.s $vx,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX pvcvt.w.s pvcvtws_vvMvl
def pvcvtwsvvMvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcvt.w.s $vx,$vy,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX pvcvt.w.s.rz pvcvtwsrz_vvvl
def pvcvtwsrzvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvcvt.w.s.rz $vx,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX pvcvt.w.s.rz pvcvtwsrz_vvMvl
def pvcvtwsrzvvMvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcvt.w.s.rz $vx,$vy,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIXX vcvt.l.d vcvtld_vvvl
def vcvtldvvvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.l.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIXX vcvt.l.d vcvtld_vvmvl
def vcvtldvvmvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.l.d $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIXX vcvt.l.d.rz vcvtldrz_vvvl
def vcvtldrzvvvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.l.d.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIXX vcvt.l.d.rz vcvtldrz_vvmvl
def vcvtldrzvvmvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.l.d.rz $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFLT vcvt.d.w vcvtdw_vvvl
def vcvtdwvvvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.d.w $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFLT vcvt.s.w vcvtsw_vvvl
def vcvtswvvvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.s.w $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFLT pvcvt.s.w pvcvtsw_vvvl
def pvcvtswvvvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvcvt.s.w $vx,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFLTX vcvt.d.l vcvtdl_vvvl
def vcvtdlvvvl : RV<0xb8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.d.l $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCVD vcvt.d.s vcvtds_vvvl
def vcvtdsvvvl : RV<0x8f, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.d.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCVS vcvt.s.d vcvtsd_vvvl
def vcvtsdvvvl : RV<0x9f, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.s.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMRG vmrg vmrg_vvvmvl
def vmrgvvvmvl : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmrg $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMRG vmrg.w vmrgw_vvvMvl
def vmrgwvvvMvl : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "vmrg.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSHF vshf vshf_vvvsvl
def vshfvvvsvl : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vshf $vx,$vy,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSHF vshf vshf_vvvIvl
def vshfvvvIvl : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vshf $vx,$vy,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCP vcp vcp_vvmvl
def vcpvvmvl : RV<0x8d, (outs V64:$vx), (ins V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcp $vx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEX vex vex_vvmvl
def vexvvmvl : RV<0x9d, (outs V64:$vx), (ins V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vex $vx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.at vfmkat_ml
def vfmkatml : RV<0xb4, (outs VM_:$vm), (ins I32:$vl),
       "vfmk.at $vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.af vfmkaf_ml
def vfmkafml : RV<0xb4, (outs VM_:$vm), (ins I32:$vl),
       "vfmk.af $vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK pvfmk.at pvfmkat_Ml
def pvfmkatMl : Pseudo<(outs VM512_:$vm), (ins I32:$vl),
       "# pvfmk.at $vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK pvfmk.af pvfmkaf_Ml
def pvfmkafMl : Pseudo<(outs VM512_:$vm), (ins I32:$vl),
       "# pvfmk.af $vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.gt vfmklgt_mvl
def vfmklgtmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.l.gt $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.gt vfmklgt_mvml
def vfmklgtmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.gt $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.lt vfmkllt_mvl
def vfmklltmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.l.lt $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.lt vfmkllt_mvml
def vfmklltmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.lt $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.ne vfmklne_mvl
def vfmklnemvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.l.ne $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.ne vfmklne_mvml
def vfmklnemvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.ne $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.eq vfmkleq_mvl
def vfmkleqmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.l.eq $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.eq vfmkleq_mvml
def vfmkleqmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.eq $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.ge vfmklge_mvl
def vfmklgemvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.l.ge $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.ge vfmklge_mvml
def vfmklgemvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.ge $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.le vfmklle_mvl
def vfmkllemvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.l.le $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.le vfmklle_mvml
def vfmkllemvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.le $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.num vfmklnum_mvl
def vfmklnummvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.l.num $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.num vfmklnum_mvml
def vfmklnummvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.num $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.nan vfmklnan_mvl
def vfmklnanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.l.nan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.nan vfmklnan_mvml
def vfmklnanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.nan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.gtnan vfmklgtnan_mvl
def vfmklgtnanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.l.gtnan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.gtnan vfmklgtnan_mvml
def vfmklgtnanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.ltnan vfmklltnan_mvl
def vfmklltnanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.l.ltnan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.ltnan vfmklltnan_mvml
def vfmklltnanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.nenan vfmklnenan_mvl
def vfmklnenanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.l.nenan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.nenan vfmklnenan_mvml
def vfmklnenanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.lenan vfmkllenan_mvl
def vfmkllenanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.l.lenan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.lenan vfmkllenan_mvml
def vfmkllenanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.gt vfmkwgt_mvl
def vfmkwgtmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.w.gt $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.gt vfmkwgt_mvml
def vfmkwgtmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.gt $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.lt vfmkwlt_mvl
def vfmkwltmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.w.lt $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.lt vfmkwlt_mvml
def vfmkwltmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.lt $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.ne vfmkwne_mvl
def vfmkwnemvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.w.ne $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.ne vfmkwne_mvml
def vfmkwnemvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.ne $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.eq vfmkweq_mvl
def vfmkweqmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.w.eq $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.eq vfmkweq_mvml
def vfmkweqmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.eq $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.ge vfmkwge_mvl
def vfmkwgemvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.w.ge $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.ge vfmkwge_mvml
def vfmkwgemvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.ge $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.le vfmkwle_mvl
def vfmkwlemvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.w.le $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.le vfmkwle_mvml
def vfmkwlemvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.le $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.num vfmkwnum_mvl
def vfmkwnummvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.w.num $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.num vfmkwnum_mvml
def vfmkwnummvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.num $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.nan vfmkwnan_mvl
def vfmkwnanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.w.nan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.nan vfmkwnan_mvml
def vfmkwnanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.nan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.gtnan vfmkwgtnan_mvl
def vfmkwgtnanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.w.gtnan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.gtnan vfmkwgtnan_mvml
def vfmkwgtnanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.ltnan vfmkwltnan_mvl
def vfmkwltnanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.w.ltnan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.ltnan vfmkwltnan_mvml
def vfmkwltnanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.nenan vfmkwnenan_mvl
def vfmkwnenanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.w.nenan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.nenan vfmkwnenan_mvml
def vfmkwnenanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.lenan vfmkwlenan_mvl
def vfmkwlenanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.w.lenan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.lenan vfmkwlenan_mvml
def vfmkwlenanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.gt pvfmkwgt_Mcvl
def pvfmkwgtMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.w.gt $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.gt pvfmkwgt_McvMl
def pvfmkwgtMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.gt $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lt pvfmkwlt_Mcvl
def pvfmkwltMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.w.lt $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lt pvfmkwlt_McvMl
def pvfmkwltMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.lt $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.ne pvfmkwne_Mcvl
def pvfmkwneMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.w.ne $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.ne pvfmkwne_McvMl
def pvfmkwneMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.ne $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.eq pvfmkweq_Mcvl
def pvfmkweqMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.w.eq $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.eq pvfmkweq_McvMl
def pvfmkweqMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.eq $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.ge pvfmkwge_Mcvl
def pvfmkwgeMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.w.ge $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.ge pvfmkwge_McvMl
def pvfmkwgeMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.ge $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.le pvfmkwle_Mcvl
def pvfmkwleMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.w.le $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.le pvfmkwle_McvMl
def pvfmkwleMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.le $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.num pvfmkwnum_Mcvl
def pvfmkwnumMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.w.num $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.num pvfmkwnum_McvMl
def pvfmkwnumMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.num $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.nan pvfmkwnan_Mcvl
def pvfmkwnanMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.w.nan $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.nan pvfmkwnan_McvMl
def pvfmkwnanMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.nan $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.gtnan pvfmkwgtnan_Mcvl
def pvfmkwgtnanMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.w.gtnan $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.gtnan pvfmkwgtnan_McvMl
def pvfmkwgtnanMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.gtnan $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.ltnan pvfmkwltnan_Mcvl
def pvfmkwltnanMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.w.ltnan $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.ltnan pvfmkwltnan_McvMl
def pvfmkwltnanMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.ltnan $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.nenan pvfmkwnenan_Mcvl
def pvfmkwnenanMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.w.nenan $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.nenan pvfmkwnenan_McvMl
def pvfmkwnenanMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.nenan $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lenan pvfmkwlenan_Mcvl
def pvfmkwlenanMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.w.lenan $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lenan pvfmkwlenan_McvMl
def pvfmkwlenanMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.lenan $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.gt vfmkdgt_mvl
def vfmkdgtmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.d.gt $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.gt vfmkdgt_mvml
def vfmkdgtmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.gt $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.lt vfmkdlt_mvl
def vfmkdltmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.d.lt $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.lt vfmkdlt_mvml
def vfmkdltmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.lt $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.ne vfmkdne_mvl
def vfmkdnemvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.d.ne $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.ne vfmkdne_mvml
def vfmkdnemvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.ne $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.eq vfmkdeq_mvl
def vfmkdeqmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.d.eq $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.eq vfmkdeq_mvml
def vfmkdeqmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.eq $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.ge vfmkdge_mvl
def vfmkdgemvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.d.ge $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.ge vfmkdge_mvml
def vfmkdgemvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.ge $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.le vfmkdle_mvl
def vfmkdlemvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.d.le $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.le vfmkdle_mvml
def vfmkdlemvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.le $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.num vfmkdnum_mvl
def vfmkdnummvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.d.num $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.num vfmkdnum_mvml
def vfmkdnummvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.num $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.nan vfmkdnan_mvl
def vfmkdnanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.d.nan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.nan vfmkdnan_mvml
def vfmkdnanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.nan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.gtnan vfmkdgtnan_mvl
def vfmkdgtnanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.d.gtnan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.gtnan vfmkdgtnan_mvml
def vfmkdgtnanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.ltnan vfmkdltnan_mvl
def vfmkdltnanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.d.ltnan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.ltnan vfmkdltnan_mvml
def vfmkdltnanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.nenan vfmkdnenan_mvl
def vfmkdnenanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.d.nenan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.nenan vfmkdnenan_mvml
def vfmkdnenanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.lenan vfmkdlenan_mvl
def vfmkdlenanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.d.lenan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.lenan vfmkdlenan_mvml
def vfmkdlenanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.gt vfmksgt_mvl
def vfmksgtmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.s.gt $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.gt vfmksgt_mvml
def vfmksgtmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.gt $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.lt vfmkslt_mvl
def vfmksltmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.s.lt $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.lt vfmkslt_mvml
def vfmksltmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.lt $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.ne vfmksne_mvl
def vfmksnemvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.s.ne $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.ne vfmksne_mvml
def vfmksnemvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.ne $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.eq vfmkseq_mvl
def vfmkseqmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.s.eq $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.eq vfmkseq_mvml
def vfmkseqmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.eq $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.ge vfmksge_mvl
def vfmksgemvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.s.ge $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.ge vfmksge_mvml
def vfmksgemvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.ge $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.le vfmksle_mvl
def vfmkslemvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.s.le $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.le vfmksle_mvml
def vfmkslemvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.le $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.num vfmksnum_mvl
def vfmksnummvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.s.num $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.num vfmksnum_mvml
def vfmksnummvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.num $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.nan vfmksnan_mvl
def vfmksnanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.s.nan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.nan vfmksnan_mvml
def vfmksnanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.nan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.gtnan vfmksgtnan_mvl
def vfmksgtnanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.s.gtnan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.gtnan vfmksgtnan_mvml
def vfmksgtnanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.ltnan vfmksltnan_mvl
def vfmksltnanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.s.ltnan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.ltnan vfmksltnan_mvml
def vfmksltnanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.nenan vfmksnenan_mvl
def vfmksnenanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.s.nenan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.nenan vfmksnenan_mvml
def vfmksnenanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.lenan vfmkslenan_mvl
def vfmkslenanmvl : RV<0xb4, (outs VM_:$vm), (ins V64:$vz, I32:$vl),
       "vfmk.s.lenan $vm,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.lenan vfmkslenan_mvml
def vfmkslenanmvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.gt pvfmksgt_Mcvl
def pvfmksgtMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.s.gt $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.gt pvfmksgt_McvMl
def pvfmksgtMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.gt $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lt pvfmkslt_Mcvl
def pvfmksltMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.s.lt $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lt pvfmkslt_McvMl
def pvfmksltMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.lt $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.ne pvfmksne_Mcvl
def pvfmksneMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.s.ne $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.ne pvfmksne_McvMl
def pvfmksneMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.ne $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.eq pvfmkseq_Mcvl
def pvfmkseqMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.s.eq $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.eq pvfmkseq_McvMl
def pvfmkseqMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.eq $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.ge pvfmksge_Mcvl
def pvfmksgeMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.s.ge $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.ge pvfmksge_McvMl
def pvfmksgeMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.ge $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.le pvfmksle_Mcvl
def pvfmksleMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.s.le $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.le pvfmksle_McvMl
def pvfmksleMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.le $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.num pvfmksnum_Mcvl
def pvfmksnumMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.s.num $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.num pvfmksnum_McvMl
def pvfmksnumMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.num $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.nan pvfmksnan_Mcvl
def pvfmksnanMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.s.nan $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.nan pvfmksnan_McvMl
def pvfmksnanMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.nan $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.gtnan pvfmksgtnan_Mcvl
def pvfmksgtnanMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.s.gtnan $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.gtnan pvfmksgtnan_McvMl
def pvfmksgtnanMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.gtnan $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.ltnan pvfmksltnan_Mcvl
def pvfmksltnanMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.s.ltnan $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.ltnan pvfmksltnan_McvMl
def pvfmksltnanMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.ltnan $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.nenan pvfmksnenan_Mcvl
def pvfmksnenanMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.s.nenan $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.nenan pvfmksnenan_McvMl
def pvfmksnenanMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.nenan $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lenan pvfmkslenan_Mcvl
def pvfmkslenanMcvl : Pseudo<(outs VM512_:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "# pvfmk.s.lenan $vm,$cc,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lenan pvfmkslenan_McvMl
def pvfmkslenanMcvMl : Pseudo<(outs VM512_:$vmx), (ins CCOp:$cc, V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.lenan $vmx,$cc,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUMS vsum.w.sx vsumwsx_vvvl
def vsumwsxvvvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vsum.w.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUMS vsum.w.sx vsumwsx_vvmvl
def vsumwsxvvmvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsum.w.sx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUMS vsum.w.zx vsumwzx_vvvl
def vsumwzxvvvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vsum.w.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUMS vsum.w.zx vsumwzx_vvmvl
def vsumwzxvvmvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsum.w.zx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUMX vsum.l vsuml_vvvl
def vsumlvvvl : RV<0xaa, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vsum.l $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUMX vsum.l vsuml_vvmvl
def vsumlvvmvl : RV<0xaa, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsum.l $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSUM vfsum.d vfsumd_vvvl
def vfsumdvvvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfsum.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSUM vfsum.d vfsumd_vvmvl
def vfsumdvvmvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vfsum.d $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSUM vfsum.s vfsums_vvvl
def vfsumsvvvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfsum.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSUM vfsum.s vfsums_vvmvl
def vfsumsvvmvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vfsum.s $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmaxs.w.fst.sx vrmaxswfstsx_vvvl
def vrmaxswfstsxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmaxs.w.lst.sx vrmaxswlstsx_vvvl
def vrmaxswlstsxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmaxs.w.fst.zx vrmaxswfstzx_vvvl
def vrmaxswfstzxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmaxs.w.lst.zx vrmaxswlstzx_vvvl
def vrmaxswlstzxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmins.w.fst.sx vrminswfstsx_vvvl
def vrminswfstsxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmins.w.lst.sx vrminswlstsx_vvvl
def vrminswlstsxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmins.w.fst.zx vrminswfstzx_vvvl
def vrminswfstzxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmins.w.lst.zx vrminswlstzx_vvvl
def vrminswlstzxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXX vrmaxs.l.fst vrmaxslfst_vvvl
def vrmaxslfstvvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.l.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXX vrmaxs.l.lst vrmaxsllst_vvvl
def vrmaxsllstvvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.l.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXX vrmins.l.fst vrminslfst_vvvl
def vrminslfstvvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.l.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXX vrmins.l.lst vrminsllst_vvvl
def vrminsllstvvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.l.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmax.d.fst vfrmaxdfst_vvvl
def vfrmaxdfstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmax.d.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmax.d.lst vfrmaxdlst_vvvl
def vfrmaxdlstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmax.d.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmax.s.fst vfrmaxsfst_vvvl
def vfrmaxsfstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmax.s.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmax.s.lst vfrmaxslst_vvvl
def vfrmaxslstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmax.s.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmin.d.fst vfrmindfst_vvvl
def vfrmindfstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmin.d.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmin.d.lst vfrmindlst_vvvl
def vfrmindlstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmin.d.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmin.s.fst vfrminsfst_vvvl
def vfrminsfstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmin.s.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmin.s.lst vfrminslst_vvvl
def vfrminslstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmin.s.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvvl
def vgtvvvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vgt $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvmvl
def vgtvvmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvvl
def vgtuvvvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vgtu $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvmvl
def vgtuvvmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvvl
def vgtlsxvvvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvmvl
def vgtlsxvvmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvvl
def vgtlzxvvvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvmvl
def vgtlzxvvmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc vsc_vvl
def vscvvl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I32:$vl),
       "vsc $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc vsc_vvml
def vscvvml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, VM_:$vm, I32:$vl),
       "vsc $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.ot vscot_vvl
def vscotvvl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I32:$vl),
       "vsc.ot $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.ot vscot_vvml
def vscotvvml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, VM_:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu vscu_vvl
def vscuvvl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I32:$vl),
       "vscu $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu vscu_vvml
def vscuvvml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, VM_:$vm, I32:$vl),
       "vscu $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.ot vscuot_vvl
def vscuotvvl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I32:$vl),
       "vscu.ot $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.ot vscuot_vvml
def vscuotvvml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, VM_:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl vscl_vvl
def vsclvvl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I32:$vl),
       "vscl $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl vscl_vvml
def vsclvvml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, VM_:$vm, I32:$vl),
       "vscl $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.ot vsclot_vvl
def vsclotvvl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I32:$vl),
       "vscl.ot $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.ot vsclot_vvml
def vsclotvvml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, VM_:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// ANDM andm andm_mmml
def andmmmml : RV<0x84, (outs VM_:$vmx), (ins VM_:$vmy, VM_:$vmz, I32:$vl),
       "andm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// ANDM andm andm_MMMl
def andmMMMl : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy, VM512_:$vmz, I32:$vl),
       "# andm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// ORM orm orm_mmml
def ormmmml : RV<0x85, (outs VM_:$vmx), (ins VM_:$vmy, VM_:$vmz, I32:$vl),
       "orm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// ORM orm orm_MMMl
def ormMMMl : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy, VM512_:$vmz, I32:$vl),
       "# orm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// XORM xorm xorm_mmml
def xormmmml : RV<0x86, (outs VM_:$vmx), (ins VM_:$vmy, VM_:$vmz, I32:$vl),
       "xorm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// XORM xorm xorm_MMMl
def xormMMMl : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy, VM512_:$vmz, I32:$vl),
       "# xorm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// EQVM eqvm eqvm_mmml
def eqvmmmml : RV<0x87, (outs VM_:$vmx), (ins VM_:$vmy, VM_:$vmz, I32:$vl),
       "eqvm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// EQVM eqvm eqvm_MMMl
def eqvmMMMl : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy, VM512_:$vmz, I32:$vl),
       "# eqvm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// NNDM nndm nndm_mmml
def nndmmmml : RV<0x94, (outs VM_:$vmx), (ins VM_:$vmy, VM_:$vmz, I32:$vl),
       "nndm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// NNDM nndm nndm_MMMl
def nndmMMMl : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy, VM512_:$vmz, I32:$vl),
       "# nndm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// NEGM negm negm_mml
def negmmml : RV<0x95, (outs VM_:$vmx), (ins VM_:$vmy, I32:$vl),
       "negm $vmx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// NEGM negm negm_MMl
def negmMMl : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy, I32:$vl),
       "# negm $vmx,$vmy", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// PCVM pcvm pcvm_sml
def pcvmsml : RV<0xa4, (outs I64:$sx), (ins VM_:$vmy, I32:$vl),
       "pcvm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// LZVM lzvm lzvm_sml
def lzvmsml : RV<0xa5, (outs I64:$sx), (ins VM_:$vmy, I32:$vl),
       "lzvm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// TOVM tovm tovm_sml
def tovmsml : RV<0xa6, (outs I64:$sx), (ins VM_:$vmy, I32:$vl),
       "tovm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}


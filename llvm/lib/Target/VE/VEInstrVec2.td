// VLDrr vld
def vldvssvl : RV<0x81, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, VLS:$vl),
       "vld $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDir vld
def vldvIsvl : RV<0x81, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, VLS:$vl),
       "vld $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDUrr vldu
def vlduvssvl : RV<0x82, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, VLS:$vl),
       "vldu $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDUir vldu
def vlduvIsvl : RV<0x82, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, VLS:$vl),
       "vldu $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDLsxrr vldl.sx
def vldlsxvssvl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, VLS:$vl),
       "vldl.sx $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDLsxir vldl.sx
def vldlsxvIsvl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, VLS:$vl),
       "vldl.sx $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDLzxrr vldl.zx
def vldlzxvssvl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, VLS:$vl),
       "vldl.zx $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDLzxir vldl.zx
def vldlzxvIsvl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, VLS:$vl),
       "vldl.zx $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLD2Drr vld2d
def vld2dvssvl : RV<0xc1, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, VLS:$vl),
       "vld2d $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLD2Dir vld2d
def vld2dvIsvl : RV<0xc1, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, VLS:$vl),
       "vld2d $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDU2Drr vldu2d
def vldu2dvssvl : RV<0xc2, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, VLS:$vl),
       "vldu2d $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDU2Dir vldu2d
def vldu2dvIsvl : RV<0xc2, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, VLS:$vl),
       "vldu2d $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDL2Dsxrr vldl2d.sx
def vldl2dsxvssvl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, VLS:$vl),
       "vldl2d.sx $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDL2Dsxir vldl2d.sx
def vldl2dsxvIsvl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, VLS:$vl),
       "vldl2d.sx $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDL2Dzxrr vldl2d.zx
def vldl2dzxvssvl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, VLS:$vl),
       "vldl2d.zx $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDL2Dzxir vldl2d.zx
def vldl2dzxvIsvl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, VLS:$vl),
       "vldl2d.zx $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTrr vst
def vstvssl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VLS:$vl),
       "vst $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTir vst
def vstvIsl : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VLS:$vl),
       "vst $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTotrr vst.ot
def vstotvssl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VLS:$vl),
       "vst.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTotrr vst.ot
def vstotvIsl : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VLS:$vl),
       "vst.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTUrr vstu
def vstuvssl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VLS:$vl),
       "vstu $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTUir vstu
def vstuvIsl : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VLS:$vl),
       "vstu $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTUotrr vstu.ot
def vstuotvssl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VLS:$vl),
       "vstu.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTUotrr vstu.ot
def vstuotvIsl : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VLS:$vl),
       "vstu.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTLrr vstl
def vstlvssl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VLS:$vl),
       "vstl $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTLir vstl
def vstlvIsl : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VLS:$vl),
       "vstl $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTLotrr vstl.ot
def vstlotvssl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VLS:$vl),
       "vstl.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTLotrr vstl.ot
def vstlotvIsl : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VLS:$vl),
       "vstl.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VST2Drr vst2d
def vst2dvssl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VLS:$vl),
       "vst2d $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VST2Dir vst2d
def vst2dvIsl : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VLS:$vl),
       "vst2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VST2Dotrr vst2d.ot
def vst2dotvssl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VLS:$vl),
       "vst2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VST2Dotrr vst2d.ot
def vst2dotvIsl : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VLS:$vl),
       "vst2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTU2Drr vstu2d
def vstu2dvssl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VLS:$vl),
       "vstu2d $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTU2Dir vstu2d
def vstu2dvIsl : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VLS:$vl),
       "vstu2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTU2Dotrr vstu2d.ot
def vstu2dotvssl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VLS:$vl),
       "vstu2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTU2Dotrr vstu2d.ot
def vstu2dotvIsl : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VLS:$vl),
       "vstu2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTL2Drr vstl2d
def vstl2dvssl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VLS:$vl),
       "vstl2d $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTL2Dir vstl2d
def vstl2dvIsl : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VLS:$vl),
       "vstl2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTL2Dotrr vstl2d.ot
def vstl2dotvssl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VLS:$vl),
       "vstl2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTL2Dotrr vstl2d.ot
def vstl2dotvIsl : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VLS:$vl),
       "vstl2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// PFCHVr pfchv
def pfchvssl : RV<0x80, (outs ), (ins I64:$sy, I64:$sz, VLS:$vl),
       "pfchv $sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// PFCHVi pfchv
def pfchvIsl : RV<0x80, (outs ), (ins simm7Op64:$I, I64:$sz, VLS:$vl),
       "pfchv $I,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// LSVr lsv

// LVSi64r lvs
def lvssvsl : RV<0x9e, (outs I64:$sx), (ins V64:$vx, I32:$sy, VLS:$vl),
       "lvs $sx,$vx,$sy", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// LVSf64r lvs

// LVSf32r lvs

// LVMr lvm
def lvmmmssl : RV<0xb7, (outs VM:$vmx), (ins VM:$vmd, I64:$sy, I64:$sz, VLS:$vl),
       "lvm $vmx,$vmd,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// LVMi lvm
def lvmmmIsl : RV<0xb7, (outs VM:$vmx), (ins VM:$vmd, simm7Op64:$N, I64:$sz, VLS:$vl),
       "lvm $vmx,$vmd,$N,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// LVMpi lvm
def lvmMMIsl : RV<0xb7, (outs VM512:$vmx), (ins VM512:$vmd, simm7Op64:$N, I64:$sz, VLS:$vl),
       "lvm $vmx,$vmd,$N,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// SVMr svm
def svmsmsl : RV<0xa7, (outs I64:$sx), (ins VM:$vmz, I64:$sy, VLS:$vl),
       "svm $sx,$vmz,$sy", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// SVMi svm
def svmsmIl : RV<0xa7, (outs I64:$sx), (ins VM:$vmz, simm7Op64:$N, VLS:$vl),
       "svm $sx,$vmz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// SVMpi svm
def svmsMIl : RV<0xa7, (outs I64:$sx), (ins VM512:$vmz, simm7Op64:$N, VLS:$vl),
       "svm $sx,$vmz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRDr vbrd
def vbrdvsvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, V64:$vd, VLS:$vl),
       "vbrd $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRDrm vbrd
def vbrdvsmvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, VM:$vm, V64:$vd, VLS:$vl),
       "vbrd $vx,$sy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRDi vbrd
def vbrdvIvl : RV<0x8c, (outs V64:$vx), (ins simm7Op64:$I, V64:$vd, VLS:$vl),
       "vbrd $vx,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRDim vbrd
def vbrdvImvl : RV<0x8c, (outs V64:$vx), (ins simm7Op64:$I, VM:$vm, V64:$vd, VLS:$vl),
       "vbrd $vx,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRDf32r vbrdu
def vbrduvsvl : RV<0x8c, (outs V64:$vx), (ins F32:$sy, V64:$vd, VLS:$vl),
       "vbrdu $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRDf32rm vbrdu
def vbrduvsmvl : RV<0x8c, (outs V64:$vx), (ins F32:$sy, VM:$vm, V64:$vd, VLS:$vl),
       "vbrdu $vx,$sy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRDi32r vbrdl
def vbrdlvsvl : RV<0x8c, (outs V64:$vx), (ins I32:$sy, V64:$vd, VLS:$vl),
       "vbrdl $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRDi32rm vbrdl
def vbrdlvsmvl : RV<0x8c, (outs V64:$vx), (ins I32:$sy, VM:$vm, V64:$vd, VLS:$vl),
       "vbrdl $vx,$sy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRDi32i vbrdl
def vbrdlvIvl : RV<0x8c, (outs V64:$vx), (ins simm7Op64:$I, V64:$vd, VLS:$vl),
       "vbrdl $vx,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRDi32im vbrdl
def vbrdlvImvl : RV<0x8c, (outs V64:$vx), (ins simm7Op64:$I, VM:$vm, V64:$vd, VLS:$vl),
       "vbrdl $vx,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRDp pvbrd
def pvbrdvsvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, V64:$vd, VLS:$vl),
       "pvbrd $vx,$sy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRDpm pvbrd
def pvbrdvsMvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, VM512:$vm, V64:$vd, VLS:$vl),
       "pvbrd $vx,$sy,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMVr vmv
def vmvvsvvl : RV<0x9c, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vmv $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMVi vmv
def vmvvIvvl : RV<0x9c, (outs V64:$vx), (ins simm7Op64:$N, V64:$vz, V64:$vd, VLS:$vl),
       "vmv $vx,$N,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADDlv vaddu.l
def vaddulvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vaddu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADDlr vaddu.l
def vaddulvsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vaddu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADDli vaddu.l
def vaddulvIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vaddu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADDlvm vaddu.l
def vaddulvvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vaddu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADDlrm vaddu.l
def vaddulvsvmvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vaddu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADDlim vaddu.l
def vaddulvIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vaddu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADDwv vaddu.w
def vadduwvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vaddu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADDwr vaddu.w
def vadduwvsvvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vaddu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADDwi vaddu.w
def vadduwvIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vaddu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADDwvm vaddu.w
def vadduwvvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vaddu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADDwrm vaddu.w
def vadduwvsvmvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vaddu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADDwim vaddu.w
def vadduwvIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vaddu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADDpv pvaddu
def pvadduvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvaddu $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADDpr pvaddu
def pvadduvsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvaddu $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADDpvm pvaddu
def pvadduvvvMvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvaddu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADDprm pvaddu
def pvadduvsvMvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvaddu $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADSwsxv vadds.w.sx
def vaddswsxvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vadds.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADSwsxr vadds.w.sx
def vaddswsxvsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vadds.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADSwsxi vadds.w.sx
def vaddswsxvIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vadds.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADSwsxvm vadds.w.sx
def vaddswsxvvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vadds.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADSwsxrm vadds.w.sx
def vaddswsxvsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vadds.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADSwsxim vadds.w.sx
def vaddswsxvIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vadds.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADSwzxv vadds.w.zx
def vaddswzxvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vadds.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADSwzxr vadds.w.zx
def vaddswzxvsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vadds.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADSwzxi vadds.w.zx
def vaddswzxvIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vadds.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADSwzxvm vadds.w.zx
def vaddswzxvvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vadds.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADSwzxrm vadds.w.zx
def vaddswzxvsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vadds.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADSwzxim vadds.w.zx
def vaddswzxvIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vadds.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADSpv pvadds
def pvaddsvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvadds $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADSpr pvadds
def pvaddsvsvvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvadds $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADSpvm pvadds
def pvaddsvvvMvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvadds $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADSprm pvadds
def pvaddsvsvMvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvadds $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADXlv vadds.l
def vaddslvvvvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vadds.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADXlr vadds.l
def vaddslvsvvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vadds.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADXli vadds.l
def vaddslvIvvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vadds.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADXlvm vadds.l
def vaddslvvvmvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vadds.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADXlrm vadds.l
def vaddslvsvmvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vadds.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADXlim vadds.l
def vaddslvIvmvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vadds.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUBlv vsubu.l
def vsubulvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vsubu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUBlr vsubu.l
def vsubulvsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vsubu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUBli vsubu.l
def vsubulvIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vsubu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUBlvm vsubu.l
def vsubulvvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vsubu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUBlrm vsubu.l
def vsubulvsvmvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vsubu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUBlim vsubu.l
def vsubulvIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vsubu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUBwv vsubu.w
def vsubuwvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vsubu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUBwr vsubu.w
def vsubuwvsvvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vsubu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUBwi vsubu.w
def vsubuwvIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vsubu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUBwvm vsubu.w
def vsubuwvvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vsubu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUBwrm vsubu.w
def vsubuwvsvmvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vsubu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUBwim vsubu.w
def vsubuwvIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vsubu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUBpv pvsubu
def pvsubuvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvsubu $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUBpr pvsubu
def pvsubuvsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvsubu $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUBpvm pvsubu
def pvsubuvvvMvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvsubu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUBprm pvsubu
def pvsubuvsvMvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvsubu $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBSwsxv vsubs.w.sx
def vsubswsxvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vsubs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBSwsxr vsubs.w.sx
def vsubswsxvsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vsubs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBSwsxi vsubs.w.sx
def vsubswsxvIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vsubs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBSwsxvm vsubs.w.sx
def vsubswsxvvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vsubs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBSwsxrm vsubs.w.sx
def vsubswsxvsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vsubs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBSwsxim vsubs.w.sx
def vsubswsxvIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vsubs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBSwzxv vsubs.w.zx
def vsubswzxvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vsubs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBSwzxr vsubs.w.zx
def vsubswzxvsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vsubs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBSwzxi vsubs.w.zx
def vsubswzxvIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vsubs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBSwzxvm vsubs.w.zx
def vsubswzxvvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vsubs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBSwzxrm vsubs.w.zx
def vsubswzxvsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vsubs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBSwzxim vsubs.w.zx
def vsubswzxvIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vsubs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBSpv pvsubs
def pvsubsvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvsubs $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBSpr pvsubs
def pvsubsvsvvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvsubs $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBSpvm pvsubs
def pvsubsvvvMvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvsubs $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBSprm pvsubs
def pvsubsvsvMvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvsubs $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBXlv vsubs.l
def vsubslvvvvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vsubs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBXlr vsubs.l
def vsubslvsvvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vsubs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBXli vsubs.l
def vsubslvIvvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vsubs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBXlvm vsubs.l
def vsubslvvvmvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vsubs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBXlrm vsubs.l
def vsubslvsvmvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vsubs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBXlim vsubs.l
def vsubslvIvmvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vsubs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPYlv vmulu.l
def vmululvvvvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vmulu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPYlr vmulu.l
def vmululvsvvl : RV<0xc9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vmulu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPYli vmulu.l
def vmululvIvvl : RV<0xc9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vmulu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPYlvm vmulu.l
def vmululvvvmvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmulu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPYlrm vmulu.l
def vmululvsvmvl : RV<0xc9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmulu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPYlim vmulu.l
def vmululvIvmvl : RV<0xc9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmulu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPYwv vmulu.w
def vmuluwvvvvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vmulu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPYwr vmulu.w
def vmuluwvsvvl : RV<0xc9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vmulu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPYwi vmulu.w
def vmuluwvIvvl : RV<0xc9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vmulu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPYwvm vmulu.w
def vmuluwvvvmvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmulu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPYwrm vmulu.w
def vmuluwvsvmvl : RV<0xc9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmulu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPYwim vmulu.w
def vmuluwvIvmvl : RV<0xc9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmulu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPSwsxv vmuls.w.sx
def vmulswsxvvvvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vmuls.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPSwsxr vmuls.w.sx
def vmulswsxvsvvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vmuls.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPSwsxi vmuls.w.sx
def vmulswsxvIvvl : RV<0xcb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vmuls.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPSwsxvm vmuls.w.sx
def vmulswsxvvvmvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmuls.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPSwsxrm vmuls.w.sx
def vmulswsxvsvmvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmuls.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPSwsxim vmuls.w.sx
def vmulswsxvIvmvl : RV<0xcb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmuls.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPSwzxv vmuls.w.zx
def vmulswzxvvvvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vmuls.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPSwzxr vmuls.w.zx
def vmulswzxvsvvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vmuls.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPSwzxi vmuls.w.zx
def vmulswzxvIvvl : RV<0xcb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vmuls.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPSwzxvm vmuls.w.zx
def vmulswzxvvvmvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmuls.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPSwzxrm vmuls.w.zx
def vmulswzxvsvmvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmuls.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPSwzxim vmuls.w.zx
def vmulswzxvIvmvl : RV<0xcb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmuls.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPXlv vmuls.l
def vmulslvvvvl : RV<0xdb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vmuls.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPXlr vmuls.l
def vmulslvsvvl : RV<0xdb, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vmuls.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPXli vmuls.l
def vmulslvIvvl : RV<0xdb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vmuls.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPXlvm vmuls.l
def vmulslvvvmvl : RV<0xdb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmuls.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPXlrm vmuls.l
def vmulslvsvmvl : RV<0xdb, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmuls.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPXlim vmuls.l
def vmulslvIvmvl : RV<0xdb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmuls.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPDv vmuls.l.w
def vmulslwvvvvl : RV<0xd9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vmuls.l.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPDr vmuls.l.w
def vmulslwvsvvl : RV<0xd9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vmuls.l.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPDi vmuls.l.w
def vmulslwvIvvl : RV<0xd9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vmuls.l.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVlv vdivu.l
def vdivulvvvvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vdivu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVlr vdivu.l
def vdivulvsvvl : RV<0xe9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vdivu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVli vdivu.l
def vdivulvIvvl : RV<0xe9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vdivu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVlvm vdivu.l
def vdivulvvvmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vdivu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVlrm vdivu.l
def vdivulvsvmvl : RV<0xe9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vdivu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVlim vdivu.l
def vdivulvIvmvl : RV<0xe9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vdivu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVwv vdivu.w
def vdivuwvvvvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vdivu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVwr vdivu.w
def vdivuwvsvvl : RV<0xe9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vdivu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVwi vdivu.w
def vdivuwvIvvl : RV<0xe9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vdivu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVwvm vdivu.w
def vdivuwvvvmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vdivu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVwrm vdivu.w
def vdivuwvsvmvl : RV<0xe9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vdivu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVwim vdivu.w
def vdivuwvIvmvl : RV<0xe9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vdivu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVlr2 vdivu.l
def vdivulvvsvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vd, VLS:$vl),
       "vdivu.l $vx,$vy,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVli2 vdivu.l
def vdivulvvIvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, V64:$vd, VLS:$vl),
       "vdivu.l $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVlrm2 vdivu.l
def vdivulvvsmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I64:$sy, VM:$vm, V64:$vd, VLS:$vl),
       "vdivu.l $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVlim2 vdivu.l
def vdivulvvImvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, VM:$vm, V64:$vd, VLS:$vl),
       "vdivu.l $vx,$vy,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVwr2 vdivu.w
def vdivuwvvsvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I32:$sy, V64:$vd, VLS:$vl),
       "vdivu.w $vx,$vy,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVwi2 vdivu.w
def vdivuwvvIvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, V64:$vd, VLS:$vl),
       "vdivu.w $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVwrm2 vdivu.w
def vdivuwvvsmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM:$vm, V64:$vd, VLS:$vl),
       "vdivu.w $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIVwim2 vdivu.w
def vdivuwvvImvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, VM:$vm, V64:$vd, VLS:$vl),
       "vdivu.w $vx,$vy,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwsxv vdivs.w.sx
def vdivswsxvvvvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vdivs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwsxr vdivs.w.sx
def vdivswsxvsvvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vdivs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwsxi vdivs.w.sx
def vdivswsxvIvvl : RV<0xeb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vdivs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwsxvm vdivs.w.sx
def vdivswsxvvvmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vdivs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwsxrm vdivs.w.sx
def vdivswsxvsvmvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vdivs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwsxim vdivs.w.sx
def vdivswsxvIvmvl : RV<0xeb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vdivs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwzxv vdivs.w.zx
def vdivswzxvvvvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vdivs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwzxr vdivs.w.zx
def vdivswzxvsvvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vdivs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwzxi vdivs.w.zx
def vdivswzxvIvvl : RV<0xeb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vdivs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwzxvm vdivs.w.zx
def vdivswzxvvvmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vdivs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwzxrm vdivs.w.zx
def vdivswzxvsvmvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vdivs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwzxim vdivs.w.zx
def vdivswzxvIvmvl : RV<0xeb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vdivs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwsxr2 vdivs.w.sx
def vdivswsxvvsvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, V64:$vd, VLS:$vl),
       "vdivs.w.sx $vx,$vy,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwsxi2 vdivs.w.sx
def vdivswsxvvIvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, V64:$vd, VLS:$vl),
       "vdivs.w.sx $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwsxrm2 vdivs.w.sx
def vdivswsxvvsmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM:$vm, V64:$vd, VLS:$vl),
       "vdivs.w.sx $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwsxim2 vdivs.w.sx
def vdivswsxvvImvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, VM:$vm, V64:$vd, VLS:$vl),
       "vdivs.w.sx $vx,$vy,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwzxr2 vdivs.w.zx
def vdivswzxvvsvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, V64:$vd, VLS:$vl),
       "vdivs.w.zx $vx,$vy,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwzxi2 vdivs.w.zx
def vdivswzxvvIvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, V64:$vd, VLS:$vl),
       "vdivs.w.zx $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwzxrm2 vdivs.w.zx
def vdivswzxvvsmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM:$vm, V64:$vd, VLS:$vl),
       "vdivs.w.zx $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVSwzxim2 vdivs.w.zx
def vdivswzxvvImvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, VM:$vm, V64:$vd, VLS:$vl),
       "vdivs.w.zx $vx,$vy,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVXlv vdivs.l
def vdivslvvvvl : RV<0xfb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vdivs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVXlr vdivs.l
def vdivslvsvvl : RV<0xfb, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vdivs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVXli vdivs.l
def vdivslvIvvl : RV<0xfb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vdivs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVXlvm vdivs.l
def vdivslvvvmvl : RV<0xfb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vdivs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVXlrm vdivs.l
def vdivslvsvmvl : RV<0xfb, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vdivs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVXlim vdivs.l
def vdivslvIvmvl : RV<0xfb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vdivs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVXlr2 vdivs.l
def vdivslvvsvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vd, VLS:$vl),
       "vdivs.l $vx,$vy,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVXli2 vdivs.l
def vdivslvvIvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, V64:$vd, VLS:$vl),
       "vdivs.l $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVXlrm2 vdivs.l
def vdivslvvsmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I64:$sy, VM:$vm, V64:$vd, VLS:$vl),
       "vdivs.l $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVXlim2 vdivs.l
def vdivslvvImvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, VM:$vm, V64:$vd, VLS:$vl),
       "vdivs.l $vx,$vy,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMPlv vcmpu.l
def vcmpulvvvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vcmpu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMPlr vcmpu.l
def vcmpulvsvvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vcmpu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMPli vcmpu.l
def vcmpulvIvvl : RV<0xb9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vcmpu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMPlvm vcmpu.l
def vcmpulvvvmvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vcmpu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMPlrm vcmpu.l
def vcmpulvsvmvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vcmpu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMPlim vcmpu.l
def vcmpulvIvmvl : RV<0xb9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vcmpu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMPwv vcmpu.w
def vcmpuwvvvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vcmpu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMPwr vcmpu.w
def vcmpuwvsvvl : RV<0xb9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vcmpu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMPwi vcmpu.w
def vcmpuwvIvvl : RV<0xb9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vcmpu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMPwvm vcmpu.w
def vcmpuwvvvmvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vcmpu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMPwrm vcmpu.w
def vcmpuwvsvmvl : RV<0xb9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vcmpu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMPwim vcmpu.w
def vcmpuwvIvmvl : RV<0xb9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vcmpu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMPpv pvcmpu
def pvcmpuvvvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvcmpu $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMPpr pvcmpu
def pvcmpuvsvvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvcmpu $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMPpvm pvcmpu
def pvcmpuvvvMvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvcmpu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMPprm pvcmpu
def pvcmpuvsvMvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvcmpu $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPSwsxv vcmps.w.sx
def vcmpswsxvvvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vcmps.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPSwsxr vcmps.w.sx
def vcmpswsxvsvvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vcmps.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPSwsxi vcmps.w.sx
def vcmpswsxvIvvl : RV<0xfa, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vcmps.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPSwsxvm vcmps.w.sx
def vcmpswsxvvvmvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vcmps.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPSwsxrm vcmps.w.sx
def vcmpswsxvsvmvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vcmps.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPSwsxim vcmps.w.sx
def vcmpswsxvIvmvl : RV<0xfa, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vcmps.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPSwzxv vcmps.w.zx
def vcmpswzxvvvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vcmps.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPSwzxr vcmps.w.zx
def vcmpswzxvsvvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vcmps.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPSwzxi vcmps.w.zx
def vcmpswzxvIvvl : RV<0xfa, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vcmps.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPSwzxvm vcmps.w.zx
def vcmpswzxvvvmvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vcmps.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPSwzxrm vcmps.w.zx
def vcmpswzxvsvmvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vcmps.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPSwzxim vcmps.w.zx
def vcmpswzxvIvmvl : RV<0xfa, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vcmps.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPSpv pvcmps
def pvcmpsvvvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvcmps $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPSpr pvcmps
def pvcmpsvsvvl : RV<0xfa, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvcmps $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPSpvm pvcmps
def pvcmpsvvvMvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvcmps $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPSprm pvcmps
def pvcmpsvsvMvl : RV<0xfa, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvcmps $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPXlv vcmps.l
def vcmpslvvvvl : RV<0xba, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vcmps.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPXlr vcmps.l
def vcmpslvsvvl : RV<0xba, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vcmps.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPXli vcmps.l
def vcmpslvIvvl : RV<0xba, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vcmps.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPXlvm vcmps.l
def vcmpslvvvmvl : RV<0xba, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vcmps.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPXlrm vcmps.l
def vcmpslvsvmvl : RV<0xba, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vcmps.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPXlim vcmps.l
def vcmpslvIvmvl : RV<0xba, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vcmps.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSawsxv vmaxs.w.sx
def vmaxswsxvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vmaxs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSawsxr vmaxs.w.sx
def vmaxswsxvsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vmaxs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSawsxi vmaxs.w.sx
def vmaxswsxvIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vmaxs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSawsxvm vmaxs.w.sx
def vmaxswsxvvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmaxs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSawsxrm vmaxs.w.sx
def vmaxswsxvsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmaxs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSawsxim vmaxs.w.sx
def vmaxswsxvIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmaxs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSawzxv vmaxs.w.zx
def vmaxswzxvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vmaxs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSawzxr vmaxs.w.zx
def vmaxswzxvsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vmaxs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSawzxi vmaxs.w.zx
def vmaxswzxvIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vmaxs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSawzxvm vmaxs.w.zx
def vmaxswzxvvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmaxs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSawzxrm vmaxs.w.zx
def vmaxswzxvsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmaxs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSawzxim vmaxs.w.zx
def vmaxswzxvIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmaxs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSapv pvmaxs
def pvmaxsvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvmaxs $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSapr pvmaxs
def pvmaxsvsvvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvmaxs $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSapvm pvmaxs
def pvmaxsvvvMvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvmaxs $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSaprm pvmaxs
def pvmaxsvsvMvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvmaxs $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSiwsxv vmins.w.sx
def vminswsxvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vmins.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSiwsxr vmins.w.sx
def vminswsxvsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vmins.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSiwsxi vmins.w.sx
def vminswsxvIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vmins.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSiwsxvm vmins.w.sx
def vminswsxvvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmins.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSiwsxrm vmins.w.sx
def vminswsxvsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmins.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSiwsxim vmins.w.sx
def vminswsxvIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmins.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSiwzxv vmins.w.zx
def vminswzxvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vmins.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSiwzxr vmins.w.zx
def vminswzxvsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vmins.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSiwzxi vmins.w.zx
def vminswzxvIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vmins.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSiwzxvm vmins.w.zx
def vminswzxvvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmins.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSiwzxrm vmins.w.zx
def vminswzxvsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmins.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSiwzxim vmins.w.zx
def vminswzxvIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmins.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSipv pvmins
def pvminsvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvmins $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSipr pvmins
def pvminsvsvvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvmins $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSipvm pvmins
def pvminsvvvMvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvmins $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMSiprm pvmins
def pvminsvsvMvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvmins $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMXalv vmaxs.l
def vmaxslvvvvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vmaxs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMXalr vmaxs.l
def vmaxslvsvvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vmaxs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMXali vmaxs.l
def vmaxslvIvvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vmaxs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMXalvm vmaxs.l
def vmaxslvvvmvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmaxs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMXalrm vmaxs.l
def vmaxslvsvmvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmaxs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMXalim vmaxs.l
def vmaxslvIvmvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmaxs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMXilv vmins.l
def vminslvvvvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vmins.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMXilr vmins.l
def vminslvsvvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vmins.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMXili vmins.l
def vminslvIvvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, VLS:$vl),
       "vmins.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMXilvm vmins.l
def vminslvvvmvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmins.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMXilrm vmins.l
def vminslvsvmvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmins.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMXilim vmins.l
def vminslvIvmvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmins.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VANDv vand
def vandvvvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vand $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VANDr vand
def vandvsvvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vand $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VANDvm vand
def vandvvvmvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vand $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VANDrm vand
def vandvsvmvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vand $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VANDpv pvand
def pvandvvvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvand $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VANDpr pvand
def pvandvsvvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvand $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VANDpvm pvand
def pvandvvvMvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvand $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VANDprm pvand
def pvandvsvMvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvand $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VORv vor
def vorvvvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VORr vor
def vorvsvvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VORvm vor
def vorvvvmvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VORrm vor
def vorvsvmvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VORpv pvor
def pvorvvvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvor $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VORpr pvor
def pvorvsvvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvor $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VORpvm pvor
def pvorvvvMvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VORprm pvor
def pvorvsvMvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VXORv vxor
def vxorvvvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vxor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VXORr vxor
def vxorvsvvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vxor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VXORvm vxor
def vxorvvvmvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vxor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VXORrm vxor
def vxorvsvmvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vxor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VXORpv pvxor
def pvxorvvvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvxor $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VXORpr pvxor
def pvxorvsvvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvxor $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VXORpvm pvxor
def pvxorvvvMvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvxor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VXORprm pvxor
def pvxorvsvMvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvxor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VEQVv veqv
def veqvvvvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "veqv $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VEQVr veqv
def veqvvsvvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "veqv $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VEQVvm veqv
def veqvvvvmvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "veqv $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VEQVrm veqv
def veqvvsvmvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "veqv $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VEQVpv pveqv
def pveqvvvvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pveqv $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VEQVpr pveqv
def pveqvvsvvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pveqv $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VEQVpvm pveqv
def pveqvvvvMvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pveqv $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VEQVprm pveqv
def pveqvvsvMvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pveqv $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSEQv vseq
def vseqvvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, VLS:$vl),
       "vseq $vx", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSEQlv pvseq.lo
def pvseqlovvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, VLS:$vl),
       "pvseq.lo $vx", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSEQuv pvseq.up
def pvsequpvvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, VLS:$vl),
       "pvseq.up $vx", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSEQpv pvseq
def pvseqvvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, VLS:$vl),
       "pvseq $vx", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLLv vsll
def vsllvvvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, VLS:$vl),
       "vsll $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLLr2 vsll
def vsllvvsvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, VLS:$vl),
       "vsll $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLLi2 vsll
def vsllvvIvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, VLS:$vl),
       "vsll $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLLvm vsll
def vsllvvvmvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vsll $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLLrm2 vsll
def vsllvvsmvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, V64:$vd, VLS:$vl),
       "vsll $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLLim2 vsll
def vsllvvImvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM:$vm, V64:$vd, VLS:$vl),
       "vsll $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLLpv pvsll
def pvsllvvvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, VLS:$vl),
       "pvsll $vx,$vz,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLLpr2 pvsll
def pvsllvvsvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, VLS:$vl),
       "pvsll $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLLpvm pvsll
def pvsllvvvMvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, V64:$vd, VLS:$vl),
       "pvsll $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLLprm2 pvsll
def pvsllvvsMvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, V64:$vd, VLS:$vl),
       "pvsll $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRLv vsrl
def vsrlvvvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, VLS:$vl),
       "vsrl $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRLr2 vsrl
def vsrlvvsvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, VLS:$vl),
       "vsrl $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRLi2 vsrl
def vsrlvvIvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, VLS:$vl),
       "vsrl $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRLvm vsrl
def vsrlvvvmvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vsrl $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRLrm2 vsrl
def vsrlvvsmvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, V64:$vd, VLS:$vl),
       "vsrl $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRLim2 vsrl
def vsrlvvImvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM:$vm, V64:$vd, VLS:$vl),
       "vsrl $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRLpv pvsrl
def pvsrlvvvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, VLS:$vl),
       "pvsrl $vx,$vz,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRLpr2 pvsrl
def pvsrlvvsvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, VLS:$vl),
       "pvsrl $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRLpvm pvsrl
def pvsrlvvvMvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, V64:$vd, VLS:$vl),
       "pvsrl $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRLprm2 pvsrl
def pvsrlvvsMvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, V64:$vd, VLS:$vl),
       "pvsrl $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAv vsla.w
def vslawvvvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, VLS:$vl),
       "vsla.w $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAr2 vsla.w
def vslawvvsvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, VLS:$vl),
       "vsla.w $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAi2 vsla.w
def vslawvvIvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, VLS:$vl),
       "vsla.w $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAvm vsla.w
def vslawvvvmvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vsla.w $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLArm2 vsla.w
def vslawvvsmvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, V64:$vd, VLS:$vl),
       "vsla.w $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAim2 vsla.w
def vslawvvImvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM:$vm, V64:$vd, VLS:$vl),
       "vsla.w $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLApv pvsla
def pvslavvvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, VLS:$vl),
       "pvsla $vx,$vz,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLApr2 pvsla
def pvslavvsvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, VLS:$vl),
       "pvsla $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLApvm pvsla
def pvslavvvMvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, V64:$vd, VLS:$vl),
       "pvsla $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAprm2 pvsla
def pvslavvsMvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, V64:$vd, VLS:$vl),
       "pvsla $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAXv vsla.l
def vslalvvvvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, VLS:$vl),
       "vsla.l $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAXr2 vsla.l
def vslalvvsvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, VLS:$vl),
       "vsla.l $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAXi2 vsla.l
def vslalvvIvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, VLS:$vl),
       "vsla.l $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAXvm vsla.l
def vslalvvvmvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vsla.l $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAXrm2 vsla.l
def vslalvvsmvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, V64:$vd, VLS:$vl),
       "vsla.l $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAXim2 vsla.l
def vslalvvImvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM:$vm, V64:$vd, VLS:$vl),
       "vsla.l $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAv vsra.w
def vsrawvvvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, VLS:$vl),
       "vsra.w $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAr2 vsra.w
def vsrawvvsvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, VLS:$vl),
       "vsra.w $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAi2 vsra.w
def vsrawvvIvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, VLS:$vl),
       "vsra.w $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAvm vsra.w
def vsrawvvvmvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vsra.w $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRArm2 vsra.w
def vsrawvvsmvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, V64:$vd, VLS:$vl),
       "vsra.w $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAim2 vsra.w
def vsrawvvImvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM:$vm, V64:$vd, VLS:$vl),
       "vsra.w $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRApv pvsra
def pvsravvvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, VLS:$vl),
       "pvsra $vx,$vz,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRApr2 pvsra
def pvsravvsvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, VLS:$vl),
       "pvsra $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRApvm pvsra
def pvsravvvMvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, V64:$vd, VLS:$vl),
       "pvsra $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAprm2 pvsra
def pvsravvsMvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, V64:$vd, VLS:$vl),
       "pvsra $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAXv vsra.l
def vsralvvvvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, VLS:$vl),
       "vsra.l $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAXr2 vsra.l
def vsralvvsvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, VLS:$vl),
       "vsra.l $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAXi2 vsra.l
def vsralvvIvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, VLS:$vl),
       "vsra.l $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAXvm vsra.l
def vsralvvvmvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vsra.l $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAXrm2 vsra.l
def vsralvvsmvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, V64:$vd, VLS:$vl),
       "vsra.l $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAXim2 vsra.l
def vsralvvImvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM:$vm, V64:$vd, VLS:$vl),
       "vsra.l $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSFAr vsfa
def vsfavvssvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, V64:$vd, VLS:$vl),
       "vsfa $vx,$vz,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSFAi vsfa
def vsfavvIsvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, simm7Op64:$I, I64:$sz, V64:$vd, VLS:$vl),
       "vsfa $vx,$vz,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSFArm vsfa
def vsfavvssmvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, VM:$vm, V64:$vd, VLS:$vl),
       "vsfa $vx,$vz,$sy,$sz,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSFAim vsfa
def vsfavvIsmvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, simm7Op64:$I, I64:$sz, VM:$vm, V64:$vd, VLS:$vl),
       "vsfa $vx,$vz,$I,$sz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFADdv vfadd.d
def vfadddvvvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vfadd.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFADdr vfadd.d
def vfadddvsvvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vfadd.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFADdvm vfadd.d
def vfadddvvvmvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfadd.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFADdrm vfadd.d
def vfadddvsvmvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfadd.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFADsv vfadd.s
def vfaddsvvvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vfadd.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFADsr vfadd.s
def vfaddsvsvvl : RV<0xcc, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vfadd.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFADsvm vfadd.s
def vfaddsvvvmvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfadd.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFADsrm vfadd.s
def vfaddsvsvmvl : RV<0xcc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfadd.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFADpv pvfadd
def pvfaddvvvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvfadd $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFADpr pvfadd
def pvfaddvsvvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvfadd $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFADpvm pvfadd
def pvfaddvvvMvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfadd $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFADprm pvfadd
def pvfaddvsvMvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfadd $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSBdv vfsub.d
def vfsubdvvvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vfsub.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSBdr vfsub.d
def vfsubdvsvvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vfsub.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSBdvm vfsub.d
def vfsubdvvvmvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfsub.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSBdrm vfsub.d
def vfsubdvsvmvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfsub.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSBsv vfsub.s
def vfsubsvvvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vfsub.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSBsr vfsub.s
def vfsubsvsvvl : RV<0xdc, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vfsub.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSBsvm vfsub.s
def vfsubsvvvmvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfsub.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSBsrm vfsub.s
def vfsubsvsvmvl : RV<0xdc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfsub.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSBpv pvfsub
def pvfsubvvvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvfsub $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSBpr pvfsub
def pvfsubvsvvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvfsub $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSBpvm pvfsub
def pvfsubvvvMvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfsub $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSBprm pvfsub
def pvfsubvsvMvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfsub $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMPdv vfmul.d
def vfmuldvvvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vfmul.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMPdr vfmul.d
def vfmuldvsvvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vfmul.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMPdvm vfmul.d
def vfmuldvvvmvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfmul.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMPdrm vfmul.d
def vfmuldvsvmvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfmul.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMPsv vfmul.s
def vfmulsvvvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vfmul.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMPsr vfmul.s
def vfmulsvsvvl : RV<0xcd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vfmul.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMPsvm vfmul.s
def vfmulsvvvmvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfmul.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMPsrm vfmul.s
def vfmulsvsvmvl : RV<0xcd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfmul.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMPpv pvfmul
def pvfmulvvvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvfmul $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMPpr pvfmul
def pvfmulvsvvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvfmul $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMPpvm pvfmul
def pvfmulvvvMvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfmul $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMPprm pvfmul
def pvfmulvsvMvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfmul $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFDVdv vfdiv.d
def vfdivdvvvvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vfdiv.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFDVdr vfdiv.d
def vfdivdvsvvl : RV<0xdd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vfdiv.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFDVdvm vfdiv.d
def vfdivdvvvmvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfdiv.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFDVdrm vfdiv.d
def vfdivdvsvmvl : RV<0xdd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfdiv.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFDVsv vfdiv.s
def vfdivsvvvvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vfdiv.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFDVsr vfdiv.s
def vfdivsvsvvl : RV<0xdd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vfdiv.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFDVsvm vfdiv.s
def vfdivsvvvmvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfdiv.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFDVsrm vfdiv.s
def vfdivsvsvmvl : RV<0xdd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfdiv.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSQRTdv vfsqrt.d
def vfsqrtdvvvl : RV<0xed, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vfsqrt.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSQRTsv vfsqrt.s
def vfsqrtsvvvl : RV<0xed, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vfsqrt.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCPdv vfcmp.d
def vfcmpdvvvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vfcmp.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCPdr vfcmp.d
def vfcmpdvsvvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vfcmp.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCPdvm vfcmp.d
def vfcmpdvvvmvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfcmp.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCPdrm vfcmp.d
def vfcmpdvsvmvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfcmp.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCPsv vfcmp.s
def vfcmpsvvvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vfcmp.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCPsr vfcmp.s
def vfcmpsvsvvl : RV<0xfc, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vfcmp.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCPsvm vfcmp.s
def vfcmpsvvvmvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfcmp.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCPsrm vfcmp.s
def vfcmpsvsvmvl : RV<0xfc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfcmp.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCPpv pvfcmp
def pvfcmpvvvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvfcmp $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCPpr pvfcmp
def pvfcmpvsvvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvfcmp $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCPpvm pvfcmp
def pvfcmpvvvMvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfcmp $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCPprm pvfcmp
def pvfcmpvsvMvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfcmp $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMadv vfmax.d
def vfmaxdvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vfmax.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMadr vfmax.d
def vfmaxdvsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vfmax.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMadvm vfmax.d
def vfmaxdvvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfmax.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMadrm vfmax.d
def vfmaxdvsvmvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfmax.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMasv vfmax.s
def vfmaxsvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vfmax.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMasr vfmax.s
def vfmaxsvsvvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vfmax.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMasvm vfmax.s
def vfmaxsvvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfmax.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMasrm vfmax.s
def vfmaxsvsvmvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfmax.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMapv pvfmax
def pvfmaxvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvfmax $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMapr pvfmax
def pvfmaxvsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvfmax $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMapvm pvfmax
def pvfmaxvvvMvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfmax $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMaprm pvfmax
def pvfmaxvsvMvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfmax $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMidv vfmin.d
def vfmindvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vfmin.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMidr vfmin.d
def vfmindvsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vfmin.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMidvm vfmin.d
def vfmindvvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfmin.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMidrm vfmin.d
def vfmindvsvmvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfmin.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMisv vfmin.s
def vfminsvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "vfmin.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMisr vfmin.s
def vfminsvsvvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "vfmin.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMisvm vfmin.s
def vfminsvvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfmin.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMisrm vfmin.s
def vfminsvsvmvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vfmin.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMipv pvfmin
def pvfminvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, VLS:$vl),
       "pvfmin $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMipr pvfmin
def pvfminvsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, VLS:$vl),
       "pvfmin $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMipvm pvfmin
def pvfminvvvMvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfmin $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCMiprm pvfmin
def pvfminvsvMvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfmin $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADdv vfmad.d
def vfmaddvvvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "vfmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADdr vfmad.d
def vfmaddvsvvvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "vfmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADdr2 vfmad.d
def vfmaddvvsvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, VLS:$vl),
       "vfmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADdvm vfmad.d
def vfmaddvvvvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfmad.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADdrm vfmad.d
def vfmaddvsvvmvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfmad.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADdr2m vfmad.d
def vfmaddvvsvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfmad.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADsv vfmad.s
def vfmadsvvvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "vfmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADsr vfmad.s
def vfmadsvsvvvl : RV<0xe2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "vfmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADsr2 vfmad.s
def vfmadsvvsvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, VLS:$vl),
       "vfmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADsvm vfmad.s
def vfmadsvvvvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfmad.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADsrm vfmad.s
def vfmadsvsvvmvl : RV<0xe2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfmad.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADsr2m vfmad.s
def vfmadsvvsvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfmad.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADpv pvfmad
def pvfmadvvvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "pvfmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADpr pvfmad
def pvfmadvsvvvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "pvfmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADpr2 pvfmad
def pvfmadvvsvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, VLS:$vl),
       "pvfmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADpvm pvfmad
def pvfmadvvvvMvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfmad $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADprm pvfmad
def pvfmadvsvvMvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfmad $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMADpr2m pvfmad
def pvfmadvvsvMvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfmad $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBdv vfmsb.d
def vfmsbdvvvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "vfmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBdr vfmsb.d
def vfmsbdvsvvvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "vfmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBdr2 vfmsb.d
def vfmsbdvvsvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, VLS:$vl),
       "vfmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBdvm vfmsb.d
def vfmsbdvvvvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfmsb.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBdrm vfmsb.d
def vfmsbdvsvvmvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfmsb.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBdr2m vfmsb.d
def vfmsbdvvsvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfmsb.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBsv vfmsb.s
def vfmsbsvvvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "vfmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBsr vfmsb.s
def vfmsbsvsvvvl : RV<0xf2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "vfmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBsr2 vfmsb.s
def vfmsbsvvsvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, VLS:$vl),
       "vfmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBsvm vfmsb.s
def vfmsbsvvvvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfmsb.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBsrm vfmsb.s
def vfmsbsvsvvmvl : RV<0xf2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfmsb.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBsr2m vfmsb.s
def vfmsbsvvsvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfmsb.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBpv pvfmsb
def pvfmsbvvvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "pvfmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBpr pvfmsb
def pvfmsbvsvvvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "pvfmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBpr2 pvfmsb
def pvfmsbvvsvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, VLS:$vl),
       "pvfmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBpvm pvfmsb
def pvfmsbvvvvMvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfmsb $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBprm pvfmsb
def pvfmsbvsvvMvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfmsb $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSBpr2m pvfmsb
def pvfmsbvvsvMvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfmsb $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADdv vfnmad.d
def vfnmaddvvvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "vfnmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADdr vfnmad.d
def vfnmaddvsvvvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "vfnmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADdr2 vfnmad.d
def vfnmaddvvsvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, VLS:$vl),
       "vfnmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADdvm vfnmad.d
def vfnmaddvvvvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfnmad.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADdrm vfnmad.d
def vfnmaddvsvvmvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfnmad.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADdr2m vfnmad.d
def vfnmaddvvsvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfnmad.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADsv vfnmad.s
def vfnmadsvvvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "vfnmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADsr vfnmad.s
def vfnmadsvsvvvl : RV<0xe3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "vfnmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADsr2 vfnmad.s
def vfnmadsvvsvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, VLS:$vl),
       "vfnmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADsvm vfnmad.s
def vfnmadsvvvvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfnmad.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADsrm vfnmad.s
def vfnmadsvsvvmvl : RV<0xe3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfnmad.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADsr2m vfnmad.s
def vfnmadsvvsvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfnmad.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADpv pvfnmad
def pvfnmadvvvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "pvfnmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADpr pvfnmad
def pvfnmadvsvvvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "pvfnmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADpr2 pvfnmad
def pvfnmadvvsvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, VLS:$vl),
       "pvfnmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADpvm pvfnmad
def pvfnmadvvvvMvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfnmad $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADprm pvfnmad
def pvfnmadvsvvMvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfnmad $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMADpr2m pvfnmad
def pvfnmadvvsvMvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfnmad $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBdv vfnmsb.d
def vfnmsbdvvvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "vfnmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBdr vfnmsb.d
def vfnmsbdvsvvvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "vfnmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBdr2 vfnmsb.d
def vfnmsbdvvsvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, VLS:$vl),
       "vfnmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBdvm vfnmsb.d
def vfnmsbdvvvvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfnmsb.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBdrm vfnmsb.d
def vfnmsbdvsvvmvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfnmsb.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBdr2m vfnmsb.d
def vfnmsbdvvsvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfnmsb.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBsv vfnmsb.s
def vfnmsbsvvvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "vfnmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBsr vfnmsb.s
def vfnmsbsvsvvvl : RV<0xf3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "vfnmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBsr2 vfnmsb.s
def vfnmsbsvvsvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, VLS:$vl),
       "vfnmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBsvm vfnmsb.s
def vfnmsbsvvvvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfnmsb.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBsrm vfnmsb.s
def vfnmsbsvsvvmvl : RV<0xf3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfnmsb.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBsr2m vfnmsb.s
def vfnmsbsvvsvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM:$vm, V64:$vd, VLS:$vl),
       "vfnmsb.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBpv pvfnmsb
def pvfnmsbvvvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "pvfnmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBpr pvfnmsb
def pvfnmsbvsvvvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, VLS:$vl),
       "pvfnmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBpr2 pvfnmsb
def pvfnmsbvvsvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, VLS:$vl),
       "pvfnmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBpvm pvfnmsb
def pvfnmsbvvvvMvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfnmsb $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBprm pvfnmsb
def pvfnmsbvsvvMvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfnmsb $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSBpr2m pvfnmsb
def pvfnmsbvvsvMvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512:$vm, V64:$vd, VLS:$vl),
       "pvfnmsb $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VRCPdv vrcp.d
def vrcpdvvvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vrcp.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VRCPsv vrcp.s
def vrcpsvvvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vrcp.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VRCPpv pvrcp
def pvrcpvvvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "pvrcp $vx,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VRSQRTdv vrsqrt.d
def vrsqrtdvvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vrsqrt.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VRSQRTsv vrsqrt.s
def vrsqrtsvvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vrsqrt.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VRSQRTpv pvrsqrt
def pvrsqrtvvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "pvrsqrt $vx,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXdsxv vcvt.w.d.sx
def vcvtwdsxvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vcvt.w.d.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXdsxvm vcvt.w.d.sx
def vcvtwdsxvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vcvt.w.d.sx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXdsxrzv vcvt.w.d.sx.rz
def vcvtwdsxrzvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vcvt.w.d.sx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXdsxrzvm vcvt.w.d.sx.rz
def vcvtwdsxrzvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vcvt.w.d.sx.rz $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXdzxv vcvt.w.d.zx
def vcvtwdzxvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vcvt.w.d.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXdzxvm vcvt.w.d.zx
def vcvtwdzxvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vcvt.w.d.zx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXdzxrzv vcvt.w.d.zx.rz
def vcvtwdzxrzvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vcvt.w.d.zx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXdzxrzvm vcvt.w.d.zx.rz
def vcvtwdzxrzvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vcvt.w.d.zx.rz $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXssxv vcvt.w.s.sx
def vcvtwssxvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vcvt.w.s.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXssxvm vcvt.w.s.sx
def vcvtwssxvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vcvt.w.s.sx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXssxrzv vcvt.w.s.sx.rz
def vcvtwssxrzvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vcvt.w.s.sx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXssxrzvm vcvt.w.s.sx.rz
def vcvtwssxrzvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vcvt.w.s.sx.rz $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXszxv vcvt.w.s.zx
def vcvtwszxvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vcvt.w.s.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXszxvm vcvt.w.s.zx
def vcvtwszxvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vcvt.w.s.zx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXszxrzv vcvt.w.s.zx.rz
def vcvtwszxrzvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vcvt.w.s.zx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXszxrzvm vcvt.w.s.zx.rz
def vcvtwszxrzvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vcvt.w.s.zx.rz $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXpv pvcvt.w.s
def pvcvtwsvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "pvcvt.w.s $vx,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXpvm pvcvt.w.s
def pvcvtwsvvMvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM512:$vm, V64:$vd, VLS:$vl),
       "pvcvt.w.s $vx,$vy,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXprzv pvcvt.w.s.rz
def pvcvtwsrzvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "pvcvt.w.s.rz $vx,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXprzvm pvcvt.w.s.rz
def pvcvtwsrzvvMvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM512:$vm, V64:$vd, VLS:$vl),
       "pvcvt.w.s.rz $vx,$vy,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXXv vcvt.l.d
def vcvtldvvvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vcvt.l.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXXvm vcvt.l.d
def vcvtldvvmvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vcvt.l.d $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXXrzv vcvt.l.d.rz
def vcvtldrzvvvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vcvt.l.d.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXXrzvm vcvt.l.d.rz
def vcvtldrzvvmvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vcvt.l.d.rz $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFLTdv vcvt.d.w
def vcvtdwvvvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vcvt.d.w $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFLTsv vcvt.s.w
def vcvtswvvvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vcvt.s.w $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFLTpv pvcvt.s.w
def pvcvtswvvvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "pvcvt.s.w $vx,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFLTXv vcvt.d.l
def vcvtdlvvvl : RV<0xb8, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vcvt.d.l $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCVDv vcvt.d.s
def vcvtdsvvvl : RV<0x8f, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vcvt.d.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCVSv vcvt.s.d
def vcvtsdvvvl : RV<0x9f, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vcvt.s.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMRGvm vmrg
def vmrgvvvmvl : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vmrg $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMRGpvm vmrg.w
def vmrgwvvvMvl : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, VLS:$vl),
       "vmrg.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSHFr vshf
def vshfvvvsvl : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I64:$sy, V64:$vd, VLS:$vl),
       "vshf $vx,$vy,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSHFi vshf
def vshfvvvIvl : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, simm7Op64:$N, V64:$vd, VLS:$vl),
       "vshf $vx,$vy,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPvm vcp
def vcpvvmvl : RV<0x8d, (outs V64:$vx), (ins V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vcp $vx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VEXvm vex
def vexvvmvl : RV<0x9d, (outs V64:$vx), (ins V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
       "vex $vx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMKv vfmk.l
def vfmklmcvl : RV<0xb4, (outs VM:$vm), (ins CCOp:$cc, V64:$vz, VLS:$vl),
       "vfmk.l $vm,$cc,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMKvm vfmk.l
def vfmklmcvml : RV<0xb4, (outs VM:$vmx), (ins CCOp:$cc, V64:$vz, VM:$vm, VLS:$vl),
       "vfmk.l $vmx,$cc,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMKat vfmk.at
def vfmkatml : RV<0xb4, (outs VM:$vm), (ins VLS:$vl),
       "vfmk.at $vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMKaf vfmk.af
def vfmkafml : RV<0xb4, (outs VM:$vm), (ins VLS:$vl),
       "vfmk.af $vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSv vfmk.w
def vfmkwmcvl : RV<0xb4, (outs VM:$vm), (ins CCOp:$cc, V64:$vz, VLS:$vl),
       "vfmk.w $vm,$cc,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSvm vfmk.w
def vfmkwmcvml : RV<0xb4, (outs VM:$vmx), (ins CCOp:$cc, V64:$vz, VM:$vm, VLS:$vl),
       "vfmk.w $vmx,$cc,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMFdv vfmk.d
def vfmkdmcvl : RV<0xb4, (outs VM:$vm), (ins CCOp:$cc, V64:$vz, VLS:$vl),
       "vfmk.d $vm,$cc,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMFdvm vfmk.d
def vfmkdmcvml : RV<0xb4, (outs VM:$vmx), (ins CCOp:$cc, V64:$vz, VM:$vm, VLS:$vl),
       "vfmk.d $vmx,$cc,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMFsv vfmk.s
def vfmksmcvl : RV<0xb4, (outs VM:$vm), (ins CCOp:$cc, V64:$vz, VLS:$vl),
       "vfmk.s $vm,$cc,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMFsvm vfmk.s
def vfmksmcvml : RV<0xb4, (outs VM:$vmx), (ins CCOp:$cc, V64:$vz, VM:$vm, VLS:$vl),
       "vfmk.s $vmx,$cc,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUMSsxv vsum.w.sx
def vsumwsxvvvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vsum.w.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUMSsxvm vsum.w.sx
def vsumwsxvvmvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vsum.w.sx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUMSzxv vsum.w.zx
def vsumwzxvvvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vsum.w.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUMSzxvm vsum.w.zx
def vsumwzxvvmvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vsum.w.zx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUMXv vsum.l
def vsumlvvvl : RV<0xaa, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vsum.l $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUMXvm vsum.l
def vsumlvvmvl : RV<0xaa, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vsum.l $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSUMdv vfsum.d
def vfsumdvvvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vfsum.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSUMdvm vfsum.d
def vfsumdvvmvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vfsum.d $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSUMsv vfsum.s
def vfsumsvvvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vfsum.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSUMsvm vfsum.s
def vfsumsvvmvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vfsum.s $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXSafsxv vrmaxs.w.fst.sx
def vrmaxswfstsxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vrmaxs.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXSalsxv vrmaxs.w.lst.sx
def vrmaxswlstsxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vrmaxs.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXSafzxv vrmaxs.w.fst.zx
def vrmaxswfstzxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vrmaxs.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXSalzxv vrmaxs.w.lst.zx
def vrmaxswlstzxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vrmaxs.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXSifsxv vrmins.w.fst.sx
def vrminswfstsxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vrmins.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXSilsxv vrmins.w.lst.sx
def vrminswlstsxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vrmins.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXSifzxv vrmins.w.fst.zx
def vrminswfstzxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vrmins.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXSilzxv vrmins.w.lst.zx
def vrminswlstzxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vrmins.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXXafv vrmaxs.l.fst
def vrmaxslfstvvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vrmaxs.l.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXXalv vrmaxs.l.lst
def vrmaxsllstvvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vrmaxs.l.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXXifv vrmins.l.fst
def vrminslfstvvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vrmins.l.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXXilv vrmins.l.lst
def vrminsllstvvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vrmins.l.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAXadfv vfrmax.d.fst
def vfrmaxdfstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vfrmax.d.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAXadlv vfrmax.d.lst
def vfrmaxdlstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vfrmax.d.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAXasfv vfrmax.s.fst
def vfrmaxsfstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vfrmax.s.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAXaslv vfrmax.s.lst
def vfrmaxslstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vfrmax.s.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAXidfv vfrmin.d.fst
def vfrmindfstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vfrmin.d.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAXidlv vfrmin.d.lst
def vfrmindlstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vfrmin.d.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAXisfv vfrmin.s.fst
def vfrminsfstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vfrmin.s.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAXislv vfrmin.s.lst
def vfrminslstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vfrmin.s.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VGTv vgt
def vgtvvvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vgt $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VGTvm vgt
def vgtvvmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vgt $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VGTUv vgtu
def vgtuvvvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vgtu $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VGTUvm vgtu
def vgtuvvmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vgtu $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VGTLsxv vgtl.sx
def vgtlsxvvvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vgtl.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VGTLsxvm vgtl.sx
def vgtlsxvvmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vgtl.sx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VGTLzxv vgtl.zx
def vgtlzxvvvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, V64:$vd, VLS:$vl),
       "vgtl.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VGTLzxvm vgtl.zx
def vgtlzxvvmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, VLS:$vl),
       "vgtl.zx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCv vsc
def vscvvl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, VLS:$vl),
       "vsc $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCvm vsc
def vscvvml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, VM:$vm, VLS:$vl),
       "vsc $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCotv vsc.ot
def vscotvvl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, VLS:$vl),
       "vsc.ot $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCotvm vsc.ot
def vscotvvml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, VM:$vm, VLS:$vl),
       "vsc.ot $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCUv vscu
def vscuvvl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, VLS:$vl),
       "vscu $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCUvm vscu
def vscuvvml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, VM:$vm, VLS:$vl),
       "vscu $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCUotv vscu.ot
def vscuotvvl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, VLS:$vl),
       "vscu.ot $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCUotvm vscu.ot
def vscuotvvml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, VM:$vm, VLS:$vl),
       "vscu.ot $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCLv vscl
def vsclvvl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, VLS:$vl),
       "vscl $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCLvm vscl
def vsclvvml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, VM:$vm, VLS:$vl),
       "vscl $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCLotv vscl.ot
def vsclotvvl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, VLS:$vl),
       "vscl.ot $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCLotvm vscl.ot
def vsclotvvml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, VM:$vm, VLS:$vl),
       "vscl.ot $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// ANDM andm
def andmmmml : RV<0x84, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz, VLS:$vl),
       "andm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// ANDMp andm
def andmMMMl : RV<0x84, (outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz, VLS:$vl),
       "andm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// ORM orm
def ormmmml : RV<0x85, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz, VLS:$vl),
       "orm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// ORMp orm
def ormMMMl : RV<0x85, (outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz, VLS:$vl),
       "orm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// XORM xorm
def xormmmml : RV<0x86, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz, VLS:$vl),
       "xorm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// XORMp xorm
def xormMMMl : RV<0x86, (outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz, VLS:$vl),
       "xorm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// EQVM eqvm
def eqvmmmml : RV<0x87, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz, VLS:$vl),
       "eqvm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// EQVMp eqvm
def eqvmMMMl : RV<0x87, (outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz, VLS:$vl),
       "eqvm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// NNDM nndm
def nndmmmml : RV<0x94, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz, VLS:$vl),
       "nndm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// NNDMp nndm
def nndmMMMl : RV<0x94, (outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz, VLS:$vl),
       "nndm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// NEGM negm
def negmmml : RV<0x95, (outs VM:$vmx), (ins VM:$vmy, VLS:$vl),
       "negm $vmx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// NEGMp negm
def negmMMl : RV<0x95, (outs VM512:$vmx), (ins VM512:$vmy, VLS:$vl),
       "negm $vmx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// PCVM pcvm
def pcvmsml : RV<0xa4, (outs I64:$sx), (ins VM:$vmy, VLS:$vl),
       "pcvm $sx,$vmy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// LZVM lzvm
def lzvmsml : RV<0xa5, (outs I64:$sx), (ins VM:$vmy, VLS:$vl),
       "lzvm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// TOVM tovm
def tovmsml : RV<0xa6, (outs I64:$sx), (ins VM:$vmy, VLS:$vl),
       "tovm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}


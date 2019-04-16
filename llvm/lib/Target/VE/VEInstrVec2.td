// VLD vld
def vldvssvl : RV<0x81, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vld $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLD vld
def vldvIsvl : RV<0x81, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vld $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDU vldu
def vlduvssvl : RV<0x82, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldu $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDU vldu
def vlduvIsvl : RV<0x82, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldu $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDL vldl.sx
def vldlsxvssvl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl.sx $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDL vldl.sx
def vldlsxvIsvl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl.sx $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDL vldl.zx
def vldlzxvssvl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl.zx $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDL vldl.zx
def vldlzxvIsvl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl.zx $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLD2D vld2d
def vld2dvssvl : RV<0xc1, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vld2d $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLD2D vld2d
def vld2dvIsvl : RV<0xc1, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vld2d $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDU2D vldu2d
def vldu2dvssvl : RV<0xc2, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldu2d $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDU2D vldu2d
def vldu2dvIsvl : RV<0xc2, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldu2d $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.sx
def vldl2dsxvssvl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.sx $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.sx
def vldl2dsxvIsvl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.sx $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.zx
def vldl2dzxvssvl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.zx $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.zx
def vldl2dzxvIsvl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.zx $vx,$I,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VST vst
def vstvssl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VST vst
def vstvIsl : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VST vst.ot
def vstotvssl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VST vst.ot
def vstotvIsl : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTU vstu
def vstuvssl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTU vstu
def vstuvIsl : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTU vstu.ot
def vstuotvssl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTU vstu.ot
def vstuotvIsl : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTL vstl
def vstlvssl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTL vstl
def vstlvIsl : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTL vstl.ot
def vstlotvssl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTL vstl.ot
def vstlotvIsl : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VST2D vst2d
def vst2dvssl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst2d $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VST2D vst2d
def vst2dvIsl : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VST2D vst2d.ot
def vst2dotvssl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VST2D vst2d.ot
def vst2dotvIsl : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d
def vstu2dvssl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu2d $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d
def vstu2dvIsl : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d.ot
def vstu2dotvssl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d.ot
def vstu2dotvIsl : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d
def vstl2dvssl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl2d $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d
def vstl2dvIsl : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d.ot
def vstl2dotvssl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d.ot
def vstl2dotvIsl : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// PFCHV pfchv
def pfchvssl : RV<0x80, (outs ), (ins I64:$sy, I64:$sz, I32:$vl),
       "pfchv $sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// PFCHV pfchv
def pfchvIsl : RV<0x80, (outs ), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "pfchv $I,$sz", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// LSV lsv
def lsvvvssl : RV<0x8e, (outs V64:$vx), (ins V64:$vd, I32:$sy, I64:$sz, I32:$vl),
       "lsv $vx,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// LVS lvs
def lvssvsl : RV<0x9e, (outs I64:$sx), (ins V64:$vx, I32:$sy, I32:$vl),
       "lvs $sx,$vx,$sy", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// LVM lvm
def lvmmmssl : RV<0xb7, (outs VM:$vmx), (ins VM:$vmd, I64:$sy, I64:$sz, I32:$vl),
       "lvm $vmx,$vmd,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// LVM lvm
def lvmmmIsl : RV<0xb7, (outs VM:$vmx), (ins VM:$vmd, simm7Op64:$N, I64:$sz, I32:$vl),
       "lvm $vmx,$vmd,$N,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// LVM lvm
def lvmMMIsl : RV<0xb7, (outs VM512:$vmx), (ins VM512:$vmd, simm7Op64:$N, I64:$sz, I32:$vl),
       "lvm $vmx,$vmd,$N,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// SVM svm
def svmsmsl : RV<0xa7, (outs I64:$sx), (ins VM:$vmz, I64:$sy, I32:$vl),
       "svm $sx,$vmz,$sy", [], NoItinerary>
{
  let cs = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// SVM svm
def svmsmIl : RV<0xa7, (outs I64:$sx), (ins VM:$vmz, simm7Op64:$N, I32:$vl),
       "svm $sx,$vmz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// SVM svm
def svmsMIl : RV<0xa7, (outs I64:$sx), (ins VM512:$vmz, simm7Op64:$N, I32:$vl),
       "svm $sx,$vmz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRD vbrd
def vbrdvsvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, V64:$vd, I32:$vl),
       "vbrd $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRD vbrd
def vbrdvsmvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, VM:$vm, V64:$vd, I32:$vl),
       "vbrd $vx,$sy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRD vbrd
def vbrdvIvl : RV<0x8c, (outs V64:$vx), (ins simm7Op64:$I, V64:$vd, I32:$vl),
       "vbrd $vx,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRD vbrd
def vbrdvImvl : RV<0x8c, (outs V64:$vx), (ins simm7Op64:$I, VM:$vm, V64:$vd, I32:$vl),
       "vbrd $vx,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRD vbrdu
def vbrduvsvl : RV<0x8c, (outs V64:$vx), (ins F32:$sy, V64:$vd, I32:$vl),
       "vbrdu $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRD vbrdu
def vbrduvsmvl : RV<0x8c, (outs V64:$vx), (ins F32:$sy, VM:$vm, V64:$vd, I32:$vl),
       "vbrdu $vx,$sy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRD vbrdl
def vbrdlvsvl : RV<0x8c, (outs V64:$vx), (ins I32:$sy, V64:$vd, I32:$vl),
       "vbrdl $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRD vbrdl
def vbrdlvsmvl : RV<0x8c, (outs V64:$vx), (ins I32:$sy, VM:$vm, V64:$vd, I32:$vl),
       "vbrdl $vx,$sy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRD vbrdl
def vbrdlvIvl : RV<0x8c, (outs V64:$vx), (ins simm7Op64:$I, V64:$vd, I32:$vl),
       "vbrdl $vx,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRD vbrdl
def vbrdlvImvl : RV<0x8c, (outs V64:$vx), (ins simm7Op64:$I, VM:$vm, V64:$vd, I32:$vl),
       "vbrdl $vx,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRD pvbrd
def pvbrdvsvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, V64:$vd, I32:$vl),
       "pvbrd $vx,$sy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VBRD pvbrd
def pvbrdvsMvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, VM512:$vm, V64:$vd, I32:$vl),
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

// VMV vmv
def vmvvsvvl : RV<0x9c, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmv $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMV vmv
def vmvvIvvl : RV<0x9c, (outs V64:$vx), (ins simm7Op64:$N, V64:$vz, V64:$vd, I32:$vl),
       "vmv $vx,$N,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADD vaddu.l
def vaddulvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADD vaddu.l
def vaddulvsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADD vaddu.l
def vaddulvIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADD vaddu.l
def vaddulvvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vaddu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADD vaddu.l
def vaddulvsvmvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vaddu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADD vaddu.l
def vaddulvIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vaddu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADD vaddu.w
def vadduwvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADD vaddu.w
def vadduwvsvvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADD vaddu.w
def vadduwvIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADD vaddu.w
def vadduwvvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vaddu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADD vaddu.w
def vadduwvsvmvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vaddu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADD vaddu.w
def vadduwvIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vaddu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADD pvaddu
def pvadduvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvaddu $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADD pvaddu
def pvadduvsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvaddu $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADD pvaddu
def pvadduvvvMvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VADD pvaddu
def pvadduvsvMvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VADS vadds.w.sx
def vaddswsxvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx
def vaddswsxvsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx
def vaddswsxvIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx
def vaddswsxvvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx
def vaddswsxvsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx
def vaddswsxvIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx
def vaddswzxvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx
def vaddswzxvsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx
def vaddswzxvIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx
def vaddswzxvvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx
def vaddswzxvsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx
def vaddswzxvIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADS pvadds
def pvaddsvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvadds $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADS pvadds
def pvaddsvsvvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvadds $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADS pvadds
def pvaddsvvvMvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VADS pvadds
def pvaddsvsvMvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VADX vadds.l
def vaddslvvvvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADX vadds.l
def vaddslvsvvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADX vadds.l
def vaddslvIvvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vadds.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADX vadds.l
def vaddslvvvmvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vadds.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADX vadds.l
def vaddslvsvmvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vadds.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VADX vadds.l
def vaddslvIvmvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vadds.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l
def vsubulvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l
def vsubulvsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l
def vsubulvIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l
def vsubulvvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vsubu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l
def vsubulvsvmvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vsubu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l
def vsubulvIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vsubu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w
def vsubuwvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w
def vsubuwvsvvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w
def vsubuwvIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w
def vsubuwvvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vsubu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w
def vsubuwvsvmvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vsubu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w
def vsubuwvIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vsubu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUB pvsubu
def pvsubuvvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvsubu $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUB pvsubu
def pvsubuvsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvsubu $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUB pvsubu
def pvsubuvvvMvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VSUB pvsubu
def pvsubuvsvMvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VSBS vsubs.w.sx
def vsubswsxvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx
def vsubswsxvsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx
def vsubswsxvIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx
def vsubswsxvvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx
def vsubswsxvsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx
def vsubswsxvIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx
def vsubswzxvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx
def vsubswzxvsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx
def vsubswzxvIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx
def vsubswzxvvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx
def vsubswzxvsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx
def vsubswzxvIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBS pvsubs
def pvsubsvvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvsubs $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBS pvsubs
def pvsubsvsvvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvsubs $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBS pvsubs
def pvsubsvvvMvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VSBS pvsubs
def pvsubsvsvMvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VSBX vsubs.l
def vsubslvvvvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l
def vsubslvsvvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l
def vsubslvIvvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l
def vsubslvvvmvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vsubs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l
def vsubslvsvmvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vsubs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l
def vsubslvIvmvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vsubs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l
def vmululvvvvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l
def vmululvsvvl : RV<0xc9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l
def vmululvIvvl : RV<0xc9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l
def vmululvvvmvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmulu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l
def vmululvsvmvl : RV<0xc9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmulu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l
def vmululvIvmvl : RV<0xc9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmulu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w
def vmuluwvvvvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w
def vmuluwvsvvl : RV<0xc9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w
def vmuluwvIvvl : RV<0xc9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w
def vmuluwvvvmvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmulu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w
def vmuluwvsvmvl : RV<0xc9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmulu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w
def vmuluwvIvmvl : RV<0xc9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmulu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx
def vmulswsxvvvvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx
def vmulswsxvsvvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx
def vmulswsxvIvvl : RV<0xcb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx
def vmulswsxvvvmvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx
def vmulswsxvsvmvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx
def vmulswsxvIvmvl : RV<0xcb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx
def vmulswzxvvvvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx
def vmulswzxvsvvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx
def vmulswzxvIvvl : RV<0xcb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx
def vmulswzxvvvmvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx
def vmulswzxvsvmvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx
def vmulswzxvIvmvl : RV<0xcb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l
def vmulslvvvvl : RV<0xdb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l
def vmulslvsvvl : RV<0xdb, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l
def vmulslvIvvl : RV<0xdb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l
def vmulslvvvmvl : RV<0xdb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmuls.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l
def vmulslvsvmvl : RV<0xdb, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmuls.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l
def vmulslvIvmvl : RV<0xdb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmuls.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPD vmuls.l.w
def vmulslwvvvvl : RV<0xd9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPD vmuls.l.w
def vmulslwvsvvl : RV<0xd9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMPD vmuls.l.w
def vmulslwvIvvl : RV<0xd9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l
def vdivulvvvvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l
def vdivulvsvvl : RV<0xe9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l
def vdivulvIvvl : RV<0xe9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l
def vdivulvvvmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l
def vdivulvsvmvl : RV<0xe9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l
def vdivulvIvmvl : RV<0xe9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w
def vdivuwvvvvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w
def vdivuwvsvvl : RV<0xe9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w
def vdivuwvIvvl : RV<0xe9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w
def vdivuwvvvmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w
def vdivuwvsvmvl : RV<0xe9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w
def vdivuwvIvmvl : RV<0xe9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l
def vdivulvvsvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l
def vdivulvvIvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l
def vdivulvvsmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I64:$sy, VM:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l
def vdivulvvImvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, VM:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w
def vdivuwvvsvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I32:$sy, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w
def vdivuwvvIvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w
def vdivuwvvsmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w
def vdivuwvvImvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, VM:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx
def vdivswsxvvvvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx
def vdivswsxvsvvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx
def vdivswsxvIvvl : RV<0xeb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx
def vdivswsxvvvmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx
def vdivswsxvsvmvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx
def vdivswsxvIvmvl : RV<0xeb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx
def vdivswzxvvvvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx
def vdivswzxvsvvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx
def vdivswzxvIvvl : RV<0xeb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx
def vdivswzxvvvmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx
def vdivswzxvsvmvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx
def vdivswzxvIvmvl : RV<0xeb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx
def vdivswsxvvsvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx
def vdivswsxvvIvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx
def vdivswsxvvsmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx
def vdivswsxvvImvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, VM:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx
def vdivswzxvvsvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx
def vdivswzxvvIvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx
def vdivswzxvvsmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx
def vdivswzxvvImvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, VM:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l
def vdivslvvvvl : RV<0xfb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l
def vdivslvsvvl : RV<0xfb, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l
def vdivslvIvvl : RV<0xfb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l
def vdivslvvvmvl : RV<0xfb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l
def vdivslvsvmvl : RV<0xfb, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l
def vdivslvIvmvl : RV<0xfb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l
def vdivslvvsvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l
def vdivslvvIvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l
def vdivslvvsmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I64:$sy, VM:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l
def vdivslvvImvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, VM:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$I,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l
def vcmpulvvvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l
def vcmpulvsvvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l
def vcmpulvIvvl : RV<0xb9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l
def vcmpulvvvmvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l
def vcmpulvsvmvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l
def vcmpulvIvmvl : RV<0xb9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w
def vcmpuwvvvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w
def vcmpuwvsvvl : RV<0xb9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w
def vcmpuwvIvvl : RV<0xb9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w
def vcmpuwvvvmvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w
def vcmpuwvsvmvl : RV<0xb9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w
def vcmpuwvIvmvl : RV<0xb9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMP pvcmpu
def pvcmpuvvvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvcmpu $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMP pvcmpu
def pvcmpuvsvvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvcmpu $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMP pvcmpu
def pvcmpuvvvMvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VCMP pvcmpu
def pvcmpuvsvMvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VCPS vcmps.w.sx
def vcmpswsxvvvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx
def vcmpswsxvsvvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx
def vcmpswsxvIvvl : RV<0xfa, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx
def vcmpswsxvvvmvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx
def vcmpswsxvsvmvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx
def vcmpswsxvIvmvl : RV<0xfa, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx
def vcmpswzxvvvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx
def vcmpswzxvsvvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx
def vcmpswzxvIvvl : RV<0xfa, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx
def vcmpswzxvvvmvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx
def vcmpswzxvsvmvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx
def vcmpswzxvIvmvl : RV<0xfa, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPS pvcmps
def pvcmpsvvvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvcmps $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPS pvcmps
def pvcmpsvsvvl : RV<0xfa, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvcmps $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPS pvcmps
def pvcmpsvvvMvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VCPS pvcmps
def pvcmpsvsvMvl : RV<0xfa, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VCPX vcmps.l
def vcmpslvvvvl : RV<0xba, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l
def vcmpslvsvvl : RV<0xba, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l
def vcmpslvIvvl : RV<0xba, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l
def vcmpslvvvmvl : RV<0xba, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vcmps.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l
def vcmpslvsvmvl : RV<0xba, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vcmps.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l
def vcmpslvIvmvl : RV<0xba, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vcmps.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx
def vmaxswsxvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx
def vmaxswsxvsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx
def vmaxswsxvIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx
def vmaxswsxvvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx
def vmaxswsxvsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx
def vmaxswsxvIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx
def vmaxswzxvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx
def vmaxswzxvsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx
def vmaxswzxvIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx
def vmaxswzxvvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx
def vmaxswzxvsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx
def vmaxswzxvIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS pvmaxs
def pvmaxsvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvmaxs $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS pvmaxs
def pvmaxsvsvvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvmaxs $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS pvmaxs
def pvmaxsvvvMvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VCMS pvmaxs
def pvmaxsvsvMvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VCMS vmins.w.sx
def vminswsxvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx
def vminswsxvsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx
def vminswsxvIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx
def vminswsxvvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx
def vminswsxvsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx
def vminswsxvIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx
def vminswzxvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx
def vminswzxvsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx
def vminswzxvIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx
def vminswzxvvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx
def vminswzxvsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx
def vminswzxvIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS pvmins
def pvminsvvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvmins $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS pvmins
def pvminsvsvvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvmins $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMS pvmins
def pvminsvvvMvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VCMS pvmins
def pvminsvsvMvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VCMX vmaxs.l
def vmaxslvvvvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l
def vmaxslvsvvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l
def vmaxslvIvvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l
def vmaxslvvvmvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l
def vmaxslvsvmvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l
def vmaxslvIvmvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMX vmins.l
def vminslvvvvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMX vmins.l
def vminslvsvvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMX vmins.l
def vminslvIvvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmins.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMX vmins.l
def vminslvvvmvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmins.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMX vmins.l
def vminslvsvmvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmins.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCMX vmins.l
def vminslvIvmvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmins.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VAND vand
def vandvvvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vand $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VAND vand
def vandvsvvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vand $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VAND vand
def vandvvvmvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vand $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VAND vand
def vandvsvmvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vand $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VAND pvand
def pvandvvvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvand $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VAND pvand
def pvandvsvvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvand $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VAND pvand
def pvandvvvMvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VAND pvand
def pvandvsvMvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VOR vor
def vorvvvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VOR vor
def vorvsvvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VOR vor
def vorvvvmvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VOR vor
def vorvsvmvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VOR pvor
def pvorvvvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvor $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VOR pvor
def pvorvsvvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvor $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VOR pvor
def pvorvvvMvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VOR pvor
def pvorvsvMvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VXOR vxor
def vxorvvvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vxor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VXOR vxor
def vxorvsvvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vxor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VXOR vxor
def vxorvvvmvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vxor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VXOR vxor
def vxorvsvmvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vxor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VXOR pvxor
def pvxorvvvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvxor $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VXOR pvxor
def pvxorvsvvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvxor $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VXOR pvxor
def pvxorvvvMvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VXOR pvxor
def pvxorvsvMvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VEQV veqv
def veqvvvvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "veqv $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VEQV veqv
def veqvvsvvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "veqv $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VEQV veqv
def veqvvvvmvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "veqv $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VEQV veqv
def veqvvsvmvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "veqv $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VEQV pveqv
def pveqvvvvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pveqv $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VEQV pveqv
def pveqvvsvvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pveqv $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VEQV pveqv
def pveqvvvvMvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VEQV pveqv
def pveqvvsvMvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VSEQ vseq
def vseqvvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, I32:$vl),
       "vseq $vx", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSEQ pvseq.lo
def pvseqlovvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, I32:$vl),
       "pvseq.lo $vx", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSEQ pvseq.up
def pvsequpvvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, I32:$vl),
       "pvseq.up $vx", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSEQ pvseq
def pvseqvvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, I32:$vl),
       "pvseq $vx", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLL vsll
def vsllvvvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLL vsll
def vsllvvsvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLL vsll
def vsllvvIvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLL vsll
def vsllvvvmvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLL vsll
def vsllvvsmvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLL vsll
def vsllvvImvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM:$vm, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLL pvsll
def pvsllvvvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "pvsll $vx,$vz,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLL pvsll
def pvsllvvsvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "pvsll $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLL pvsll
def pvsllvvvMvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, V64:$vd, I32:$vl),
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

// VSLL pvsll
def pvsllvvsMvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, V64:$vd, I32:$vl),
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

// VSRL vsrl
def vsrlvvvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRL vsrl
def vsrlvvsvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRL vsrl
def vsrlvvIvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRL vsrl
def vsrlvvvmvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRL vsrl
def vsrlvvsmvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRL vsrl
def vsrlvvImvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM:$vm, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRL pvsrl
def pvsrlvvvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "pvsrl $vx,$vz,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRL pvsrl
def pvsrlvvsvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "pvsrl $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRL pvsrl
def pvsrlvvvMvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, V64:$vd, I32:$vl),
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

// VSRL pvsrl
def pvsrlvvsMvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, V64:$vd, I32:$vl),
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

// VSLA vsla.w
def vslawvvvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLA vsla.w
def vslawvvsvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLA vsla.w
def vslawvvIvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLA vsla.w
def vslawvvvmvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLA vsla.w
def vslawvvsmvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLA vsla.w
def vslawvvImvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM:$vm, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLA pvsla
def pvslavvvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "pvsla $vx,$vz,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLA pvsla
def pvslavvsvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "pvsla $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLA pvsla
def pvslavvvMvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, V64:$vd, I32:$vl),
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

// VSLA pvsla
def pvslavvsMvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, V64:$vd, I32:$vl),
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

// VSLAX vsla.l
def vslalvvvvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l
def vslalvvsvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l
def vslalvvIvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l
def vslalvvvmvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l
def vslalvvsmvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l
def vslalvvImvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM:$vm, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRA vsra.w
def vsrawvvvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRA vsra.w
def vsrawvvsvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRA vsra.w
def vsrawvvIvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRA vsra.w
def vsrawvvvmvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRA vsra.w
def vsrawvvsmvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRA vsra.w
def vsrawvvImvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM:$vm, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRA pvsra
def pvsravvvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "pvsra $vx,$vz,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRA pvsra
def pvsravvsvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "pvsra $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRA pvsra
def pvsravvvMvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, V64:$vd, I32:$vl),
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

// VSRA pvsra
def pvsravvsMvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, V64:$vd, I32:$vl),
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

// VSRAX vsra.l
def vsralvvvvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l
def vsralvvsvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$sy", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l
def vsralvvIvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l
def vsralvvvmvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l
def vsralvvsmvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l
def vsralvvImvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM:$vm, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$N,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSFA vsfa
def vsfavvssvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vsfa $vx,$vz,$sy,$sz", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSFA vsfa
def vsfavvIsvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vsfa $vx,$vz,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSFA vsfa
def vsfavvssmvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, VM:$vm, V64:$vd, I32:$vl),
       "vsfa $vx,$vz,$sy,$sz,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSFA vsfa
def vsfavvIsmvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, simm7Op64:$I, I64:$sz, VM:$vm, V64:$vd, I32:$vl),
       "vsfa $vx,$vz,$I,$sz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFAD vfadd.d
def vfadddvvvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfadd.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFAD vfadd.d
def vfadddvsvvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfadd.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFAD vfadd.d
def vfadddvvvmvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfadd.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFAD vfadd.d
def vfadddvsvmvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfadd.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFAD vfadd.s
def vfaddsvvvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfadd.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFAD vfadd.s
def vfaddsvsvvl : RV<0xcc, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfadd.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFAD vfadd.s
def vfaddsvvvmvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfadd.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFAD vfadd.s
def vfaddsvsvmvl : RV<0xcc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfadd.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFAD pvfadd
def pvfaddvvvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfadd $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFAD pvfadd
def pvfaddvsvvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfadd $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFAD pvfadd
def pvfaddvvvMvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VFAD pvfadd
def pvfaddvsvMvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VFSB vfsub.d
def vfsubdvvvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfsub.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSB vfsub.d
def vfsubdvsvvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfsub.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSB vfsub.d
def vfsubdvvvmvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfsub.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSB vfsub.d
def vfsubdvsvmvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfsub.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSB vfsub.s
def vfsubsvvvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfsub.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSB vfsub.s
def vfsubsvsvvl : RV<0xdc, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfsub.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSB vfsub.s
def vfsubsvvvmvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfsub.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSB vfsub.s
def vfsubsvsvmvl : RV<0xdc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfsub.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSB pvfsub
def pvfsubvvvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfsub $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSB pvfsub
def pvfsubvsvvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfsub $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSB pvfsub
def pvfsubvvvMvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VFSB pvfsub
def pvfsubvsvMvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VFMP vfmul.d
def vfmuldvvvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmul.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMP vfmul.d
def vfmuldvsvvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmul.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMP vfmul.d
def vfmuldvvvmvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfmul.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMP vfmul.d
def vfmuldvsvmvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfmul.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMP vfmul.s
def vfmulsvvvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmul.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMP vfmul.s
def vfmulsvsvvl : RV<0xcd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmul.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMP vfmul.s
def vfmulsvvvmvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfmul.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMP vfmul.s
def vfmulsvsvmvl : RV<0xcd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfmul.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMP pvfmul
def pvfmulvvvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmul $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMP pvfmul
def pvfmulvsvvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmul $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMP pvfmul
def pvfmulvvvMvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VFMP pvfmul
def pvfmulvsvMvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VFDV vfdiv.d
def vfdivdvvvvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfdiv.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.d
def vfdivdvsvvl : RV<0xdd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfdiv.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.d
def vfdivdvvvmvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfdiv.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.d
def vfdivdvsvmvl : RV<0xdd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfdiv.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.s
def vfdivsvvvvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfdiv.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.s
def vfdivsvsvvl : RV<0xdd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfdiv.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.s
def vfdivsvvvmvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfdiv.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.s
def vfdivsvsvmvl : RV<0xdd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfdiv.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSQRT vfsqrt.d
def vfsqrtdvvvl : RV<0xed, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfsqrt.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSQRT vfsqrt.s
def vfsqrtsvvvl : RV<0xed, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfsqrt.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.d
def vfcmpdvvvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfcmp.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.d
def vfcmpdvsvvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfcmp.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.d
def vfcmpdvvvmvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfcmp.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.d
def vfcmpdvsvmvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfcmp.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.s
def vfcmpsvvvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfcmp.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.s
def vfcmpsvsvvl : RV<0xfc, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfcmp.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.s
def vfcmpsvvvmvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfcmp.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.s
def vfcmpsvsvmvl : RV<0xfc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfcmp.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCP pvfcmp
def pvfcmpvvvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfcmp $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCP pvfcmp
def pvfcmpvsvvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfcmp $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCP pvfcmp
def pvfcmpvvvMvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VFCP pvfcmp
def pvfcmpvsvMvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VFCM vfmax.d
def vfmaxdvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmax.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM vfmax.d
def vfmaxdvsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmax.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM vfmax.d
def vfmaxdvvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfmax.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM vfmax.d
def vfmaxdvsvmvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfmax.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM vfmax.s
def vfmaxsvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmax.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM vfmax.s
def vfmaxsvsvvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmax.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM vfmax.s
def vfmaxsvvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfmax.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM vfmax.s
def vfmaxsvsvmvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfmax.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM pvfmax
def pvfmaxvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmax $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM pvfmax
def pvfmaxvsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmax $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM pvfmax
def pvfmaxvvvMvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VFCM pvfmax
def pvfmaxvsvMvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VFCM vfmin.d
def vfmindvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmin.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM vfmin.d
def vfmindvsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmin.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM vfmin.d
def vfmindvvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfmin.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM vfmin.d
def vfmindvsvmvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfmin.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM vfmin.s
def vfminsvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmin.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM vfmin.s
def vfminsvsvvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmin.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM vfmin.s
def vfminsvvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfmin.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM vfmin.s
def vfminsvsvmvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vfmin.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM pvfmin
def pvfminvvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmin $vx,$vy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM pvfmin
def pvfminvsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmin $vx,$sy,$vz", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFCM pvfmin
def pvfminvvvMvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VFCM pvfmin
def pvfminvsvMvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VFMAD vfmad.d
def vfmaddvvvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d
def vfmaddvsvvvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d
def vfmaddvvsvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d
def vfmaddvvvvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfmad.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d
def vfmaddvsvvmvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfmad.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d
def vfmaddvvsvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfmad.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s
def vfmadsvvvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s
def vfmadsvsvvvl : RV<0xe2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s
def vfmadsvvsvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s
def vfmadsvvvvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfmad.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s
def vfmadsvsvvmvl : RV<0xe2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfmad.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s
def vfmadsvvsvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfmad.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad
def pvfmadvvvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad
def pvfmadvsvvvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad
def pvfmadvvsvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "pvfmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad
def pvfmadvvvvMvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512:$vm, V64:$vd, I32:$vl),
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

// VFMAD pvfmad
def pvfmadvsvvMvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512:$vm, V64:$vd, I32:$vl),
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

// VFMAD pvfmad
def pvfmadvvsvMvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512:$vm, V64:$vd, I32:$vl),
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

// VFMSB vfmsb.d
def vfmsbdvvvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d
def vfmsbdvsvvvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d
def vfmsbdvvsvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d
def vfmsbdvvvvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d
def vfmsbdvsvvmvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d
def vfmsbdvvsvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s
def vfmsbsvvvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s
def vfmsbsvsvvvl : RV<0xf2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s
def vfmsbsvvsvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s
def vfmsbsvvvvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s
def vfmsbsvsvvmvl : RV<0xf2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s
def vfmsbsvvsvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb
def pvfmsbvvvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb
def pvfmsbvsvvvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb
def pvfmsbvvsvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "pvfmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb
def pvfmsbvvvvMvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512:$vm, V64:$vd, I32:$vl),
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

// VFMSB pvfmsb
def pvfmsbvsvvMvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512:$vm, V64:$vd, I32:$vl),
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

// VFMSB pvfmsb
def pvfmsbvvsvMvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512:$vm, V64:$vd, I32:$vl),
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

// VFNMAD vfnmad.d
def vfnmaddvvvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d
def vfnmaddvsvvvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d
def vfnmaddvvsvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d
def vfnmaddvvvvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d
def vfnmaddvsvvmvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d
def vfnmaddvvsvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s
def vfnmadsvvvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s
def vfnmadsvsvvvl : RV<0xe3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s
def vfnmadsvvsvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s
def vfnmadsvvvvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s
def vfnmadsvsvvmvl : RV<0xe3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s
def vfnmadsvvsvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad
def pvfnmadvvvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad
def pvfnmadvsvvvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad
def pvfnmadvvsvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad
def pvfnmadvvvvMvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512:$vm, V64:$vd, I32:$vl),
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

// VFNMAD pvfnmad
def pvfnmadvsvvMvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512:$vm, V64:$vd, I32:$vl),
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

// VFNMAD pvfnmad
def pvfnmadvvsvMvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512:$vm, V64:$vd, I32:$vl),
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

// VFNMSB vfnmsb.d
def vfnmsbdvvvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d
def vfnmsbdvsvvvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d
def vfnmsbdvvsvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d
def vfnmsbdvvvvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d
def vfnmsbdvsvvmvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d
def vfnmsbdvvsvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s
def vfnmsbsvvvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s
def vfnmsbsvsvvvl : RV<0xf3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s
def vfnmsbsvvsvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s
def vfnmsbsvvvvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s
def vfnmsbsvsvvmvl : RV<0xf3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s
def vfnmsbsvvsvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM:$vm, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let cs = 1;
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb
def pvfnmsbvvvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb
def pvfnmsbvsvvvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb
def pvfnmsbvvsvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let cs = 1;
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb
def pvfnmsbvvvvMvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512:$vm, V64:$vd, I32:$vl),
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

// VFNMSB pvfnmsb
def pvfnmsbvsvvMvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512:$vm, V64:$vd, I32:$vl),
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

// VFNMSB pvfnmsb
def pvfnmsbvvsvMvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512:$vm, V64:$vd, I32:$vl),
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

// VRCP vrcp.d
def vrcpdvvvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrcp.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VRCP vrcp.s
def vrcpsvvvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrcp.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VRCP pvrcp
def pvrcpvvvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvrcp $vx,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VRSQRT vrsqrt.d
def vrsqrtdvvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrsqrt.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VRSQRT vrsqrt.s
def vrsqrtsvvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrsqrt.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VRSQRT pvrsqrt
def pvrsqrtvvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvrsqrt $vx,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.sx
def vcvtwdsxvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.d.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.sx
def vcvtwdsxvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vcvt.w.d.sx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.sx.rz
def vcvtwdsxrzvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.d.sx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.sx.rz
def vcvtwdsxrzvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vcvt.w.d.sx.rz $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.zx
def vcvtwdzxvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.d.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.zx
def vcvtwdzxvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vcvt.w.d.zx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.zx.rz
def vcvtwdzxrzvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.d.zx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.zx.rz
def vcvtwdzxrzvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vcvt.w.d.zx.rz $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.sx
def vcvtwssxvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.s.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.sx
def vcvtwssxvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vcvt.w.s.sx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.sx.rz
def vcvtwssxrzvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.s.sx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.sx.rz
def vcvtwssxrzvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vcvt.w.s.sx.rz $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.zx
def vcvtwszxvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.s.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.zx
def vcvtwszxvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vcvt.w.s.zx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.zx.rz
def vcvtwszxrzvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.s.zx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.zx.rz
def vcvtwszxrzvvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vcvt.w.s.zx.rz $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX pvcvt.w.s
def pvcvtwsvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvcvt.w.s $vx,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX pvcvt.w.s
def pvcvtwsvvMvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM512:$vm, V64:$vd, I32:$vl),
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

// VFIX pvcvt.w.s.rz
def pvcvtwsrzvvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvcvt.w.s.rz $vx,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIX pvcvt.w.s.rz
def pvcvtwsrzvvMvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM512:$vm, V64:$vd, I32:$vl),
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

// VFIXX vcvt.l.d
def vcvtldvvvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.l.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXX vcvt.l.d
def vcvtldvvmvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vcvt.l.d $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXX vcvt.l.d.rz
def vcvtldrzvvvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.l.d.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFIXX vcvt.l.d.rz
def vcvtldrzvvmvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vcvt.l.d.rz $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFLT vcvt.d.w
def vcvtdwvvvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.d.w $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFLT vcvt.s.w
def vcvtswvvvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.s.w $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFLT pvcvt.s.w
def pvcvtswvvvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvcvt.s.w $vx,$vy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFLTX vcvt.d.l
def vcvtdlvvvl : RV<0xb8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.d.l $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCVD vcvt.d.s
def vcvtdsvvvl : RV<0x8f, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.d.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCVS vcvt.s.d
def vcvtsdvvvl : RV<0x9f, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.s.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMRG vmrg
def vmrgvvvmvl : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vmrg $vx,$vy,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMRG vmrg.w
def vmrgwvvvMvl : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd, I32:$vl),
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

// VSHF vshf
def vshfvvvsvl : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vshf $vx,$vy,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSHF vshf
def vshfvvvIvl : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vshf $vx,$vy,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VCP vcp
def vcpvvmvl : RV<0x8d, (outs V64:$vx), (ins V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vcp $vx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VEX vex
def vexvvmvl : RV<0x9d, (outs V64:$vx), (ins V64:$vz, VM:$vm, V64:$vd, I32:$vl),
       "vex $vx,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l
def vfmklmcvl : RV<0xb4, (outs VM:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "vfmk.l $vm,$cc,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l
def vfmklmcvml : RV<0xb4, (outs VM:$vmx), (ins CCOp:$cc, V64:$vz, VM:$vm, I32:$vl),
       "vfmk.l $vmx,$cc,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMK vfmk.at
def vfmkatml : RV<0xb4, (outs VM:$vm), (ins I32:$vl),
       "vfmk.at $vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMK vfmk.af
def vfmkafml : RV<0xb4, (outs VM:$vm), (ins I32:$vl),
       "vfmk.af $vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w
def vfmkwmcvl : RV<0xb4, (outs VM:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "vfmk.w $vm,$cc,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w
def vfmkwmcvml : RV<0xb4, (outs VM:$vmx), (ins CCOp:$cc, V64:$vz, VM:$vm, I32:$vl),
       "vfmk.w $vmx,$cc,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d
def vfmkdmcvl : RV<0xb4, (outs VM:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "vfmk.d $vm,$cc,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d
def vfmkdmcvml : RV<0xb4, (outs VM:$vmx), (ins CCOp:$cc, V64:$vz, VM:$vm, I32:$vl),
       "vfmk.d $vmx,$cc,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s
def vfmksmcvl : RV<0xb4, (outs VM:$vm), (ins CCOp:$cc, V64:$vz, I32:$vl),
       "vfmk.s $vm,$cc,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s
def vfmksmcvml : RV<0xb4, (outs VM:$vmx), (ins CCOp:$cc, V64:$vz, VM:$vm, I32:$vl),
       "vfmk.s $vmx,$cc,$vz,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUMS vsum.w.sx
def vsumwsxvvvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vsum.w.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUMS vsum.w.sx
def vsumwsxvvmvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vsum.w.sx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUMS vsum.w.zx
def vsumwzxvvvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vsum.w.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUMS vsum.w.zx
def vsumwzxvvmvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vsum.w.zx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUMX vsum.l
def vsumlvvvl : RV<0xaa, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vsum.l $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSUMX vsum.l
def vsumlvvmvl : RV<0xaa, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vsum.l $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSUM vfsum.d
def vfsumdvvvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfsum.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSUM vfsum.d
def vfsumdvvmvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vfsum.d $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSUM vfsum.s
def vfsumsvvvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfsum.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFSUM vfsum.s
def vfsumsvvmvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vfsum.s $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXS vrmaxs.w.fst.sx
def vrmaxswfstsxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXS vrmaxs.w.lst.sx
def vrmaxswlstsxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXS vrmaxs.w.fst.zx
def vrmaxswfstzxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXS vrmaxs.w.lst.zx
def vrmaxswlstzxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXS vrmins.w.fst.sx
def vrminswfstsxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXS vrmins.w.lst.sx
def vrminswlstsxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXS vrmins.w.fst.zx
def vrminswfstzxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXS vrmins.w.lst.zx
def vrminswlstzxvvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXX vrmaxs.l.fst
def vrmaxslfstvvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.l.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXX vrmaxs.l.lst
def vrmaxsllstvvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.l.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXX vrmins.l.fst
def vrminslfstvvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.l.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VMAXX vrmins.l.lst
def vrminsllstvvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.l.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAX vfrmax.d.fst
def vfrmaxdfstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmax.d.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAX vfrmax.d.lst
def vfrmaxdlstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmax.d.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAX vfrmax.s.fst
def vfrmaxsfstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmax.s.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAX vfrmax.s.lst
def vfrmaxslstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmax.s.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAX vfrmin.d.fst
def vfrmindfstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmin.d.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAX vfrmin.d.lst
def vfrmindlstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmin.d.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAX vfrmin.s.fst
def vfrminsfstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmin.s.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VFMAX vfrmin.s.lst
def vfrminslstvvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmin.s.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VGT vgt
def vgtvvvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vgt $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VGT vgt
def vgtvvmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VGTU vgtu
def vgtuvvvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vgtu $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VGTU vgtu
def vgtuvvmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx
def vgtlsxvvvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx
def vgtlsxvvmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx
def vgtlzxvvvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx
def vgtlzxvvmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, VM:$vm, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSC vsc
def vscvvl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I32:$vl),
       "vsc $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSC vsc
def vscvvml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, VM:$vm, I32:$vl),
       "vsc $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSC vsc.ot
def vscotvvl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I32:$vl),
       "vsc.ot $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSC vsc.ot
def vscotvvml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, VM:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCU vscu
def vscuvvl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I32:$vl),
       "vscu $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCU vscu
def vscuvvml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, VM:$vm, I32:$vl),
       "vscu $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCU vscu.ot
def vscuotvvl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I32:$vl),
       "vscu.ot $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCU vscu.ot
def vscuotvvml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, VM:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCL vscl
def vsclvvl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I32:$vl),
       "vscl $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCL vscl
def vsclvvml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, VM:$vm, I32:$vl),
       "vscl $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCL vscl.ot
def vsclotvvl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I32:$vl),
       "vscl.ot $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// VSCL vscl.ot
def vsclotvvml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, VM:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$vm", [], NoItinerary>
{
  bits<4> vm;
  let m = vm;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// ANDM andm
def andmmmml : RV<0x84, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz, I32:$vl),
       "andm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// ANDM andm
def andmMMMl : RV<0x84, (outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz, I32:$vl),
       "andm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// ORM orm
def ormmmml : RV<0x85, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz, I32:$vl),
       "orm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// ORM orm
def ormMMMl : RV<0x85, (outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz, I32:$vl),
       "orm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// XORM xorm
def xormmmml : RV<0x86, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz, I32:$vl),
       "xorm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// XORM xorm
def xormMMMl : RV<0x86, (outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz, I32:$vl),
       "xorm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// EQVM eqvm
def eqvmmmml : RV<0x87, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz, I32:$vl),
       "eqvm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// EQVM eqvm
def eqvmMMMl : RV<0x87, (outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz, I32:$vl),
       "eqvm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// NNDM nndm
def nndmmmml : RV<0x94, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz, I32:$vl),
       "nndm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// NNDM nndm
def nndmMMMl : RV<0x94, (outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz, I32:$vl),
       "nndm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// NEGM negm
def negmmml : RV<0x95, (outs VM:$vmx), (ins VM:$vmy, I32:$vl),
       "negm $vmx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// NEGM negm
def negmMMl : RV<0x95, (outs VM512:$vmx), (ins VM512:$vmy, I32:$vl),
       "negm $vmx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// PCVM pcvm
def pcvmsml : RV<0xa4, (outs I64:$sx), (ins VM:$vmy, I32:$vl),
       "pcvm $sx,$vmy", [], NoItinerary>
{
  let cx = 1;
  let cx2 = 1;
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// LZVM lzvm
def lzvmsml : RV<0xa5, (outs I64:$sx), (ins VM:$vmy, I32:$vl),
       "lzvm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}

// TOVM tovm
def tovmsml : RV<0xa6, (outs I64:$sx), (ins VM:$vmy, I32:$vl),
       "tovm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let DisableEncoding = "$vl";
}


// inst=LVM asm=lvm intrisic=lvm_mmss
def veoldLVMrr_m : RV<0xb7, (outs VM:$vmx), (ins I64:$sy, I64:$sz, VM:$ptm),
       "lvm $vmx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vmx = $ptm";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=LVM asm=lvm intrisic=lvm_MMss
def veoldLVMyrr_y : Pseudo<(outs VM512:$vmx), (ins I64:$sy, I64:$sz, VM512:$ptm),
       "# lvm $vmx,$sy,$sz", []>
{
  let Constraints = "$vmx = $ptm";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=SVM asm=svm intrisic=svm_sMs
def veoldSVMyr : Pseudo<(outs I64:$sx), (ins VM512:$vmz, I64:$sy),
       "# svm $sx,$vmz,$sy", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=ANDM asm=andm intrisic=andm_MMM
def veoldANDMyy : Pseudo<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz),
       "# andm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=ORM asm=orm intrisic=orm_MMM
def veoldORMyy : Pseudo<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz),
       "# orm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=XORM asm=xorm intrisic=xorm_MMM
def veoldXORMyy : Pseudo<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz),
       "# xorm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=EQVM asm=eqvm intrisic=eqvm_MMM
def veoldEQVMyy : Pseudo<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz),
       "# eqvm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=NNDM asm=nndm intrisic=nndm_MMM
def veoldNNDMyy : Pseudo<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz),
       "# nndm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=NEGM asm=negm intrisic=negm_MM
def veoldNEGMy : Pseudo<(outs VM512:$vmx), (ins VM512:$vmy),
       "# negm $vmx,$vmy", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}


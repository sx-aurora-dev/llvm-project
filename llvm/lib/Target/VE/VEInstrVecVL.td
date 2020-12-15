// inst=ANDM asm=andm intrisic=andm_MMM
def ANDMyy : Pseudo<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz),
       "# andm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=ORM asm=orm intrisic=orm_MMM
def ORMyy : Pseudo<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz),
       "# orm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=XORM asm=xorm intrisic=xorm_MMM
def XORMyy : Pseudo<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz),
       "# xorm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=EQVM asm=eqvm intrisic=eqvm_MMM
def EQVMyy : Pseudo<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz),
       "# eqvm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=NNDM asm=nndm intrisic=nndm_MMM
def NNDMyy : Pseudo<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz),
       "# nndm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=NEGM asm=negm intrisic=negm_MM
def NEGMy : Pseudo<(outs VM512:$vmx), (ins VM512:$vmy),
       "# negm $vmx,$vmy", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

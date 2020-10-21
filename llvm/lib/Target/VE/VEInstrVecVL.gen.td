// inst=VLD asm=vld intrisic=vld_vssl
def veoldVLDrrl : RV<0x81, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vld $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD asm=vld intrisic=vld_vssvl
def veoldVLDrrl_v : RV<0x81, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vld $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD asm=vld intrisic=vld_vssl
def veoldVLDirl : RV<0x81, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl),
       "vld $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD asm=vld intrisic=vld_vssvl
def veoldVLDirl_v : RV<0x81, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vld $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD asm=vld.nc intrisic=vldnc_vssl
def veoldVLDNCrrl : RV<0x81, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vld.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD asm=vld.nc intrisic=vldnc_vssvl
def veoldVLDNCrrl_v : RV<0x81, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vld.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD asm=vld.nc intrisic=vldnc_vssl
def veoldVLDNCirl : RV<0x81, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl),
       "vld.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD asm=vld.nc intrisic=vldnc_vssvl
def veoldVLDNCirl_v : RV<0x81, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vld.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU asm=vldu intrisic=vldu_vssl
def veoldVLDUrrl : RV<0x82, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldu $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU asm=vldu intrisic=vldu_vssvl
def veoldVLDUrrl_v : RV<0x82, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vldu $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU asm=vldu intrisic=vldu_vssl
def veoldVLDUirl : RV<0x82, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl),
       "vldu $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU asm=vldu intrisic=vldu_vssvl
def veoldVLDUirl_v : RV<0x82, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vldu $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU asm=vldu.nc intrisic=vldunc_vssl
def veoldVLDUNCrrl : RV<0x82, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldu.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU asm=vldu.nc intrisic=vldunc_vssvl
def veoldVLDUNCrrl_v : RV<0x82, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vldu.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU asm=vldu.nc intrisic=vldunc_vssl
def veoldVLDUNCirl : RV<0x82, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl),
       "vldu.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU asm=vldu.nc intrisic=vldunc_vssvl
def veoldVLDUNCirl_v : RV<0x82, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vldu.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.sx intrisic=vldlsx_vssl
def veoldVLDLSXrrl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl.sx $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.sx intrisic=vldlsx_vssvl
def veoldVLDLSXrrl_v : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vldl.sx $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.sx intrisic=vldlsx_vssl
def veoldVLDLSXirl : RV<0x83, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl),
       "vldl.sx $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.sx intrisic=vldlsx_vssvl
def veoldVLDLSXirl_v : RV<0x83, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vldl.sx $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.sx.nc intrisic=vldlsxnc_vssl
def veoldVLDLSXNCrrl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl.sx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.sx.nc intrisic=vldlsxnc_vssvl
def veoldVLDLSXNCrrl_v : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vldl.sx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.sx.nc intrisic=vldlsxnc_vssl
def veoldVLDLSXNCirl : RV<0x83, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl),
       "vldl.sx.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.sx.nc intrisic=vldlsxnc_vssvl
def veoldVLDLSXNCirl_v : RV<0x83, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vldl.sx.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.zx intrisic=vldlzx_vssl
def veoldVLDLZXrrl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl.zx $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.zx intrisic=vldlzx_vssvl
def veoldVLDLZXrrl_v : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vldl.zx $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.zx intrisic=vldlzx_vssl
def veoldVLDLZXirl : RV<0x83, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl),
       "vldl.zx $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.zx intrisic=vldlzx_vssvl
def veoldVLDLZXirl_v : RV<0x83, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vldl.zx $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.zx.nc intrisic=vldlzxnc_vssl
def veoldVLDLZXNCrrl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl.zx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.zx.nc intrisic=vldlzxnc_vssvl
def veoldVLDLZXNCrrl_v : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vldl.zx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.zx.nc intrisic=vldlzxnc_vssl
def veoldVLDLZXNCirl : RV<0x83, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl),
       "vldl.zx.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.zx.nc intrisic=vldlzxnc_vssvl
def veoldVLDLZXNCirl_v : RV<0x83, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vldl.zx.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD2D asm=vld2d intrisic=vld2d_vssl
def veoldVLD2Drrl : RV<0xc1, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vld2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD2D asm=vld2d intrisic=vld2d_vssvl
def veoldVLD2Drrl_v : RV<0xc1, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vld2d $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD2D asm=vld2d intrisic=vld2d_vssl
def veoldVLD2Dirl : RV<0xc1, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl),
       "vld2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD2D asm=vld2d intrisic=vld2d_vssvl
def veoldVLD2Dirl_v : RV<0xc1, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vld2d $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD2D asm=vld2d.nc intrisic=vld2dnc_vssl
def veoldVLD2DNCrrl : RV<0xc1, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vld2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD2D asm=vld2d.nc intrisic=vld2dnc_vssvl
def veoldVLD2DNCrrl_v : RV<0xc1, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vld2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD2D asm=vld2d.nc intrisic=vld2dnc_vssl
def veoldVLD2DNCirl : RV<0xc1, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl),
       "vld2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD2D asm=vld2d.nc intrisic=vld2dnc_vssvl
def veoldVLD2DNCirl_v : RV<0xc1, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vld2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU2D asm=vldu2d intrisic=vldu2d_vssl
def veoldVLDU2Drrl : RV<0xc2, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldu2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU2D asm=vldu2d intrisic=vldu2d_vssvl
def veoldVLDU2Drrl_v : RV<0xc2, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vldu2d $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU2D asm=vldu2d intrisic=vldu2d_vssl
def veoldVLDU2Dirl : RV<0xc2, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl),
       "vldu2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU2D asm=vldu2d intrisic=vldu2d_vssvl
def veoldVLDU2Dirl_v : RV<0xc2, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vldu2d $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU2D asm=vldu2d.nc intrisic=vldu2dnc_vssl
def veoldVLDU2DNCrrl : RV<0xc2, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldu2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU2D asm=vldu2d.nc intrisic=vldu2dnc_vssvl
def veoldVLDU2DNCrrl_v : RV<0xc2, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vldu2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU2D asm=vldu2d.nc intrisic=vldu2dnc_vssl
def veoldVLDU2DNCirl : RV<0xc2, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl),
       "vldu2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU2D asm=vldu2d.nc intrisic=vldu2dnc_vssvl
def veoldVLDU2DNCirl_v : RV<0xc2, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vldu2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.sx intrisic=vldl2dsx_vssl
def veoldVLDL2DSXrrl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl2d.sx $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.sx intrisic=vldl2dsx_vssvl
def veoldVLDL2DSXrrl_v : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vldl2d.sx $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.sx intrisic=vldl2dsx_vssl
def veoldVLDL2DSXirl : RV<0xc3, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl),
       "vldl2d.sx $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.sx intrisic=vldl2dsx_vssvl
def veoldVLDL2DSXirl_v : RV<0xc3, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vldl2d.sx $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.sx.nc intrisic=vldl2dsxnc_vssl
def veoldVLDL2DSXNCrrl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl2d.sx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.sx.nc intrisic=vldl2dsxnc_vssvl
def veoldVLDL2DSXNCrrl_v : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vldl2d.sx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.sx.nc intrisic=vldl2dsxnc_vssl
def veoldVLDL2DSXNCirl : RV<0xc3, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl),
       "vldl2d.sx.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.sx.nc intrisic=vldl2dsxnc_vssvl
def veoldVLDL2DSXNCirl_v : RV<0xc3, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vldl2d.sx.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.zx intrisic=vldl2dzx_vssl
def veoldVLDL2DZXrrl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl2d.zx $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.zx intrisic=vldl2dzx_vssvl
def veoldVLDL2DZXrrl_v : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vldl2d.zx $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.zx intrisic=vldl2dzx_vssl
def veoldVLDL2DZXirl : RV<0xc3, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl),
       "vldl2d.zx $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.zx intrisic=vldl2dzx_vssvl
def veoldVLDL2DZXirl_v : RV<0xc3, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vldl2d.zx $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.zx.nc intrisic=vldl2dzxnc_vssl
def veoldVLDL2DZXNCrrl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl2d.zx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.zx.nc intrisic=vldl2dzxnc_vssvl
def veoldVLDL2DZXNCrrl_v : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vldl2d.zx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.zx.nc intrisic=vldl2dzxnc_vssl
def veoldVLDL2DZXNCirl : RV<0xc3, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl),
       "vldl2d.zx.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.zx.nc intrisic=vldl2dzxnc_vssvl
def veoldVLDL2DZXNCirl_v : RV<0xc3, (outs V64:$vx), (ins simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vldl2d.zx.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst intrisic=vst_vssl
def veoldVSTrrvl : RV<0x91, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vst $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst intrisic=vst_vssl
def veoldVSTirvl : RV<0x91, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vst $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst intrisic=vst_vssml
def veoldVSTrrvml : RV<0x91, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vst $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst intrisic=vst_vssml
def veoldVSTirvml : RV<0x91, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vst $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc intrisic=vstnc_vssl
def veoldVSTNCrrvl : RV<0x91, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vst.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc intrisic=vstnc_vssl
def veoldVSTNCirvl : RV<0x91, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vst.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc intrisic=vstnc_vssml
def veoldVSTNCrrvml : RV<0x91, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vst.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc intrisic=vstnc_vssml
def veoldVSTNCirvml : RV<0x91, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vst.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.ot intrisic=vstot_vssl
def veoldVSTOTrrvl : RV<0x91, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vst.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.ot intrisic=vstot_vssl
def veoldVSTOTirvl : RV<0x91, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vst.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.ot intrisic=vstot_vssml
def veoldVSTOTrrvml : RV<0x91, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vst.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.ot intrisic=vstot_vssml
def veoldVSTOTirvml : RV<0x91, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vst.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc.ot intrisic=vstncot_vssl
def veoldVSTNCOTrrvl : RV<0x91, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vst.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc.ot intrisic=vstncot_vssl
def veoldVSTNCOTirvl : RV<0x91, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vst.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc.ot intrisic=vstncot_vssml
def veoldVSTNCOTrrvml : RV<0x91, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vst.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc.ot intrisic=vstncot_vssml
def veoldVSTNCOTirvml : RV<0x91, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vst.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu intrisic=vstu_vssl
def veoldVSTUrrvl : RV<0x92, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vstu $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu intrisic=vstu_vssl
def veoldVSTUirvl : RV<0x92, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vstu $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu intrisic=vstu_vssml
def veoldVSTUrrvml : RV<0x92, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstu $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu intrisic=vstu_vssml
def veoldVSTUirvml : RV<0x92, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstu $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc intrisic=vstunc_vssl
def veoldVSTUNCrrvl : RV<0x92, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vstu.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc intrisic=vstunc_vssl
def veoldVSTUNCirvl : RV<0x92, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vstu.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc intrisic=vstunc_vssml
def veoldVSTUNCrrvml : RV<0x92, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstu.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc intrisic=vstunc_vssml
def veoldVSTUNCirvml : RV<0x92, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstu.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.ot intrisic=vstuot_vssl
def veoldVSTUOTrrvl : RV<0x92, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vstu.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.ot intrisic=vstuot_vssl
def veoldVSTUOTirvl : RV<0x92, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vstu.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.ot intrisic=vstuot_vssml
def veoldVSTUOTrrvml : RV<0x92, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstu.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.ot intrisic=vstuot_vssml
def veoldVSTUOTirvml : RV<0x92, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstu.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc.ot intrisic=vstuncot_vssl
def veoldVSTUNCOTrrvl : RV<0x92, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vstu.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc.ot intrisic=vstuncot_vssl
def veoldVSTUNCOTirvl : RV<0x92, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vstu.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc.ot intrisic=vstuncot_vssml
def veoldVSTUNCOTrrvml : RV<0x92, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstu.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc.ot intrisic=vstuncot_vssml
def veoldVSTUNCOTirvml : RV<0x92, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstu.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl intrisic=vstl_vssl
def veoldVSTLrrvl : RV<0x93, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vstl $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl intrisic=vstl_vssl
def veoldVSTLirvl : RV<0x93, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vstl $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl intrisic=vstl_vssml
def veoldVSTLrrvml : RV<0x93, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstl $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl intrisic=vstl_vssml
def veoldVSTLirvml : RV<0x93, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstl $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc intrisic=vstlnc_vssl
def veoldVSTLNCrrvl : RV<0x93, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vstl.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc intrisic=vstlnc_vssl
def veoldVSTLNCirvl : RV<0x93, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vstl.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc intrisic=vstlnc_vssml
def veoldVSTLNCrrvml : RV<0x93, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstl.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc intrisic=vstlnc_vssml
def veoldVSTLNCirvml : RV<0x93, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstl.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.ot intrisic=vstlot_vssl
def veoldVSTLOTrrvl : RV<0x93, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vstl.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.ot intrisic=vstlot_vssl
def veoldVSTLOTirvl : RV<0x93, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vstl.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.ot intrisic=vstlot_vssml
def veoldVSTLOTrrvml : RV<0x93, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstl.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.ot intrisic=vstlot_vssml
def veoldVSTLOTirvml : RV<0x93, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstl.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc.ot intrisic=vstlncot_vssl
def veoldVSTLNCOTrrvl : RV<0x93, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vstl.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc.ot intrisic=vstlncot_vssl
def veoldVSTLNCOTirvl : RV<0x93, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vstl.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc.ot intrisic=vstlncot_vssml
def veoldVSTLNCOTrrvml : RV<0x93, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstl.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc.ot intrisic=vstlncot_vssml
def veoldVSTLNCOTirvml : RV<0x93, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstl.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d intrisic=vst2d_vssl
def veoldVST2Drrvl : RV<0xd1, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vst2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d intrisic=vst2d_vssl
def veoldVST2Dirvl : RV<0xd1, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vst2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d intrisic=vst2d_vssml
def veoldVST2Drrvml : RV<0xd1, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vst2d $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d intrisic=vst2d_vssml
def veoldVST2Dirvml : RV<0xd1, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vst2d $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc intrisic=vst2dnc_vssl
def veoldVST2DNCrrvl : RV<0xd1, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vst2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc intrisic=vst2dnc_vssl
def veoldVST2DNCirvl : RV<0xd1, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vst2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc intrisic=vst2dnc_vssml
def veoldVST2DNCrrvml : RV<0xd1, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vst2d.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc intrisic=vst2dnc_vssml
def veoldVST2DNCirvml : RV<0xd1, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vst2d.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.ot intrisic=vst2dot_vssl
def veoldVST2DOTrrvl : RV<0xd1, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vst2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.ot intrisic=vst2dot_vssl
def veoldVST2DOTirvl : RV<0xd1, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vst2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.ot intrisic=vst2dot_vssml
def veoldVST2DOTrrvml : RV<0xd1, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vst2d.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.ot intrisic=vst2dot_vssml
def veoldVST2DOTirvml : RV<0xd1, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vst2d.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc.ot intrisic=vst2dncot_vssl
def veoldVST2DNCOTrrvl : RV<0xd1, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vst2d.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc.ot intrisic=vst2dncot_vssl
def veoldVST2DNCOTirvl : RV<0xd1, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vst2d.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc.ot intrisic=vst2dncot_vssml
def veoldVST2DNCOTrrvml : RV<0xd1, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vst2d.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc.ot intrisic=vst2dncot_vssml
def veoldVST2DNCOTirvml : RV<0xd1, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vst2d.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d intrisic=vstu2d_vssl
def veoldVSTU2Drrvl : RV<0xd2, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vstu2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d intrisic=vstu2d_vssl
def veoldVSTU2Dirvl : RV<0xd2, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vstu2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d intrisic=vstu2d_vssml
def veoldVSTU2Drrvml : RV<0xd2, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstu2d $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d intrisic=vstu2d_vssml
def veoldVSTU2Dirvml : RV<0xd2, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstu2d $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc intrisic=vstu2dnc_vssl
def veoldVSTU2DNCrrvl : RV<0xd2, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vstu2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc intrisic=vstu2dnc_vssl
def veoldVSTU2DNCirvl : RV<0xd2, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vstu2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc intrisic=vstu2dnc_vssml
def veoldVSTU2DNCrrvml : RV<0xd2, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstu2d.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc intrisic=vstu2dnc_vssml
def veoldVSTU2DNCirvml : RV<0xd2, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstu2d.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.ot intrisic=vstu2dot_vssl
def veoldVSTU2DOTrrvl : RV<0xd2, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vstu2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.ot intrisic=vstu2dot_vssl
def veoldVSTU2DOTirvl : RV<0xd2, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vstu2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.ot intrisic=vstu2dot_vssml
def veoldVSTU2DOTrrvml : RV<0xd2, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstu2d.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.ot intrisic=vstu2dot_vssml
def veoldVSTU2DOTirvml : RV<0xd2, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstu2d.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc.ot intrisic=vstu2dncot_vssl
def veoldVSTU2DNCOTrrvl : RV<0xd2, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vstu2d.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc.ot intrisic=vstu2dncot_vssl
def veoldVSTU2DNCOTirvl : RV<0xd2, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vstu2d.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc.ot intrisic=vstu2dncot_vssml
def veoldVSTU2DNCOTrrvml : RV<0xd2, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstu2d.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc.ot intrisic=vstu2dncot_vssml
def veoldVSTU2DNCOTirvml : RV<0xd2, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstu2d.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d intrisic=vstl2d_vssl
def veoldVSTL2Drrvl : RV<0xd3, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vstl2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d intrisic=vstl2d_vssl
def veoldVSTL2Dirvl : RV<0xd3, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vstl2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d intrisic=vstl2d_vssml
def veoldVSTL2Drrvml : RV<0xd3, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstl2d $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d intrisic=vstl2d_vssml
def veoldVSTL2Dirvml : RV<0xd3, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstl2d $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc intrisic=vstl2dnc_vssl
def veoldVSTL2DNCrrvl : RV<0xd3, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vstl2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc intrisic=vstl2dnc_vssl
def veoldVSTL2DNCirvl : RV<0xd3, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vstl2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc intrisic=vstl2dnc_vssml
def veoldVSTL2DNCrrvml : RV<0xd3, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstl2d.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc intrisic=vstl2dnc_vssml
def veoldVSTL2DNCirvml : RV<0xd3, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstl2d.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.ot intrisic=vstl2dot_vssl
def veoldVSTL2DOTrrvl : RV<0xd3, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vstl2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.ot intrisic=vstl2dot_vssl
def veoldVSTL2DOTirvl : RV<0xd3, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vstl2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.ot intrisic=vstl2dot_vssml
def veoldVSTL2DOTrrvml : RV<0xd3, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstl2d.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.ot intrisic=vstl2dot_vssml
def veoldVSTL2DOTirvml : RV<0xd3, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstl2d.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc.ot intrisic=vstl2dncot_vssl
def veoldVSTL2DNCOTrrvl : RV<0xd3, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vstl2d.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc.ot intrisic=vstl2dncot_vssl
def veoldVSTL2DNCOTirvl : RV<0xd3, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vstl2d.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc.ot intrisic=vstl2dncot_vssml
def veoldVSTL2DNCOTrrvml : RV<0xd3, (outs ), (ins I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstl2d.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc.ot intrisic=vstl2dncot_vssml
def veoldVSTL2DNCOTirvml : RV<0xd3, (outs ), (ins simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vstl2d.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=PFCHV asm=pfchv intrisic=pfchv_ssl
def veoldPFCHVrrl : RV<0x80, (outs ), (ins I64:$sy, I64:$sz, I32:$vl),
       "pfchv $sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=PFCHV asm=pfchv intrisic=pfchv_ssl
def veoldPFCHVirl : RV<0x80, (outs ), (ins simm7:$I, I64:$sz, I32:$vl),
       "pfchv $I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=PFCHV asm=pfchv.nc intrisic=pfchvnc_ssl
def veoldPFCHVNCrrl : RV<0x80, (outs ), (ins I64:$sy, I64:$sz, I32:$vl),
       "pfchv.nc $sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=PFCHV asm=pfchv.nc intrisic=pfchvnc_ssl
def veoldPFCHVNCirl : RV<0x80, (outs ), (ins simm7:$I, I64:$sz, I32:$vl),
       "pfchv.nc $I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=LVM asm=lvm intrisic=lvm_mmss
def veoldLVMrr_m : RV<0xb7, (outs VM:$vmx), (ins I64:$sy, I64:$sz, VM:$ptm),
       "lvm $vmx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vmx = $ptm";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=LVM asm=lvm intrisic=lvm_mmss
def veoldLVMir_m : RV<0xb7, (outs VM:$vmx), (ins simm7:$N, I64:$sz, VM:$ptm),
       "lvm $vmx,$N,$sz", [], NoItinerary>
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

// inst=LVM asm=lvm intrisic=lvm_MMss
def veoldLVMyir_y : Pseudo<(outs VM512:$vmx), (ins simm7:$N, I64:$sz, VM512:$ptm),
       "# lvm $vmx,$N,$sz", []>
{
  let Constraints = "$vmx = $ptm";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=SVM asm=svm intrisic=svm_sms
def veoldSVMmr : RV<0xa7, (outs I64:$sx), (ins VM:$vmz, I64:$sy),
       "svm $sx,$vmz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=SVM asm=svm intrisic=svm_sms
def veoldSVMmi : RV<0xa7, (outs I64:$sx), (ins VM:$vmz, simm7:$N),
       "svm $sx,$vmz,$N", [], NoItinerary>
{
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

// inst=SVM asm=svm intrisic=svm_sMs
def veoldSVMyi : Pseudo<(outs I64:$sx), (ins VM512:$vmz, simm7:$N),
       "# svm $sx,$vmz,$N", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=VBRD asm=vbrd intrisic=vbrdl_vsl
def veoldVBRDrl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, I32:$vl),
       "vbrd $vx,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrd intrisic=vbrdl_vsvl
def veoldVBRDrl_v : RV<0x8c, (outs V64:$vx), (ins I64:$sy, I32:$vl, V64:$pt),
       "vbrd $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrd intrisic=vbrdl_vsmvl
def veoldVBRDrml_v : RV<0x8c, (outs V64:$vx), (ins I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vbrd $vx,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrd intrisic=vbrdl_vsl
def veoldVBRDil : RV<0x8c, (outs V64:$vx), (ins simm7:$I, I32:$vl),
       "vbrd $vx,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrd intrisic=vbrdl_vsvl
def veoldVBRDil_v : RV<0x8c, (outs V64:$vx), (ins simm7:$I, I32:$vl, V64:$pt),
       "vbrd $vx,$I", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrd intrisic=vbrdl_vsmvl
def veoldVBRDiml_v : RV<0x8c, (outs V64:$vx), (ins simm7:$I, VM:$vm, I32:$vl, V64:$pt),
       "vbrd $vx,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdu intrisic=vbrds_vsl
def veoldVBRDUrl : RV<0x8c, (outs V64:$vx), (ins F32:$sy, I32:$vl),
       "vbrdu $vx,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdu intrisic=vbrds_vsvl
def veoldVBRDUrl_v : RV<0x8c, (outs V64:$vx), (ins F32:$sy, I32:$vl, V64:$pt),
       "vbrdu $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdu intrisic=vbrds_vsmvl
def veoldVBRDUrml_v : RV<0x8c, (outs V64:$vx), (ins F32:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vbrdu $vx,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdl intrisic=vbrdw_vsl
def veoldVBRDLrl : RV<0x8c, (outs V64:$vx), (ins I32:$sy, I32:$vl),
       "vbrdl $vx,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdl intrisic=vbrdw_vsvl
def veoldVBRDLrl_v : RV<0x8c, (outs V64:$vx), (ins I32:$sy, I32:$vl, V64:$pt),
       "vbrdl $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdl intrisic=vbrdw_vsmvl
def veoldVBRDLrml_v : RV<0x8c, (outs V64:$vx), (ins I32:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vbrdl $vx,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdl intrisic=vbrdw_vsl
def veoldVBRDLil : RV<0x8c, (outs V64:$vx), (ins simm7:$I, I32:$vl),
       "vbrdl $vx,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdl intrisic=vbrdw_vsvl
def veoldVBRDLil_v : RV<0x8c, (outs V64:$vx), (ins simm7:$I, I32:$vl, V64:$pt),
       "vbrdl $vx,$I", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdl intrisic=vbrdw_vsmvl
def veoldVBRDLiml_v : RV<0x8c, (outs V64:$vx), (ins simm7:$I, VM:$vm, I32:$vl, V64:$pt),
       "vbrdl $vx,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=pvbrd intrisic=pvbrd_vsl
def veoldPVBRDrl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, I32:$vl),
       "pvbrd $vx,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=pvbrd intrisic=pvbrd_vsvl
def veoldPVBRDrl_v : RV<0x8c, (outs V64:$vx), (ins I64:$sy, I32:$vl, V64:$pt),
       "pvbrd $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=pvbrd intrisic=pvbrd_vsMvl
def veoldPVBRDrml_v : RV<0x8c, (outs V64:$vx), (ins I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
       "pvbrd $vx,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMV asm=vmv intrisic=vmv_vsvl
def veoldVMVrvl : RV<0x9c, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmv $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMV asm=vmv intrisic=vmv_vsvvl
def veoldVMVrvl_v : RV<0x9c, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vmv $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMV asm=vmv intrisic=vmv_vsvmvl
def veoldVMVrvml_v : RV<0x9c, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmv $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMV asm=vmv intrisic=vmv_vsvl
def veoldVMVivl : RV<0x9c, (outs V64:$vx), (ins simm7:$N, V64:$vz, I32:$vl),
       "vmv $vx,$N,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMV asm=vmv intrisic=vmv_vsvvl
def veoldVMVivl_v : RV<0x9c, (outs V64:$vx), (ins simm7:$N, V64:$vz, I32:$vl, V64:$pt),
       "vmv $vx,$N,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMV asm=vmv intrisic=vmv_vsvmvl
def veoldVMVivml_v : RV<0x9c, (outs V64:$vx), (ins simm7:$N, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmv $vx,$N,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vvvl
def veoldVADDULvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vaddu.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vvvvl
def veoldVADDULvvl_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vaddu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vsvl
def veoldVADDULrvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vaddu.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vsvvl
def veoldVADDULrvl_v : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vaddu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vsvl
def veoldVADDULivl : RV<0xc8, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vaddu.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vsvvl
def veoldVADDULivl_v : RV<0xc8, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vaddu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vvvmvl
def veoldVADDULvvml_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vaddu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vsvmvl
def veoldVADDULrvml_v : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vaddu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vsvmvl
def veoldVADDULivml_v : RV<0xc8, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vaddu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vvvl
def veoldVADDUWvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vaddu.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vvvvl
def veoldVADDUWvvl_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vaddu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vsvl
def veoldVADDUWrvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vaddu.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vsvvl
def veoldVADDUWrvl_v : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vaddu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vsvl
def veoldVADDUWivl : RV<0xc8, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vaddu.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vsvvl
def veoldVADDUWivl_v : RV<0xc8, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vaddu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vvvmvl
def veoldVADDUWvvml_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vaddu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vsvmvl
def veoldVADDUWrvml_v : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vaddu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vsvmvl
def veoldVADDUWivml_v : RV<0xc8, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vaddu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=pvaddu intrisic=pvaddu_vvvl
def veoldPVADDUvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvaddu $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=pvaddu intrisic=pvaddu_vvvvl
def veoldPVADDUvvl_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvaddu $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=pvaddu intrisic=pvaddu_vsvl
def veoldPVADDUrvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvaddu $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=pvaddu intrisic=pvaddu_vsvvl
def veoldPVADDUrvl_v : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvaddu $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=pvaddu intrisic=pvaddu_vvvMvl
def veoldPVADDUvvml_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvaddu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=pvaddu intrisic=pvaddu_vsvMvl
def veoldPVADDUrvml_v : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvaddu $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vvvl
def veoldVADDSWSXvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vadds.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vvvvl
def veoldVADDSWSXvvl_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vadds.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vsvl
def veoldVADDSWSXrvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vadds.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vsvvl
def veoldVADDSWSXrvl_v : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vadds.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vsvl
def veoldVADDSWSXivl : RV<0xca, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vadds.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vsvvl
def veoldVADDSWSXivl_v : RV<0xca, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vadds.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vvvmvl
def veoldVADDSWSXvvml_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vadds.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vsvmvl
def veoldVADDSWSXrvml_v : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vadds.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vsvmvl
def veoldVADDSWSXivml_v : RV<0xca, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vadds.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vvvl
def veoldVADDSWZXvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vadds.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vvvvl
def veoldVADDSWZXvvl_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vadds.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vsvl
def veoldVADDSWZXrvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vadds.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vsvvl
def veoldVADDSWZXrvl_v : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vadds.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vsvl
def veoldVADDSWZXivl : RV<0xca, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vadds.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vsvvl
def veoldVADDSWZXivl_v : RV<0xca, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vadds.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vvvmvl
def veoldVADDSWZXvvml_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vadds.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vsvmvl
def veoldVADDSWZXrvml_v : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vadds.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vsvmvl
def veoldVADDSWZXivml_v : RV<0xca, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vadds.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=pvadds intrisic=pvadds_vvvl
def veoldPVADDSvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvadds $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=pvadds intrisic=pvadds_vvvvl
def veoldPVADDSvvl_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvadds $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=pvadds intrisic=pvadds_vsvl
def veoldPVADDSrvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvadds $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=pvadds intrisic=pvadds_vsvvl
def veoldPVADDSrvl_v : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvadds $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=pvadds intrisic=pvadds_vvvMvl
def veoldPVADDSvvml_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvadds $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=pvadds intrisic=pvadds_vsvMvl
def veoldPVADDSrvml_v : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvadds $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vvvl
def veoldVADDSLvvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vadds.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vvvvl
def veoldVADDSLvvl_v : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vadds.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vsvl
def veoldVADDSLrvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vadds.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vsvvl
def veoldVADDSLrvl_v : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vadds.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vsvl
def veoldVADDSLivl : RV<0x8b, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vadds.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vsvvl
def veoldVADDSLivl_v : RV<0x8b, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vadds.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vvvmvl
def veoldVADDSLvvml_v : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vadds.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vsvmvl
def veoldVADDSLrvml_v : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vadds.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vsvmvl
def veoldVADDSLivml_v : RV<0x8b, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vadds.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vvvl
def veoldVSUBULvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vsubu.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vvvvl
def veoldVSUBULvvl_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vsubu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vsvl
def veoldVSUBULrvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vsubu.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vsvvl
def veoldVSUBULrvl_v : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vsubu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vsvl
def veoldVSUBULivl : RV<0xc8, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vsubu.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vsvvl
def veoldVSUBULivl_v : RV<0xc8, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vsubu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vvvmvl
def veoldVSUBULvvml_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vsvmvl
def veoldVSUBULrvml_v : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vsvmvl
def veoldVSUBULivml_v : RV<0xc8, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vvvl
def veoldVSUBUWvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vsubu.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vvvvl
def veoldVSUBUWvvl_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vsubu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vsvl
def veoldVSUBUWrvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vsubu.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vsvvl
def veoldVSUBUWrvl_v : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vsubu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vsvl
def veoldVSUBUWivl : RV<0xc8, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vsubu.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vsvvl
def veoldVSUBUWivl_v : RV<0xc8, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vsubu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vvvmvl
def veoldVSUBUWvvml_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vsvmvl
def veoldVSUBUWrvml_v : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vsvmvl
def veoldVSUBUWivml_v : RV<0xc8, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=pvsubu intrisic=pvsubu_vvvl
def veoldPVSUBUvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvsubu $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=pvsubu intrisic=pvsubu_vvvvl
def veoldPVSUBUvvl_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvsubu $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=pvsubu intrisic=pvsubu_vsvl
def veoldPVSUBUrvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvsubu $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=pvsubu intrisic=pvsubu_vsvvl
def veoldPVSUBUrvl_v : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvsubu $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=pvsubu intrisic=pvsubu_vvvMvl
def veoldPVSUBUvvml_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvsubu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=pvsubu intrisic=pvsubu_vsvMvl
def veoldPVSUBUrvml_v : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvsubu $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vvvl
def veoldVSUBSWSXvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vsubs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vvvvl
def veoldVSUBSWSXvvl_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vsubs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vsvl
def veoldVSUBSWSXrvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vsubs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vsvvl
def veoldVSUBSWSXrvl_v : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vsubs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vsvl
def veoldVSUBSWSXivl : RV<0xca, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vsubs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vsvvl
def veoldVSUBSWSXivl_v : RV<0xca, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vsubs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vvvmvl
def veoldVSUBSWSXvvml_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vsvmvl
def veoldVSUBSWSXrvml_v : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vsvmvl
def veoldVSUBSWSXivml_v : RV<0xca, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vvvl
def veoldVSUBSWZXvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vsubs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vvvvl
def veoldVSUBSWZXvvl_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vsubs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vsvl
def veoldVSUBSWZXrvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vsubs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vsvvl
def veoldVSUBSWZXrvl_v : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vsubs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vsvl
def veoldVSUBSWZXivl : RV<0xca, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vsubs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vsvvl
def veoldVSUBSWZXivl_v : RV<0xca, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vsubs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vvvmvl
def veoldVSUBSWZXvvml_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vsvmvl
def veoldVSUBSWZXrvml_v : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vsvmvl
def veoldVSUBSWZXivml_v : RV<0xca, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=pvsubs intrisic=pvsubs_vvvl
def veoldPVSUBSvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvsubs $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=pvsubs intrisic=pvsubs_vvvvl
def veoldPVSUBSvvl_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvsubs $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=pvsubs intrisic=pvsubs_vsvl
def veoldPVSUBSrvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvsubs $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=pvsubs intrisic=pvsubs_vsvvl
def veoldPVSUBSrvl_v : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvsubs $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=pvsubs intrisic=pvsubs_vvvMvl
def veoldPVSUBSvvml_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvsubs $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=pvsubs intrisic=pvsubs_vsvMvl
def veoldPVSUBSrvml_v : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvsubs $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vvvl
def veoldVSUBSLvvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vsubs.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vvvvl
def veoldVSUBSLvvl_v : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vsubs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vsvl
def veoldVSUBSLrvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vsubs.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vsvvl
def veoldVSUBSLrvl_v : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vsubs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vsvl
def veoldVSUBSLivl : RV<0x8b, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vsubs.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vsvvl
def veoldVSUBSLivl_v : RV<0x8b, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vsubs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vvvmvl
def veoldVSUBSLvvml_v : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vsvmvl
def veoldVSUBSLrvml_v : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vsvmvl
def veoldVSUBSLivml_v : RV<0x8b, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vvvl
def veoldVMULULvvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmulu.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vvvvl
def veoldVMULULvvl_v : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vmulu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vsvl
def veoldVMULULrvl : RV<0xc9, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vmulu.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vsvvl
def veoldVMULULrvl_v : RV<0xc9, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vmulu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vsvl
def veoldVMULULivl : RV<0xc9, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vmulu.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vsvvl
def veoldVMULULivl_v : RV<0xc9, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vmulu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vvvmvl
def veoldVMULULvvml_v : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmulu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vsvmvl
def veoldVMULULrvml_v : RV<0xc9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmulu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vsvmvl
def veoldVMULULivml_v : RV<0xc9, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmulu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vvvl
def veoldVMULUWvvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmulu.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vvvvl
def veoldVMULUWvvl_v : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vmulu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vsvl
def veoldVMULUWrvl : RV<0xc9, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmulu.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vsvvl
def veoldVMULUWrvl_v : RV<0xc9, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vmulu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vsvl
def veoldVMULUWivl : RV<0xc9, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vmulu.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vsvvl
def veoldVMULUWivl_v : RV<0xc9, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vmulu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vvvmvl
def veoldVMULUWvvml_v : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmulu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vsvmvl
def veoldVMULUWrvml_v : RV<0xc9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmulu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vsvmvl
def veoldVMULUWivml_v : RV<0xc9, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmulu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vvvl
def veoldVMULSWSXvvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmuls.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vvvvl
def veoldVMULSWSXvvl_v : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vmuls.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vsvl
def veoldVMULSWSXrvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmuls.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vsvvl
def veoldVMULSWSXrvl_v : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vmuls.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vsvl
def veoldVMULSWSXivl : RV<0xcb, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vmuls.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vsvvl
def veoldVMULSWSXivl_v : RV<0xcb, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vmuls.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vvvmvl
def veoldVMULSWSXvvml_v : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmuls.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vsvmvl
def veoldVMULSWSXrvml_v : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmuls.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vsvmvl
def veoldVMULSWSXivml_v : RV<0xcb, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmuls.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vvvl
def veoldVMULSWZXvvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmuls.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vvvvl
def veoldVMULSWZXvvl_v : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vmuls.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vsvl
def veoldVMULSWZXrvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmuls.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vsvvl
def veoldVMULSWZXrvl_v : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vmuls.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vsvl
def veoldVMULSWZXivl : RV<0xcb, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vmuls.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vsvvl
def veoldVMULSWZXivl_v : RV<0xcb, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vmuls.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vvvmvl
def veoldVMULSWZXvvml_v : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmuls.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vsvmvl
def veoldVMULSWZXrvml_v : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmuls.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vsvmvl
def veoldVMULSWZXivml_v : RV<0xcb, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmuls.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vvvl
def veoldVMULSLvvl : RV<0xdb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmuls.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vvvvl
def veoldVMULSLvvl_v : RV<0xdb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vmuls.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vsvl
def veoldVMULSLrvl : RV<0xdb, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vmuls.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vsvvl
def veoldVMULSLrvl_v : RV<0xdb, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vmuls.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vsvl
def veoldVMULSLivl : RV<0xdb, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vmuls.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vsvvl
def veoldVMULSLivl_v : RV<0xdb, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vmuls.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vvvmvl
def veoldVMULSLvvml_v : RV<0xdb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmuls.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vsvmvl
def veoldVMULSLrvml_v : RV<0xdb, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmuls.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vsvmvl
def veoldVMULSLivml_v : RV<0xdb, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmuls.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPD asm=vmuls.l.w intrisic=vmulslw_vvvl
def veoldVMULSLWvvl : RV<0xd9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmuls.l.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPD asm=vmuls.l.w intrisic=vmulslw_vvvvl
def veoldVMULSLWvvl_v : RV<0xd9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vmuls.l.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPD asm=vmuls.l.w intrisic=vmulslw_vsvl
def veoldVMULSLWrvl : RV<0xd9, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmuls.l.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPD asm=vmuls.l.w intrisic=vmulslw_vsvvl
def veoldVMULSLWrvl_v : RV<0xd9, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vmuls.l.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPD asm=vmuls.l.w intrisic=vmulslw_vsvl
def veoldVMULSLWivl : RV<0xd9, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vmuls.l.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPD asm=vmuls.l.w intrisic=vmulslw_vsvvl
def veoldVMULSLWivl_v : RV<0xd9, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vmuls.l.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvvl
def veoldVDIVULvvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vdivu.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvvvl
def veoldVDIVULvvl_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vdivu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vsvl
def veoldVDIVULrvl : RV<0xe9, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vdivu.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vsvvl
def veoldVDIVULrvl_v : RV<0xe9, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vdivu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vsvl
def veoldVDIVULivl : RV<0xe9, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vdivu.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vsvvl
def veoldVDIVULivl_v : RV<0xe9, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vdivu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvvmvl
def veoldVDIVULvvml_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vsvmvl
def veoldVDIVULrvml_v : RV<0xe9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vsvmvl
def veoldVDIVULivml_v : RV<0xe9, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvvl
def veoldVDIVUWvvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vdivu.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvvvl
def veoldVDIVUWvvl_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vdivu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vsvl
def veoldVDIVUWrvl : RV<0xe9, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vdivu.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vsvvl
def veoldVDIVUWrvl_v : RV<0xe9, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vdivu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vsvl
def veoldVDIVUWivl : RV<0xe9, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vdivu.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vsvvl
def veoldVDIVUWivl_v : RV<0xe9, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vdivu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvvmvl
def veoldVDIVUWvvml_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vsvmvl
def veoldVDIVUWrvml_v : RV<0xe9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vsvmvl
def veoldVDIVUWivml_v : RV<0xe9, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvsl
def veoldVDIVULvrl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I64:$sy, I32:$vl),
       "vdivu.l $vx,$vy,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvsvl
def veoldVDIVULvrl_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I64:$sy, I32:$vl, V64:$pt),
       "vdivu.l $vx,$vy,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvsl
def veoldVDIVULvil : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7:$I, I32:$vl),
       "vdivu.l $vx,$vy,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvsvl
def veoldVDIVULvil_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7:$I, I32:$vl, V64:$pt),
       "vdivu.l $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvsmvl
def veoldVDIVULvrml_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vdivu.l $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvsmvl
def veoldVDIVULviml_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7:$I, VM:$vm, I32:$vl, V64:$pt),
       "vdivu.l $vx,$vy,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvsl
def veoldVDIVUWvrl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I32:$sy, I32:$vl),
       "vdivu.w $vx,$vy,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvsvl
def veoldVDIVUWvrl_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I32:$sy, I32:$vl, V64:$pt),
       "vdivu.w $vx,$vy,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvsl
def veoldVDIVUWvil : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7:$I, I32:$vl),
       "vdivu.w $vx,$vy,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvsvl
def veoldVDIVUWvil_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7:$I, I32:$vl, V64:$pt),
       "vdivu.w $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvsmvl
def veoldVDIVUWvrml_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vdivu.w $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvsmvl
def veoldVDIVUWviml_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7:$I, VM:$vm, I32:$vl, V64:$pt),
       "vdivu.w $vx,$vy,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvvl
def veoldVDIVSWSXvvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vdivs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvvvl
def veoldVDIVSWSXvvl_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vdivs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vsvl
def veoldVDIVSWSXrvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vdivs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vsvvl
def veoldVDIVSWSXrvl_v : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vdivs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vsvl
def veoldVDIVSWSXivl : RV<0xeb, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vdivs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vsvvl
def veoldVDIVSWSXivl_v : RV<0xeb, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vdivs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvvmvl
def veoldVDIVSWSXvvml_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vsvmvl
def veoldVDIVSWSXrvml_v : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vsvmvl
def veoldVDIVSWSXivml_v : RV<0xeb, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvvl
def veoldVDIVSWZXvvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vdivs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvvvl
def veoldVDIVSWZXvvl_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vdivs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vsvl
def veoldVDIVSWZXrvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vdivs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vsvvl
def veoldVDIVSWZXrvl_v : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vdivs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vsvl
def veoldVDIVSWZXivl : RV<0xeb, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vdivs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vsvvl
def veoldVDIVSWZXivl_v : RV<0xeb, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vdivs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvvmvl
def veoldVDIVSWZXvvml_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vsvmvl
def veoldVDIVSWZXrvml_v : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vsvmvl
def veoldVDIVSWZXivml_v : RV<0xeb, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvsl
def veoldVDIVSWSXvrl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, I32:$vl),
       "vdivs.w.sx $vx,$vy,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvsvl
def veoldVDIVSWSXvrl_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, I32:$vl, V64:$pt),
       "vdivs.w.sx $vx,$vy,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvsl
def veoldVDIVSWSXvil : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7:$I, I32:$vl),
       "vdivs.w.sx $vx,$vy,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvsvl
def veoldVDIVSWSXvil_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7:$I, I32:$vl, V64:$pt),
       "vdivs.w.sx $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvsmvl
def veoldVDIVSWSXvrml_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.w.sx $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvsmvl
def veoldVDIVSWSXviml_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7:$I, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.w.sx $vx,$vy,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvsl
def veoldVDIVSWZXvrl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, I32:$vl),
       "vdivs.w.zx $vx,$vy,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvsvl
def veoldVDIVSWZXvrl_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, I32:$vl, V64:$pt),
       "vdivs.w.zx $vx,$vy,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvsl
def veoldVDIVSWZXvil : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7:$I, I32:$vl),
       "vdivs.w.zx $vx,$vy,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvsvl
def veoldVDIVSWZXvil_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7:$I, I32:$vl, V64:$pt),
       "vdivs.w.zx $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvsmvl
def veoldVDIVSWZXvrml_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.w.zx $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvsmvl
def veoldVDIVSWZXviml_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7:$I, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.w.zx $vx,$vy,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvvl
def veoldVDIVSLvvl : RV<0xfb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vdivs.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvvvl
def veoldVDIVSLvvl_v : RV<0xfb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vdivs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vsvl
def veoldVDIVSLrvl : RV<0xfb, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vdivs.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vsvvl
def veoldVDIVSLrvl_v : RV<0xfb, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vdivs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vsvl
def veoldVDIVSLivl : RV<0xfb, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vdivs.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vsvvl
def veoldVDIVSLivl_v : RV<0xfb, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vdivs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvvmvl
def veoldVDIVSLvvml_v : RV<0xfb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vsvmvl
def veoldVDIVSLrvml_v : RV<0xfb, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vsvmvl
def veoldVDIVSLivml_v : RV<0xfb, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvsl
def veoldVDIVSLvrl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I64:$sy, I32:$vl),
       "vdivs.l $vx,$vy,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvsvl
def veoldVDIVSLvrl_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I64:$sy, I32:$vl, V64:$pt),
       "vdivs.l $vx,$vy,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvsl
def veoldVDIVSLvil : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7:$I, I32:$vl),
       "vdivs.l $vx,$vy,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvsvl
def veoldVDIVSLvil_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7:$I, I32:$vl, V64:$pt),
       "vdivs.l $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvsmvl
def veoldVDIVSLvrml_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.l $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvsmvl
def veoldVDIVSLviml_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7:$I, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.l $vx,$vy,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vvvl
def veoldVCMPULvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vcmpu.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vvvvl
def veoldVCMPULvvl_v : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vcmpu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vsvl
def veoldVCMPULrvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vcmpu.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vsvvl
def veoldVCMPULrvl_v : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vcmpu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vsvl
def veoldVCMPULivl : RV<0xb9, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vcmpu.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vsvvl
def veoldVCMPULivl_v : RV<0xb9, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vcmpu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vvvmvl
def veoldVCMPULvvml_v : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmpu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vsvmvl
def veoldVCMPULrvml_v : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmpu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vsvmvl
def veoldVCMPULivml_v : RV<0xb9, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmpu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vvvl
def veoldVCMPUWvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vcmpu.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vvvvl
def veoldVCMPUWvvl_v : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vcmpu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vsvl
def veoldVCMPUWrvl : RV<0xb9, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vcmpu.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vsvvl
def veoldVCMPUWrvl_v : RV<0xb9, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vcmpu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vsvl
def veoldVCMPUWivl : RV<0xb9, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vcmpu.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vsvvl
def veoldVCMPUWivl_v : RV<0xb9, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vcmpu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vvvmvl
def veoldVCMPUWvvml_v : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmpu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vsvmvl
def veoldVCMPUWrvml_v : RV<0xb9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmpu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vsvmvl
def veoldVCMPUWivml_v : RV<0xb9, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmpu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=pvcmpu intrisic=pvcmpu_vvvl
def veoldPVCMPUvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvcmpu $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=pvcmpu intrisic=pvcmpu_vvvvl
def veoldPVCMPUvvl_v : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvcmpu $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=pvcmpu intrisic=pvcmpu_vsvl
def veoldPVCMPUrvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvcmpu $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=pvcmpu intrisic=pvcmpu_vsvvl
def veoldPVCMPUrvl_v : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvcmpu $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=pvcmpu intrisic=pvcmpu_vvvMvl
def veoldPVCMPUvvml_v : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvcmpu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=pvcmpu intrisic=pvcmpu_vsvMvl
def veoldPVCMPUrvml_v : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvcmpu $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vvvl
def veoldVCMPSWSXvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vcmps.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vvvvl
def veoldVCMPSWSXvvl_v : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vcmps.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vsvl
def veoldVCMPSWSXrvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vcmps.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vsvvl
def veoldVCMPSWSXrvl_v : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vcmps.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vsvl
def veoldVCMPSWSXivl : RV<0xfa, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vcmps.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vsvvl
def veoldVCMPSWSXivl_v : RV<0xfa, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vcmps.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vvvmvl
def veoldVCMPSWSXvvml_v : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmps.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vsvmvl
def veoldVCMPSWSXrvml_v : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmps.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vsvmvl
def veoldVCMPSWSXivml_v : RV<0xfa, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmps.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vvvl
def veoldVCMPSWZXvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vcmps.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vvvvl
def veoldVCMPSWZXvvl_v : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vcmps.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vsvl
def veoldVCMPSWZXrvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vcmps.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vsvvl
def veoldVCMPSWZXrvl_v : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vcmps.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vsvl
def veoldVCMPSWZXivl : RV<0xfa, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vcmps.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vsvvl
def veoldVCMPSWZXivl_v : RV<0xfa, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vcmps.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vvvmvl
def veoldVCMPSWZXvvml_v : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmps.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vsvmvl
def veoldVCMPSWZXrvml_v : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmps.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vsvmvl
def veoldVCMPSWZXivml_v : RV<0xfa, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmps.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=pvcmps intrisic=pvcmps_vvvl
def veoldPVCMPSvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvcmps $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=pvcmps intrisic=pvcmps_vvvvl
def veoldPVCMPSvvl_v : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvcmps $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=pvcmps intrisic=pvcmps_vsvl
def veoldPVCMPSrvl : RV<0xfa, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvcmps $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=pvcmps intrisic=pvcmps_vsvvl
def veoldPVCMPSrvl_v : RV<0xfa, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvcmps $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=pvcmps intrisic=pvcmps_vvvMvl
def veoldPVCMPSvvml_v : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvcmps $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=pvcmps intrisic=pvcmps_vsvMvl
def veoldPVCMPSrvml_v : RV<0xfa, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvcmps $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vvvl
def veoldVCMPSLvvl : RV<0xba, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vcmps.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vvvvl
def veoldVCMPSLvvl_v : RV<0xba, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vcmps.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vsvl
def veoldVCMPSLrvl : RV<0xba, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vcmps.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vsvvl
def veoldVCMPSLrvl_v : RV<0xba, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vcmps.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vsvl
def veoldVCMPSLivl : RV<0xba, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vcmps.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vsvvl
def veoldVCMPSLivl_v : RV<0xba, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vcmps.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vvvmvl
def veoldVCMPSLvvml_v : RV<0xba, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmps.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vsvmvl
def veoldVCMPSLrvml_v : RV<0xba, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmps.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vsvmvl
def veoldVCMPSLivml_v : RV<0xba, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmps.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vvvl
def veoldVMAXSWSXvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmaxs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vvvvl
def veoldVMAXSWSXvvl_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vmaxs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vsvl
def veoldVMAXSWSXrvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmaxs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vsvvl
def veoldVMAXSWSXrvl_v : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vmaxs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vsvl
def veoldVMAXSWSXivl : RV<0x8a, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vmaxs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vsvvl
def veoldVMAXSWSXivl_v : RV<0x8a, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vmaxs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vvvmvl
def veoldVMAXSWSXvvml_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmaxs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vsvmvl
def veoldVMAXSWSXrvml_v : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmaxs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vsvmvl
def veoldVMAXSWSXivml_v : RV<0x8a, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmaxs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vvvl
def veoldVMAXSWZXvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmaxs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vvvvl
def veoldVMAXSWZXvvl_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vmaxs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vsvl
def veoldVMAXSWZXrvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmaxs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vsvvl
def veoldVMAXSWZXrvl_v : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vmaxs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vsvl
def veoldVMAXSWZXivl : RV<0x8a, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vmaxs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vsvvl
def veoldVMAXSWZXivl_v : RV<0x8a, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vmaxs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vvvmvl
def veoldVMAXSWZXvvml_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmaxs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vsvmvl
def veoldVMAXSWZXrvml_v : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmaxs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vsvmvl
def veoldVMAXSWZXivml_v : RV<0x8a, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmaxs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmaxs intrisic=pvmaxs_vvvl
def veoldPVMAXSvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvmaxs $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmaxs intrisic=pvmaxs_vvvvl
def veoldPVMAXSvvl_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvmaxs $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmaxs intrisic=pvmaxs_vsvl
def veoldPVMAXSrvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvmaxs $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmaxs intrisic=pvmaxs_vsvvl
def veoldPVMAXSrvl_v : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvmaxs $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmaxs intrisic=pvmaxs_vvvMvl
def veoldPVMAXSvvml_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvmaxs $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmaxs intrisic=pvmaxs_vsvMvl
def veoldPVMAXSrvml_v : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvmaxs $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vvvl
def veoldVMINSWSXvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmins.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vvvvl
def veoldVMINSWSXvvl_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vmins.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vsvl
def veoldVMINSWSXrvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmins.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vsvvl
def veoldVMINSWSXrvl_v : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vmins.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vsvl
def veoldVMINSWSXivl : RV<0x8a, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vmins.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vsvvl
def veoldVMINSWSXivl_v : RV<0x8a, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vmins.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vvvmvl
def veoldVMINSWSXvvml_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmins.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vsvmvl
def veoldVMINSWSXrvml_v : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmins.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vsvmvl
def veoldVMINSWSXivml_v : RV<0x8a, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmins.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vvvl
def veoldVMINSWZXvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmins.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vvvvl
def veoldVMINSWZXvvl_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vmins.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vsvl
def veoldVMINSWZXrvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmins.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vsvvl
def veoldVMINSWZXrvl_v : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vmins.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vsvl
def veoldVMINSWZXivl : RV<0x8a, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vmins.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vsvvl
def veoldVMINSWZXivl_v : RV<0x8a, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vmins.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vvvmvl
def veoldVMINSWZXvvml_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmins.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vsvmvl
def veoldVMINSWZXrvml_v : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmins.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vsvmvl
def veoldVMINSWZXivml_v : RV<0x8a, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmins.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmins intrisic=pvmins_vvvl
def veoldPVMINSvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvmins $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmins intrisic=pvmins_vvvvl
def veoldPVMINSvvl_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvmins $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmins intrisic=pvmins_vsvl
def veoldPVMINSrvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvmins $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmins intrisic=pvmins_vsvvl
def veoldPVMINSrvl_v : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvmins $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmins intrisic=pvmins_vvvMvl
def veoldPVMINSvvml_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvmins $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmins intrisic=pvmins_vsvMvl
def veoldPVMINSrvml_v : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvmins $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vvvl
def veoldVMAXSLvvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmaxs.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vvvvl
def veoldVMAXSLvvl_v : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vmaxs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vsvl
def veoldVMAXSLrvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vmaxs.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vsvvl
def veoldVMAXSLrvl_v : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vmaxs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vsvl
def veoldVMAXSLivl : RV<0x9a, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vmaxs.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vsvvl
def veoldVMAXSLivl_v : RV<0x9a, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vmaxs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vvvmvl
def veoldVMAXSLvvml_v : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmaxs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vsvmvl
def veoldVMAXSLrvml_v : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmaxs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vsvmvl
def veoldVMAXSLivml_v : RV<0x9a, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmaxs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vvvl
def veoldVMINSLvvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmins.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vvvvl
def veoldVMINSLvvl_v : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vmins.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vsvl
def veoldVMINSLrvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vmins.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vsvvl
def veoldVMINSLrvl_v : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vmins.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vsvl
def veoldVMINSLivl : RV<0x9a, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl),
       "vmins.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vsvvl
def veoldVMINSLivl_v : RV<0x9a, (outs V64:$vx), (ins simm7:$I, V64:$vz, I32:$vl, V64:$pt),
       "vmins.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vvvmvl
def veoldVMINSLvvml_v : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmins.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vsvmvl
def veoldVMINSLrvml_v : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmins.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vsvmvl
def veoldVMINSLivml_v : RV<0x9a, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmins.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=vand intrisic=vand_vvvl
def veoldVANDvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vand $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=vand intrisic=vand_vvvvl
def veoldVANDvvl_v : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vand $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=vand intrisic=vand_vsvl
def veoldVANDrvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vand $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=vand intrisic=vand_vsvvl
def veoldVANDrvl_v : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vand $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=vand intrisic=vand_vvvmvl
def veoldVANDvvml_v : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vand $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=vand intrisic=vand_vsvmvl
def veoldVANDrvml_v : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vand $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand intrisic=pvand_vvvl
def veoldPVANDvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvand $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand intrisic=pvand_vvvvl
def veoldPVANDvvl_v : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvand $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand intrisic=pvand_vsvl
def veoldPVANDrvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvand $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand intrisic=pvand_vsvvl
def veoldPVANDrvl_v : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvand $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand intrisic=pvand_vvvMvl
def veoldPVANDvvml_v : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvand $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand intrisic=pvand_vsvMvl
def veoldPVANDrvml_v : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvand $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=vor intrisic=vor_vvvl
def veoldVORvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vor $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=vor intrisic=vor_vvvvl
def veoldVORvvl_v : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=vor intrisic=vor_vsvl
def veoldVORrvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vor $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=vor intrisic=vor_vsvvl
def veoldVORrvl_v : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=vor intrisic=vor_vvvmvl
def veoldVORvvml_v : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=vor intrisic=vor_vsvmvl
def veoldVORrvml_v : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor intrisic=pvor_vvvl
def veoldPVORvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvor $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor intrisic=pvor_vvvvl
def veoldPVORvvl_v : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor intrisic=pvor_vsvl
def veoldPVORrvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvor $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor intrisic=pvor_vsvvl
def veoldPVORrvl_v : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor intrisic=pvor_vvvMvl
def veoldPVORvvml_v : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor intrisic=pvor_vsvMvl
def veoldPVORrvml_v : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=vxor intrisic=vxor_vvvl
def veoldVXORvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vxor $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=vxor intrisic=vxor_vvvvl
def veoldVXORvvl_v : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vxor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=vxor intrisic=vxor_vsvl
def veoldVXORrvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vxor $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=vxor intrisic=vxor_vsvvl
def veoldVXORrvl_v : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vxor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=vxor intrisic=vxor_vvvmvl
def veoldVXORvvml_v : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vxor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=vxor intrisic=vxor_vsvmvl
def veoldVXORrvml_v : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vxor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor intrisic=pvxor_vvvl
def veoldPVXORvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvxor $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor intrisic=pvxor_vvvvl
def veoldPVXORvvl_v : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvxor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor intrisic=pvxor_vsvl
def veoldPVXORrvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvxor $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor intrisic=pvxor_vsvvl
def veoldPVXORrvl_v : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvxor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor intrisic=pvxor_vvvMvl
def veoldPVXORvvml_v : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvxor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor intrisic=pvxor_vsvMvl
def veoldPVXORrvml_v : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvxor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=veqv intrisic=veqv_vvvl
def veoldVEQVvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "veqv $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=veqv intrisic=veqv_vvvvl
def veoldVEQVvvl_v : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "veqv $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=veqv intrisic=veqv_vsvl
def veoldVEQVrvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "veqv $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=veqv intrisic=veqv_vsvvl
def veoldVEQVrvl_v : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "veqv $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=veqv intrisic=veqv_vvvmvl
def veoldVEQVvvml_v : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "veqv $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=veqv intrisic=veqv_vsvmvl
def veoldVEQVrvml_v : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "veqv $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv intrisic=pveqv_vvvl
def veoldPVEQVvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pveqv $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv intrisic=pveqv_vvvvl
def veoldPVEQVvvl_v : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pveqv $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv intrisic=pveqv_vsvl
def veoldPVEQVrvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pveqv $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv intrisic=pveqv_vsvvl
def veoldPVEQVrvl_v : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pveqv $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv intrisic=pveqv_vvvMvl
def veoldPVEQVvvml_v : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pveqv $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv intrisic=pveqv_vsvMvl
def veoldPVEQVrvml_v : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pveqv $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSEQ asm=vseq intrisic=vseq_vl
def veoldVSEQl : RV<0x99, (outs V64:$vx), (ins I32:$vl),
       "vseq $vx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSEQ asm=vseq intrisic=vseq_vvl
def veoldVSEQl_v : RV<0x99, (outs V64:$vx), (ins I32:$vl, V64:$pt),
       "vseq $vx", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSEQ asm=pvseq.lo intrisic=pvseqlo_vl
def veoldPVSEQLOl : RV<0x99, (outs V64:$vx), (ins I32:$vl),
       "pvseq.lo $vx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSEQ asm=pvseq.lo intrisic=pvseqlo_vvl
def veoldPVSEQLOl_v : RV<0x99, (outs V64:$vx), (ins I32:$vl, V64:$pt),
       "pvseq.lo $vx", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSEQ asm=pvseq.up intrisic=pvsequp_vl
def veoldPVSEQUPl : RV<0x99, (outs V64:$vx), (ins I32:$vl),
       "pvseq.up $vx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSEQ asm=pvseq.up intrisic=pvsequp_vvl
def veoldPVSEQUPl_v : RV<0x99, (outs V64:$vx), (ins I32:$vl, V64:$pt),
       "pvseq.up $vx", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSEQ asm=pvseq intrisic=pvseq_vl
def veoldPVSEQl : RV<0x99, (outs V64:$vx), (ins I32:$vl),
       "pvseq $vx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSEQ asm=pvseq intrisic=pvseq_vvl
def veoldPVSEQl_v : RV<0x99, (outs V64:$vx), (ins I32:$vl, V64:$pt),
       "pvseq $vx", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvvl
def veoldVSLLvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsll $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvvvl
def veoldVSLLvvl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "vsll $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvsl
def veoldVSLLvrl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsll $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvsvl
def veoldVSLLvrl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "vsll $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvsl
def veoldVSLLvil : RV<0xe5, (outs V64:$vx), (ins V64:$vz, simm7:$N, I32:$vl),
       "vsll $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvsvl
def veoldVSLLvil_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, simm7:$N, I32:$vl, V64:$pt),
       "vsll $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvvmvl
def veoldVSLLvvml_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vsll $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvsmvl
def veoldVSLLvrml_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vsll $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvsmvl
def veoldVSLLviml_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, simm7:$N, VM:$vm, I32:$vl, V64:$pt),
       "vsll $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll intrisic=pvsll_vvvl
def veoldPVSLLvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsll $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll intrisic=pvsll_vvvvl
def veoldPVSLLvvl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "pvsll $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll intrisic=pvsll_vvsl
def veoldPVSLLvrl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsll $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll intrisic=pvsll_vvsvl
def veoldPVSLLvrl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "pvsll $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll intrisic=pvsll_vvvMvl
def veoldPVSLLvvml_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsll $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll intrisic=pvsll_vvsMvl
def veoldPVSLLvrml_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsll $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvvl
def veoldVSRLvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsrl $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvvvl
def veoldVSRLvvl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "vsrl $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvsl
def veoldVSRLvrl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsrl $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvsvl
def veoldVSRLvrl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "vsrl $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvsl
def veoldVSRLvil : RV<0xf5, (outs V64:$vx), (ins V64:$vz, simm7:$N, I32:$vl),
       "vsrl $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvsvl
def veoldVSRLvil_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, simm7:$N, I32:$vl, V64:$pt),
       "vsrl $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvvmvl
def veoldVSRLvvml_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vsrl $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvsmvl
def veoldVSRLvrml_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vsrl $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvsmvl
def veoldVSRLviml_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, simm7:$N, VM:$vm, I32:$vl, V64:$pt),
       "vsrl $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl intrisic=pvsrl_vvvl
def veoldPVSRLvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsrl $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl intrisic=pvsrl_vvvvl
def veoldPVSRLvvl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "pvsrl $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl intrisic=pvsrl_vvsl
def veoldPVSRLvrl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsrl $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl intrisic=pvsrl_vvsvl
def veoldPVSRLvrl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "pvsrl $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl intrisic=pvsrl_vvvMvl
def veoldPVSRLvvml_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsrl $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl intrisic=pvsrl_vvsMvl
def veoldPVSRLvrml_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsrl $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.sx intrisic=vslawsx_vvvl
def veoldVSLAWSXvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsla.w.sx $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.sx intrisic=vslawsx_vvvvl
def veoldVSLAWSXvvl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "vsla.w.sx $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.sx intrisic=vslawsx_vvsl
def veoldVSLAWSXvrl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I32:$sy, I32:$vl),
       "vsla.w.sx $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.sx intrisic=vslawsx_vvsvl
def veoldVSLAWSXvrl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I32:$sy, I32:$vl, V64:$pt),
       "vsla.w.sx $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.sx intrisic=vslawsx_vvsl
def veoldVSLAWSXvil : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7:$N, I32:$vl),
       "vsla.w.sx $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.sx intrisic=vslawsx_vvsvl
def veoldVSLAWSXvil_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7:$N, I32:$vl, V64:$pt),
       "vsla.w.sx $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.sx intrisic=vslawsx_vvvmvl
def veoldVSLAWSXvvml_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vsla.w.sx $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.sx intrisic=vslawsx_vvsmvl
def veoldVSLAWSXvrml_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I32:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vsla.w.sx $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.sx intrisic=vslawsx_vvsmvl
def veoldVSLAWSXviml_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7:$N, VM:$vm, I32:$vl, V64:$pt),
       "vsla.w.sx $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.zx intrisic=vslawzx_vvvl
def veoldVSLAWZXvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsla.w.zx $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.zx intrisic=vslawzx_vvvvl
def veoldVSLAWZXvvl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "vsla.w.zx $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.zx intrisic=vslawzx_vvsl
def veoldVSLAWZXvrl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I32:$sy, I32:$vl),
       "vsla.w.zx $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.zx intrisic=vslawzx_vvsvl
def veoldVSLAWZXvrl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I32:$sy, I32:$vl, V64:$pt),
       "vsla.w.zx $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.zx intrisic=vslawzx_vvsl
def veoldVSLAWZXvil : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7:$N, I32:$vl),
       "vsla.w.zx $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.zx intrisic=vslawzx_vvsvl
def veoldVSLAWZXvil_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7:$N, I32:$vl, V64:$pt),
       "vsla.w.zx $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.zx intrisic=vslawzx_vvvmvl
def veoldVSLAWZXvvml_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vsla.w.zx $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.zx intrisic=vslawzx_vvsmvl
def veoldVSLAWZXvrml_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I32:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vsla.w.zx $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.zx intrisic=vslawzx_vvsmvl
def veoldVSLAWZXviml_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7:$N, VM:$vm, I32:$vl, V64:$pt),
       "vsla.w.zx $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla intrisic=pvsla_vvvl
def veoldPVSLAvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsla $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla intrisic=pvsla_vvvvl
def veoldPVSLAvvl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "pvsla $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla intrisic=pvsla_vvsl
def veoldPVSLAvrl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsla $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla intrisic=pvsla_vvsvl
def veoldPVSLAvrl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "pvsla $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla intrisic=pvsla_vvvMvl
def veoldPVSLAvvml_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsla $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla intrisic=pvsla_vvsMvl
def veoldPVSLAvrml_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsla $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvvl
def veoldVSLALvvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsla.l $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvvvl
def veoldVSLALvvl_v : RV<0xd4, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "vsla.l $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvsl
def veoldVSLALvrl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsla.l $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvsvl
def veoldVSLALvrl_v : RV<0xd4, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "vsla.l $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvsl
def veoldVSLALvil : RV<0xd4, (outs V64:$vx), (ins V64:$vz, simm7:$N, I32:$vl),
       "vsla.l $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvsvl
def veoldVSLALvil_v : RV<0xd4, (outs V64:$vx), (ins V64:$vz, simm7:$N, I32:$vl, V64:$pt),
       "vsla.l $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvvmvl
def veoldVSLALvvml_v : RV<0xd4, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vsla.l $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvsmvl
def veoldVSLALvrml_v : RV<0xd4, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vsla.l $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvsmvl
def veoldVSLALviml_v : RV<0xd4, (outs V64:$vx), (ins V64:$vz, simm7:$N, VM:$vm, I32:$vl, V64:$pt),
       "vsla.l $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.sx intrisic=vsrawsx_vvvl
def veoldVSRAWSXvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsra.w.sx $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.sx intrisic=vsrawsx_vvvvl
def veoldVSRAWSXvvl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "vsra.w.sx $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.sx intrisic=vsrawsx_vvsl
def veoldVSRAWSXvrl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I32:$sy, I32:$vl),
       "vsra.w.sx $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.sx intrisic=vsrawsx_vvsvl
def veoldVSRAWSXvrl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I32:$sy, I32:$vl, V64:$pt),
       "vsra.w.sx $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.sx intrisic=vsrawsx_vvsl
def veoldVSRAWSXvil : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7:$N, I32:$vl),
       "vsra.w.sx $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.sx intrisic=vsrawsx_vvsvl
def veoldVSRAWSXvil_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7:$N, I32:$vl, V64:$pt),
       "vsra.w.sx $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.sx intrisic=vsrawsx_vvvmvl
def veoldVSRAWSXvvml_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vsra.w.sx $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.sx intrisic=vsrawsx_vvsmvl
def veoldVSRAWSXvrml_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I32:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vsra.w.sx $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.sx intrisic=vsrawsx_vvsmvl
def veoldVSRAWSXviml_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7:$N, VM:$vm, I32:$vl, V64:$pt),
       "vsra.w.sx $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.zx intrisic=vsrawzx_vvvl
def veoldVSRAWZXvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsra.w.zx $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.zx intrisic=vsrawzx_vvvvl
def veoldVSRAWZXvvl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "vsra.w.zx $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.zx intrisic=vsrawzx_vvsl
def veoldVSRAWZXvrl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I32:$sy, I32:$vl),
       "vsra.w.zx $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.zx intrisic=vsrawzx_vvsvl
def veoldVSRAWZXvrl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I32:$sy, I32:$vl, V64:$pt),
       "vsra.w.zx $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.zx intrisic=vsrawzx_vvsl
def veoldVSRAWZXvil : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7:$N, I32:$vl),
       "vsra.w.zx $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.zx intrisic=vsrawzx_vvsvl
def veoldVSRAWZXvil_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7:$N, I32:$vl, V64:$pt),
       "vsra.w.zx $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.zx intrisic=vsrawzx_vvvmvl
def veoldVSRAWZXvvml_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vsra.w.zx $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.zx intrisic=vsrawzx_vvsmvl
def veoldVSRAWZXvrml_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I32:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vsra.w.zx $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.zx intrisic=vsrawzx_vvsmvl
def veoldVSRAWZXviml_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7:$N, VM:$vm, I32:$vl, V64:$pt),
       "vsra.w.zx $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra intrisic=pvsra_vvvl
def veoldPVSRAvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsra $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra intrisic=pvsra_vvvvl
def veoldPVSRAvvl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "pvsra $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra intrisic=pvsra_vvsl
def veoldPVSRAvrl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsra $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra intrisic=pvsra_vvsvl
def veoldPVSRAvrl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "pvsra $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra intrisic=pvsra_vvvMvl
def veoldPVSRAvvml_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsra $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra intrisic=pvsra_vvsMvl
def veoldPVSRAvrml_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsra $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvvl
def veoldVSRALvvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsra.l $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvvvl
def veoldVSRALvvl_v : RV<0xd5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "vsra.l $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvsl
def veoldVSRALvrl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsra.l $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvsvl
def veoldVSRALvrl_v : RV<0xd5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "vsra.l $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvsl
def veoldVSRALvil : RV<0xd5, (outs V64:$vx), (ins V64:$vz, simm7:$N, I32:$vl),
       "vsra.l $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvsvl
def veoldVSRALvil_v : RV<0xd5, (outs V64:$vx), (ins V64:$vz, simm7:$N, I32:$vl, V64:$pt),
       "vsra.l $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvvmvl
def veoldVSRALvvml_v : RV<0xd5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vsra.l $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvsmvl
def veoldVSRALvrml_v : RV<0xd5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vsra.l $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvsmvl
def veoldVSRALviml_v : RV<0xd5, (outs V64:$vx), (ins V64:$vz, simm7:$N, VM:$vm, I32:$vl, V64:$pt),
       "vsra.l $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSFA asm=vsfa intrisic=vsfa_vvssl
def veoldVSFAvrrl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, I32:$vl),
       "vsfa $vx,$vz,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSFA asm=vsfa intrisic=vsfa_vvssvl
def veoldVSFAvrrl_v : RV<0xd7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vsfa $vx,$vz,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSFA asm=vsfa intrisic=vsfa_vvssl
def veoldVSFAvirl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, simm7:$I, I64:$sz, I32:$vl),
       "vsfa $vx,$vz,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSFA asm=vsfa intrisic=vsfa_vvssvl
def veoldVSFAvirl_v : RV<0xd7, (outs V64:$vx), (ins V64:$vz, simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vsfa $vx,$vz,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSFA asm=vsfa intrisic=vsfa_vvssmvl
def veoldVSFAvrrml_v : RV<0xd7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vsfa $vx,$vz,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSFA asm=vsfa intrisic=vsfa_vvssmvl
def veoldVSFAvirml_v : RV<0xd7, (outs V64:$vx), (ins V64:$vz, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vsfa $vx,$vz,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.d intrisic=vfaddd_vvvl
def veoldVFADDDvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfadd.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.d intrisic=vfaddd_vvvvl
def veoldVFADDDvvl_v : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vfadd.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.d intrisic=vfaddd_vsvl
def veoldVFADDDrvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfadd.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.d intrisic=vfaddd_vsvvl
def veoldVFADDDrvl_v : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vfadd.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.d intrisic=vfaddd_vvvmvl
def veoldVFADDDvvml_v : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfadd.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.d intrisic=vfaddd_vsvmvl
def veoldVFADDDrvml_v : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfadd.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.s intrisic=vfadds_vvvl
def veoldVFADDSvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfadd.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.s intrisic=vfadds_vvvvl
def veoldVFADDSvvl_v : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vfadd.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.s intrisic=vfadds_vsvl
def veoldVFADDSrvl : RV<0xcc, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfadd.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.s intrisic=vfadds_vsvvl
def veoldVFADDSrvl_v : RV<0xcc, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vfadd.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.s intrisic=vfadds_vvvmvl
def veoldVFADDSvvml_v : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfadd.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.s intrisic=vfadds_vsvmvl
def veoldVFADDSrvml_v : RV<0xcc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfadd.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=pvfadd intrisic=pvfadd_vvvl
def veoldPVFADDvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfadd $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=pvfadd intrisic=pvfadd_vvvvl
def veoldPVFADDvvl_v : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvfadd $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=pvfadd intrisic=pvfadd_vsvl
def veoldPVFADDrvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfadd $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=pvfadd intrisic=pvfadd_vsvvl
def veoldPVFADDrvl_v : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvfadd $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=pvfadd intrisic=pvfadd_vvvMvl
def veoldPVFADDvvml_v : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfadd $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=pvfadd intrisic=pvfadd_vsvMvl
def veoldPVFADDrvml_v : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfadd $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.d intrisic=vfsubd_vvvl
def veoldVFSUBDvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfsub.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.d intrisic=vfsubd_vvvvl
def veoldVFSUBDvvl_v : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vfsub.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.d intrisic=vfsubd_vsvl
def veoldVFSUBDrvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfsub.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.d intrisic=vfsubd_vsvvl
def veoldVFSUBDrvl_v : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vfsub.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.d intrisic=vfsubd_vvvmvl
def veoldVFSUBDvvml_v : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfsub.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.d intrisic=vfsubd_vsvmvl
def veoldVFSUBDrvml_v : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfsub.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.s intrisic=vfsubs_vvvl
def veoldVFSUBSvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfsub.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.s intrisic=vfsubs_vvvvl
def veoldVFSUBSvvl_v : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vfsub.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.s intrisic=vfsubs_vsvl
def veoldVFSUBSrvl : RV<0xdc, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfsub.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.s intrisic=vfsubs_vsvvl
def veoldVFSUBSrvl_v : RV<0xdc, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vfsub.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.s intrisic=vfsubs_vvvmvl
def veoldVFSUBSvvml_v : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfsub.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.s intrisic=vfsubs_vsvmvl
def veoldVFSUBSrvml_v : RV<0xdc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfsub.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=pvfsub intrisic=pvfsub_vvvl
def veoldPVFSUBvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfsub $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=pvfsub intrisic=pvfsub_vvvvl
def veoldPVFSUBvvl_v : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvfsub $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=pvfsub intrisic=pvfsub_vsvl
def veoldPVFSUBrvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfsub $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=pvfsub intrisic=pvfsub_vsvvl
def veoldPVFSUBrvl_v : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvfsub $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=pvfsub intrisic=pvfsub_vvvMvl
def veoldPVFSUBvvml_v : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfsub $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=pvfsub intrisic=pvfsub_vsvMvl
def veoldPVFSUBrvml_v : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfsub $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.d intrisic=vfmuld_vvvl
def veoldVFMULDvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmul.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.d intrisic=vfmuld_vvvvl
def veoldVFMULDvvl_v : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vfmul.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.d intrisic=vfmuld_vsvl
def veoldVFMULDrvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfmul.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.d intrisic=vfmuld_vsvvl
def veoldVFMULDrvl_v : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vfmul.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.d intrisic=vfmuld_vvvmvl
def veoldVFMULDvvml_v : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmul.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.d intrisic=vfmuld_vsvmvl
def veoldVFMULDrvml_v : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmul.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.s intrisic=vfmuls_vvvl
def veoldVFMULSvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmul.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.s intrisic=vfmuls_vvvvl
def veoldVFMULSvvl_v : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vfmul.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.s intrisic=vfmuls_vsvl
def veoldVFMULSrvl : RV<0xcd, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfmul.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.s intrisic=vfmuls_vsvvl
def veoldVFMULSrvl_v : RV<0xcd, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vfmul.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.s intrisic=vfmuls_vvvmvl
def veoldVFMULSvvml_v : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmul.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.s intrisic=vfmuls_vsvmvl
def veoldVFMULSrvml_v : RV<0xcd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmul.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=pvfmul intrisic=pvfmul_vvvl
def veoldPVFMULvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfmul $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=pvfmul intrisic=pvfmul_vvvvl
def veoldPVFMULvvl_v : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvfmul $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=pvfmul intrisic=pvfmul_vsvl
def veoldPVFMULrvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfmul $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=pvfmul intrisic=pvfmul_vsvvl
def veoldPVFMULrvl_v : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvfmul $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=pvfmul intrisic=pvfmul_vvvMvl
def veoldPVFMULvvml_v : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmul $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=pvfmul intrisic=pvfmul_vsvMvl
def veoldPVFMULrvml_v : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmul $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.d intrisic=vfdivd_vvvl
def veoldVFDIVDvvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfdiv.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.d intrisic=vfdivd_vvvvl
def veoldVFDIVDvvl_v : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vfdiv.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.d intrisic=vfdivd_vsvl
def veoldVFDIVDrvl : RV<0xdd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfdiv.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.d intrisic=vfdivd_vsvvl
def veoldVFDIVDrvl_v : RV<0xdd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vfdiv.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.d intrisic=vfdivd_vvvmvl
def veoldVFDIVDvvml_v : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfdiv.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.d intrisic=vfdivd_vsvmvl
def veoldVFDIVDrvml_v : RV<0xdd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfdiv.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.s intrisic=vfdivs_vvvl
def veoldVFDIVSvvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfdiv.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.s intrisic=vfdivs_vvvvl
def veoldVFDIVSvvl_v : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vfdiv.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.s intrisic=vfdivs_vsvl
def veoldVFDIVSrvl : RV<0xdd, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfdiv.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.s intrisic=vfdivs_vsvvl
def veoldVFDIVSrvl_v : RV<0xdd, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vfdiv.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.s intrisic=vfdivs_vvvmvl
def veoldVFDIVSvvml_v : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfdiv.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.s intrisic=vfdivs_vsvmvl
def veoldVFDIVSrvml_v : RV<0xdd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfdiv.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSQRT asm=vfsqrt.d intrisic=vfsqrtd_vvl
def veoldVFSQRTDvl : RV<0xed, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfsqrt.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSQRT asm=vfsqrt.d intrisic=vfsqrtd_vvvl
def veoldVFSQRTDvl_v : RV<0xed, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vfsqrt.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSQRT asm=vfsqrt.s intrisic=vfsqrts_vvl
def veoldVFSQRTSvl : RV<0xed, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfsqrt.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSQRT asm=vfsqrt.s intrisic=vfsqrts_vvvl
def veoldVFSQRTSvl_v : RV<0xed, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vfsqrt.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.d intrisic=vfcmpd_vvvl
def veoldVFCMPDvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfcmp.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.d intrisic=vfcmpd_vvvvl
def veoldVFCMPDvvl_v : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vfcmp.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.d intrisic=vfcmpd_vsvl
def veoldVFCMPDrvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfcmp.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.d intrisic=vfcmpd_vsvvl
def veoldVFCMPDrvl_v : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vfcmp.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.d intrisic=vfcmpd_vvvmvl
def veoldVFCMPDvvml_v : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfcmp.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.d intrisic=vfcmpd_vsvmvl
def veoldVFCMPDrvml_v : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfcmp.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.s intrisic=vfcmps_vvvl
def veoldVFCMPSvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfcmp.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.s intrisic=vfcmps_vvvvl
def veoldVFCMPSvvl_v : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vfcmp.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.s intrisic=vfcmps_vsvl
def veoldVFCMPSrvl : RV<0xfc, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfcmp.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.s intrisic=vfcmps_vsvvl
def veoldVFCMPSrvl_v : RV<0xfc, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vfcmp.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.s intrisic=vfcmps_vvvmvl
def veoldVFCMPSvvml_v : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfcmp.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.s intrisic=vfcmps_vsvmvl
def veoldVFCMPSrvml_v : RV<0xfc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfcmp.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=pvfcmp intrisic=pvfcmp_vvvl
def veoldPVFCMPvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfcmp $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=pvfcmp intrisic=pvfcmp_vvvvl
def veoldPVFCMPvvl_v : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvfcmp $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=pvfcmp intrisic=pvfcmp_vsvl
def veoldPVFCMPrvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfcmp $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=pvfcmp intrisic=pvfcmp_vsvvl
def veoldPVFCMPrvl_v : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvfcmp $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=pvfcmp intrisic=pvfcmp_vvvMvl
def veoldPVFCMPvvml_v : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfcmp $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=pvfcmp intrisic=pvfcmp_vsvMvl
def veoldPVFCMPrvml_v : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfcmp $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.d intrisic=vfmaxd_vvvl
def veoldVFMAXDvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmax.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.d intrisic=vfmaxd_vvvvl
def veoldVFMAXDvvl_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vfmax.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.d intrisic=vfmaxd_vsvl
def veoldVFMAXDrvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfmax.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.d intrisic=vfmaxd_vsvvl
def veoldVFMAXDrvl_v : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vfmax.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.d intrisic=vfmaxd_vvvmvl
def veoldVFMAXDvvml_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmax.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.d intrisic=vfmaxd_vsvmvl
def veoldVFMAXDrvml_v : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmax.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.s intrisic=vfmaxs_vvvl
def veoldVFMAXSvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmax.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.s intrisic=vfmaxs_vvvvl
def veoldVFMAXSvvl_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vfmax.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.s intrisic=vfmaxs_vsvl
def veoldVFMAXSrvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfmax.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.s intrisic=vfmaxs_vsvvl
def veoldVFMAXSrvl_v : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vfmax.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.s intrisic=vfmaxs_vvvmvl
def veoldVFMAXSvvml_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmax.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.s intrisic=vfmaxs_vsvmvl
def veoldVFMAXSrvml_v : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmax.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmax intrisic=pvfmax_vvvl
def veoldPVFMAXvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfmax $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmax intrisic=pvfmax_vvvvl
def veoldPVFMAXvvl_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvfmax $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmax intrisic=pvfmax_vsvl
def veoldPVFMAXrvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfmax $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmax intrisic=pvfmax_vsvvl
def veoldPVFMAXrvl_v : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvfmax $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmax intrisic=pvfmax_vvvMvl
def veoldPVFMAXvvml_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmax $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmax intrisic=pvfmax_vsvMvl
def veoldPVFMAXrvml_v : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmax $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.d intrisic=vfmind_vvvl
def veoldVFMINDvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmin.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.d intrisic=vfmind_vvvvl
def veoldVFMINDvvl_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vfmin.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.d intrisic=vfmind_vsvl
def veoldVFMINDrvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfmin.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.d intrisic=vfmind_vsvvl
def veoldVFMINDrvl_v : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vfmin.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.d intrisic=vfmind_vvvmvl
def veoldVFMINDvvml_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmin.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.d intrisic=vfmind_vsvmvl
def veoldVFMINDrvml_v : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmin.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.s intrisic=vfmins_vvvl
def veoldVFMINSvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmin.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.s intrisic=vfmins_vvvvl
def veoldVFMINSvvl_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "vfmin.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.s intrisic=vfmins_vsvl
def veoldVFMINSrvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfmin.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.s intrisic=vfmins_vsvvl
def veoldVFMINSrvl_v : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl, V64:$pt),
       "vfmin.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.s intrisic=vfmins_vvvmvl
def veoldVFMINSvvml_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmin.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.s intrisic=vfmins_vsvmvl
def veoldVFMINSrvml_v : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmin.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmin intrisic=pvfmin_vvvl
def veoldPVFMINvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfmin $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmin intrisic=pvfmin_vvvvl
def veoldPVFMINvvl_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvfmin $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmin intrisic=pvfmin_vsvl
def veoldPVFMINrvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfmin $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmin intrisic=pvfmin_vsvvl
def veoldPVFMINrvl_v : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvfmin $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmin intrisic=pvfmin_vvvMvl
def veoldPVFMINvvml_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmin $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmin intrisic=pvfmin_vsvMvl
def veoldPVFMINrvml_v : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmin $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vvvvl
def veoldVFMADDvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vvvvvl
def veoldVFMADDvvvl_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "vfmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vsvvl
def veoldVFMADDrvvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vsvvvl
def veoldVFMADDrvvl_v : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "vfmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vvsvl
def veoldVFMADDvrvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "vfmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vvsvvl
def veoldVFMADDvrvl_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl, V64:$pt),
       "vfmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vvvvmvl
def veoldVFMADDvvvml_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmad.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vsvvmvl
def veoldVFMADDrvvml_v : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmad.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vvsvmvl
def veoldVFMADDvrvml_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmad.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vvvvl
def veoldVFMADSvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vvvvvl
def veoldVFMADSvvvl_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "vfmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vsvvl
def veoldVFMADSrvvl : RV<0xe2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vsvvvl
def veoldVFMADSrvvl_v : RV<0xe2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "vfmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vvsvl
def veoldVFMADSvrvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, I32:$vl),
       "vfmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vvsvvl
def veoldVFMADSvrvl_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, I32:$vl, V64:$pt),
       "vfmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vvvvmvl
def veoldVFMADSvvvml_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmad.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vsvvmvl
def veoldVFMADSrvvml_v : RV<0xe2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmad.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vvsvmvl
def veoldVFMADSvrvml_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmad.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vvvvl
def veoldPVFMADvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "pvfmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vvvvvl
def veoldPVFMADvvvl_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "pvfmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vsvvl
def veoldPVFMADrvvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "pvfmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vsvvvl
def veoldPVFMADrvvl_v : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "pvfmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vvsvl
def veoldPVFMADvrvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "pvfmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vvsvvl
def veoldPVFMADvrvl_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl, V64:$pt),
       "pvfmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vvvvMvl
def veoldPVFMADvvvml_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmad $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vsvvMvl
def veoldPVFMADrvvml_v : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmad $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vvsvMvl
def veoldPVFMADvrvml_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmad $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vvvvl
def veoldVFMSBDvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vvvvvl
def veoldVFMSBDvvvl_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "vfmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vsvvl
def veoldVFMSBDrvvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vsvvvl
def veoldVFMSBDrvvl_v : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "vfmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vvsvl
def veoldVFMSBDvrvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "vfmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vvsvvl
def veoldVFMSBDvrvl_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl, V64:$pt),
       "vfmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vvvvmvl
def veoldVFMSBDvvvml_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmsb.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vsvvmvl
def veoldVFMSBDrvvml_v : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmsb.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vvsvmvl
def veoldVFMSBDvrvml_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmsb.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vvvvl
def veoldVFMSBSvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vvvvvl
def veoldVFMSBSvvvl_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "vfmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vsvvl
def veoldVFMSBSrvvl : RV<0xf2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vsvvvl
def veoldVFMSBSrvvl_v : RV<0xf2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "vfmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vvsvl
def veoldVFMSBSvrvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, I32:$vl),
       "vfmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vvsvvl
def veoldVFMSBSvrvl_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, I32:$vl, V64:$pt),
       "vfmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vvvvmvl
def veoldVFMSBSvvvml_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmsb.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vsvvmvl
def veoldVFMSBSrvvml_v : RV<0xf2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmsb.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vvsvmvl
def veoldVFMSBSvrvml_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmsb.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vvvvl
def veoldPVFMSBvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "pvfmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vvvvvl
def veoldPVFMSBvvvl_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "pvfmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vsvvl
def veoldPVFMSBrvvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "pvfmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vsvvvl
def veoldPVFMSBrvvl_v : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "pvfmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vvsvl
def veoldPVFMSBvrvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "pvfmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vvsvvl
def veoldPVFMSBvrvl_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl, V64:$pt),
       "pvfmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vvvvMvl
def veoldPVFMSBvvvml_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmsb $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vsvvMvl
def veoldPVFMSBrvvml_v : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmsb $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vvsvMvl
def veoldPVFMSBvrvml_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmsb $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vvvvl
def veoldVFNMADDvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vvvvvl
def veoldVFNMADDvvvl_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "vfnmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vsvvl
def veoldVFNMADDrvvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vsvvvl
def veoldVFNMADDrvvl_v : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "vfnmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vvsvl
def veoldVFNMADDvrvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "vfnmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vvsvvl
def veoldVFNMADDvrvl_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl, V64:$pt),
       "vfnmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vvvvmvl
def veoldVFNMADDvvvml_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmad.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vsvvmvl
def veoldVFNMADDrvvml_v : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmad.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vvsvmvl
def veoldVFNMADDvrvml_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmad.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vvvvl
def veoldVFNMADSvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vvvvvl
def veoldVFNMADSvvvl_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "vfnmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vsvvl
def veoldVFNMADSrvvl : RV<0xe3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vsvvvl
def veoldVFNMADSrvvl_v : RV<0xe3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "vfnmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vvsvl
def veoldVFNMADSvrvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, I32:$vl),
       "vfnmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vvsvvl
def veoldVFNMADSvrvl_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, I32:$vl, V64:$pt),
       "vfnmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vvvvmvl
def veoldVFNMADSvvvml_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmad.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vsvvmvl
def veoldVFNMADSrvvml_v : RV<0xe3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmad.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vvsvmvl
def veoldVFNMADSvrvml_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmad.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vvvvl
def veoldPVFNMADvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "pvfnmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vvvvvl
def veoldPVFNMADvvvl_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "pvfnmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vsvvl
def veoldPVFNMADrvvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "pvfnmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vsvvvl
def veoldPVFNMADrvvl_v : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "pvfnmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vvsvl
def veoldPVFNMADvrvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "pvfnmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vvsvvl
def veoldPVFNMADvrvl_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl, V64:$pt),
       "pvfnmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vvvvMvl
def veoldPVFNMADvvvml_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfnmad $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vsvvMvl
def veoldPVFNMADrvvml_v : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfnmad $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vvsvMvl
def veoldPVFNMADvrvml_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfnmad $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vvvvl
def veoldVFNMSBDvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vvvvvl
def veoldVFNMSBDvvvl_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "vfnmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vsvvl
def veoldVFNMSBDrvvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vsvvvl
def veoldVFNMSBDrvvl_v : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "vfnmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vvsvl
def veoldVFNMSBDvrvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "vfnmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vvsvvl
def veoldVFNMSBDvrvl_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl, V64:$pt),
       "vfnmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vvvvmvl
def veoldVFNMSBDvvvml_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmsb.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vsvvmvl
def veoldVFNMSBDrvvml_v : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmsb.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vvsvmvl
def veoldVFNMSBDvrvml_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmsb.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vvvvl
def veoldVFNMSBSvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vvvvvl
def veoldVFNMSBSvvvl_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "vfnmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vsvvl
def veoldVFNMSBSrvvl : RV<0xf3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vsvvvl
def veoldVFNMSBSrvvl_v : RV<0xf3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "vfnmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vvsvl
def veoldVFNMSBSvrvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, I32:$vl),
       "vfnmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vvsvvl
def veoldVFNMSBSvrvl_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, I32:$vl, V64:$pt),
       "vfnmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vvvvmvl
def veoldVFNMSBSvvvml_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmsb.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vsvvmvl
def veoldVFNMSBSrvvml_v : RV<0xf3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmsb.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vvsvmvl
def veoldVFNMSBSvrvml_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmsb.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vvvvl
def veoldPVFNMSBvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "pvfnmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vvvvvl
def veoldPVFNMSBvvvl_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "pvfnmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vsvvl
def veoldPVFNMSBrvvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "pvfnmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vsvvvl
def veoldPVFNMSBrvvl_v : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl, V64:$pt),
       "pvfnmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vvsvl
def veoldPVFNMSBvrvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "pvfnmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vvsvvl
def veoldPVFNMSBvrvl_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl, V64:$pt),
       "pvfnmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vvvvMvl
def veoldPVFNMSBvvvml_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfnmsb $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vsvvMvl
def veoldPVFNMSBrvvml_v : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfnmsb $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vvsvMvl
def veoldPVFNMSBvrvml_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfnmsb $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRCP asm=vrcp.d intrisic=vrcpd_vvl
def veoldVRCPDvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrcp.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRCP asm=vrcp.d intrisic=vrcpd_vvvl
def veoldVRCPDvl_v : RV<0xe1, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrcp.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRCP asm=vrcp.s intrisic=vrcps_vvl
def veoldVRCPSvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrcp.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRCP asm=vrcp.s intrisic=vrcps_vvvl
def veoldVRCPSvl_v : RV<0xe1, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrcp.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRCP asm=pvrcp intrisic=pvrcp_vvl
def veoldPVRCPvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvrcp $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRCP asm=pvrcp intrisic=pvrcp_vvvl
def veoldPVRCPvl_v : RV<0xe1, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "pvrcp $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=vrsqrt.d intrisic=vrsqrtd_vvl
def veoldVRSQRTDvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrsqrt.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=vrsqrt.d intrisic=vrsqrtd_vvvl
def veoldVRSQRTDvl_v : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrsqrt.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=vrsqrt.s intrisic=vrsqrts_vvl
def veoldVRSQRTSvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrsqrt.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=vrsqrt.s intrisic=vrsqrts_vvvl
def veoldVRSQRTSvl_v : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrsqrt.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=pvrsqrt intrisic=pvrsqrt_vvl
def veoldPVRSQRTvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvrsqrt $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=pvrsqrt intrisic=pvrsqrt_vvvl
def veoldPVRSQRTvl_v : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "pvrsqrt $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=vrsqrt.d.nex intrisic=vrsqrtdnex_vvl
def veoldVRSQRTDNEXvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrsqrt.d.nex $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=vrsqrt.d.nex intrisic=vrsqrtdnex_vvvl
def veoldVRSQRTDNEXvl_v : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrsqrt.d.nex $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=vrsqrt.s.nex intrisic=vrsqrtsnex_vvl
def veoldVRSQRTSNEXvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrsqrt.s.nex $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=vrsqrt.s.nex intrisic=vrsqrtsnex_vvvl
def veoldVRSQRTSNEXvl_v : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrsqrt.s.nex $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=pvrsqrt.nex intrisic=pvrsqrtnex_vvl
def veoldPVRSQRTNEXvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvrsqrt.nex $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=pvrsqrt.nex intrisic=pvrsqrtnex_vvvl
def veoldPVRSQRTNEXvl_v : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "pvrsqrt.nex $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFLT asm=vcvt.d.w intrisic=vcvtdw_vvl
def veoldVCVTDWvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.d.w $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFLT asm=vcvt.d.w intrisic=vcvtdw_vvvl
def veoldVCVTDWvl_v : RV<0xf8, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vcvt.d.w $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFLT asm=vcvt.s.w intrisic=vcvtsw_vvl
def veoldVCVTSWvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.s.w $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFLT asm=vcvt.s.w intrisic=vcvtsw_vvvl
def veoldVCVTSWvl_v : RV<0xf8, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vcvt.s.w $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFLT asm=pvcvt.s.w intrisic=pvcvtsw_vvl
def veoldPVCVTSWvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvcvt.s.w $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFLT asm=pvcvt.s.w intrisic=pvcvtsw_vvvl
def veoldPVCVTSWvl_v : RV<0xf8, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "pvcvt.s.w $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFLTX asm=vcvt.d.l intrisic=vcvtdl_vvl
def veoldVCVTDLvl : RV<0xb8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.d.l $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFLTX asm=vcvt.d.l intrisic=vcvtdl_vvvl
def veoldVCVTDLvl_v : RV<0xb8, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vcvt.d.l $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCVD asm=vcvt.d.s intrisic=vcvtds_vvl
def veoldVCVTDSvl : RV<0x8f, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.d.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCVD asm=vcvt.d.s intrisic=vcvtds_vvvl
def veoldVCVTDSvl_v : RV<0x8f, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vcvt.d.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCVS asm=vcvt.s.d intrisic=vcvtsd_vvl
def veoldVCVTSDvl : RV<0x9f, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.s.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCVS asm=vcvt.s.d intrisic=vcvtsd_vvvl
def veoldVCVTSDvl_v : RV<0x9f, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vcvt.s.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vvvml
def veoldVMRGvvml : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl),
       "vmrg $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vvvmvl
def veoldVMRGvvml_v : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmrg $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vsvml
def veoldVMRGrvml : RV<0xd6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl),
       "vmrg $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vsvmvl
def veoldVMRGrvml_v : RV<0xd6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmrg $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vsvml
def veoldVMRGivml : RV<0xd6, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl),
       "vmrg $vx,$I,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vsvmvl
def veoldVMRGivml_v : RV<0xd6, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmrg $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg.w intrisic=vmrgw_vvvMl
def veoldVMRGWvvml : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl),
       "vmrg.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg.w intrisic=vmrgw_vvvMvl
def veoldVMRGWvvml_v : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "vmrg.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg.w intrisic=vmrgw_vsvMl
def veoldVMRGWrvml : RV<0xd6, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM512:$vm, I32:$vl),
       "vmrg.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg.w intrisic=vmrgw_vsvMvl
def veoldVMRGWrvml_v : RV<0xd6, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "vmrg.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSHF asm=vshf intrisic=vshf_vvvsl
def veoldVSHFvvrl : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I64:$sy, I32:$vl),
       "vshf $vx,$vy,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSHF asm=vshf intrisic=vshf_vvvsvl
def veoldVSHFvvrl_v : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "vshf $vx,$vy,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSHF asm=vshf intrisic=vshf_vvvsl
def veoldVSHFvvil : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, simm7:$N, I32:$vl),
       "vshf $vx,$vy,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSHF asm=vshf intrisic=vshf_vvvsvl
def veoldVSHFvvil_v : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, simm7:$N, I32:$vl, V64:$pt),
       "vshf $vx,$vy,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCP asm=vcp intrisic=vcp_vvmvl
def veoldVCPvml_v : RV<0x8d, (outs V64:$vx), (ins V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcp $vx,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEX asm=vex intrisic=vex_vvmvl
def veoldVEXvml_v : RV<0x9d, (outs V64:$vx), (ins V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vex $vx,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.at intrisic=vfmklat_ml
def veoldVFMKLal : RV<0xb4, (outs VM:$vmx), (ins I32:$vl),
       "vfmk.l.at $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.af intrisic=vfmklaf_ml
def veoldVFMKLnal : RV<0xb4, (outs VM:$vmx), (ins I32:$vl),
       "vfmk.l.af $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUMS asm=vsum.w.sx intrisic=vsumwsx_vvl
def veoldVSUMWSXvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vsum.w.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUMS asm=vsum.w.sx intrisic=vsumwsx_vvml
def veoldVSUMWSXvml : RV<0xea, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl),
       "vsum.w.sx $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUMS asm=vsum.w.zx intrisic=vsumwzx_vvl
def veoldVSUMWZXvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vsum.w.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUMS asm=vsum.w.zx intrisic=vsumwzx_vvml
def veoldVSUMWZXvml : RV<0xea, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl),
       "vsum.w.zx $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUMX asm=vsum.l intrisic=vsuml_vvl
def veoldVSUMLvl : RV<0xaa, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vsum.l $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUMX asm=vsum.l intrisic=vsuml_vvml
def veoldVSUMLvml : RV<0xaa, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl),
       "vsum.l $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSUM asm=vfsum.d intrisic=vfsumd_vvl
def veoldVFSUMDvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfsum.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSUM asm=vfsum.d intrisic=vfsumd_vvml
def veoldVFSUMDvml : RV<0xec, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl),
       "vfsum.d $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSUM asm=vfsum.s intrisic=vfsums_vvl
def veoldVFSUMSvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfsum.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSUM asm=vfsum.s intrisic=vfsums_vvml
def veoldVFSUMSvml : RV<0xec, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl),
       "vfsum.s $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmaxs.w.fst.sx intrisic=vrmaxswfstsx_vvl
def veoldVRMAXSWFSTSXvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmaxs.w.fst.sx intrisic=vrmaxswfstsx_vvvl
def veoldVRMAXSWFSTSXvl_v : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrmaxs.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmaxs.w.lst.sx intrisic=vrmaxswlstsx_vvl
def veoldVRMAXSWLSTSXvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmaxs.w.lst.sx intrisic=vrmaxswlstsx_vvvl
def veoldVRMAXSWLSTSXvl_v : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrmaxs.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmaxs.w.fst.zx intrisic=vrmaxswfstzx_vvl
def veoldVRMAXSWFSTZXvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmaxs.w.fst.zx intrisic=vrmaxswfstzx_vvvl
def veoldVRMAXSWFSTZXvl_v : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrmaxs.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmaxs.w.lst.zx intrisic=vrmaxswlstzx_vvl
def veoldVRMAXSWLSTZXvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmaxs.w.lst.zx intrisic=vrmaxswlstzx_vvvl
def veoldVRMAXSWLSTZXvl_v : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrmaxs.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmins.w.fst.sx intrisic=vrminswfstsx_vvl
def veoldVRMINSWFSTSXvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmins.w.fst.sx intrisic=vrminswfstsx_vvvl
def veoldVRMINSWFSTSXvl_v : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrmins.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmins.w.lst.sx intrisic=vrminswlstsx_vvl
def veoldVRMINSWLSTSXvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmins.w.lst.sx intrisic=vrminswlstsx_vvvl
def veoldVRMINSWLSTSXvl_v : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrmins.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmins.w.fst.zx intrisic=vrminswfstzx_vvl
def veoldVRMINSWFSTZXvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmins.w.fst.zx intrisic=vrminswfstzx_vvvl
def veoldVRMINSWFSTZXvl_v : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrmins.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmins.w.lst.zx intrisic=vrminswlstzx_vvl
def veoldVRMINSWLSTZXvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmins.w.lst.zx intrisic=vrminswlstzx_vvvl
def veoldVRMINSWLSTZXvl_v : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrmins.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXX asm=vrmaxs.l.fst intrisic=vrmaxslfst_vvl
def veoldVRMAXSLFSTvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.l.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXX asm=vrmaxs.l.fst intrisic=vrmaxslfst_vvvl
def veoldVRMAXSLFSTvl_v : RV<0xab, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrmaxs.l.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXX asm=vrmaxs.l.lst intrisic=vrmaxsllst_vvl
def veoldVRMAXSLLSTvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.l.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXX asm=vrmaxs.l.lst intrisic=vrmaxsllst_vvvl
def veoldVRMAXSLLSTvl_v : RV<0xab, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrmaxs.l.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXX asm=vrmins.l.fst intrisic=vrminslfst_vvl
def veoldVRMINSLFSTvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.l.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXX asm=vrmins.l.fst intrisic=vrminslfst_vvvl
def veoldVRMINSLFSTvl_v : RV<0xab, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrmins.l.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXX asm=vrmins.l.lst intrisic=vrminsllst_vvl
def veoldVRMINSLLSTvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.l.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXX asm=vrmins.l.lst intrisic=vrminsllst_vvvl
def veoldVRMINSLLSTvl_v : RV<0xab, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vrmins.l.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmax.d.fst intrisic=vfrmaxdfst_vvl
def veoldVFRMAXDFSTvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmax.d.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmax.d.fst intrisic=vfrmaxdfst_vvvl
def veoldVFRMAXDFSTvl_v : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vfrmax.d.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmax.d.lst intrisic=vfrmaxdlst_vvl
def veoldVFRMAXDLSTvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmax.d.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmax.d.lst intrisic=vfrmaxdlst_vvvl
def veoldVFRMAXDLSTvl_v : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vfrmax.d.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmax.s.fst intrisic=vfrmaxsfst_vvl
def veoldVFRMAXSFSTvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmax.s.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmax.s.fst intrisic=vfrmaxsfst_vvvl
def veoldVFRMAXSFSTvl_v : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vfrmax.s.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmax.s.lst intrisic=vfrmaxslst_vvl
def veoldVFRMAXSLSTvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmax.s.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmax.s.lst intrisic=vfrmaxslst_vvvl
def veoldVFRMAXSLSTvl_v : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vfrmax.s.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmin.d.fst intrisic=vfrmindfst_vvl
def veoldVFRMINDFSTvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmin.d.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmin.d.fst intrisic=vfrmindfst_vvvl
def veoldVFRMINDFSTvl_v : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vfrmin.d.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmin.d.lst intrisic=vfrmindlst_vvl
def veoldVFRMINDLSTvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmin.d.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmin.d.lst intrisic=vfrmindlst_vvvl
def veoldVFRMINDLSTvl_v : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vfrmin.d.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmin.s.fst intrisic=vfrminsfst_vvl
def veoldVFRMINSFSTvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmin.s.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmin.s.fst intrisic=vfrminsfst_vvvl
def veoldVFRMINSFSTvl_v : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vfrmin.s.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmin.s.lst intrisic=vfrminslst_vvl
def veoldVFRMINSLSTvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmin.s.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmin.s.lst intrisic=vfrminslst_vvvl
def veoldVFRMINSLSTvl_v : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vfrmin.s.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRAND asm=vrand intrisic=vrand_vvl
def veoldVRANDvl : RV<0x88, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrand $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRAND asm=vrand intrisic=vrand_vvml
def veoldVRANDvml : RV<0x88, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl),
       "vrand $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VROR asm=vror intrisic=vror_vvl
def veoldVRORvl : RV<0x98, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vror $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VROR asm=vror intrisic=vror_vvml
def veoldVRORvml : RV<0x98, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl),
       "vror $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRXOR asm=vrxor intrisic=vrxor_vvl
def veoldVRXORvl : RV<0x89, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrxor $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRXOR asm=vrxor intrisic=vrxor_vvml
def veoldVRXORvml : RV<0x89, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl),
       "vrxor $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssl
def veoldVGTvrrl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgt $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssvl
def veoldVGTvrrl_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vgt $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssl
def veoldVGTvrzl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vgt $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssvl
def veoldVGTvrzl_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, I32:$vl, V64:$pt),
       "vgt $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssl
def veoldVGTvirl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vgt $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssvl
def veoldVGTvirl_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vgt $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssl
def veoldVGTvizl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vgt $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssvl
def veoldVGTvizl_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, I32:$vl, V64:$pt),
       "vgt $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssml
def veoldVGTvrrml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vgt $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssmvl
def veoldVGTvrrml_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgt $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssml
def veoldVGTvrzml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vgt $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssmvl
def veoldVGTvrzml_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgt $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssml
def veoldVGTvirml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vgt $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssmvl
def veoldVGTvirml_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgt $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssml
def veoldVGTvizml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vgt $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssmvl
def veoldVGTvizml_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgt $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssl
def veoldVGTNCvrrl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssvl
def veoldVGTNCvrrl_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vgt.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssl
def veoldVGTNCvrzl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssvl
def veoldVGTNCvrzl_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, I32:$vl, V64:$pt),
       "vgt.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssl
def veoldVGTNCvirl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vgt.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssvl
def veoldVGTNCvirl_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vgt.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssl
def veoldVGTNCvizl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vgt.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssvl
def veoldVGTNCvizl_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, I32:$vl, V64:$pt),
       "vgt.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssml
def veoldVGTNCvrrml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssmvl
def veoldVGTNCvrrml_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgt.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssml
def veoldVGTNCvrzml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssmvl
def veoldVGTNCvrzml_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgt.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssml
def veoldVGTNCvirml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vgt.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssmvl
def veoldVGTNCvirml_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgt.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssml
def veoldVGTNCvizml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vgt.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssmvl
def veoldVGTNCvizml_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgt.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssl
def veoldVGTUvrrl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtu $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssvl
def veoldVGTUvrrl_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vgtu $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssl
def veoldVGTUvrzl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vgtu $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssvl
def veoldVGTUvrzl_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, I32:$vl, V64:$pt),
       "vgtu $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssl
def veoldVGTUvirl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vgtu $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssvl
def veoldVGTUvirl_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vgtu $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssl
def veoldVGTUvizl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vgtu $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssvl
def veoldVGTUvizl_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, I32:$vl, V64:$pt),
       "vgtu $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssml
def veoldVGTUvrrml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vgtu $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssmvl
def veoldVGTUvrrml_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtu $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssml
def veoldVGTUvrzml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vgtu $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssmvl
def veoldVGTUvrzml_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtu $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssml
def veoldVGTUvirml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vgtu $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssmvl
def veoldVGTUvirml_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtu $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssml
def veoldVGTUvizml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vgtu $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssmvl
def veoldVGTUvizml_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtu $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssl
def veoldVGTUNCvrrl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssvl
def veoldVGTUNCvrrl_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vgtu.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssl
def veoldVGTUNCvrzl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssvl
def veoldVGTUNCvrzl_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, I32:$vl, V64:$pt),
       "vgtu.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssl
def veoldVGTUNCvirl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssvl
def veoldVGTUNCvirl_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vgtu.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssl
def veoldVGTUNCvizl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssvl
def veoldVGTUNCvizl_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, I32:$vl, V64:$pt),
       "vgtu.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssml
def veoldVGTUNCvrrml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssmvl
def veoldVGTUNCvrrml_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtu.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssml
def veoldVGTUNCvrzml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssmvl
def veoldVGTUNCvrzml_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtu.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssml
def veoldVGTUNCvirml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssmvl
def veoldVGTUNCvirml_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtu.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssml
def veoldVGTUNCvizml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssmvl
def veoldVGTUNCvizml_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtu.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssl
def veoldVGTLSXvrrl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssvl
def veoldVGTLSXvrrl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vgtl.sx $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssl
def veoldVGTLSXvrzl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssvl
def veoldVGTLSXvrzl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, I32:$vl, V64:$pt),
       "vgtl.sx $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssl
def veoldVGTLSXvirl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssvl
def veoldVGTLSXvirl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vgtl.sx $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssl
def veoldVGTLSXvizl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssvl
def veoldVGTLSXvizl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, I32:$vl, V64:$pt),
       "vgtl.sx $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssml
def veoldVGTLSXvrrml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssmvl
def veoldVGTLSXvrrml_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.sx $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssml
def veoldVGTLSXvrzml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssmvl
def veoldVGTLSXvrzml_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.sx $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssml
def veoldVGTLSXvirml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssmvl
def veoldVGTLSXvirml_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.sx $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssml
def veoldVGTLSXvizml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssmvl
def veoldVGTLSXvizml_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.sx $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssl
def veoldVGTLSXNCvrrl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssvl
def veoldVGTLSXNCvrrl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vgtl.sx.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssl
def veoldVGTLSXNCvrzl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssvl
def veoldVGTLSXNCvrzl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, I32:$vl, V64:$pt),
       "vgtl.sx.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssl
def veoldVGTLSXNCvirl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssvl
def veoldVGTLSXNCvirl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vgtl.sx.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssl
def veoldVGTLSXNCvizl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssvl
def veoldVGTLSXNCvizl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, I32:$vl, V64:$pt),
       "vgtl.sx.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssml
def veoldVGTLSXNCvrrml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssmvl
def veoldVGTLSXNCvrrml_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.sx.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssml
def veoldVGTLSXNCvrzml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssmvl
def veoldVGTLSXNCvrzml_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.sx.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssml
def veoldVGTLSXNCvirml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssmvl
def veoldVGTLSXNCvirml_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.sx.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssml
def veoldVGTLSXNCvizml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssmvl
def veoldVGTLSXNCvizml_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.sx.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssl
def veoldVGTLZXvrrl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssvl
def veoldVGTLZXvrrl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vgtl.zx $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssl
def veoldVGTLZXvrzl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssvl
def veoldVGTLZXvrzl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, I32:$vl, V64:$pt),
       "vgtl.zx $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssl
def veoldVGTLZXvirl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssvl
def veoldVGTLZXvirl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vgtl.zx $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssl
def veoldVGTLZXvizl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssvl
def veoldVGTLZXvizl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, I32:$vl, V64:$pt),
       "vgtl.zx $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssml
def veoldVGTLZXvrrml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssmvl
def veoldVGTLZXvrrml_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.zx $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssml
def veoldVGTLZXvrzml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssmvl
def veoldVGTLZXvrzml_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.zx $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssml
def veoldVGTLZXvirml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssmvl
def veoldVGTLZXvirml_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.zx $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssml
def veoldVGTLZXvizml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssmvl
def veoldVGTLZXvizml_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.zx $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssl
def veoldVGTLZXNCvrrl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssvl
def veoldVGTLZXNCvrrl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl, V64:$pt),
       "vgtl.zx.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssl
def veoldVGTLZXNCvrzl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssvl
def veoldVGTLZXNCvrzl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, I32:$vl, V64:$pt),
       "vgtl.zx.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssl
def veoldVGTLZXNCvirl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssvl
def veoldVGTLZXNCvirl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, I32:$vl, V64:$pt),
       "vgtl.zx.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssl
def veoldVGTLZXNCvizl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssvl
def veoldVGTLZXNCvizl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, I32:$vl, V64:$pt),
       "vgtl.zx.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssml
def veoldVGTLZXNCvrrml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssmvl
def veoldVGTLZXNCvrrml_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.zx.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssml
def veoldVGTLZXNCvrzml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssmvl
def veoldVGTLZXNCvrzml_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.zx.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssml
def veoldVGTLZXNCvirml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssmvl
def veoldVGTLZXNCvirml_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.zx.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssml
def veoldVGTLZXNCvizml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssmvl
def veoldVGTLZXNCvizml_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.zx.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssl
def veoldVSCvrrvl : RV<0xb1, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vsc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssl
def veoldVSCvrzvl : RV<0xb1, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, I32:$vl),
       "vsc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssl
def veoldVSCvirvl : RV<0xb1, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vsc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssl
def veoldVSCvizvl : RV<0xb1, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, I32:$vl),
       "vsc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssml
def veoldVSCvrrvml : RV<0xb1, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vsc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssml
def veoldVSCvrzvml : RV<0xb1, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vsc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssml
def veoldVSCvirvml : RV<0xb1, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vsc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssml
def veoldVSCvizvml : RV<0xb1, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vsc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssl
def veoldVSCNCvrrvl : RV<0xb1, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vsc.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssl
def veoldVSCNCvrzvl : RV<0xb1, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, I32:$vl),
       "vsc.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssl
def veoldVSCNCvirvl : RV<0xb1, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vsc.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssl
def veoldVSCNCvizvl : RV<0xb1, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, I32:$vl),
       "vsc.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssml
def veoldVSCNCvrrvml : RV<0xb1, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vsc.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssml
def veoldVSCNCvrzvml : RV<0xb1, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vsc.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssml
def veoldVSCNCvirvml : RV<0xb1, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vsc.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssml
def veoldVSCNCvizvml : RV<0xb1, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vsc.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssl
def veoldVSCOTvrrvl : RV<0xb1, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vsc.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssl
def veoldVSCOTvrzvl : RV<0xb1, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, I32:$vl),
       "vsc.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssl
def veoldVSCOTvirvl : RV<0xb1, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vsc.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssl
def veoldVSCOTvizvl : RV<0xb1, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, I32:$vl),
       "vsc.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssml
def veoldVSCOTvrrvml : RV<0xb1, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssml
def veoldVSCOTvrzvml : RV<0xb1, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssml
def veoldVSCOTvirvml : RV<0xb1, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssml
def veoldVSCOTvizvml : RV<0xb1, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssl
def veoldVSCNCOTvrrvl : RV<0xb1, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vsc.nc.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssl
def veoldVSCNCOTvrzvl : RV<0xb1, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, I32:$vl),
       "vsc.nc.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssl
def veoldVSCNCOTvirvl : RV<0xb1, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vsc.nc.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssl
def veoldVSCNCOTvizvl : RV<0xb1, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, I32:$vl),
       "vsc.nc.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssml
def veoldVSCNCOTvrrvml : RV<0xb1, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vsc.nc.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssml
def veoldVSCNCOTvrzvml : RV<0xb1, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vsc.nc.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssml
def veoldVSCNCOTvirvml : RV<0xb1, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vsc.nc.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssml
def veoldVSCNCOTvizvml : RV<0xb1, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vsc.nc.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssl
def veoldVSCUvrrvl : RV<0xb2, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vscu $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssl
def veoldVSCUvrzvl : RV<0xb2, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, I32:$vl),
       "vscu $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssl
def veoldVSCUvirvl : RV<0xb2, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vscu $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssl
def veoldVSCUvizvl : RV<0xb2, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, I32:$vl),
       "vscu $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssml
def veoldVSCUvrrvml : RV<0xb2, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vscu $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssml
def veoldVSCUvrzvml : RV<0xb2, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vscu $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssml
def veoldVSCUvirvml : RV<0xb2, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vscu $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssml
def veoldVSCUvizvml : RV<0xb2, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vscu $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssl
def veoldVSCUNCvrrvl : RV<0xb2, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vscu.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssl
def veoldVSCUNCvrzvl : RV<0xb2, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, I32:$vl),
       "vscu.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssl
def veoldVSCUNCvirvl : RV<0xb2, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vscu.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssl
def veoldVSCUNCvizvl : RV<0xb2, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, I32:$vl),
       "vscu.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssml
def veoldVSCUNCvrrvml : RV<0xb2, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vscu.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssml
def veoldVSCUNCvrzvml : RV<0xb2, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vscu.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssml
def veoldVSCUNCvirvml : RV<0xb2, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vscu.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssml
def veoldVSCUNCvizvml : RV<0xb2, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vscu.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssl
def veoldVSCUOTvrrvl : RV<0xb2, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vscu.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssl
def veoldVSCUOTvrzvl : RV<0xb2, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, I32:$vl),
       "vscu.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssl
def veoldVSCUOTvirvl : RV<0xb2, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vscu.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssl
def veoldVSCUOTvizvl : RV<0xb2, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, I32:$vl),
       "vscu.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssml
def veoldVSCUOTvrrvml : RV<0xb2, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssml
def veoldVSCUOTvrzvml : RV<0xb2, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssml
def veoldVSCUOTvirvml : RV<0xb2, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssml
def veoldVSCUOTvizvml : RV<0xb2, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssl
def veoldVSCUNCOTvrrvl : RV<0xb2, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vscu.nc.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssl
def veoldVSCUNCOTvrzvl : RV<0xb2, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, I32:$vl),
       "vscu.nc.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssl
def veoldVSCUNCOTvirvl : RV<0xb2, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vscu.nc.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssl
def veoldVSCUNCOTvizvl : RV<0xb2, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, I32:$vl),
       "vscu.nc.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssml
def veoldVSCUNCOTvrrvml : RV<0xb2, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vscu.nc.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssml
def veoldVSCUNCOTvrzvml : RV<0xb2, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vscu.nc.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssml
def veoldVSCUNCOTvirvml : RV<0xb2, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vscu.nc.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssml
def veoldVSCUNCOTvizvml : RV<0xb2, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vscu.nc.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssl
def veoldVSCLvrrvl : RV<0xb3, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vscl $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssl
def veoldVSCLvrzvl : RV<0xb3, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, I32:$vl),
       "vscl $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssl
def veoldVSCLvirvl : RV<0xb3, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vscl $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssl
def veoldVSCLvizvl : RV<0xb3, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, I32:$vl),
       "vscl $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssml
def veoldVSCLvrrvml : RV<0xb3, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vscl $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssml
def veoldVSCLvrzvml : RV<0xb3, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vscl $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssml
def veoldVSCLvirvml : RV<0xb3, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vscl $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssml
def veoldVSCLvizvml : RV<0xb3, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vscl $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssl
def veoldVSCLNCvrrvl : RV<0xb3, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vscl.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssl
def veoldVSCLNCvrzvl : RV<0xb3, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, I32:$vl),
       "vscl.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssl
def veoldVSCLNCvirvl : RV<0xb3, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vscl.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssl
def veoldVSCLNCvizvl : RV<0xb3, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, I32:$vl),
       "vscl.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssml
def veoldVSCLNCvrrvml : RV<0xb3, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vscl.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssml
def veoldVSCLNCvrzvml : RV<0xb3, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vscl.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssml
def veoldVSCLNCvirvml : RV<0xb3, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vscl.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssml
def veoldVSCLNCvizvml : RV<0xb3, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vscl.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssl
def veoldVSCLOTvrrvl : RV<0xb3, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vscl.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssl
def veoldVSCLOTvrzvl : RV<0xb3, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, I32:$vl),
       "vscl.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssl
def veoldVSCLOTvirvl : RV<0xb3, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vscl.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssl
def veoldVSCLOTvizvl : RV<0xb3, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, I32:$vl),
       "vscl.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssml
def veoldVSCLOTvrrvml : RV<0xb3, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssml
def veoldVSCLOTvrzvml : RV<0xb3, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssml
def veoldVSCLOTvirvml : RV<0xb3, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssml
def veoldVSCLOTvizvml : RV<0xb3, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssl
def veoldVSCLNCOTvrrvl : RV<0xb3, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, I32:$vl),
       "vscl.nc.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssl
def veoldVSCLNCOTvrzvl : RV<0xb3, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, I32:$vl),
       "vscl.nc.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssl
def veoldVSCLNCOTvirvl : RV<0xb3, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, I32:$vl),
       "vscl.nc.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssl
def veoldVSCLNCOTvizvl : RV<0xb3, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, I32:$vl),
       "vscl.nc.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssml
def veoldVSCLNCOTvrrvml : RV<0xb3, (outs ), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vscl.nc.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssml
def veoldVSCLNCOTvrzvml : RV<0xb3, (outs ), (ins V64:$vy, I64:$sy, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vscl.nc.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssml
def veoldVSCLNCOTvirvml : RV<0xb3, (outs ), (ins V64:$vy, simm7:$I, I64:$sz, V64:$vx, VM:$vm, I32:$vl),
       "vscl.nc.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssml
def veoldVSCLNCOTvizvml : RV<0xb3, (outs ), (ins V64:$vy, simm7:$I, simm7:$Z, V64:$vx, VM:$vm, I32:$vl),
       "vscl.nc.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=ANDM asm=andm intrisic=andm_mmm
def veoldANDMmm : RV<0x84, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz),
       "andm $vmx,$vmy,$vmz", [], NoItinerary>
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

// inst=ORM asm=orm intrisic=orm_mmm
def veoldORMmm : RV<0x85, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz),
       "orm $vmx,$vmy,$vmz", [], NoItinerary>
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

// inst=XORM asm=xorm intrisic=xorm_mmm
def veoldXORMmm : RV<0x86, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz),
       "xorm $vmx,$vmy,$vmz", [], NoItinerary>
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

// inst=EQVM asm=eqvm intrisic=eqvm_mmm
def veoldEQVMmm : RV<0x87, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz),
       "eqvm $vmx,$vmy,$vmz", [], NoItinerary>
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

// inst=NNDM asm=nndm intrisic=nndm_mmm
def veoldNNDMmm : RV<0x94, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz),
       "nndm $vmx,$vmy,$vmz", [], NoItinerary>
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

// inst=NEGM asm=negm intrisic=negm_mm
def veoldNEGMm : RV<0x95, (outs VM:$vmx), (ins VM:$vmy),
       "negm $vmx,$vmy", [], NoItinerary>
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

// inst=PCVM asm=pcvm intrisic=pcvm_sml
def veoldPCVMml : RV<0xa4, (outs I64:$sx), (ins VM:$vmy, I32:$vl),
       "pcvm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=LZVM asm=lzvm intrisic=lzvm_sml
def veoldLZVMml : RV<0xa5, (outs I64:$sx), (ins VM:$vmy, I32:$vl),
       "lzvm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=TOVM asm=tovm intrisic=tovm_sml
def veoldTOVMml : RV<0xa6, (outs I64:$sx), (ins VM:$vmy, I32:$vl),
       "tovm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}


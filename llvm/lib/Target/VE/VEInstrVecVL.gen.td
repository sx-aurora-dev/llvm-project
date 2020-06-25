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
def veoldVSTvrrl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst intrisic=vst_vssl
def veoldVSTvirl : RV<0x91, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vst $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst intrisic=vst_vssml
def veoldVSTvrrxl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vst $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst intrisic=vst_vssml
def veoldVSTvirxl : RV<0x91, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vst $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc intrisic=vstnc_vssl
def veoldVSTNCvrrl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc intrisic=vstnc_vssl
def veoldVSTNCvirl : RV<0x91, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vst.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc intrisic=vstnc_vssml
def veoldVSTNCvrrxl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vst.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc intrisic=vstnc_vssml
def veoldVSTNCvirxl : RV<0x91, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vst.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.ot intrisic=vstot_vssl
def veoldVSTOTvrrl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.ot intrisic=vstot_vssl
def veoldVSTOTvirl : RV<0x91, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vst.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.ot intrisic=vstot_vssml
def veoldVSTOTvrrxl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vst.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.ot intrisic=vstot_vssml
def veoldVSTOTvirxl : RV<0x91, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vst.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc.ot intrisic=vstncot_vssl
def veoldVSTNCOTvrrl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc.ot intrisic=vstncot_vssl
def veoldVSTNCOTvirl : RV<0x91, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vst.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc.ot intrisic=vstncot_vssml
def veoldVSTNCOTvrrxl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vst.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc.ot intrisic=vstncot_vssml
def veoldVSTNCOTvirxl : RV<0x91, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vst.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu intrisic=vstu_vssl
def veoldVSTUvrrl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu intrisic=vstu_vssl
def veoldVSTUvirl : RV<0x92, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vstu $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu intrisic=vstu_vssml
def veoldVSTUvrrxl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vstu $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu intrisic=vstu_vssml
def veoldVSTUvirxl : RV<0x92, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vstu $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc intrisic=vstunc_vssl
def veoldVSTUNCvrrl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc intrisic=vstunc_vssl
def veoldVSTUNCvirl : RV<0x92, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vstu.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc intrisic=vstunc_vssml
def veoldVSTUNCvrrxl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vstu.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc intrisic=vstunc_vssml
def veoldVSTUNCvirxl : RV<0x92, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vstu.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.ot intrisic=vstuot_vssl
def veoldVSTUOTvrrl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.ot intrisic=vstuot_vssl
def veoldVSTUOTvirl : RV<0x92, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vstu.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.ot intrisic=vstuot_vssml
def veoldVSTUOTvrrxl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vstu.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.ot intrisic=vstuot_vssml
def veoldVSTUOTvirxl : RV<0x92, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vstu.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc.ot intrisic=vstuncot_vssl
def veoldVSTUNCOTvrrl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc.ot intrisic=vstuncot_vssl
def veoldVSTUNCOTvirl : RV<0x92, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vstu.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc.ot intrisic=vstuncot_vssml
def veoldVSTUNCOTvrrxl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vstu.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc.ot intrisic=vstuncot_vssml
def veoldVSTUNCOTvirxl : RV<0x92, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vstu.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl intrisic=vstl_vssl
def veoldVSTLvrrl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl intrisic=vstl_vssl
def veoldVSTLvirl : RV<0x93, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vstl $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl intrisic=vstl_vssml
def veoldVSTLvrrxl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vstl $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl intrisic=vstl_vssml
def veoldVSTLvirxl : RV<0x93, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vstl $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc intrisic=vstlnc_vssl
def veoldVSTLNCvrrl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc intrisic=vstlnc_vssl
def veoldVSTLNCvirl : RV<0x93, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vstl.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc intrisic=vstlnc_vssml
def veoldVSTLNCvrrxl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vstl.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc intrisic=vstlnc_vssml
def veoldVSTLNCvirxl : RV<0x93, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vstl.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.ot intrisic=vstlot_vssl
def veoldVSTLOTvrrl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.ot intrisic=vstlot_vssl
def veoldVSTLOTvirl : RV<0x93, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vstl.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.ot intrisic=vstlot_vssml
def veoldVSTLOTvrrxl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vstl.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.ot intrisic=vstlot_vssml
def veoldVSTLOTvirxl : RV<0x93, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vstl.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc.ot intrisic=vstlncot_vssl
def veoldVSTLNCOTvrrl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc.ot intrisic=vstlncot_vssl
def veoldVSTLNCOTvirl : RV<0x93, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vstl.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc.ot intrisic=vstlncot_vssml
def veoldVSTLNCOTvrrxl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vstl.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc.ot intrisic=vstlncot_vssml
def veoldVSTLNCOTvirxl : RV<0x93, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vstl.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d intrisic=vst2d_vssl
def veoldVST2Dvrrl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d intrisic=vst2d_vssl
def veoldVST2Dvirl : RV<0xd1, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vst2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d intrisic=vst2d_vssml
def veoldVST2Dvrrxl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vst2d $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d intrisic=vst2d_vssml
def veoldVST2Dvirxl : RV<0xd1, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vst2d $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc intrisic=vst2dnc_vssl
def veoldVST2DNCvrrl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc intrisic=vst2dnc_vssl
def veoldVST2DNCvirl : RV<0xd1, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vst2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc intrisic=vst2dnc_vssml
def veoldVST2DNCvrrxl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vst2d.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc intrisic=vst2dnc_vssml
def veoldVST2DNCvirxl : RV<0xd1, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vst2d.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.ot intrisic=vst2dot_vssl
def veoldVST2DOTvrrl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.ot intrisic=vst2dot_vssl
def veoldVST2DOTvirl : RV<0xd1, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vst2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.ot intrisic=vst2dot_vssml
def veoldVST2DOTvrrxl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vst2d.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.ot intrisic=vst2dot_vssml
def veoldVST2DOTvirxl : RV<0xd1, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vst2d.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc.ot intrisic=vst2dncot_vssl
def veoldVST2DNCOTvrrl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst2d.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc.ot intrisic=vst2dncot_vssl
def veoldVST2DNCOTvirl : RV<0xd1, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vst2d.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc.ot intrisic=vst2dncot_vssml
def veoldVST2DNCOTvrrxl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vst2d.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc.ot intrisic=vst2dncot_vssml
def veoldVST2DNCOTvirxl : RV<0xd1, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vst2d.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d intrisic=vstu2d_vssl
def veoldVSTU2Dvrrl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d intrisic=vstu2d_vssl
def veoldVSTU2Dvirl : RV<0xd2, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vstu2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d intrisic=vstu2d_vssml
def veoldVSTU2Dvrrxl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vstu2d $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d intrisic=vstu2d_vssml
def veoldVSTU2Dvirxl : RV<0xd2, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vstu2d $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc intrisic=vstu2dnc_vssl
def veoldVSTU2DNCvrrl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc intrisic=vstu2dnc_vssl
def veoldVSTU2DNCvirl : RV<0xd2, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vstu2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc intrisic=vstu2dnc_vssml
def veoldVSTU2DNCvrrxl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vstu2d.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc intrisic=vstu2dnc_vssml
def veoldVSTU2DNCvirxl : RV<0xd2, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vstu2d.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.ot intrisic=vstu2dot_vssl
def veoldVSTU2DOTvrrl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.ot intrisic=vstu2dot_vssl
def veoldVSTU2DOTvirl : RV<0xd2, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vstu2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.ot intrisic=vstu2dot_vssml
def veoldVSTU2DOTvrrxl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vstu2d.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.ot intrisic=vstu2dot_vssml
def veoldVSTU2DOTvirxl : RV<0xd2, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vstu2d.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc.ot intrisic=vstu2dncot_vssl
def veoldVSTU2DNCOTvrrl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu2d.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc.ot intrisic=vstu2dncot_vssl
def veoldVSTU2DNCOTvirl : RV<0xd2, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vstu2d.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc.ot intrisic=vstu2dncot_vssml
def veoldVSTU2DNCOTvrrxl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vstu2d.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc.ot intrisic=vstu2dncot_vssml
def veoldVSTU2DNCOTvirxl : RV<0xd2, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vstu2d.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d intrisic=vstl2d_vssl
def veoldVSTL2Dvrrl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d intrisic=vstl2d_vssl
def veoldVSTL2Dvirl : RV<0xd3, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vstl2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d intrisic=vstl2d_vssml
def veoldVSTL2Dvrrxl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vstl2d $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d intrisic=vstl2d_vssml
def veoldVSTL2Dvirxl : RV<0xd3, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vstl2d $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc intrisic=vstl2dnc_vssl
def veoldVSTL2DNCvrrl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc intrisic=vstl2dnc_vssl
def veoldVSTL2DNCvirl : RV<0xd3, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vstl2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc intrisic=vstl2dnc_vssml
def veoldVSTL2DNCvrrxl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vstl2d.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc intrisic=vstl2dnc_vssml
def veoldVSTL2DNCvirxl : RV<0xd3, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vstl2d.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.ot intrisic=vstl2dot_vssl
def veoldVSTL2DOTvrrl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.ot intrisic=vstl2dot_vssl
def veoldVSTL2DOTvirl : RV<0xd3, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vstl2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.ot intrisic=vstl2dot_vssml
def veoldVSTL2DOTvrrxl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vstl2d.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.ot intrisic=vstl2dot_vssml
def veoldVSTL2DOTvirxl : RV<0xd3, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vstl2d.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc.ot intrisic=vstl2dncot_vssl
def veoldVSTL2DNCOTvrrl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl2d.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc.ot intrisic=vstl2dncot_vssl
def veoldVSTL2DNCOTvirl : RV<0xd3, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, I32:$vl),
       "vstl2d.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc.ot intrisic=vstl2dncot_vssml
def veoldVSTL2DNCOTvrrxl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vstl2d.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc.ot intrisic=vstl2dncot_vssml
def veoldVSTL2DNCOTvirxl : RV<0xd3, (outs ), (ins V64:$vx, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
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
def veoldLVMxrr_x : RV<0xb7, (outs VM:$vmx), (ins I64:$sy, I64:$sz, VM:$ptm),
       "lvm $vmx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vmx = $ptm";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=LVM asm=lvm intrisic=lvm_mmss
def veoldLVMxir_x : RV<0xb7, (outs VM:$vmx), (ins simm7:$N, I64:$sz, VM:$ptm),
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
def veoldSVMxr : RV<0xa7, (outs I64:$sx), (ins VM:$vmz, I64:$sy),
       "svm $sx,$vmz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=SVM asm=svm intrisic=svm_sms
def veoldSVMxi : RV<0xa7, (outs I64:$sx), (ins VM:$vmz, simm7:$N),
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
def veoldVBRDrxl_v : RV<0x8c, (outs V64:$vx), (ins I64:$sy, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVBRDixl_v : RV<0x8c, (outs V64:$vx), (ins simm7:$I, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVBRDUrxl_v : RV<0x8c, (outs V64:$vx), (ins F32:$sy, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVBRDLrxl_v : RV<0x8c, (outs V64:$vx), (ins I32:$sy, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVBRDLixl_v : RV<0x8c, (outs V64:$vx), (ins simm7:$I, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVBRDrxl_v : RV<0x8c, (outs V64:$vx), (ins I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVMVrvxl_v : RV<0x9c, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmv $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMV asm=vmv intrisic=vmv_vsvmvl
def veoldVMVivxl_v : RV<0x9c, (outs V64:$vx), (ins simm7:$N, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVADDULvvxl_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vaddu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vsvmvl
def veoldVADDULrvxl_v : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vaddu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vsvmvl
def veoldVADDULivxl_v : RV<0xc8, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVADDUWvvxl_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vaddu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vsvmvl
def veoldVADDUWrvxl_v : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vaddu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vsvmvl
def veoldVADDUWivxl_v : RV<0xc8, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVADDUvvxl_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvaddu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=pvaddu intrisic=pvaddu_vsvMvl
def veoldPVADDUrvxl_v : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVADDSWSXvvxl_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vadds.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vsvmvl
def veoldVADDSWSXrvxl_v : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vadds.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vsvmvl
def veoldVADDSWSXivxl_v : RV<0xca, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVADDSWZXvvxl_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vadds.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vsvmvl
def veoldVADDSWZXrvxl_v : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vadds.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vsvmvl
def veoldVADDSWZXivxl_v : RV<0xca, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVADDSvvxl_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvadds $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=pvadds intrisic=pvadds_vsvMvl
def veoldPVADDSrvxl_v : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVADDSLvvxl_v : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vadds.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vsvmvl
def veoldVADDSLrvxl_v : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vadds.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vsvmvl
def veoldVADDSLivxl_v : RV<0x8b, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVSUBULvvxl_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vsvmvl
def veoldVSUBULrvxl_v : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vsvmvl
def veoldVSUBULivxl_v : RV<0xc8, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVSUBUWvvxl_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vsvmvl
def veoldVSUBUWrvxl_v : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vsvmvl
def veoldVSUBUWivxl_v : RV<0xc8, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVSUBUvvxl_v : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvsubu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=pvsubu intrisic=pvsubu_vsvMvl
def veoldPVSUBUrvxl_v : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVSUBSWSXvvxl_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vsvmvl
def veoldVSUBSWSXrvxl_v : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vsvmvl
def veoldVSUBSWSXivxl_v : RV<0xca, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVSUBSWZXvvxl_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vsvmvl
def veoldVSUBSWZXrvxl_v : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vsvmvl
def veoldVSUBSWZXivxl_v : RV<0xca, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVSUBSvvxl_v : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvsubs $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=pvsubs intrisic=pvsubs_vsvMvl
def veoldPVSUBSrvxl_v : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVSUBSLvvxl_v : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vsvmvl
def veoldVSUBSLrvxl_v : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vsubs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vsvmvl
def veoldVSUBSLivxl_v : RV<0x8b, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVMULULvvxl_v : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmulu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vsvmvl
def veoldVMULULrvxl_v : RV<0xc9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmulu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vsvmvl
def veoldVMULULivxl_v : RV<0xc9, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVMULUWvvxl_v : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmulu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vsvmvl
def veoldVMULUWrvxl_v : RV<0xc9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmulu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vsvmvl
def veoldVMULUWivxl_v : RV<0xc9, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVMULSWSXvvxl_v : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmuls.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vsvmvl
def veoldVMULSWSXrvxl_v : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmuls.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vsvmvl
def veoldVMULSWSXivxl_v : RV<0xcb, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVMULSWZXvvxl_v : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmuls.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vsvmvl
def veoldVMULSWZXrvxl_v : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmuls.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vsvmvl
def veoldVMULSWZXivxl_v : RV<0xcb, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVMULSLvvxl_v : RV<0xdb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmuls.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vsvmvl
def veoldVMULSLrvxl_v : RV<0xdb, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmuls.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vsvmvl
def veoldVMULSLivxl_v : RV<0xdb, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVDIVULvvxl_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vsvmvl
def veoldVDIVULrvxl_v : RV<0xe9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vsvmvl
def veoldVDIVULivxl_v : RV<0xe9, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVDIVUWvvxl_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vsvmvl
def veoldVDIVUWrvxl_v : RV<0xe9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vsvmvl
def veoldVDIVUWivxl_v : RV<0xe9, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVDIVULvrxl_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vdivu.l $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvsmvl
def veoldVDIVULvixl_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7:$I, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVDIVUWvrxl_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vdivu.w $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvsmvl
def veoldVDIVUWvixl_v : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7:$I, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVDIVSWSXvvxl_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vsvmvl
def veoldVDIVSWSXrvxl_v : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vsvmvl
def veoldVDIVSWSXivxl_v : RV<0xeb, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVDIVSWZXvvxl_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vsvmvl
def veoldVDIVSWZXrvxl_v : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vsvmvl
def veoldVDIVSWZXivxl_v : RV<0xeb, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVDIVSWSXvrxl_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.w.sx $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvsmvl
def veoldVDIVSWSXvixl_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7:$I, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVDIVSWZXvrxl_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.w.zx $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvsmvl
def veoldVDIVSWZXvixl_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7:$I, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVDIVSLvvxl_v : RV<0xfb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vsvmvl
def veoldVDIVSLrvxl_v : RV<0xfb, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vsvmvl
def veoldVDIVSLivxl_v : RV<0xfb, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVDIVSLvrxl_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vdivs.l $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvsmvl
def veoldVDIVSLvixl_v : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7:$I, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVCMPULvvxl_v : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmpu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vsvmvl
def veoldVCMPULrvxl_v : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmpu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vsvmvl
def veoldVCMPULivxl_v : RV<0xb9, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVCMPUWvvxl_v : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmpu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vsvmvl
def veoldVCMPUWrvxl_v : RV<0xb9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmpu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vsvmvl
def veoldVCMPUWivxl_v : RV<0xb9, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVCMPUvvxl_v : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvcmpu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=pvcmpu intrisic=pvcmpu_vsvMvl
def veoldPVCMPUrvxl_v : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVCMPSWSXvvxl_v : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmps.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vsvmvl
def veoldVCMPSWSXrvxl_v : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmps.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vsvmvl
def veoldVCMPSWSXivxl_v : RV<0xfa, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVCMPSWZXvvxl_v : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmps.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vsvmvl
def veoldVCMPSWZXrvxl_v : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmps.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vsvmvl
def veoldVCMPSWZXivxl_v : RV<0xfa, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVCMPSvvxl_v : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvcmps $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=pvcmps intrisic=pvcmps_vsvMvl
def veoldPVCMPSrvxl_v : RV<0xfa, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVCMPSLvvxl_v : RV<0xba, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmps.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vsvmvl
def veoldVCMPSLrvxl_v : RV<0xba, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcmps.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vsvmvl
def veoldVCMPSLivxl_v : RV<0xba, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVMAXSWSXvvxl_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmaxs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vsvmvl
def veoldVMAXSWSXrvxl_v : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmaxs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vsvmvl
def veoldVMAXSWSXivxl_v : RV<0x8a, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVMAXSWZXvvxl_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmaxs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vsvmvl
def veoldVMAXSWZXrvxl_v : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmaxs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vsvmvl
def veoldVMAXSWZXivxl_v : RV<0x8a, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVMAXSvvxl_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvmaxs $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmaxs intrisic=pvmaxs_vsvMvl
def veoldPVMAXSrvxl_v : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVMINSWSXvvxl_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmins.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vsvmvl
def veoldVMINSWSXrvxl_v : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmins.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vsvmvl
def veoldVMINSWSXivxl_v : RV<0x8a, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVMINSWZXvvxl_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmins.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vsvmvl
def veoldVMINSWZXrvxl_v : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmins.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vsvmvl
def veoldVMINSWZXivxl_v : RV<0x8a, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVMINSvvxl_v : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvmins $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmins intrisic=pvmins_vsvMvl
def veoldPVMINSrvxl_v : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVMAXSLvvxl_v : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmaxs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vsvmvl
def veoldVMAXSLrvxl_v : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmaxs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vsvmvl
def veoldVMAXSLivxl_v : RV<0x9a, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVMINSLvvxl_v : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmins.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vsvmvl
def veoldVMINSLrvxl_v : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmins.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vsvmvl
def veoldVMINSLivxl_v : RV<0x9a, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVANDvvxl_v : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vand $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=vand intrisic=vand_vsvmvl
def veoldVANDrvxl_v : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vand $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand.lo intrisic=pvandlo_vvvl
def veoldPVANDLOvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvand.lo $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand.lo intrisic=pvandlo_vvvvl
def veoldPVANDLOvvl_v : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvand.lo $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand.lo intrisic=pvandlo_vsvl
def veoldPVANDLOrvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvand.lo $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand.lo intrisic=pvandlo_vsvvl
def veoldPVANDLOrvl_v : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvand.lo $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand.lo intrisic=pvandlo_vvvMvl
def veoldPVANDLOvvxl_v : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvand.lo $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand.lo intrisic=pvandlo_vsvMvl
def veoldPVANDLOrvxl_v : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvand.lo $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand.up intrisic=pvandup_vvvl
def veoldPVANDUPvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvand.up $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand.up intrisic=pvandup_vvvvl
def veoldPVANDUPvvl_v : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvand.up $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand.up intrisic=pvandup_vsvl
def veoldPVANDUPrvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvand.up $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand.up intrisic=pvandup_vsvvl
def veoldPVANDUPrvl_v : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvand.up $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand.up intrisic=pvandup_vvvMvl
def veoldPVANDUPvvxl_v : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvand.up $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand.up intrisic=pvandup_vsvMvl
def veoldPVANDUPrvxl_v : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvand.up $vx,$sy,$vz,$vm", [], NoItinerary>
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
def veoldPVANDvvxl_v : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvand $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand intrisic=pvand_vsvMvl
def veoldPVANDrvxl_v : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVORvvxl_v : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=vor intrisic=vor_vsvmvl
def veoldVORrvxl_v : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor.lo intrisic=pvorlo_vvvl
def veoldPVORLOvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvor.lo $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor.lo intrisic=pvorlo_vvvvl
def veoldPVORLOvvl_v : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvor.lo $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor.lo intrisic=pvorlo_vsvl
def veoldPVORLOrvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvor.lo $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor.lo intrisic=pvorlo_vsvvl
def veoldPVORLOrvl_v : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvor.lo $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor.lo intrisic=pvorlo_vvvMvl
def veoldPVORLOvvxl_v : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvor.lo $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor.lo intrisic=pvorlo_vsvMvl
def veoldPVORLOrvxl_v : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvor.lo $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor.up intrisic=pvorup_vvvl
def veoldPVORUPvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvor.up $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor.up intrisic=pvorup_vvvvl
def veoldPVORUPvvl_v : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvor.up $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor.up intrisic=pvorup_vsvl
def veoldPVORUPrvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvor.up $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor.up intrisic=pvorup_vsvvl
def veoldPVORUPrvl_v : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvor.up $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor.up intrisic=pvorup_vvvMvl
def veoldPVORUPvvxl_v : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvor.up $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor.up intrisic=pvorup_vsvMvl
def veoldPVORUPrvxl_v : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvor.up $vx,$sy,$vz,$vm", [], NoItinerary>
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
def veoldPVORvvxl_v : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor intrisic=pvor_vsvMvl
def veoldPVORrvxl_v : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVXORvvxl_v : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vxor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=vxor intrisic=vxor_vsvmvl
def veoldVXORrvxl_v : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vxor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor.lo intrisic=pvxorlo_vvvl
def veoldPVXORLOvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvxor.lo $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor.lo intrisic=pvxorlo_vvvvl
def veoldPVXORLOvvl_v : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvxor.lo $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor.lo intrisic=pvxorlo_vsvl
def veoldPVXORLOrvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvxor.lo $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor.lo intrisic=pvxorlo_vsvvl
def veoldPVXORLOrvl_v : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvxor.lo $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor.lo intrisic=pvxorlo_vvvMvl
def veoldPVXORLOvvxl_v : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvxor.lo $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor.lo intrisic=pvxorlo_vsvMvl
def veoldPVXORLOrvxl_v : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvxor.lo $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor.up intrisic=pvxorup_vvvl
def veoldPVXORUPvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvxor.up $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor.up intrisic=pvxorup_vvvvl
def veoldPVXORUPvvl_v : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pvxor.up $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor.up intrisic=pvxorup_vsvl
def veoldPVXORUPrvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvxor.up $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor.up intrisic=pvxorup_vsvvl
def veoldPVXORUPrvl_v : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pvxor.up $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor.up intrisic=pvxorup_vvvMvl
def veoldPVXORUPvvxl_v : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvxor.up $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor.up intrisic=pvxorup_vsvMvl
def veoldPVXORUPrvxl_v : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvxor.up $vx,$sy,$vz,$vm", [], NoItinerary>
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
def veoldPVXORvvxl_v : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvxor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor intrisic=pvxor_vsvMvl
def veoldPVXORrvxl_v : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVEQVvvxl_v : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "veqv $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=veqv intrisic=veqv_vsvmvl
def veoldVEQVrvxl_v : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "veqv $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv.lo intrisic=pveqvlo_vvvl
def veoldPVEQVLOvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pveqv.lo $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv.lo intrisic=pveqvlo_vvvvl
def veoldPVEQVLOvvl_v : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pveqv.lo $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv.lo intrisic=pveqvlo_vsvl
def veoldPVEQVLOrvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pveqv.lo $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv.lo intrisic=pveqvlo_vsvvl
def veoldPVEQVLOrvl_v : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pveqv.lo $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv.lo intrisic=pveqvlo_vvvMvl
def veoldPVEQVLOvvxl_v : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pveqv.lo $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv.lo intrisic=pveqvlo_vsvMvl
def veoldPVEQVLOrvxl_v : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pveqv.lo $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv.up intrisic=pveqvup_vvvl
def veoldPVEQVUPvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pveqv.up $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv.up intrisic=pveqvup_vvvvl
def veoldPVEQVUPvvl_v : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl, V64:$pt),
       "pveqv.up $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv.up intrisic=pveqvup_vsvl
def veoldPVEQVUPrvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pveqv.up $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv.up intrisic=pveqvup_vsvvl
def veoldPVEQVUPrvl_v : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl, V64:$pt),
       "pveqv.up $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv.up intrisic=pveqvup_vvvMvl
def veoldPVEQVUPvvxl_v : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pveqv.up $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv.up intrisic=pveqvup_vsvMvl
def veoldPVEQVUPrvxl_v : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pveqv.up $vx,$sy,$vz,$vm", [], NoItinerary>
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
def veoldPVEQVvvxl_v : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pveqv $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv intrisic=pveqv_vsvMvl
def veoldPVEQVrvxl_v : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVSLLvvxl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vsll $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvsmvl
def veoldVSLLvrxl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vsll $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvsmvl
def veoldVSLLvixl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, simm7:$N, VM:$vm, I32:$vl, V64:$pt),
       "vsll $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll.lo intrisic=pvslllo_vvvl
def veoldPVSLLLOvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsll.lo $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll.lo intrisic=pvslllo_vvvvl
def veoldPVSLLLOvvl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "pvsll.lo $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll.lo intrisic=pvslllo_vvsl
def veoldPVSLLLOvrl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsll.lo $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll.lo intrisic=pvslllo_vvsvl
def veoldPVSLLLOvrl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "pvsll.lo $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll.lo intrisic=pvslllo_vvvMvl
def veoldPVSLLLOvvxl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsll.lo $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll.lo intrisic=pvslllo_vvsMvl
def veoldPVSLLLOvrxl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsll.lo $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll.up intrisic=pvsllup_vvvl
def veoldPVSLLUPvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsll.up $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll.up intrisic=pvsllup_vvvvl
def veoldPVSLLUPvvl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "pvsll.up $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll.up intrisic=pvsllup_vvsl
def veoldPVSLLUPvrl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsll.up $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll.up intrisic=pvsllup_vvsvl
def veoldPVSLLUPvrl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "pvsll.up $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll.up intrisic=pvsllup_vvvMvl
def veoldPVSLLUPvvxl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsll.up $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll.up intrisic=pvsllup_vvsMvl
def veoldPVSLLUPvrxl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsll.up $vx,$vz,$sy,$vm", [], NoItinerary>
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
def veoldPVSLLvvxl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsll $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll intrisic=pvsll_vvsMvl
def veoldPVSLLvrxl_v : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVSRLvvxl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vsrl $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvsmvl
def veoldVSRLvrxl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vsrl $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvsmvl
def veoldVSRLvixl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, simm7:$N, VM:$vm, I32:$vl, V64:$pt),
       "vsrl $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl.lo intrisic=pvsrllo_vvvl
def veoldPVSRLLOvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsrl.lo $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl.lo intrisic=pvsrllo_vvvvl
def veoldPVSRLLOvvl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "pvsrl.lo $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl.lo intrisic=pvsrllo_vvsl
def veoldPVSRLLOvrl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsrl.lo $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl.lo intrisic=pvsrllo_vvsvl
def veoldPVSRLLOvrl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "pvsrl.lo $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl.lo intrisic=pvsrllo_vvvMvl
def veoldPVSRLLOvvxl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsrl.lo $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl.lo intrisic=pvsrllo_vvsMvl
def veoldPVSRLLOvrxl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsrl.lo $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl.up intrisic=pvsrlup_vvvl
def veoldPVSRLUPvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsrl.up $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl.up intrisic=pvsrlup_vvvvl
def veoldPVSRLUPvvl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "pvsrl.up $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl.up intrisic=pvsrlup_vvsl
def veoldPVSRLUPvrl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsrl.up $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl.up intrisic=pvsrlup_vvsvl
def veoldPVSRLUPvrl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "pvsrl.up $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl.up intrisic=pvsrlup_vvvMvl
def veoldPVSRLUPvvxl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsrl.up $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl.up intrisic=pvsrlup_vvsMvl
def veoldPVSRLUPvrxl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsrl.up $vx,$vz,$sy,$vm", [], NoItinerary>
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
def veoldPVSRLvvxl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsrl $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl intrisic=pvsrl_vvsMvl
def veoldPVSRLvrxl_v : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVSLAWSXvrl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsla.w.sx $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.sx intrisic=vslawsx_vvsvl
def veoldVSLAWSXvrl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
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
def veoldVSLAWSXvvxl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vsla.w.sx $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.sx intrisic=vslawsx_vvsmvl
def veoldVSLAWSXvrxl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vsla.w.sx $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.sx intrisic=vslawsx_vvsmvl
def veoldVSLAWSXvixl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7:$N, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVSLAWZXvrl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsla.w.zx $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.zx intrisic=vslawzx_vvsvl
def veoldVSLAWZXvrl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
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
def veoldVSLAWZXvvxl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vsla.w.zx $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.zx intrisic=vslawzx_vvsmvl
def veoldVSLAWZXvrxl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vsla.w.zx $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w.zx intrisic=vslawzx_vvsmvl
def veoldVSLAWZXvixl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7:$N, VM:$vm, I32:$vl, V64:$pt),
       "vsla.w.zx $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla.lo intrisic=pvslalo_vvvl
def veoldPVSLALOvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsla.lo $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla.lo intrisic=pvslalo_vvvvl
def veoldPVSLALOvvl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "pvsla.lo $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla.lo intrisic=pvslalo_vvsl
def veoldPVSLALOvrl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsla.lo $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla.lo intrisic=pvslalo_vvsvl
def veoldPVSLALOvrl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "pvsla.lo $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla.lo intrisic=pvslalo_vvvMvl
def veoldPVSLALOvvxl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsla.lo $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla.lo intrisic=pvslalo_vvsMvl
def veoldPVSLALOvrxl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsla.lo $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla.up intrisic=pvslaup_vvvl
def veoldPVSLAUPvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsla.up $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla.up intrisic=pvslaup_vvvvl
def veoldPVSLAUPvvl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "pvsla.up $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla.up intrisic=pvslaup_vvsl
def veoldPVSLAUPvrl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsla.up $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla.up intrisic=pvslaup_vvsvl
def veoldPVSLAUPvrl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "pvsla.up $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla.up intrisic=pvslaup_vvvMvl
def veoldPVSLAUPvvxl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsla.up $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla.up intrisic=pvslaup_vvsMvl
def veoldPVSLAUPvrxl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsla.up $vx,$vz,$sy,$vm", [], NoItinerary>
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
def veoldPVSLAvvxl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsla $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla intrisic=pvsla_vvsMvl
def veoldPVSLAvrxl_v : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVSLALvvxl_v : RV<0xd4, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vsla.l $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvsmvl
def veoldVSLALvrxl_v : RV<0xd4, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vsla.l $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvsmvl
def veoldVSLALvixl_v : RV<0xd4, (outs V64:$vx), (ins V64:$vz, simm7:$N, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVSRAWSXvrl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsra.w.sx $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.sx intrisic=vsrawsx_vvsvl
def veoldVSRAWSXvrl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
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
def veoldVSRAWSXvvxl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vsra.w.sx $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.sx intrisic=vsrawsx_vvsmvl
def veoldVSRAWSXvrxl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vsra.w.sx $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.sx intrisic=vsrawsx_vvsmvl
def veoldVSRAWSXvixl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7:$N, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVSRAWZXvrl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsra.w.zx $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.zx intrisic=vsrawzx_vvsvl
def veoldVSRAWZXvrl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
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
def veoldVSRAWZXvvxl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vsra.w.zx $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.zx intrisic=vsrawzx_vvsmvl
def veoldVSRAWZXvrxl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vsra.w.zx $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w.zx intrisic=vsrawzx_vvsmvl
def veoldVSRAWZXvixl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7:$N, VM:$vm, I32:$vl, V64:$pt),
       "vsra.w.zx $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra.lo intrisic=pvsralo_vvvl
def veoldPVSRALOvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsra.lo $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra.lo intrisic=pvsralo_vvvvl
def veoldPVSRALOvvl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "pvsra.lo $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra.lo intrisic=pvsralo_vvsl
def veoldPVSRALOvrl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsra.lo $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra.lo intrisic=pvsralo_vvsvl
def veoldPVSRALOvrl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "pvsra.lo $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra.lo intrisic=pvsralo_vvvMvl
def veoldPVSRALOvvxl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsra.lo $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra.lo intrisic=pvsralo_vvsMvl
def veoldPVSRALOvrxl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsra.lo $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra.up intrisic=pvsraup_vvvl
def veoldPVSRAUPvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsra.up $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra.up intrisic=pvsraup_vvvvl
def veoldPVSRAUPvvl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl, V64:$pt),
       "pvsra.up $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra.up intrisic=pvsraup_vvsl
def veoldPVSRAUPvrl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsra.up $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra.up intrisic=pvsraup_vvsvl
def veoldPVSRAUPvrl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl, V64:$pt),
       "pvsra.up $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra.up intrisic=pvsraup_vvvMvl
def veoldPVSRAUPvvxl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsra.up $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra.up intrisic=pvsraup_vvsMvl
def veoldPVSRAUPvrxl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsra.up $vx,$vz,$sy,$vm", [], NoItinerary>
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
def veoldPVSRAvvxl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvsra $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra intrisic=pvsra_vvsMvl
def veoldPVSRAvrxl_v : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVSRALvvxl_v : RV<0xd5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vsra.l $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvsmvl
def veoldVSRALvrxl_v : RV<0xd5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, I32:$vl, V64:$pt),
       "vsra.l $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvsmvl
def veoldVSRALvixl_v : RV<0xd5, (outs V64:$vx), (ins V64:$vz, simm7:$N, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVSFAvrrxl_v : RV<0xd7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vsfa $vx,$vz,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSFA asm=vsfa intrisic=vsfa_vvssmvl
def veoldVSFAvirxl_v : RV<0xd7, (outs V64:$vx), (ins V64:$vz, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVFADDDvvxl_v : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfadd.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.d intrisic=vfaddd_vsvmvl
def veoldVFADDDrvxl_v : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVFADDSvvxl_v : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfadd.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.s intrisic=vfadds_vsvmvl
def veoldVFADDSrvxl_v : RV<0xcc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVFADDvvxl_v : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfadd $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=pvfadd intrisic=pvfadd_vsvMvl
def veoldPVFADDrvxl_v : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVFSUBDvvxl_v : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfsub.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.d intrisic=vfsubd_vsvmvl
def veoldVFSUBDrvxl_v : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVFSUBSvvxl_v : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfsub.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.s intrisic=vfsubs_vsvmvl
def veoldVFSUBSrvxl_v : RV<0xdc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVFSUBvvxl_v : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfsub $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=pvfsub intrisic=pvfsub_vsvMvl
def veoldPVFSUBrvxl_v : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVFMULDvvxl_v : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmul.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.d intrisic=vfmuld_vsvmvl
def veoldVFMULDrvxl_v : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVFMULSvvxl_v : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmul.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.s intrisic=vfmuls_vsvmvl
def veoldVFMULSrvxl_v : RV<0xcd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVFMULvvxl_v : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmul $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=pvfmul intrisic=pvfmul_vsvMvl
def veoldPVFMULrvxl_v : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVFDIVDvvxl_v : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfdiv.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.d intrisic=vfdivd_vsvmvl
def veoldVFDIVDrvxl_v : RV<0xdd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVFDIVSvvxl_v : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfdiv.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.s intrisic=vfdivs_vsvmvl
def veoldVFDIVSrvxl_v : RV<0xdd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVFCMPDvvxl_v : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfcmp.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.d intrisic=vfcmpd_vsvmvl
def veoldVFCMPDrvxl_v : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVFCMPSvvxl_v : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfcmp.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.s intrisic=vfcmps_vsvmvl
def veoldVFCMPSrvxl_v : RV<0xfc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVFCMPvvxl_v : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfcmp $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=pvfcmp intrisic=pvfcmp_vsvMvl
def veoldPVFCMPrvxl_v : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVFMAXDvvxl_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmax.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.d intrisic=vfmaxd_vsvmvl
def veoldVFMAXDrvxl_v : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVFMAXSvvxl_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmax.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.s intrisic=vfmaxs_vsvmvl
def veoldVFMAXSrvxl_v : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVFMAXvvxl_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmax $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmax intrisic=pvfmax_vsvMvl
def veoldPVFMAXrvxl_v : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVFMINDvvxl_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmin.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.d intrisic=vfmind_vsvmvl
def veoldVFMINDrvxl_v : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVFMINSvvxl_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vfmin.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.s intrisic=vfmins_vsvmvl
def veoldVFMINSrvxl_v : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVFMINvvxl_v : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmin $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmin intrisic=pvfmin_vsvMvl
def veoldPVFMINrvxl_v : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVFMADDvvvxl_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmad.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vsvvmvl
def veoldVFMADDrvvxl_v : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmad.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vvsvmvl
def veoldVFMADDvrvxl_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVFMADSvvvxl_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmad.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vsvvmvl
def veoldVFMADSrvvxl_v : RV<0xe2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmad.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vvsvmvl
def veoldVFMADSvrvxl_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVFMADvvvxl_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmad $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vsvvMvl
def veoldPVFMADrvvxl_v : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmad $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vvsvMvl
def veoldPVFMADvrvxl_v : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVFMSBDvvvxl_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmsb.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vsvvmvl
def veoldVFMSBDrvvxl_v : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmsb.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vvsvmvl
def veoldVFMSBDvrvxl_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVFMSBSvvvxl_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmsb.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vsvvmvl
def veoldVFMSBSrvvxl_v : RV<0xf2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfmsb.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vvsvmvl
def veoldVFMSBSvrvxl_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVFMSBvvvxl_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmsb $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vsvvMvl
def veoldPVFMSBrvvxl_v : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfmsb $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vvsvMvl
def veoldPVFMSBvrvxl_v : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVFNMADDvvvxl_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmad.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vsvvmvl
def veoldVFNMADDrvvxl_v : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmad.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vvsvmvl
def veoldVFNMADDvrvxl_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVFNMADSvvvxl_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmad.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vsvvmvl
def veoldVFNMADSrvvxl_v : RV<0xe3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmad.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vvsvmvl
def veoldVFNMADSvrvxl_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVFNMADvvvxl_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfnmad $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vsvvMvl
def veoldPVFNMADrvvxl_v : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfnmad $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vvsvMvl
def veoldPVFNMADvrvxl_v : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVFNMSBDvvvxl_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmsb.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vsvvmvl
def veoldVFNMSBDrvvxl_v : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmsb.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vvsvmvl
def veoldVFNMSBDvrvxl_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVFNMSBSvvvxl_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmsb.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vsvvmvl
def veoldVFNMSBSrvvxl_v : RV<0xf3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
       "vfnmsb.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vvsvmvl
def veoldVFNMSBSvrvxl_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM:$vm, I32:$vl, V64:$pt),
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
def veoldPVFNMSBvvvxl_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfnmsb $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vsvvMvl
def veoldPVFNMSBrvvxl_v : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
       "pvfnmsb $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vvsvMvl
def veoldPVFNMSBvrvxl_v : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512:$vm, I32:$vl, V64:$pt),
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

// inst=VFIX asm=vcvt.w.d.sx intrisic=vcvtwdsx_vvl
def veoldVCVTWDSXvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.d.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.sx intrisic=vcvtwdsx_vvvl
def veoldVCVTWDSXvl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vcvt.w.d.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.sx intrisic=vcvtwdsx_vvmvl
def veoldVCVTWDSXvxl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vcvt.w.d.sx $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.sx.rz intrisic=vcvtwdsxrz_vvl
def veoldVCVTWDSXRZvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.d.sx.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.sx.rz intrisic=vcvtwdsxrz_vvvl
def veoldVCVTWDSXRZvl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vcvt.w.d.sx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.sx.rz intrisic=vcvtwdsxrz_vvmvl
def veoldVCVTWDSXRZvxl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vcvt.w.d.sx.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.zx intrisic=vcvtwdzx_vvl
def veoldVCVTWDZXvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.d.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.zx intrisic=vcvtwdzx_vvvl
def veoldVCVTWDZXvl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vcvt.w.d.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.zx intrisic=vcvtwdzx_vvmvl
def veoldVCVTWDZXvxl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vcvt.w.d.zx $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.zx.rz intrisic=vcvtwdzxrz_vvl
def veoldVCVTWDZXRZvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.d.zx.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.zx.rz intrisic=vcvtwdzxrz_vvvl
def veoldVCVTWDZXRZvl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vcvt.w.d.zx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.zx.rz intrisic=vcvtwdzxrz_vvmvl
def veoldVCVTWDZXRZvxl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vcvt.w.d.zx.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.sx intrisic=vcvtwssx_vvl
def veoldVCVTWSSXvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.s.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.sx intrisic=vcvtwssx_vvvl
def veoldVCVTWSSXvl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vcvt.w.s.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.sx intrisic=vcvtwssx_vvmvl
def veoldVCVTWSSXvxl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vcvt.w.s.sx $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.sx.rz intrisic=vcvtwssxrz_vvl
def veoldVCVTWSSXRZvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.s.sx.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.sx.rz intrisic=vcvtwssxrz_vvvl
def veoldVCVTWSSXRZvl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vcvt.w.s.sx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.sx.rz intrisic=vcvtwssxrz_vvmvl
def veoldVCVTWSSXRZvxl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vcvt.w.s.sx.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.zx intrisic=vcvtwszx_vvl
def veoldVCVTWSZXvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.s.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.zx intrisic=vcvtwszx_vvvl
def veoldVCVTWSZXvl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vcvt.w.s.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.zx intrisic=vcvtwszx_vvmvl
def veoldVCVTWSZXvxl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vcvt.w.s.zx $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.zx.rz intrisic=vcvtwszxrz_vvl
def veoldVCVTWSZXRZvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.s.zx.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.zx.rz intrisic=vcvtwszxrz_vvvl
def veoldVCVTWSZXRZvl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vcvt.w.s.zx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.zx.rz intrisic=vcvtwszxrz_vvmvl
def veoldVCVTWSZXRZvxl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vcvt.w.s.zx.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=pvcvt.w.s intrisic=pvcvtws_vvl
def veoldPVCVTWSvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvcvt.w.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=pvcvt.w.s intrisic=pvcvtws_vvvl
def veoldPVCVTWSvl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "pvcvt.w.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=pvcvt.w.s intrisic=pvcvtws_vvMvl
def veoldPVCVTWSvxl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvcvt.w.s $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=pvcvt.w.s.rz intrisic=pvcvtwsrz_vvl
def veoldPVCVTWSRZvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvcvt.w.s.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=pvcvt.w.s.rz intrisic=pvcvtwsrz_vvvl
def veoldPVCVTWSRZvl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "pvcvt.w.s.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=pvcvt.w.s.rz intrisic=pvcvtwsrz_vvMvl
def veoldPVCVTWSRZvxl_v : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM512:$vm, I32:$vl, V64:$pt),
       "pvcvt.w.s.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIXX asm=vcvt.l.d intrisic=vcvtld_vvl
def veoldVCVTLDvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.l.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIXX asm=vcvt.l.d intrisic=vcvtld_vvvl
def veoldVCVTLDvl_v : RV<0xa8, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vcvt.l.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIXX asm=vcvt.l.d intrisic=vcvtld_vvmvl
def veoldVCVTLDvxl_v : RV<0xa8, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vcvt.l.d $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIXX asm=vcvt.l.d.rz intrisic=vcvtldrz_vvl
def veoldVCVTLDRZvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.l.d.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIXX asm=vcvt.l.d.rz intrisic=vcvtldrz_vvvl
def veoldVCVTLDRZvl_v : RV<0xa8, (outs V64:$vx), (ins V64:$vy, I32:$vl, V64:$pt),
       "vcvt.l.d.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIXX asm=vcvt.l.d.rz intrisic=vcvtldrz_vvmvl
def veoldVCVTLDRZvxl_v : RV<0xa8, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl, V64:$pt),
       "vcvt.l.d.rz $vx,$vy,$vm", [], NoItinerary>
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
def veoldVMRGvvxl : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl),
       "vmrg $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vvvmvl
def veoldVMRGvvxl_v : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmrg $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vsvml
def veoldVMRGrvxl : RV<0xd6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl),
       "vmrg $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vsvmvl
def veoldVMRGrvxl_v : RV<0xd6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmrg $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vsvml
def veoldVMRGivxl : RV<0xd6, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl),
       "vmrg $vx,$I,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vsvmvl
def veoldVMRGivxl_v : RV<0xd6, (outs V64:$vx), (ins simm7:$I, V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vmrg $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg.w intrisic=vmrgw_vvvMl
def veoldVMRGWvvxl : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl),
       "vmrg.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg.w intrisic=vmrgw_vvvMvl
def veoldVMRGWvvxl_v : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
       "vmrg.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg.w intrisic=vmrgw_vsvMl
def veoldVMRGWrvxl : RV<0xd6, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM512:$vm, I32:$vl),
       "vmrg.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg.w intrisic=vmrgw_vsvMvl
def veoldVMRGWrvxl_v : RV<0xd6, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM512:$vm, I32:$vl, V64:$pt),
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
def veoldVCPvxl_v : RV<0x8d, (outs V64:$vx), (ins V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vcp $vx,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEX asm=vex intrisic=vex_vvmvl
def veoldVEXvxl_v : RV<0x9d, (outs V64:$vx), (ins V64:$vz, VM:$vm, I32:$vl, V64:$pt),
       "vex $vx,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.at intrisic=vfmklat_ml
def veoldVFMKLATl : RV<0xb4, (outs VM:$vmx), (ins I32:$vl),
       "vfmk.l.at $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.af intrisic=vfmklaf_ml
def veoldVFMKLAFl : RV<0xb4, (outs VM:$vmx), (ins I32:$vl),
       "vfmk.l.af $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=pvfmk.w.lo.at intrisic=pvfmkwloat_ml
def veoldPVFMKWLOATl : RV<0xb5, (outs VM:$vmx), (ins I32:$vl),
       "pvfmk.w.lo.at $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=pvfmk.w.up.at intrisic=pvfmkwupat_ml
def veoldPVFMKWUPATl : RV<0xb5, (outs VM:$vmx), (ins I32:$vl),
       "pvfmk.w.up.at $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=pvfmk.w.lo.af intrisic=pvfmkwloaf_ml
def veoldPVFMKWLOAFl : RV<0xb5, (outs VM:$vmx), (ins I32:$vl),
       "pvfmk.w.lo.af $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=pvfmk.w.up.af intrisic=pvfmkwupaf_ml
def veoldPVFMKWUPAFl : RV<0xb5, (outs VM:$vmx), (ins I32:$vl),
       "pvfmk.w.up.af $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=pvfmk.at intrisic=pvfmkat_Ml
def veoldPVFMKATl : Pseudo<(outs VM512:$vmx), (ins I32:$vl),
       "# pvfmk.at $vmx", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=pvfmk.af intrisic=pvfmkaf_Ml
def veoldPVFMKAFl : Pseudo<(outs VM512:$vmx), (ins I32:$vl),
       "# pvfmk.af $vmx", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.gt intrisic=vfmklgt_mvl
def veoldVFMKLGTvl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.gt intrisic=vfmklgt_mvml
def veoldVFMKLGTvxl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.l.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.lt intrisic=vfmkllt_mvl
def veoldVFMKLLTvl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.lt intrisic=vfmkllt_mvml
def veoldVFMKLLTvxl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.l.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.ne intrisic=vfmklne_mvl
def veoldVFMKLNEvl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.ne intrisic=vfmklne_mvml
def veoldVFMKLNEvxl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.l.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.eq intrisic=vfmkleq_mvl
def veoldVFMKLEQvl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.eq intrisic=vfmkleq_mvml
def veoldVFMKLEQvxl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.l.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.ge intrisic=vfmklge_mvl
def veoldVFMKLGEvl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.ge intrisic=vfmklge_mvml
def veoldVFMKLGEvxl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.l.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.le intrisic=vfmklle_mvl
def veoldVFMKLLEvl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.le intrisic=vfmklle_mvml
def veoldVFMKLLEvxl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.l.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.num intrisic=vfmklnum_mvl
def veoldVFMKLNUMvl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.num intrisic=vfmklnum_mvml
def veoldVFMKLNUMvxl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.l.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.nan intrisic=vfmklnan_mvl
def veoldVFMKLNANvl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.nan intrisic=vfmklnan_mvml
def veoldVFMKLNANvxl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.l.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.gtnan intrisic=vfmklgtnan_mvl
def veoldVFMKLGTNANvl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.gtnan intrisic=vfmklgtnan_mvml
def veoldVFMKLGTNANvxl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.l.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.ltnan intrisic=vfmklltnan_mvl
def veoldVFMKLLTNANvl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.ltnan intrisic=vfmklltnan_mvml
def veoldVFMKLLTNANvxl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.l.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.nenan intrisic=vfmklnenan_mvl
def veoldVFMKLNENANvl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.nenan intrisic=vfmklnenan_mvml
def veoldVFMKLNENANvxl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.l.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.eqnan intrisic=vfmkleqnan_mvl
def veoldVFMKLEQNANvl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.eqnan intrisic=vfmkleqnan_mvml
def veoldVFMKLEQNANvxl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.l.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.genan intrisic=vfmklgenan_mvl
def veoldVFMKLGENANvl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.genan intrisic=vfmklgenan_mvml
def veoldVFMKLGENANvxl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.l.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.lenan intrisic=vfmkllenan_mvl
def veoldVFMKLLENANvl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.lenan intrisic=vfmkllenan_mvml
def veoldVFMKLLENANvxl : RV<0xb4, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.l.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.gt intrisic=vfmkwgt_mvl
def veoldVFMKWGTvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.gt intrisic=vfmkwgt_mvml
def veoldVFMKWGTvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.w.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.lt intrisic=vfmkwlt_mvl
def veoldVFMKWLTvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.lt intrisic=vfmkwlt_mvml
def veoldVFMKWLTvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.w.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.ne intrisic=vfmkwne_mvl
def veoldVFMKWNEvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.ne intrisic=vfmkwne_mvml
def veoldVFMKWNEvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.w.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.eq intrisic=vfmkweq_mvl
def veoldVFMKWEQvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.eq intrisic=vfmkweq_mvml
def veoldVFMKWEQvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.w.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.ge intrisic=vfmkwge_mvl
def veoldVFMKWGEvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.ge intrisic=vfmkwge_mvml
def veoldVFMKWGEvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.w.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.le intrisic=vfmkwle_mvl
def veoldVFMKWLEvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.le intrisic=vfmkwle_mvml
def veoldVFMKWLEvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.w.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.num intrisic=vfmkwnum_mvl
def veoldVFMKWNUMvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.num intrisic=vfmkwnum_mvml
def veoldVFMKWNUMvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.w.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.nan intrisic=vfmkwnan_mvl
def veoldVFMKWNANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.nan intrisic=vfmkwnan_mvml
def veoldVFMKWNANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.w.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.gtnan intrisic=vfmkwgtnan_mvl
def veoldVFMKWGTNANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.gtnan intrisic=vfmkwgtnan_mvml
def veoldVFMKWGTNANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.w.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.ltnan intrisic=vfmkwltnan_mvl
def veoldVFMKWLTNANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.ltnan intrisic=vfmkwltnan_mvml
def veoldVFMKWLTNANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.w.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.nenan intrisic=vfmkwnenan_mvl
def veoldVFMKWNENANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.nenan intrisic=vfmkwnenan_mvml
def veoldVFMKWNENANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.w.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.eqnan intrisic=vfmkweqnan_mvl
def veoldVFMKWEQNANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.eqnan intrisic=vfmkweqnan_mvml
def veoldVFMKWEQNANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.w.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.genan intrisic=vfmkwgenan_mvl
def veoldVFMKWGENANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.genan intrisic=vfmkwgenan_mvml
def veoldVFMKWGENANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.w.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.lenan intrisic=vfmkwlenan_mvl
def veoldVFMKWLENANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.lenan intrisic=vfmkwlenan_mvml
def veoldVFMKWLENANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.w.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.gt intrisic=pvfmkwlogt_mvl
def veoldPVFMKWLOGTvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.gt intrisic=pvfmkwupgt_mvl
def veoldPVFMKWUPGTvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.gt intrisic=pvfmkwlogt_mvml
def veoldPVFMKWLOGTvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.lo.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.gt intrisic=pvfmkwupgt_mvml
def veoldPVFMKWUPGTvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.up.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.lt intrisic=pvfmkwlolt_mvl
def veoldPVFMKWLOLTvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.lt intrisic=pvfmkwuplt_mvl
def veoldPVFMKWUPLTvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.lt intrisic=pvfmkwlolt_mvml
def veoldPVFMKWLOLTvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.lo.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.lt intrisic=pvfmkwuplt_mvml
def veoldPVFMKWUPLTvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.up.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.ne intrisic=pvfmkwlone_mvl
def veoldPVFMKWLONEvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.ne intrisic=pvfmkwupne_mvl
def veoldPVFMKWUPNEvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.ne intrisic=pvfmkwlone_mvml
def veoldPVFMKWLONEvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.lo.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.ne intrisic=pvfmkwupne_mvml
def veoldPVFMKWUPNEvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.up.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.eq intrisic=pvfmkwloeq_mvl
def veoldPVFMKWLOEQvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.eq intrisic=pvfmkwupeq_mvl
def veoldPVFMKWUPEQvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.eq intrisic=pvfmkwloeq_mvml
def veoldPVFMKWLOEQvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.lo.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.eq intrisic=pvfmkwupeq_mvml
def veoldPVFMKWUPEQvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.up.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.ge intrisic=pvfmkwloge_mvl
def veoldPVFMKWLOGEvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.ge intrisic=pvfmkwupge_mvl
def veoldPVFMKWUPGEvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.ge intrisic=pvfmkwloge_mvml
def veoldPVFMKWLOGEvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.lo.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.ge intrisic=pvfmkwupge_mvml
def veoldPVFMKWUPGEvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.up.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.le intrisic=pvfmkwlole_mvl
def veoldPVFMKWLOLEvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.le intrisic=pvfmkwuple_mvl
def veoldPVFMKWUPLEvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.le intrisic=pvfmkwlole_mvml
def veoldPVFMKWLOLEvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.lo.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.le intrisic=pvfmkwuple_mvml
def veoldPVFMKWUPLEvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.up.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.num intrisic=pvfmkwlonum_mvl
def veoldPVFMKWLONUMvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.num intrisic=pvfmkwupnum_mvl
def veoldPVFMKWUPNUMvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.num intrisic=pvfmkwlonum_mvml
def veoldPVFMKWLONUMvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.lo.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.num intrisic=pvfmkwupnum_mvml
def veoldPVFMKWUPNUMvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.up.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.nan intrisic=pvfmkwlonan_mvl
def veoldPVFMKWLONANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.nan intrisic=pvfmkwupnan_mvl
def veoldPVFMKWUPNANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.nan intrisic=pvfmkwlonan_mvml
def veoldPVFMKWLONANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.lo.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.nan intrisic=pvfmkwupnan_mvml
def veoldPVFMKWUPNANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.up.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.gtnan intrisic=pvfmkwlogtnan_mvl
def veoldPVFMKWLOGTNANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.gtnan intrisic=pvfmkwupgtnan_mvl
def veoldPVFMKWUPGTNANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.gtnan intrisic=pvfmkwlogtnan_mvml
def veoldPVFMKWLOGTNANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.lo.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.gtnan intrisic=pvfmkwupgtnan_mvml
def veoldPVFMKWUPGTNANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.up.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.ltnan intrisic=pvfmkwloltnan_mvl
def veoldPVFMKWLOLTNANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.ltnan intrisic=pvfmkwupltnan_mvl
def veoldPVFMKWUPLTNANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.ltnan intrisic=pvfmkwloltnan_mvml
def veoldPVFMKWLOLTNANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.lo.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.ltnan intrisic=pvfmkwupltnan_mvml
def veoldPVFMKWUPLTNANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.up.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.nenan intrisic=pvfmkwlonenan_mvl
def veoldPVFMKWLONENANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.nenan intrisic=pvfmkwupnenan_mvl
def veoldPVFMKWUPNENANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.nenan intrisic=pvfmkwlonenan_mvml
def veoldPVFMKWLONENANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.lo.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.nenan intrisic=pvfmkwupnenan_mvml
def veoldPVFMKWUPNENANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.up.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.eqnan intrisic=pvfmkwloeqnan_mvl
def veoldPVFMKWLOEQNANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.eqnan intrisic=pvfmkwupeqnan_mvl
def veoldPVFMKWUPEQNANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.eqnan intrisic=pvfmkwloeqnan_mvml
def veoldPVFMKWLOEQNANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.lo.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.eqnan intrisic=pvfmkwupeqnan_mvml
def veoldPVFMKWUPEQNANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.up.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.genan intrisic=pvfmkwlogenan_mvl
def veoldPVFMKWLOGENANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.genan intrisic=pvfmkwupgenan_mvl
def veoldPVFMKWUPGENANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.genan intrisic=pvfmkwlogenan_mvml
def veoldPVFMKWLOGENANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.lo.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.genan intrisic=pvfmkwupgenan_mvml
def veoldPVFMKWUPGENANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.up.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.lenan intrisic=pvfmkwlolenan_mvl
def veoldPVFMKWLOLENANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.lenan intrisic=pvfmkwuplenan_mvl
def veoldPVFMKWUPLENANvl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.lenan intrisic=pvfmkwlolenan_mvml
def veoldPVFMKWLOLENANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.lo.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.lenan intrisic=pvfmkwuplenan_mvml
def veoldPVFMKWUPLENANvxl : RV<0xb5, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.w.up.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.gt intrisic=pvfmkwgt_Mvl
def veoldPVFMKWGTvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.gt $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.gt intrisic=pvfmkwgt_MvMl
def veoldPVFMKWGTvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.w.gt $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lt intrisic=pvfmkwlt_Mvl
def veoldPVFMKWLTvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.lt $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lt intrisic=pvfmkwlt_MvMl
def veoldPVFMKWLTvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.w.lt $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.ne intrisic=pvfmkwne_Mvl
def veoldPVFMKWNEvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.ne $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.ne intrisic=pvfmkwne_MvMl
def veoldPVFMKWNEvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.w.ne $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.eq intrisic=pvfmkweq_Mvl
def veoldPVFMKWEQvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.eq $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.eq intrisic=pvfmkweq_MvMl
def veoldPVFMKWEQvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.w.eq $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.ge intrisic=pvfmkwge_Mvl
def veoldPVFMKWGEvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.ge $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.ge intrisic=pvfmkwge_MvMl
def veoldPVFMKWGEvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.w.ge $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.le intrisic=pvfmkwle_Mvl
def veoldPVFMKWLEvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.le $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.le intrisic=pvfmkwle_MvMl
def veoldPVFMKWLEvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.w.le $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.num intrisic=pvfmkwnum_Mvl
def veoldPVFMKWNUMvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.num $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.num intrisic=pvfmkwnum_MvMl
def veoldPVFMKWNUMvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.w.num $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.nan intrisic=pvfmkwnan_Mvl
def veoldPVFMKWNANvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.nan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.nan intrisic=pvfmkwnan_MvMl
def veoldPVFMKWNANvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.w.nan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.gtnan intrisic=pvfmkwgtnan_Mvl
def veoldPVFMKWGTNANvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.gtnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.gtnan intrisic=pvfmkwgtnan_MvMl
def veoldPVFMKWGTNANvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.w.gtnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.ltnan intrisic=pvfmkwltnan_Mvl
def veoldPVFMKWLTNANvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.ltnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.ltnan intrisic=pvfmkwltnan_MvMl
def veoldPVFMKWLTNANvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.w.ltnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.nenan intrisic=pvfmkwnenan_Mvl
def veoldPVFMKWNENANvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.nenan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.nenan intrisic=pvfmkwnenan_MvMl
def veoldPVFMKWNENANvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.w.nenan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.eqnan intrisic=pvfmkweqnan_Mvl
def veoldPVFMKWEQNANvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.eqnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.eqnan intrisic=pvfmkweqnan_MvMl
def veoldPVFMKWEQNANvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.w.eqnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.genan intrisic=pvfmkwgenan_Mvl
def veoldPVFMKWGENANvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.genan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.genan intrisic=pvfmkwgenan_MvMl
def veoldPVFMKWGENANvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.w.genan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lenan intrisic=pvfmkwlenan_Mvl
def veoldPVFMKWLENANvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.lenan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lenan intrisic=pvfmkwlenan_MvMl
def veoldPVFMKWLENANvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.w.lenan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.gt intrisic=vfmkdgt_mvl
def veoldVFMKDGTvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.gt intrisic=vfmkdgt_mvml
def veoldVFMKDGTvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.d.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.lt intrisic=vfmkdlt_mvl
def veoldVFMKDLTvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.lt intrisic=vfmkdlt_mvml
def veoldVFMKDLTvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.d.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.ne intrisic=vfmkdne_mvl
def veoldVFMKDNEvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.ne intrisic=vfmkdne_mvml
def veoldVFMKDNEvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.d.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.eq intrisic=vfmkdeq_mvl
def veoldVFMKDEQvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.eq intrisic=vfmkdeq_mvml
def veoldVFMKDEQvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.d.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.ge intrisic=vfmkdge_mvl
def veoldVFMKDGEvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.ge intrisic=vfmkdge_mvml
def veoldVFMKDGEvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.d.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.le intrisic=vfmkdle_mvl
def veoldVFMKDLEvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.le intrisic=vfmkdle_mvml
def veoldVFMKDLEvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.d.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.num intrisic=vfmkdnum_mvl
def veoldVFMKDNUMvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.num intrisic=vfmkdnum_mvml
def veoldVFMKDNUMvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.d.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.nan intrisic=vfmkdnan_mvl
def veoldVFMKDNANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.nan intrisic=vfmkdnan_mvml
def veoldVFMKDNANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.d.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.gtnan intrisic=vfmkdgtnan_mvl
def veoldVFMKDGTNANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.gtnan intrisic=vfmkdgtnan_mvml
def veoldVFMKDGTNANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.d.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.ltnan intrisic=vfmkdltnan_mvl
def veoldVFMKDLTNANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.ltnan intrisic=vfmkdltnan_mvml
def veoldVFMKDLTNANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.d.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.nenan intrisic=vfmkdnenan_mvl
def veoldVFMKDNENANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.nenan intrisic=vfmkdnenan_mvml
def veoldVFMKDNENANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.d.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.eqnan intrisic=vfmkdeqnan_mvl
def veoldVFMKDEQNANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.eqnan intrisic=vfmkdeqnan_mvml
def veoldVFMKDEQNANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.d.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.genan intrisic=vfmkdgenan_mvl
def veoldVFMKDGENANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.genan intrisic=vfmkdgenan_mvml
def veoldVFMKDGENANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.d.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.lenan intrisic=vfmkdlenan_mvl
def veoldVFMKDLENANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.lenan intrisic=vfmkdlenan_mvml
def veoldVFMKDLENANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.d.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.gt intrisic=vfmksgt_mvl
def veoldVFMKSGTvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.gt intrisic=vfmksgt_mvml
def veoldVFMKSGTvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.s.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.lt intrisic=vfmkslt_mvl
def veoldVFMKSLTvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.lt intrisic=vfmkslt_mvml
def veoldVFMKSLTvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.s.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.ne intrisic=vfmksne_mvl
def veoldVFMKSNEvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.ne intrisic=vfmksne_mvml
def veoldVFMKSNEvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.s.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.eq intrisic=vfmkseq_mvl
def veoldVFMKSEQvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.eq intrisic=vfmkseq_mvml
def veoldVFMKSEQvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.s.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.ge intrisic=vfmksge_mvl
def veoldVFMKSGEvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.ge intrisic=vfmksge_mvml
def veoldVFMKSGEvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.s.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.le intrisic=vfmksle_mvl
def veoldVFMKSLEvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.le intrisic=vfmksle_mvml
def veoldVFMKSLEvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.s.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.num intrisic=vfmksnum_mvl
def veoldVFMKSNUMvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.num intrisic=vfmksnum_mvml
def veoldVFMKSNUMvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.s.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.nan intrisic=vfmksnan_mvl
def veoldVFMKSNANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.nan intrisic=vfmksnan_mvml
def veoldVFMKSNANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.s.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.gtnan intrisic=vfmksgtnan_mvl
def veoldVFMKSGTNANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.gtnan intrisic=vfmksgtnan_mvml
def veoldVFMKSGTNANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.s.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.ltnan intrisic=vfmksltnan_mvl
def veoldVFMKSLTNANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.ltnan intrisic=vfmksltnan_mvml
def veoldVFMKSLTNANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.s.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.nenan intrisic=vfmksnenan_mvl
def veoldVFMKSNENANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.nenan intrisic=vfmksnenan_mvml
def veoldVFMKSNENANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.s.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.eqnan intrisic=vfmkseqnan_mvl
def veoldVFMKSEQNANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.eqnan intrisic=vfmkseqnan_mvml
def veoldVFMKSEQNANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.s.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.genan intrisic=vfmksgenan_mvl
def veoldVFMKSGENANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.genan intrisic=vfmksgenan_mvml
def veoldVFMKSGENANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.s.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.lenan intrisic=vfmkslenan_mvl
def veoldVFMKSLENANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.lenan intrisic=vfmkslenan_mvml
def veoldVFMKSLENANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "vfmk.s.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.gt intrisic=pvfmkslogt_mvl
def veoldPVFMKSLOGTvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.gt intrisic=pvfmksupgt_mvl
def veoldPVFMKSUPGTvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.gt intrisic=pvfmkslogt_mvml
def veoldPVFMKSLOGTvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.lo.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.gt intrisic=pvfmksupgt_mvml
def veoldPVFMKSUPGTvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.up.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.lt intrisic=pvfmkslolt_mvl
def veoldPVFMKSLOLTvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.lt intrisic=pvfmksuplt_mvl
def veoldPVFMKSUPLTvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.lt intrisic=pvfmkslolt_mvml
def veoldPVFMKSLOLTvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.lo.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.lt intrisic=pvfmksuplt_mvml
def veoldPVFMKSUPLTvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.up.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.ne intrisic=pvfmkslone_mvl
def veoldPVFMKSLONEvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.ne intrisic=pvfmksupne_mvl
def veoldPVFMKSUPNEvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.ne intrisic=pvfmkslone_mvml
def veoldPVFMKSLONEvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.lo.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.ne intrisic=pvfmksupne_mvml
def veoldPVFMKSUPNEvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.up.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.eq intrisic=pvfmksloeq_mvl
def veoldPVFMKSLOEQvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.eq intrisic=pvfmksupeq_mvl
def veoldPVFMKSUPEQvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.eq intrisic=pvfmksloeq_mvml
def veoldPVFMKSLOEQvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.lo.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.eq intrisic=pvfmksupeq_mvml
def veoldPVFMKSUPEQvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.up.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.ge intrisic=pvfmksloge_mvl
def veoldPVFMKSLOGEvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.ge intrisic=pvfmksupge_mvl
def veoldPVFMKSUPGEvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.ge intrisic=pvfmksloge_mvml
def veoldPVFMKSLOGEvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.lo.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.ge intrisic=pvfmksupge_mvml
def veoldPVFMKSUPGEvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.up.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.le intrisic=pvfmkslole_mvl
def veoldPVFMKSLOLEvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.le intrisic=pvfmksuple_mvl
def veoldPVFMKSUPLEvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.le intrisic=pvfmkslole_mvml
def veoldPVFMKSLOLEvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.lo.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.le intrisic=pvfmksuple_mvml
def veoldPVFMKSUPLEvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.up.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.num intrisic=pvfmkslonum_mvl
def veoldPVFMKSLONUMvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.num intrisic=pvfmksupnum_mvl
def veoldPVFMKSUPNUMvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.num intrisic=pvfmkslonum_mvml
def veoldPVFMKSLONUMvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.lo.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.num intrisic=pvfmksupnum_mvml
def veoldPVFMKSUPNUMvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.up.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.nan intrisic=pvfmkslonan_mvl
def veoldPVFMKSLONANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.nan intrisic=pvfmksupnan_mvl
def veoldPVFMKSUPNANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.nan intrisic=pvfmkslonan_mvml
def veoldPVFMKSLONANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.lo.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.nan intrisic=pvfmksupnan_mvml
def veoldPVFMKSUPNANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.up.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.gtnan intrisic=pvfmkslogtnan_mvl
def veoldPVFMKSLOGTNANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.gtnan intrisic=pvfmksupgtnan_mvl
def veoldPVFMKSUPGTNANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.gtnan intrisic=pvfmkslogtnan_mvml
def veoldPVFMKSLOGTNANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.lo.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.gtnan intrisic=pvfmksupgtnan_mvml
def veoldPVFMKSUPGTNANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.up.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.ltnan intrisic=pvfmksloltnan_mvl
def veoldPVFMKSLOLTNANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.ltnan intrisic=pvfmksupltnan_mvl
def veoldPVFMKSUPLTNANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.ltnan intrisic=pvfmksloltnan_mvml
def veoldPVFMKSLOLTNANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.lo.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.ltnan intrisic=pvfmksupltnan_mvml
def veoldPVFMKSUPLTNANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.up.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.nenan intrisic=pvfmkslonenan_mvl
def veoldPVFMKSLONENANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.nenan intrisic=pvfmksupnenan_mvl
def veoldPVFMKSUPNENANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.nenan intrisic=pvfmkslonenan_mvml
def veoldPVFMKSLONENANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.lo.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.nenan intrisic=pvfmksupnenan_mvml
def veoldPVFMKSUPNENANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.up.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.eqnan intrisic=pvfmksloeqnan_mvl
def veoldPVFMKSLOEQNANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.eqnan intrisic=pvfmksupeqnan_mvl
def veoldPVFMKSUPEQNANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.eqnan intrisic=pvfmksloeqnan_mvml
def veoldPVFMKSLOEQNANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.lo.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.eqnan intrisic=pvfmksupeqnan_mvml
def veoldPVFMKSUPEQNANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.up.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.genan intrisic=pvfmkslogenan_mvl
def veoldPVFMKSLOGENANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.genan intrisic=pvfmksupgenan_mvl
def veoldPVFMKSUPGENANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.genan intrisic=pvfmkslogenan_mvml
def veoldPVFMKSLOGENANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.lo.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.genan intrisic=pvfmksupgenan_mvml
def veoldPVFMKSUPGENANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.up.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.lenan intrisic=pvfmkslolenan_mvl
def veoldPVFMKSLOLENANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.lenan intrisic=pvfmksuplenan_mvl
def veoldPVFMKSUPLENANvl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.lenan intrisic=pvfmkslolenan_mvml
def veoldPVFMKSLOLENANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.lo.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.lenan intrisic=pvfmksuplenan_mvml
def veoldPVFMKSUPLENANvxl : RV<0xb6, (outs VM:$vmx), (ins V64:$vz, VM:$vm, I32:$vl),
       "pvfmk.s.up.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.gt intrisic=pvfmksgt_Mvl
def veoldPVFMKSGTvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.gt $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.gt intrisic=pvfmksgt_MvMl
def veoldPVFMKSGTvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.s.gt $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lt intrisic=pvfmkslt_Mvl
def veoldPVFMKSLTvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.lt $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lt intrisic=pvfmkslt_MvMl
def veoldPVFMKSLTvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.s.lt $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.ne intrisic=pvfmksne_Mvl
def veoldPVFMKSNEvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.ne $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.ne intrisic=pvfmksne_MvMl
def veoldPVFMKSNEvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.s.ne $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.eq intrisic=pvfmkseq_Mvl
def veoldPVFMKSEQvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.eq $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.eq intrisic=pvfmkseq_MvMl
def veoldPVFMKSEQvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.s.eq $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.ge intrisic=pvfmksge_Mvl
def veoldPVFMKSGEvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.ge $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.ge intrisic=pvfmksge_MvMl
def veoldPVFMKSGEvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.s.ge $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.le intrisic=pvfmksle_Mvl
def veoldPVFMKSLEvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.le $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.le intrisic=pvfmksle_MvMl
def veoldPVFMKSLEvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.s.le $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.num intrisic=pvfmksnum_Mvl
def veoldPVFMKSNUMvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.num $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.num intrisic=pvfmksnum_MvMl
def veoldPVFMKSNUMvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.s.num $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.nan intrisic=pvfmksnan_Mvl
def veoldPVFMKSNANvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.nan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.nan intrisic=pvfmksnan_MvMl
def veoldPVFMKSNANvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.s.nan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.gtnan intrisic=pvfmksgtnan_Mvl
def veoldPVFMKSGTNANvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.gtnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.gtnan intrisic=pvfmksgtnan_MvMl
def veoldPVFMKSGTNANvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.s.gtnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.ltnan intrisic=pvfmksltnan_Mvl
def veoldPVFMKSLTNANvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.ltnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.ltnan intrisic=pvfmksltnan_MvMl
def veoldPVFMKSLTNANvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.s.ltnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.nenan intrisic=pvfmksnenan_Mvl
def veoldPVFMKSNENANvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.nenan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.nenan intrisic=pvfmksnenan_MvMl
def veoldPVFMKSNENANvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.s.nenan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.eqnan intrisic=pvfmkseqnan_Mvl
def veoldPVFMKSEQNANvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.eqnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.eqnan intrisic=pvfmkseqnan_MvMl
def veoldPVFMKSEQNANvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.s.eqnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.genan intrisic=pvfmksgenan_Mvl
def veoldPVFMKSGENANvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.genan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.genan intrisic=pvfmksgenan_MvMl
def veoldPVFMKSGENANvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.s.genan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lenan intrisic=pvfmkslenan_Mvl
def veoldPVFMKSLENANvl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.lenan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lenan intrisic=pvfmkslenan_MvMl
def veoldPVFMKSLENANvxl : Pseudo<(outs VM512:$vmx), (ins V64:$vz, VM512:$vm, I32:$vl),
       "# pvfmk.s.lenan $vmx,$vz,$vm", []>
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
def veoldVSUMWSXvxl : RV<0xea, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl),
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
def veoldVSUMWZXvxl : RV<0xea, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl),
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
def veoldVSUMLvxl : RV<0xaa, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl),
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
def veoldVFSUMDvxl : RV<0xec, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl),
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
def veoldVFSUMSvxl : RV<0xec, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl),
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
def veoldVRANDvxl : RV<0x88, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl),
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
def veoldVRORvxl : RV<0x98, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl),
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
def veoldVRXORvxl : RV<0x89, (outs V64:$vx), (ins V64:$vy, VM:$vm, I32:$vl),
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
def veoldVGTvrrxl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vgt $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssmvl
def veoldVGTvrrxl_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgt $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssml
def veoldVGTvrzxl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vgt $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssmvl
def veoldVGTvrzxl_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgt $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssml
def veoldVGTvirxl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vgt $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssmvl
def veoldVGTvirxl_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgt $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssml
def veoldVGTvizxl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vgt $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssmvl
def veoldVGTvizxl_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVGTNCvrrxl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssmvl
def veoldVGTNCvrrxl_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgt.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssml
def veoldVGTNCvrzxl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssmvl
def veoldVGTNCvrzxl_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgt.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssml
def veoldVGTNCvirxl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vgt.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssmvl
def veoldVGTNCvirxl_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgt.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssml
def veoldVGTNCvizxl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vgt.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssmvl
def veoldVGTNCvizxl_v : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVGTUvrrxl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vgtu $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssmvl
def veoldVGTUvrrxl_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtu $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssml
def veoldVGTUvrzxl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vgtu $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssmvl
def veoldVGTUvrzxl_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtu $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssml
def veoldVGTUvirxl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vgtu $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssmvl
def veoldVGTUvirxl_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtu $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssml
def veoldVGTUvizxl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vgtu $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssmvl
def veoldVGTUvizxl_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVGTUNCvrrxl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssmvl
def veoldVGTUNCvrrxl_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtu.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssml
def veoldVGTUNCvrzxl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssmvl
def veoldVGTUNCvrzxl_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtu.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssml
def veoldVGTUNCvirxl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssmvl
def veoldVGTUNCvirxl_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtu.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssml
def veoldVGTUNCvizxl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssmvl
def veoldVGTUNCvizxl_v : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVGTLSXvrrxl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssmvl
def veoldVGTLSXvrrxl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.sx $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssml
def veoldVGTLSXvrzxl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssmvl
def veoldVGTLSXvrzxl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.sx $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssml
def veoldVGTLSXvirxl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssmvl
def veoldVGTLSXvirxl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.sx $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssml
def veoldVGTLSXvizxl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssmvl
def veoldVGTLSXvizxl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVGTLSXNCvrrxl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssmvl
def veoldVGTLSXNCvrrxl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.sx.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssml
def veoldVGTLSXNCvrzxl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssmvl
def veoldVGTLSXNCvrzxl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.sx.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssml
def veoldVGTLSXNCvirxl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssmvl
def veoldVGTLSXNCvirxl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.sx.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssml
def veoldVGTLSXNCvizxl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssmvl
def veoldVGTLSXNCvizxl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVGTLZXvrrxl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssmvl
def veoldVGTLZXvrrxl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.zx $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssml
def veoldVGTLZXvrzxl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssmvl
def veoldVGTLZXvrzxl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.zx $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssml
def veoldVGTLZXvirxl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssmvl
def veoldVGTLZXvirxl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.zx $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssml
def veoldVGTLZXvizxl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssmvl
def veoldVGTLZXvizxl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
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
def veoldVGTLZXNCvrrxl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssmvl
def veoldVGTLZXNCvrrxl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.zx.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssml
def veoldVGTLZXNCvrzxl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssmvl
def veoldVGTLZXNCvrzxl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.zx.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssml
def veoldVGTLZXNCvirxl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssmvl
def veoldVGTLZXNCvirxl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.zx.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssml
def veoldVGTLZXNCvizxl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssmvl
def veoldVGTLZXNCvizxl_v : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl, V64:$pt),
       "vgtl.zx.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssl
def veoldVSCvvrrl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vsc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssl
def veoldVSCvvrzl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vsc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssl
def veoldVSCvvirl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vsc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssl
def veoldVSCvvizl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vsc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssml
def veoldVSCvvrrxl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vsc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssml
def veoldVSCvvrzxl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vsc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssml
def veoldVSCvvirxl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vsc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssml
def veoldVSCvvizxl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vsc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssl
def veoldVSCNCvvrrl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vsc.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssl
def veoldVSCNCvvrzl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vsc.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssl
def veoldVSCNCvvirl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vsc.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssl
def veoldVSCNCvvizl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vsc.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssml
def veoldVSCNCvvrrxl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vsc.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssml
def veoldVSCNCvvrzxl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vsc.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssml
def veoldVSCNCvvirxl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vsc.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssml
def veoldVSCNCvvizxl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vsc.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssl
def veoldVSCOTvvrrl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vsc.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssl
def veoldVSCOTvvrzl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vsc.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssl
def veoldVSCOTvvirl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vsc.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssl
def veoldVSCOTvvizl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vsc.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssml
def veoldVSCOTvvrrxl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssml
def veoldVSCOTvvrzxl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssml
def veoldVSCOTvvirxl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssml
def veoldVSCOTvvizxl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssl
def veoldVSCNCOTvvrrl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vsc.nc.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssl
def veoldVSCNCOTvvrzl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vsc.nc.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssl
def veoldVSCNCOTvvirl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vsc.nc.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssl
def veoldVSCNCOTvvizl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vsc.nc.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssml
def veoldVSCNCOTvvrrxl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vsc.nc.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssml
def veoldVSCNCOTvvrzxl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vsc.nc.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssml
def veoldVSCNCOTvvirxl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vsc.nc.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssml
def veoldVSCNCOTvvizxl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vsc.nc.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssl
def veoldVSCUvvrrl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscu $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssl
def veoldVSCUvvrzl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vscu $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssl
def veoldVSCUvvirl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vscu $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssl
def veoldVSCUvvizl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vscu $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssml
def veoldVSCUvvrrxl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vscu $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssml
def veoldVSCUvvrzxl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vscu $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssml
def veoldVSCUvvirxl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vscu $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssml
def veoldVSCUvvizxl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vscu $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssl
def veoldVSCUNCvvrrl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscu.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssl
def veoldVSCUNCvvrzl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vscu.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssl
def veoldVSCUNCvvirl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vscu.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssl
def veoldVSCUNCvvizl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vscu.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssml
def veoldVSCUNCvvrrxl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vscu.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssml
def veoldVSCUNCvvrzxl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vscu.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssml
def veoldVSCUNCvvirxl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vscu.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssml
def veoldVSCUNCvvizxl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vscu.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssl
def veoldVSCUOTvvrrl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscu.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssl
def veoldVSCUOTvvrzl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vscu.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssl
def veoldVSCUOTvvirl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vscu.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssl
def veoldVSCUOTvvizl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vscu.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssml
def veoldVSCUOTvvrrxl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssml
def veoldVSCUOTvvrzxl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssml
def veoldVSCUOTvvirxl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssml
def veoldVSCUOTvvizxl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssl
def veoldVSCUNCOTvvrrl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscu.nc.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssl
def veoldVSCUNCOTvvrzl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vscu.nc.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssl
def veoldVSCUNCOTvvirl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vscu.nc.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssl
def veoldVSCUNCOTvvizl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vscu.nc.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssml
def veoldVSCUNCOTvvrrxl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vscu.nc.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssml
def veoldVSCUNCOTvvrzxl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vscu.nc.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssml
def veoldVSCUNCOTvvirxl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vscu.nc.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssml
def veoldVSCUNCOTvvizxl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vscu.nc.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssl
def veoldVSCLvvrrl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscl $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssl
def veoldVSCLvvrzl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vscl $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssl
def veoldVSCLvvirl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vscl $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssl
def veoldVSCLvvizl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vscl $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssml
def veoldVSCLvvrrxl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vscl $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssml
def veoldVSCLvvrzxl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vscl $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssml
def veoldVSCLvvirxl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vscl $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssml
def veoldVSCLvvizxl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vscl $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssl
def veoldVSCLNCvvrrl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscl.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssl
def veoldVSCLNCvvrzl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vscl.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssl
def veoldVSCLNCvvirl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vscl.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssl
def veoldVSCLNCvvizl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vscl.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssml
def veoldVSCLNCvvrrxl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vscl.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssml
def veoldVSCLNCvvrzxl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vscl.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssml
def veoldVSCLNCvvirxl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vscl.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssml
def veoldVSCLNCvvizxl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vscl.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssl
def veoldVSCLOTvvrrl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscl.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssl
def veoldVSCLOTvvrzl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vscl.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssl
def veoldVSCLOTvvirl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vscl.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssl
def veoldVSCLOTvvizl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vscl.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssml
def veoldVSCLOTvvrrxl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssml
def veoldVSCLOTvvrzxl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssml
def veoldVSCLOTvvirxl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssml
def veoldVSCLOTvvizxl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssl
def veoldVSCLNCOTvvrrl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscl.nc.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssl
def veoldVSCLNCOTvvrzl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, I32:$vl),
       "vscl.nc.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssl
def veoldVSCLNCOTvvirl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, I32:$vl),
       "vscl.nc.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssl
def veoldVSCLNCOTvvizl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, I32:$vl),
       "vscl.nc.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssml
def veoldVSCLNCOTvvrrxl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM:$vm, I32:$vl),
       "vscl.nc.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssml
def veoldVSCLNCOTvvrzxl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7:$Z, VM:$vm, I32:$vl),
       "vscl.nc.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssml
def veoldVSCLNCOTvvirxl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, I64:$sz, VM:$vm, I32:$vl),
       "vscl.nc.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssml
def veoldVSCLNCOTvvizxl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7:$I, simm7:$Z, VM:$vm, I32:$vl),
       "vscl.nc.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=ANDM asm=andm intrisic=andm_mmm
def veoldANDMxx : RV<0x84, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz),
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
def veoldORMxx : RV<0x85, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz),
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
def veoldXORMxx : RV<0x86, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz),
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
def veoldEQVMxx : RV<0x87, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz),
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
def veoldNNDMxx : RV<0x94, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz),
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
def veoldNEGMx : RV<0x95, (outs VM:$vmx), (ins VM:$vmy),
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
def veoldPCVMxl : RV<0xa4, (outs I64:$sx), (ins VM:$vmy, I32:$vl),
       "pcvm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=LZVM asm=lzvm intrisic=lzvm_sml
def veoldLZVMxl : RV<0xa5, (outs I64:$sx), (ins VM:$vmy, I32:$vl),
       "lzvm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=TOVM asm=tovm intrisic=tovm_sml
def veoldTOVMxl : RV<0xa6, (outs I64:$sx), (ins VM:$vmy, I32:$vl),
       "tovm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}


def : Pat<(int_ve_vscot_vv v256f64:$vx, v256f64:$vy), (VSCotv v256f64:$vx, v256f64:$vy, (GetVL (i32 0)))>;
def : Pat<(int_ve_vscuot_vv v256f64:$vx, v256f64:$vy), (VSCUotv v256f64:$vx, v256f64:$vy, (GetVL (i32 0)))>;
def : Pat<(int_ve_vsclot_vv v256f64:$vx, v256f64:$vy), (VSCLotv v256f64:$vx, v256f64:$vy, (GetVL (i32 0)))>;

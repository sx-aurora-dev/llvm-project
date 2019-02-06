def : Pat<(int_ve_vscot_vv v256f64:$vx, v256f64:$vy), (VSCotv v256f64:$vx, v256f64:$vy, VLS)>;

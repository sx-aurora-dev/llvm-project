# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=skylake-avx512 -instruction-tables < %s | FileCheck %s

vandnpd           %zmm16, %zmm17, %zmm19
vandnpd           (%rax), %zmm17, %zmm19
vandnpd           (%rax){1to8}, %zmm17, %zmm19
vandnpd           %zmm16, %zmm17, %zmm19 {k1}
vandnpd           (%rax), %zmm17, %zmm19 {k1}
vandnpd           (%rax){1to8}, %zmm17, %zmm19 {k1}
vandnpd           %zmm16, %zmm17, %zmm19 {z}{k1}
vandnpd           (%rax), %zmm17, %zmm19 {z}{k1}
vandnpd           (%rax){1to8}, %zmm17, %zmm19 {z}{k1}

vandnps           %zmm16, %zmm17, %zmm19
vandnps           (%rax), %zmm17, %zmm19
vandnps           (%rax){1to16}, %zmm17, %zmm19
vandnps           %zmm16, %zmm17, %zmm19 {k1}
vandnps           (%rax), %zmm17, %zmm19 {k1}
vandnps           (%rax){1to16}, %zmm17, %zmm19 {k1}
vandnps           %zmm16, %zmm17, %zmm19 {z}{k1}
vandnps           (%rax), %zmm17, %zmm19 {z}{k1}
vandnps           (%rax){1to16}, %zmm17, %zmm19 {z}{k1}

vandpd            %zmm16, %zmm17, %zmm19
vandpd            (%rax), %zmm17, %zmm19
vandpd            (%rax){1to8}, %zmm17, %zmm19
vandpd            %zmm16, %zmm17, %zmm19 {k1}
vandpd            (%rax), %zmm17, %zmm19 {k1}
vandpd            (%rax){1to8}, %zmm17, %zmm19 {k1}
vandpd            %zmm16, %zmm17, %zmm19 {z}{k1}
vandpd            (%rax), %zmm17, %zmm19 {z}{k1}
vandpd            (%rax){1to8}, %zmm17, %zmm19 {z}{k1}

vandps            %zmm16, %zmm17, %zmm19
vandps            (%rax), %zmm17, %zmm19
vandps            (%rax){1to16}, %zmm17, %zmm19
vandps            %zmm16, %zmm17, %zmm19 {k1}
vandps            (%rax), %zmm17, %zmm19 {k1}
vandps            (%rax){1to16}, %zmm17, %zmm19 {k1}
vandps            %zmm16, %zmm17, %zmm19 {z}{k1}
vandps            (%rax), %zmm17, %zmm19 {z}{k1}
vandps            (%rax){1to16}, %zmm17, %zmm19 {z}{k1}

vcvtqq2pd         %zmm16, %zmm19
vcvtqq2pd         (%rax), %zmm19
vcvtqq2pd         (%rax){1to8}, %zmm19
vcvtqq2pd         %zmm16, %zmm19 {k1}
vcvtqq2pd         (%rax), %zmm19 {k1}
vcvtqq2pd         (%rax){1to8}, %zmm19 {k1}
vcvtqq2pd         %zmm16, %zmm19 {z}{k1}
vcvtqq2pd         (%rax), %zmm19 {z}{k1}
vcvtqq2pd         (%rax){1to8}, %zmm19 {z}{k1}

vcvtqq2ps         %zmm16, %ymm19
vcvtqq2ps         (%rax), %ymm19
vcvtqq2ps         (%rax){1to8}, %ymm19
vcvtqq2ps         %zmm16, %ymm19 {k1}
vcvtqq2ps         (%rax), %ymm19 {k1}
vcvtqq2ps         (%rax){1to8}, %ymm19 {k1}
vcvtqq2ps         %zmm16, %ymm19 {z}{k1}
vcvtqq2ps         (%rax), %ymm19 {z}{k1}
vcvtqq2ps         (%rax){1to8}, %ymm19 {z}{k1}

vorpd             %zmm16, %zmm17, %zmm19
vorpd             (%rax), %zmm17, %zmm19
vorpd             (%rax){1to8}, %zmm17, %zmm19
vorpd             %zmm16, %zmm17, %zmm19 {k1}
vorpd             (%rax), %zmm17, %zmm19 {k1}
vorpd             (%rax){1to8}, %zmm17, %zmm19 {k1}
vorpd             %zmm16, %zmm17, %zmm19 {z}{k1}
vorpd             (%rax), %zmm17, %zmm19 {z}{k1}
vorpd             (%rax){1to8}, %zmm17, %zmm19 {z}{k1}

vorps             %zmm16, %zmm17, %zmm19
vorps             (%rax), %zmm17, %zmm19
vorps             (%rax){1to16}, %zmm17, %zmm19
vorps             %zmm16, %zmm17, %zmm19 {k1}
vorps             (%rax), %zmm17, %zmm19 {k1}
vorps             (%rax){1to16}, %zmm17, %zmm19 {k1}
vorps             %zmm16, %zmm17, %zmm19 {z}{k1}
vorps             (%rax), %zmm17, %zmm19 {z}{k1}
vorps             (%rax){1to16}, %zmm17, %zmm19 {z}{k1}

vpmullq           %zmm16, %zmm17, %zmm19
vpmullq           (%rax), %zmm17, %zmm19
vpmullq           %zmm16, %zmm17, %zmm19 {k1}
vpmullq           (%rax), %zmm17, %zmm19 {k1}
vpmullq           %zmm16, %zmm17, %zmm19 {z}{k1}
vpmullq           (%rax), %zmm17, %zmm19 {z}{k1}

vxorpd            %zmm16, %zmm17, %zmm19
vxorpd            (%rax), %zmm17, %zmm19
vxorpd            (%rax){1to8}, %zmm17, %zmm19
vxorpd            %zmm16, %zmm17, %zmm19 {k1}
vxorpd            (%rax), %zmm17, %zmm19 {k1}
vxorpd            (%rax){1to8}, %zmm17, %zmm19 {k1}
vxorpd            %zmm16, %zmm17, %zmm19 {z}{k1}
vxorpd            (%rax), %zmm17, %zmm19 {z}{k1}
vxorpd            (%rax){1to8}, %zmm17, %zmm19 {z}{k1}

vxorps            %zmm16, %zmm17, %zmm19
vxorps            (%rax), %zmm17, %zmm19
vxorps            (%rax){1to16}, %zmm17, %zmm19
vxorps            %zmm16, %zmm17, %zmm19 {k1}
vxorps            (%rax), %zmm17, %zmm19 {k1}
vxorps            (%rax){1to16}, %zmm17, %zmm19 {k1}
vxorps            %zmm16, %zmm17, %zmm19 {z}{k1}
vxorps            (%rax), %zmm17, %zmm19 {z}{k1}
vxorps            (%rax){1to16}, %zmm17, %zmm19 {z}{k1}

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     0.50                        vandnpd	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vandnpd	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vandnpd	(%rax){1to8}, %zmm17, %zmm19
# CHECK-NEXT:  1      1     0.50                        vandnpd	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vandnpd	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vandnpd	(%rax){1to8}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     0.50                        vandnpd	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vandnpd	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vandnpd	(%rax){1to8}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     0.50                        vandnps	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vandnps	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vandnps	(%rax){1to16}, %zmm17, %zmm19
# CHECK-NEXT:  1      1     0.50                        vandnps	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vandnps	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vandnps	(%rax){1to16}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     0.50                        vandnps	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vandnps	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vandnps	(%rax){1to16}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     0.50                        vandpd	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vandpd	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vandpd	(%rax){1to8}, %zmm17, %zmm19
# CHECK-NEXT:  1      1     0.50                        vandpd	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vandpd	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vandpd	(%rax){1to8}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     0.50                        vandpd	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vandpd	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vandpd	(%rax){1to8}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     0.50                        vandps	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vandps	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vandps	(%rax){1to16}, %zmm17, %zmm19
# CHECK-NEXT:  1      1     0.50                        vandps	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vandps	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vandps	(%rax){1to16}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     0.50                        vandps	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vandps	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vandps	(%rax){1to16}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      4     0.50                        vcvtqq2pd	%zmm16, %zmm19
# CHECK-NEXT:  2      11    0.50    *                   vcvtqq2pd	(%rax), %zmm19
# CHECK-NEXT:  2      11    0.50    *                   vcvtqq2pd	(%rax){1to8}, %zmm19
# CHECK-NEXT:  1      4     0.50                        vcvtqq2pd	%zmm16, %zmm19 {%k1}
# CHECK-NEXT:  2      11    0.50    *                   vcvtqq2pd	(%rax), %zmm19 {%k1}
# CHECK-NEXT:  2      11    0.50    *                   vcvtqq2pd	(%rax){1to8}, %zmm19 {%k1}
# CHECK-NEXT:  1      4     0.50                        vcvtqq2pd	%zmm16, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      11    0.50    *                   vcvtqq2pd	(%rax), %zmm19 {%k1} {z}
# CHECK-NEXT:  2      11    0.50    *                   vcvtqq2pd	(%rax){1to8}, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      7     1.00                        vcvtqq2ps	%zmm16, %ymm19
# CHECK-NEXT:  3      14    1.00    *                   vcvtqq2ps	(%rax), %ymm19
# CHECK-NEXT:  3      14    1.00    *                   vcvtqq2ps	(%rax){1to8}, %ymm19
# CHECK-NEXT:  1      4     0.50                        vcvtqq2ps	%zmm16, %ymm19 {%k1}
# CHECK-NEXT:  3      14    1.00    *                   vcvtqq2ps	(%rax), %ymm19 {%k1}
# CHECK-NEXT:  3      14    1.00    *                   vcvtqq2ps	(%rax){1to8}, %ymm19 {%k1}
# CHECK-NEXT:  1      4     0.50                        vcvtqq2ps	%zmm16, %ymm19 {%k1} {z}
# CHECK-NEXT:  3      14    1.00    *                   vcvtqq2ps	(%rax), %ymm19 {%k1} {z}
# CHECK-NEXT:  3      14    1.00    *                   vcvtqq2ps	(%rax){1to8}, %ymm19 {%k1} {z}
# CHECK-NEXT:  1      1     0.50                        vorpd	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vorpd	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vorpd	(%rax){1to8}, %zmm17, %zmm19
# CHECK-NEXT:  1      1     0.50                        vorpd	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vorpd	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vorpd	(%rax){1to8}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     0.50                        vorpd	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vorpd	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vorpd	(%rax){1to8}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     0.50                        vorps	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vorps	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vorps	(%rax){1to16}, %zmm17, %zmm19
# CHECK-NEXT:  1      1     0.50                        vorps	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vorps	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vorps	(%rax){1to16}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     0.50                        vorps	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vorps	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vorps	(%rax){1to16}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  3      12    1.50                        vpmullq	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  4      19    1.00    *                   vpmullq	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  3      12    1.50                        vpmullq	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  4      19    1.00    *                   vpmullq	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  3      12    1.50                        vpmullq	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  4      19    1.00    *                   vpmullq	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     0.50                        vxorpd	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vxorpd	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vxorpd	(%rax){1to8}, %zmm17, %zmm19
# CHECK-NEXT:  1      1     0.50                        vxorpd	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vxorpd	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vxorpd	(%rax){1to8}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     0.50                        vxorpd	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vxorpd	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vxorpd	(%rax){1to8}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     0.50                        vxorps	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vxorps	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vxorps	(%rax){1to16}, %zmm17, %zmm19
# CHECK-NEXT:  1      1     0.50                        vxorps	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vxorps	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vxorps	(%rax){1to16}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     0.50                        vxorps	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vxorps	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vxorps	(%rax){1to16}, %zmm17, %zmm19 {%k1} {z}

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SKXDivider
# CHECK-NEXT: [1]   - SKXFPDivider
# CHECK-NEXT: [2]   - SKXPort0
# CHECK-NEXT: [3]   - SKXPort1
# CHECK-NEXT: [4]   - SKXPort2
# CHECK-NEXT: [5]   - SKXPort3
# CHECK-NEXT: [6]   - SKXPort4
# CHECK-NEXT: [7]   - SKXPort5
# CHECK-NEXT: [8]   - SKXPort6
# CHECK-NEXT: [9]   - SKXPort7

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]
# CHECK-NEXT:  -      -     50.50  7.00   31.50  31.50   -     57.50   -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    Instructions:
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vandnpd	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandnpd	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandnpd	(%rax){1to8}, %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vandnpd	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandnpd	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandnpd	(%rax){1to8}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vandnpd	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandnpd	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandnpd	(%rax){1to8}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vandnps	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandnps	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandnps	(%rax){1to16}, %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vandnps	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandnps	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandnps	(%rax){1to16}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vandnps	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandnps	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandnps	(%rax){1to16}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vandpd	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandpd	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandpd	(%rax){1to8}, %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vandpd	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandpd	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandpd	(%rax){1to8}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vandpd	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandpd	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandpd	(%rax){1to8}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vandps	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandps	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandps	(%rax){1to16}, %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vandps	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandps	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandps	(%rax){1to16}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vandps	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandps	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vandps	(%rax){1to16}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vcvtqq2pd	%zmm16, %zmm19
# CHECK-NEXT:  -      -     0.33   0.33   0.50   0.50    -     0.33    -      -     vcvtqq2pd	(%rax), %zmm19
# CHECK-NEXT:  -      -     0.33   0.33   0.50   0.50    -     0.33    -      -     vcvtqq2pd	(%rax){1to8}, %zmm19
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vcvtqq2pd	%zmm16, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.33   0.33   0.50   0.50    -     0.33    -      -     vcvtqq2pd	(%rax), %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.33   0.33   0.50   0.50    -     0.33    -      -     vcvtqq2pd	(%rax){1to8}, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vcvtqq2pd	%zmm16, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.33   0.33   0.50   0.50    -     0.33    -      -     vcvtqq2pd	(%rax), %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.33   0.33   0.50   0.50    -     0.33    -      -     vcvtqq2pd	(%rax){1to8}, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     1.50    -      -     vcvtqq2ps	%zmm16, %ymm19
# CHECK-NEXT:  -      -     0.33   0.33   0.50   0.50    -     1.33    -      -     vcvtqq2ps	(%rax), %ymm19
# CHECK-NEXT:  -      -     0.33   0.33   0.50   0.50    -     1.33    -      -     vcvtqq2ps	(%rax){1to8}, %ymm19
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vcvtqq2ps	%zmm16, %ymm19 {%k1}
# CHECK-NEXT:  -      -     0.33   0.33   0.50   0.50    -     1.33    -      -     vcvtqq2ps	(%rax), %ymm19 {%k1}
# CHECK-NEXT:  -      -     0.33   0.33   0.50   0.50    -     1.33    -      -     vcvtqq2ps	(%rax){1to8}, %ymm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vcvtqq2ps	%zmm16, %ymm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.33   0.33   0.50   0.50    -     1.33    -      -     vcvtqq2ps	(%rax), %ymm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.33   0.33   0.50   0.50    -     1.33    -      -     vcvtqq2ps	(%rax){1to8}, %ymm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vorpd	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vorpd	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vorpd	(%rax){1to8}, %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vorpd	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vorpd	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vorpd	(%rax){1to8}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vorpd	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vorpd	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vorpd	(%rax){1to8}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vorps	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vorps	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vorps	(%rax){1to16}, %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vorps	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vorps	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vorps	(%rax){1to16}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vorps	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vorps	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vorps	(%rax){1to16}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     1.50    -      -      -      -     1.50    -      -     vpmullq	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -     1.00   1.00   0.50   0.50    -     1.00    -      -     vpmullq	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -     1.50    -      -      -      -     1.50    -      -     vpmullq	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     1.00   1.00   0.50   0.50    -     1.00    -      -     vpmullq	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     1.50    -      -      -      -     1.50    -      -     vpmullq	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     1.00   1.00   0.50   0.50    -     1.00    -      -     vpmullq	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vxorpd	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vxorpd	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vxorpd	(%rax){1to8}, %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vxorpd	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vxorpd	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vxorpd	(%rax){1to8}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vxorpd	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vxorpd	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vxorpd	(%rax){1to8}, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vxorps	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vxorps	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vxorps	(%rax){1to16}, %zmm17, %zmm19
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vxorps	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vxorps	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vxorps	(%rax){1to16}, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -     0.50    -      -      -      -     0.50    -      -     vxorps	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vxorps	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.50    -     0.50   0.50    -     0.50    -      -     vxorps	(%rax){1to16}, %zmm17, %zmm19 {%k1} {z}

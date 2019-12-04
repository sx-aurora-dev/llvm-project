=======================================
How to use Vector Length register on VE
=======================================

.. contents:: Table of Contents
  :depth: 4
  :local:

Introduction
============

This is a description of Vector Length register on VE and its usage, how to
generate MIR, how to generate intrinsic IR, etc.  Assembler instructions are
available at
(https://www.hpc.nec/documents/sdk/pdfs/VectorEngine-as-manual-v1.2.pdf).

What is Vector Length register
==============================

A Vector Length register (VL) is implicitly specified from almost all
vector instructions to represent the length of vector calculation of
the instruction.  For example, `vadds.w.sx` instruction calculates
v256i32 when VL is 256.  The same instruction calculates v128i32 when
VL is 128.

This VL can holds a value from 0 to 256 on the first generation of Vector
Engine.

What is a problem
=================

VL register is implicitly specified.  That means llvm cannot track
its liveness information if we implement this VL by implicit-def/use.

For example, if we have following program, we need to spill/restore
vector registers and VL register since function calls destroy them.
However, it is difficult to restore correct VL at vfaddd intrinsic
without information to track the VL register.

```
  _ve_lvl(32);     // specify 32 to VL
  __vr vy = _ve_vld_vss(8, pvy);
  __vr vz = _ve_vld_vss(8, pvz);
  dump(vy);
  dump(vz);
  __vr vx = _ve_vfaddd_vvv(vy, vz);
```

How to solve the problem
========================

We decide to specify VL register at each vector instruction explicitly
and let register allocator allocates VL register even if only one VL
register available on VE.  This gives llvm enough information to track the
VL register.

For example, above example code is converted to following MIR.
Then, we can spill/restore %21 virtual register correctly.

```
  %20:i64 = LEAzzi 32
  %21:vls = COPY %20:i64
  %23:v64 = VLDir 8, killed %22:i64, %21:vls
  %25:v64 = VLDir 8, killed %24:i64, %21:vls
  CALLr $sx12, ...
  CALLr $sx12, ...
  %32:v64 = VFADdv killed %23:v64, killed %25:v64, %21:vls
```

In order to do so, we need to add a new path to add VL explicitly
and form SSA correctly.

How to create new MIR with VL
=============================

If you need a new VL, you can create it like below.  We generaly add
the VL as the last operand.

```
  unsigned Tmp1 = MF.getRegInfo().createVirtualRegister(&VE::I32RegClass);
  BuildMI(MBB, MBBI, dl, TII.get(VE::LEAzzi), Tmp1)
    .addImm(128);
  unsigned VLReg = MF.getRegInfo().createVirtualRegister(&VE::VLSRegClass);
  BuildMI(MBB, MBBI, dl, TII.get(VE::COPY), VLReg)
    .addReg(Tmp1, getKillRegState(true));
  BuildMI(MBB, MBBI, dl, TII.get(VE::VFMADsv), DestReg)
    .addReg(V5).addReg(V5).addReg(V4)
    .addReg(VLReg, getKillRegState(true));
```

Or like below in DAG (this example uses existing VL).

```
  unsigned VLReg = Subtarget->getInstrInfo()->getVectorLengthReg(&MF);
  SDValue VL = DAG.getCopyFromReg(DAG.getEntryNode(), dl, VLReg, MVT::i32);
  SDValue V5 = SDValue(DAG.getMachineNode(VE::VRCPsv, dl, VT, V1, VL), 0);
```

Latter example uses single virtual VL register at conversion, but codes
will be modified to refer correct virtual VL register in finalizeLowering().

How to create new MIR with VL in tblgen
=======================================

If you need a new VL, you can create it like below.

```
def : Pat<(v512i32 (load ADDRri:$addr)),
          (v512i32 (VLDir 8, (LEAasx ADDRri:$addr),
                             (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
```

Or you can refer existing VL like below.  This `(GetVL (i32 0))` returns
the default virtual VL register defined in MachineFunction.

```
  def : Pat<(int_ve_vscot_vv v256f64:$vx, v256f64:$vy),
            (VSCotv v256f64:$vx, v256f64:$vy, (GetVL (i32 0)))>;
```

This example uses single virtual VL register at conversion, but codes
will be modified to refer correct virtual VL register in finalizeLowering().

Details of forming SSA form for VL register
===========================================

At conversion, we define single default virtual VL register per
MachineFunction.  All vector instructions needed to refer existing
VL regsiter use this default virtual VL register.  However, `_ve_lvl`
intrinsic which defines a new VL is converted to an instruction
defines physical VL register since re-defining existing virtual VL
register breaks SSA.

For example, let's consider about following inputs.

```
.bb.0:
  ...

.bb.1:
  _ve_lvl(32);
  bra .bb.3

.bb.2:
  _ve_lvl(l);

.bb.3:
  __vr vx = _ve_vfaddd_vvv(vy, vz);
```

This is converted like below in the middle of MIR lowering.

```
.bb.0:
  %0:vls = COPY $vl   ; copy incoming $vl to the default virtual VL register
  ...

.bb.1:
  $vl = COPY 32       ; copy new value to $vl temporary to not break SSA
  bra .bb.3

.bb.2:
  $vl = COPY %l:i32   ; copy new value to $vl temporary to not break SSA

.bb.3:
  %32:v64 = VFADdv killed %23:v64, killed %25:v64, %0:vls
```

And, this is converted like below at `finalizeLowering()`.

```
.bb.0:
  %0:vls = COPY $vl
  ...

.bb.1:
  %1:vls = COPY 32     ; create new virtual VL at finalize phase.
  bra .bb.3

.bb.2:
  %2:vls = COPY %l:i32 ; create new virtual VL at finalize phase.

.bb.3:
  %3:vls = PHI %1:vls, %bb.1, %2:vls, %bb.2 ; create new PHI to form SSA
                                            ; correctly at finalize phase.
  %32:v64 = VFADdv killed %23:v64, killed %25:v64, %3:vls
```

We would like to use mem2reg here, but it is difficult to use mem2reg
in the middle of MIR lowering, so we implemented our own SSA stuff
in `finalizeLowering()`.


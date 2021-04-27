# We use long line(E501) and ambiguous variable name like I, O(E741)
# pylama:ignore=E501,E741

import argparse
import re
from functools import partial


class Type:
    def __init__(self, ValueType, builtinCode, intrinDefType, ctype,
                 elemType=None):
        self.ValueType = ValueType  # v256f64, f64, f32, i64, ...
        self.builtinCode = builtinCode  # V256d, d, f, ...
        self.intrinDefType = intrinDefType  # LLVMType<f64>, ...
        self.ctype = ctype
        self.elemType = elemType

    def isVectorType(self):
        return self.elemType is not None

    def stride(self):
        if self.isVectorType():
            if self.elemType in [T_f64, T_i64, T_u64]:
                return 8
            else:
                return 4
        raise Exception("not a vector type")

T_f64     = Type("f64",     "d",      "LLVMType<f64>", "double")  # noqa
T_f32     = Type("f32",     "f",      "LLVMType<f32>", "float")  # noqa
T_i64     = Type("i64",     "Li",     "LLVMType<i64>", "long int")  # noqa
T_i32     = Type("i32",     "i",      "LLVMType<i32>", "int", "I32")  # noqa
T_u64     = Type("i64",     "LUi",    "LLVMType<i64>", "unsigned long int")  # noqa
T_u32     = Type("i32",     "Ui",     "LLVMType<i32>", "unsigned int")  # noqa
T_voidp   = Type("i64",     "v*",     "llvm_ptr_ty",   "void*")  # noqa
T_voidcp  = Type("i64",     "vC*",    "llvm_ptr_ty",   "void const*") # noqa

T_v256f64 = Type("v256f64", "V256d",  "LLVMType<v256f64>", "double*", T_f64)
T_v256f32 = Type("v256f64", "V256d",  "LLVMType<v256f64>", "float*",  T_f32)
T_v256i64 = Type("v256f64", "V256d",  "LLVMType<v256f64>", "long int*", T_i64)
T_v256i32 = Type("v256f64", "V256d",  "LLVMType<v256f64>", "int*", T_i32)
T_v256u64 = Type("v256f64", "V256d",  "LLVMType<v256f64>", "unsigned long int*", T_u64)  # noqa
T_v256u32 = Type("v256f64", "V256d",  "LLVMType<v256f64>", "unsigned int*", T_u32)  # noqa

T_v256i1   = Type("v256i1",   "V256b",   "LLVMType<v256i1>", "unsigned int*", T_u64) # noqa
T_v512i1   = Type("v512i1",   "V512b",   "LLVMType<v512i1>", "unsigned int*", T_u64) # noqa


class Op:
    def __init__(self, kind, ty, name, regClass, instSuffix=None):
        self.kind = kind
        self.ty_ = ty
        self.name_ = name
        self.regClass_ = regClass
        self.instSuffix = instSuffix if instSuffix is not None else kind

    def regClass(self): return self.regClass_
    def intrinDefType(self): return self.ty_.intrinDefType
    def ValueType(self): return self.ty_.ValueType
    def builtinCode(self): return self.ty_.builtinCode
    def elemType(self): return self.ty_.elemType
    def ctype(self): return self.ty_.ctype
    def stride(self): return self.ty_.stride()

    def dagOpL(self):
        if self.kind == 'I' or self.kind == 'Z':
            return "{}:${}".format(self.immType, self.name_)
        else:
            return "{}:${}".format(self.ty_.ValueType, self.name_)

    def dagOpR(self):
        if self.kind == 'I' or self.kind == 'Z':
            if self.immType == "uimm7":
                return "(ULO7 ${})".format(self.name_)
            elif self.immType == "uimm6":
                return "(ULO7 ${})".format(self.name_)
            else:
                return "(LO7 ${})".format(self.name_)
        elif self.kind == 'cc':
            return "{}".format(self.cc_val_)
        elif self.kind == 'rd':
            return "{}".format(self.rd_val_)
        else:
            return "{}:${}".format(self.ty_.ValueType, self.name_)

    def isImm(self): return self.kind == 'I' or self.kind == 'N' or self.kind == "Z" # noqa
    def isReg(self): return self.kind == 'v' or self.kind == 's'
    def isSReg(self): return self.kind == 's' or self.kind == 'f'
    def isVReg(self): return self.kind == 'v'
    def isMask(self): return self.kind == 'm' or self.kind == 'M'
    def isMask256(self): return self.kind == 'm'
    def isMask512(self): return self.kind == 'M'
    def isVL(self): return self.kind == 'l'
    def isPassTrough(self): return self.name_ == "pt" or self.name_ == "ptm"

    def regName(self):
        return self.name_

    def formalName(self):
        if self.isVReg() or self.isMask():
            return "p" + self.name_
        else:
            return self.name_

    def VectorType(self):
        if self.isVReg():
            return "__vr"
        elif self.isMask512():
            return "__vm512"
        elif self.isMask():
            return "__vm256"
        raise Exception("not a vector type: {}".format(self.kind))


def VOp(ty, name, instSuffix=None):
    vtype = {T_f64: T_v256f64, T_f32: T_v256f32,
             T_i64: T_v256i64, T_i32: T_v256i32,
             T_u64: T_v256u64, T_u32: T_v256u32}
    if ty in vtype:
        return Op("v", vtype[ty], name, "V64", instSuffix)
    else:
        raise Exception("unknown type")


def SOp(ty, name):
    if ty in [T_f64, T_i64, T_u64, T_voidp, T_voidcp]:
        return Op("s", ty, name, "I64", "r")
    elif ty == T_f32:
        return Op("s", ty, name, "F32", "r")
    elif ty == T_i32:
        return Op("s", ty, name, "I32", "r")
    elif ty == T_u32:
        return Op("s", ty, name, "I32", "r")
    else:
        raise Exception("unknown type: {}".format(ty.ValueType))


def SX(ty): return SOp(ty, "sx")
def SY(ty): return SOp(ty, "sy")
def SZ(ty): return SOp(ty, "sz")
def SW(ty): return SOp(ty, "sw")


def VX(ty): return VOp(ty, "vx")
def VY(ty): return VOp(ty, "vy")
def VZ(ty): return VOp(ty, "vz")
def VW(ty): return VOp(ty, "vw")
def VD(ty): return VOp(ty, "pt", "_v")  # pass through


VL = Op("l", T_u32, "vl", "I32")
VM = Op("m", T_v256i1, "vm", "VM", "m")
VMX = Op("m", T_v256i1, "vmx", "VM", "m")
VMY = Op("m", T_v256i1, "vmy", "VM", "m")
VMZ = Op("m", T_v256i1, "vmz", "VM", "m")
VMD = Op("m", T_v256i1, "ptm", "VM", "_m")  # pass through
VM512 = Op("M", T_v512i1, "vm", "VM512", "m")
VMX512 = Op("M", T_v512i1, "vmx", "VM512", "m")
VMY512 = Op("M", T_v512i1, "vmy", "VM512", "m")
VMZ512 = Op("M", T_v512i1, "vmz", "VM512", "m")
VMD512 = Op("M", T_v512i1, "ptm", "VM512", "_m")  # pass through


class ImmOp(Op):
    def __init__(self, kind, ty, name, immType, instSuffix):
        regClass = {T_u32: "simm7", T_i32: "simm7",
                    T_u64: "simm7", T_i64: "simm7"}[ty]
        super(ImmOp, self).__init__(kind, ty, name, regClass, instSuffix)
        self.immType = immType


def ImmI(ty): return ImmOp("I", ty, "I", "simm7", "i")  # kind, type, varname
def ImmN(ty): return ImmOp("I", ty, "N", "uimm6", "i")
def UImm7(ty): return ImmOp("I", ty, "N", "uimm7", "i")
def UImm2(ty): return ImmOp("I", ty, "I", "uimm2", "i")
def UImm3(ty): return ImmOp("I", ty, "I", "uimm3", "i")
def ImmZ(ty): return ImmOp("Z", ty, "Z", "zero", "z")


CC_FLOAT = {'af': 'CC_AF',
            'gt': 'CC_G',  'lt': 'CC_L',
            'ne': 'CC_NE', 'eq': 'CC_EQ',
            'ge': 'CC_GE', 'le': 'CC_LE',
            'num': 'CC_NUM', 'nan': 'CC_NAN',
            'gtnan': 'CC_GNAN',  'ltnan': 'CC_LNAN',
            'nenan': 'CC_NENAN', 'eqnan': 'CC_EQNAN',
            'genan': 'CC_GENAN', 'lenan': 'CC_LENAN',
            'at': 'CC_AT'}
CC_INT = {'af': 'CC_AF',
          'gt': 'CC_IG',  'lt': 'CC_IL',
          'ne': 'CC_INE', 'eq': 'CC_IEQ',
          'ge': 'CC_IGE', 'le': 'CC_ILE',
          'num': 'CC_NUM', 'nan': 'CC_NAN',
          'gtnan': 'CC_GNAN',  'ltnan': 'CC_LNAN',
          'nenan': 'CC_NENAN', 'eqnan': 'CC_EQNAN',
          'genan': 'CC_GENAN', 'lenan': 'CC_LENAN',
          'at': 'CC_AT'}


class CCConstOp(Op):
    def __init__(self, cc_val):
        super(CCConstOp, self).__init__("cc", None, 'cc', "CCOp", "")
        self.cc_val_ = cc_val


class RDConstOp(Op):
    def __init__(self, rd_val):
        super(RDConstOp, self).__init__("rd", None, 'rd', "RDOp", "")
        self.rd_val_ = rd_val


def Args_vvv(ty): return [VX(ty), VY(ty), VZ(ty)]
def Args_vsv(tyV, tyS=None): return [VX(tyV), SY(tyS or tyV), VZ(tyV)]
def Args_vIv(ty): return [VX(ty), ImmI(ty), VZ(ty)]


def movePassTroughOp(ary):
    ret = []
    passTroughOp = None
    for op in ary:
        if op.isPassTrough():
            passTroughOp = op
        else:
            ret.append(op)
    if passTroughOp is not None:
        ret.append(passTroughOp)
    return ret


def reorderVSTOps(ary):
    return [ary[1], ary[2], ary[0]] + ary[3:]


def reorderVSCOps(ary):
    return [ary[1], ary[2], ary[3], ary[0]] + ary[4:]


def reorderSCROps(ary):
    return [ary[1], ary[2], ary[0]]


def addCCConstOp(ary, inst):
    cc = inst.kwargs['cc']
    if cc in ["CC_AT", "CC_AF"]:
        return ary
    return [CCConstOp(inst.kwargs['cc'])] + ary


def addRDConstOp(ary, inst):
    return [RDConstOp(inst.kwargs['rd'])] + ary


def getLLVMInstArgs(ary, inst=None, inst0=None):
    tmp = inst0 if inst is None else inst.inst()
    if tmp in ["VST", "VSTL", "VSTU", "VST2D", "VSTL2D", "VSTU2D"]:
        return reorderVSTOps(ary)
    if tmp in ["VSC", "VSCL", "VSCU"]:
        return reorderVSCOps(ary)
    if tmp in ["VFMK", "VFMS", "VFMF"] and inst is not None:
        return addCCConstOp(ary, inst)
    if tmp in ["VFIX", "VFIXX"] and inst is not None and 'rd' in inst.kwargs:
        return movePassTroughOp(addRDConstOp(ary, inst))
    if tmp in ["SCR", "TSCR"]:
        return reorderSCROps(ary)
    return movePassTroughOp(ary)

# inst: instruction in the manual. VFAD
# opc: op code (8bit)
# asm: vfadd.$df, vfmk.$df.$cf, vst.$nc.$ot
# llvmInst: Instruction in VEInstrVec.td. VFADdv
# intrinsicName: function name without prefix
#  => _ve_{intrinsicName}, __builtin_ve_{intrinsicName}, int_ve_{intrinsicName}

# subcode: cx, cx2, ... (4bit)
# subname: d, s, nc, ot, ...


class Inst:
    def __init__(self, opc, inst, asm, intrinsicName, outs, ins, **kwargs):
        self.kwargs = kwargs
        self.opc = opc
        self.outs = outs
        self.ins = ins

        self.inst_ = inst
        # self.subop_ = kwargs['subop'] if 'subop' in kwargs else None
        self.llvmInst_ = kwargs['llvmInst']
        self.asm_ = asm
        self.intrinsicName_ = intrinsicName
        self.funcPrefix_ = "_ve_"
        self.llvmIntrinsicPrefix_ = "_ve_"

        self.hasTest_ = True
        self.prop_ = ["IntrNoMem"]
        self.hasBuiltin_ = True
        self.hasPat_ = True
        self.hasLLVMInstDefine_ = True
        self.hasIntrinsicDef_ = True
        self.notYetImplemented_ = False
        self.Obsolete_ = False
        self.useNewInst_ = True

    def inst(self): return self.inst_
    def llvmInst(self): return self.llvmInst_
    def intrinsicName(self): return self.intrinsicName_
    def asm(self): return self.asm_ if self.asm_ else ""

    def expr(self):
        return None if 'expr' not in self.kwargs else self.kwargs['expr']

    def funcName(self): return f'{self.funcPrefix_}{self.intrinsicName()}'

    def builtinName(self):
        return f"__builtin{self.llvmIntrinsicPrefix_}{self.intrinsicName()}"

    def llvmIntrinName(self):
        return f"int{self.llvmIntrinsicPrefix_}{self.intrinsicName()}"

    def isNotYetImplemented(self): return self.notYetImplemented_

    def NYI(self, flag=True):
        self.notYetImplemented_ = flag
        if flag:
            self.hasTest_ = False
        return self

    def Obsolete(self): self.Obsolete_ = True
    def isObsolete(self): return self.Obsolete_

    # difference among dummy and pseudo
    #   dummy: instructions to insert a entry into the manual
    #   pseudo:  instructions without opcode, ie: no machine instruction

    # predicates
    def isDummy(self): return False
    def isMasked(self): return any([op.regName() == "vm" for op in self.ins])

    def isPacked(self):
        return ('packed' in self.kwargs) and self.kwargs['packed']

    def noLLVMInstDefine(self):
        self.hasLLVMInstDefine_ = False
        return self

    def hasLLVMInstDefine(self):
        return self.hasLLVMInstDefine_ and (not self.isDummy())

    def hasIntrinsicDef(self): return self.hasIntrinsicDef_

    def noLLVM(self):
        self.hasLLVMInstDefine_ = False
        self.hasPat_ = False
        self.hasIntrinsicDef_ = False
        self.hasBuiltin_ = False
        return self

    def hasPassThroughOp(self):
        return any([op.regName() == "pt" for op in self.ins])

    def hasPassThroughMaskOp(self):
        return any([op.regName() == "ptm" for op in self.ins])

    def hasImmOp(self): return any([op.isImm() for op in self.ins])
    def hasVLOp(self): return any([op.isVL() for op in self.ins])

    def noBuiltin(self): self.hasBuiltin_ = False
    def hasBuiltin(self): return self.hasBuiltin_

    def hasMask(self):
        if len(self.outs) > 0 and self.outs[0].isMask():
            return True
        return any([op.isMask() for op in self.ins])

    def readMem(self):
        self.prop_ = ["IntrReadMem"]
        return self

    def writeMem(self):
        self.prop_ = ["IntrWriteMem"]
        return self

    def inaccessibleMemOrArgMemOnly(self):
        self.prop_ = ["IntrInaccessibleMemOrArgMemOnly"]
        return self

    def hasSideEffects(self):
        self.prop_ += ["IntrHasSideEffects"]

    def prop(self):
        return self.prop_

    def hasInst(self): return self.inst_ is not None

    # to be included from IntrinsicsVE.td
    def intrinsicDefine(self):
        outs = ", ".join([op.intrinDefType() for op in self.outs])
        ins = ", ".join([op.intrinDefType() for op in self.ins])
        prop = ', '.join(self.prop())

        return (f'let TargetPrefix = "ve" in def {self.llvmIntrinName()}'
                f' : GCCBuiltin<"{self.builtinName()}">,'
                f' Intrinsic<[{outs}], [{ins}], [{prop}]>;')

    # to be included from BuiltinsVE.def
    def builtin(self):
        if len(self.outs) == 0:
            tmp = "v"
        else:
            tmp = "".join([i.builtinCode() for i in self.outs])
        tmp += "".join([i.builtinCode() for i in self.ins])
        return f'BUILTIN({self.builtinName()}, "{tmp}", "n")'

    # to be included from veintrin.h
    def veintrin(self):
        return f"#define {self.funcName()} {self.builtinName()}"

    def noTest(self):
        self.hasTest_ = False
        return self

    def hasTest(self):
        return self.hasTest_

    def stride(self, op):
        return 8 if self.isPacked() else op.stride()

    def hasExpr(self): return self.expr() is not None

    def noPat(self): self.hasPat_ = False
    def hasPat(self): return self.hasPat_

    def new(self): self.useNewInst_ = True
    def old(self): self.useNewInst_ = False
    def useNew(self): return self.useNewInst_


class DummyInst(Inst):
    def __init__(self, opc, inst, func, asm, **kwargs):
        kwargs['llvmInst'] = None
        super().__init__(opc, inst, asm, func, None, None, **kwargs)
        self.func_ = func

    def func(self): return self.func_
    def isDummy(self): return True


class InstVEL(Inst):
    def __init__(self, opc, inst, asm, intrinsicName, outs, ins, **kwargs):
        if 'llvmInst' not in kwargs:
            if asm:
                suffix = "".join([op.instSuffix for op
                                  in getLLVMInstArgs(ins, None, inst)])
                llvmInst = re.sub(r"\.", "", asm).upper() + suffix
                llvmInst = re.sub("RZ", "", llvmInst)  # Remove RD_RZ suffix
            else:
                llvmInst = None
            kwargs['llvmInst'] = llvmInst

        kwargs['llvmInst'] = "veold" + kwargs['llvmInst']

        super().__init__(opc, inst, asm, intrinsicName, outs, ins, **kwargs)

        self.funcPrefix_ = "_vel_"

        # we have to start from "_ve_" in LLVM
        self.llvmIntrinsicPrefix_ = "_ve_vl_"

    def pattern(self):
        argsL = ", ".join([op.dagOpL() for op in self.ins])
        argsR = ", ".join([op.dagOpR() for op
                           in getLLVMInstArgs(self.ins, self)])
        left = "({} {})".format(self.llvmIntrinName(), argsL)
        right = "({} {})".format(self.llvmInst(), argsR)

        if self.useNew():
            right = re.sub('veold', '', right)

        return "def : Pat<{}, {}>;".format(left, right)


class TestFunc:
    def __init__(self, header, definition, ref):
        self.header_ = header
        self.definition_ = definition
        self.ref_ = ref

    def header(self):
        return self.header_

    def definition(self):
        return self.definition_

    def reference(self):
        return self.ref_

    def decl(self):
        return "extern {};".format(self.header_)


class TestGeneratorMask:
    def gen(self, I):
        header = (f"void {I.intrinsicName()}(unsigned long int* px, "
                  "unsigned long int const* py, unsigned long int* pz, int n)")

        args = ", ".join([op.regName() for op in I.ins])

        if I.outs[0].isMask512():
            vm_t = "__vm512"
            m = "M"
            sz = 8
        else:
            vm_t = "__vm256"
            m = "m"
            sz = 4

        lvm = []
        svm = []
        for i in range(sz):
            lvm += [f"vmy = _vel_lvm_{m}{m}ss(vmy, {i}, py[{i}]);"]
            lvm += [f"vmz = _vel_lvm_{m}{m}ss(vmz, {i}, pz[{i}]);"]
            svm += [f"px[{i}] = _vel_svm_s{m}s(vmx, {i});"]

        sep = '\n    '

        func = f"""\
#include <velintrin.h>
{header}
{{
    {vm_t} vmx, vmy, vmz;
    {sep.join(lvm)}
    int vl = 256;
    vmx = _vel_{I.intrinsicName()}({args});
    {sep.join(svm)}
}}
"""

        ref = None
        if I.hasExpr():
            args = ["px[i]", "py[i]", "pz[i]"]
            ref = f'''\
{header}
{{
    for (int i = 0; i < {sz}; ++i)
        {I.expr().format(*args)};
}}
'''

        return TestFunc(header, func, ref)


class TestGenerator:
    def funcHeader(self, I):
        tmp = [i for i in (I.outs + I.ins)
               if (not i.isImm()) and (not i.isVL())]
        args = ["{} {}".format(i.ctype(), i.formalName()) for i in tmp]

        name = I.intrinsicName()
        if I.hasImmOp():
            name = name + "_imm"

        return f"void {name}({', '.join(args)}, int n)"

    def get_vld_vst_inst(self, I, op):
        vld = "vld_vssl"
        vst = "vst_vssl"
        if not I.isPacked():
            if op.elemType() == T_f32:
                vld = "vldu_vssl"
                vst = "vstu_vssl"
            elif op.elemType() == T_i32 or op.elemType() == T_u32:
                vld = "vldlsx_vssl"
                vst = "vstl_vssl"
        return [vld, vst]

    def test_(self, I):
        head = self.funcHeader(I)
        body = []

        if I.isPacked():
            step = 512
            body += ["int l = n - i < 512 ? (n - i) / 2UL : 256;"]
        else:
            step = 256
            body += ["int l = n - i < 256 ? n - i : 256;"]

        ins = I.ins
        if I.hasMask() and I.ins[-1].isVReg():  # remove vd when vm, vd
            ins = I.ins[0:-1]

        # input
        args = []
        for op in ins:
            vr = op.regName()
            ptr = f'p{op.regName()}'
            if op.isVReg():
                stride = I.stride(op)
                vld, vst = self.get_vld_vst_inst(I, op)
                body += [f"__vr {vr} = _vel_{vld}({stride}, {ptr}, l);"]
            if op.isMask512():
                # FIXME
                stride = I.stride(op)
                # vld, vst = self.get_vld_vst_inst(I, op)
                body += [f"__vr {vr}0 = _vel_vld_vssl({stride}, {ptr}, l);"]
                body += [f"__vm512 {vr} = _vel_pvfmkwgt_Mvl({vr}0, l);"]
            elif op.isMask():
                stride = I.stride(op)
                # vld, vst = self.get_vld_vst_inst(I, op)
                body += [f"__vr {vr}0 = _vel_vldlzx_vssl(4, {ptr}, l);"]
                body += [f"__vm256 {vr} = _vel_vfmkwgt_mvl({vr}0, l);"]
            if op.isReg() or op.isMask():
                args.append(op.regName())
            elif op.isImm():
                args.append("3")

        out = I.outs[0]
        vr = out.regName()
        body += [f"__vr {vr} = _vel_{I.intrinsicName()}({', '.join(args)}, l);"]

        if out.isVReg():
            stride = I.stride(out)
            _, vst = self.get_vld_vst_inst(I, out)
            body += [f"_vel_{vst}({vr}, {stride}, {out.formalName()}, l);"]

        for op in (I.outs + ins):
            if op.isVReg() or op.isMask():
                body += [f"p{op.regName()} += {512 if I.isPacked() else 256};"]

        sep = "\n        "

        func = f'''\
#include "velintrin.h"
{head} {{
    for (int i = 0; i < n; i += {step}) {{
        {sep.join(body)}
    }}
}}
'''
        return func

    def reference(self, I):
        if not I.hasExpr():
            return None

        head = self.funcHeader(I)

        tmp = []
        for op in I.outs + I.ins:
            if op.isVReg():
                tmp.append("p{}[i]".format(op.regName()))
            elif op.isVL():
                pass
            elif op.isReg():
                tmp.append(op.regName())
            elif op.isImm():
                tmp.append("3")

        body = I.expr().format(*tmp) + ";"

        preprocess = ''
        for op in I.ins:
            if op.isSReg():
                if I.isPacked():
                    ctype = I.outs[0].elemType().ctype
                    preprocess = '{} sy0 = *({}*)&sy;'.format(ctype, ctype)
                    body = re.sub('sy', "sy0", body)

        if I.hasMask():
            body = "if (pvm[i] > 0) {{ {} }}".format(body)

        func = f'''\
{head}
{{
    {preprocess}
    for (int i = 0; i < n; ++i) {{
        {body}
    }}
}}'''

        return func

    def gen(self, I):
        return TestFunc(self.funcHeader(I), self.test_(I), self.reference(I))


def getTestGenerator(I):
    if len(I.outs) > 0 and I.outs[0].isMask():
        return TestGeneratorMask()
    return TestGenerator()


class ManualInstPrinter:
    def __init__(self):
        pass

    def printAll(self, insts):
        for i in insts:
            self.printI(i)

    def make(self, I):
        v = []

        outType = "void"
        if len(I.outs) > 0:
            out = I.outs[0]
            if out.isVReg():
                outType = "__vr"
                v.append("{}[:]".format(out.regName()))
            elif out.isMask512():
                outType = "__vm512"
                v.append("{}[:]".format(out.regName()))
            elif out.isMask():
                outType = "__vm256"
                v.append("{}[:]".format(out.regName()))
            elif out.isSReg():
                outType = out.ctype()
            else:
                raise Exception(f"unknown output operand type: {out.kind}")

        ins = []
        for op in I.ins:
            if op.isVReg():
                ins.append("__vr " + op.regName())
                v.append("{}[:]".format(op.regName()))
            elif op.isSReg():
                ins.append("{} {}".format(op.ctype(), op.regName()))
                v.append("{}".format(op.regName()))
            elif op.isMask512():
                ins.append("__vm512 {}".format(op.regName()))
                v.append("{}[:]".format(op.regName()))
            elif op.isMask():
                ins.append("__vm256 {}".format(op.regName()))
                v.append("{}[:]".format(op.regName()))
            elif op.isImm():
                ins.append("{} {}".format(op.ctype(), op.regName()))
                v.append("{}".format(op.regName()))
            elif op.isVL():
                ins.append("int vl")
            else:
                raise Exception("unknown register kind: {}".format(op.kind))

        func = "{} {}({})".format(outType, I.funcName(), ", ".join(ins))

        if I.hasExpr():
            if I.hasMask():
                expr = I.expr().format(*v)
                expr = re.sub(r'.*= ', '', expr)
                expr = "{} = {} ? {} : {}".format(v[0], v[-2], expr, v[-1])
            else:
                expr = I.expr().format(*v)
        else:
            expr = ""
        return [func, expr]

    def printI(self, I):
        if not I.hasExpr():
            return

        func, expr = self.make(I)
        line = "    {:<80} // {}".format(func, expr)
        print(line)


class HtmlManualPrinter(ManualInstPrinter):
    def printAll(self, T, opt_no_link):
        idx = 0
        for s in T.sections:
            print("<a href=\"#sec{}\">{}</a><br>".format(idx, s.name))
            idx += 1
        idx = 0
        for s in T.sections:
            rowspan = {}
            tmp = []
            for I in s.instsWithDummy():  # noqa
                if I.isDummy():
                    func = I.func()
                    expr = ""
                else:
                    func, expr = self.make(I)
                inst = I.inst() if I.hasInst() else ""
                inst = re.sub(r'i64|i32|f64|f32', '', inst)
                if inst in rowspan:
                    rowspan[inst] += 1
                else:
                    rowspan[inst] = 1
                asm = I.asm() if I.opc else ""
                if not opt_no_link:
                    asm = "<a href=\"@ASM_MANUAL@#page={}\">{}</a>".format(s.page, asm)
                if I.isNotYetImplemented():
                    func = '<font color="darkgray">' + func + '</font><a href="#ft1">[1]</a>'
                if I.isObsolete():
                    func = '<font color="darkgray">' + func + '</font><a href="#ft2">[2]</a>'
                tmp.append([inst, func, asm, expr])

            print("<h3><a name=\"sec{}\">{}</a></h3>".format(idx, s.name))
            print("<table border=1>")
            print("<tr><th>Instruction</th><th>Function</th>"
                  "<th>asm</th><th>Description</th></tr>")
            row = 0
            for a in tmp:
                inst = a.pop(0)
                print("<tr>")
                if row == 0:
                    row = rowspan[inst]
                    print("<td rowspan={}>{}</td>".format(row, inst))
                row -= 1
                print("<td>{}</td><td>{}</td><td>{}</td></tr>".format(*a))
            print("</table>")
            idx += 1

        print('<p><a name="ft1">[1] Not yet implemented.</a></p>')
        print('<p><a name="ft2">[2] Obsolete.</a></p>')


class InstList:
    def __init__(self, clazz):
        self.a = []
        self.clazz = clazz

    def add(self, I):
        self.a.append(I)
        return self

    def __iter__(self):
        return self.a.__iter__()

    def __getattr__(self, attrname):
        def _method_missing(self, name, *args):
            for i in self.a:
                getattr(i, name)(*args)
            return self
        return partial(_method_missing, self, attrname)


class Section:
    def __init__(self, name, page):
        self.name = name
        self.page = page
        self.a = []

    def add(self, i):
        self.a.append(i)

    def insts(self):
        return [i for i in self.a if not i.isDummy()]

    def instsWithDummy(self):
        return self.a


class InstTable:
    def __init__(self, InstClass):
        self.currentSection = []
        self.sections = []
        self.InstClass = InstClass

    def Section(self, name, page):
        s = Section(name, page)
        self.sections.append(s)
        self.currentSection = s

    def insts(self):
        a = []
        for s in self.sections:
            a.extend(s.insts())
        return a

    def add(self, inst):
        self.currentSection.add(inst)
        return inst

    def Dummy(self, func, asm):
        return self.add(DummyInst(None, "", func, asm))

    def NoImpl(self, inst):
        self.add(DummyInst(None, inst, "not yet implemented", "").NYI(True))

    # intrinsic name is generated from asm and arguments
    def Def(self, opc, inst, subop, asm, ary, expr=None, **kwargs):
        baseIntrinName = (kwargs['baseIntrinName']
                          if 'baseIntrinName' in kwargs
                          else re.sub(r'\.', '', asm))
        IL = InstList(self.InstClass)
        for args in ary:
            func_suffix = ""
            if args[0] is not None or len(args) > 1:
                func_suffix = "_" + "".join([op.kind for op in args if op])
            intrinsicName = baseIntrinName + func_suffix
            intrinsicName = re.sub(r'[INZ]', 's', intrinsicName)  # Imm to s
            outs = [args[0]] if args[0] else []
            ins = args[1:]
            kwargs['packed'] = 'p' in subop
            kwargs['expr'] = expr
            kwargs['subop'] = subop
            i = self.InstClass(opc, inst, asm, intrinsicName, outs, ins,
                               **kwargs)
            self.add(i)
            IL.add(i)
        return IL

    def DefS(self, *args, **kwargs):  # define scalar instruction
        return self.Def(*args, **kwargs, noVL=True)

    def DefM(self, opc, baseInstName, subop, asm, OL, expr=None, **kwargs):
        vm = VM512 if 'p' in subop else VM
        OL = self.addMask(OL, vm)
        return self.Def(opc, baseInstName, subop, asm, OL, expr, **kwargs)

    def addMask(self, ary, MaskOp=VM, addVD=True):
        tmp = []
        for a in ary:
            if addVD:
                tmp.append(a + [MaskOp, VD(a[0].elemType())])
            else:
                tmp.append(a + [MaskOp])
        return ary + tmp

    def VLDm(self, opc, inst, subop, asm):
        O = []
        O.append([VX(T_u64), SY(T_u64), SZ(T_voidcp)])
        O.append([VX(T_u64), ImmI(T_u64), SZ(T_voidcp)])
        # O.append([VX(T_u64), SY(T_u64), ImmZ(T_voidcp)])
        # O.append([VX(T_u64), ImmI(T_u64), ImmZ(T_voidcp)])

        self.Def(opc, inst, subop, asm, O).noTest().readMem()
        self.Def(opc, inst, subop+"nc", asm+".nc", O).noTest().readMem()

    def VSTm(self, opc, inst, asm):
        O_rr = [None, VX(T_u64), SY(T_u64), SZ(T_voidp)]
        O_ir = [None, VX(T_u64), ImmI(T_u64), SZ(T_voidp)]
        O = self.addMask([O_rr, O_ir], addVD=False)
        self.Def(opc, inst, "", asm, O).noTest().writeMem()
        self.Def(opc, inst, "nc", asm+".nc", O).noTest().writeMem()
        self.Def(opc, inst, "ot", asm+".ot", O).noTest().writeMem()
        self.Def(opc, inst, "ncot", asm+".nc.ot", O).noTest().writeMem()

    def VBRDm(self, opc):
        expr = "{0} = {1}"
        self.DefM(0x8C, "VBRD", "", "vbrd", [[VX(T_f64), SY(T_f64)]], expr, baseIntrinName="vbrdd").noLLVMInstDefine()
        self.DefM(0x8C, "VBRD", "", "vbrd", [[VX(T_i64), SY(T_i64)]], expr, baseIntrinName="vbrdl")
        self.DefM(0x8C, "VBRD", "", "vbrd", [[VX(T_i64), ImmI(T_i64)]], expr, baseIntrinName="vbrdl")
        self.DefM(0x8C, "VBRD", "", "vbrdu", [[VX(T_f32), SY(T_f32)]], expr, baseIntrinName="vbrds")
        self.DefM(0x8C, "VBRD", "", "vbrdl", [[VX(T_i32), SY(T_i32)]], expr, baseIntrinName="vbrdw")
        self.DefM(0x8C, "VBRD", "", "vbrdl", [[VX(T_i32), ImmI(T_i32)]], expr, baseIntrinName="vbrdw")
        self.DefM(0x8C, "VBRD", "p", "pvbrd", [[VX(T_u32), SY(T_u64)]], expr)

    def VMVm(self):
        O_s = [VX(T_u64), SY(T_u32), VZ(T_u64)]
        O_i = [VX(T_u64), UImm7(T_u32), VZ(T_u64)]
        O_s = self.addMask([O_s])
        O_i = self.addMask([O_i])
        self.Def(0x9C, "VMV", "", "vmv", O_s).noTest().noPat()
        self.Def(0x9C, "VMV", "", "vmv", O_i).noTest()

    def LVSm(self, opc):
        I = self.InstClass
        # Manual LLVMInstDefine
        self.add(I(opc, "LVS", "lvs", "lvsl_svs", [SX(T_u64)], [VX(T_u64), SY(T_u32)], llvmInst="LVSvr", noVL=True).noTest()).noLLVMInstDefine().noPat()
        self.add(I(opc, "LVS", "lvs", "lvsd_svs", [SX(T_f64)], [VX(T_u64), SY(T_u32)], llvmInst="LVSvr", noVL=True).noTest()).noLLVMInstDefine().noPat()
        self.add(I(opc, "LVS", "lvs", "lvss_svs", [SX(T_f32)], [VX(T_u64), SY(T_u32)], noVL=True).noTest()).noLLVMInstDefine().noPat()

    def Inst2f(self, opc, name, instName, expr, hasPacked=True, hasNex=False):
        self.Def(opc, instName, "d", name+".d", [[VX(T_f64), VY(T_f64)]], expr)
        self.Def(opc, instName, "s", name+".s", [[VX(T_f32), VY(T_f32)]], expr)
        if hasPacked:
            self.Def(opc, instName, "p", "p"+name, [[VX(T_f32), VY(T_f32)]], expr)
        if hasNex:
            self.Def(opc, instName, "d", name+".d.nex", [[VX(T_f64), VY(T_f64)]], expr)
            self.Def(opc, instName, "s", name+".s.nex", [[VX(T_f32), VY(T_f32)]], expr)
            if hasPacked:
                self.Def(opc, instName, "p", "p"+name+".nex", [[VX(T_f32), VY(T_f32)]], expr)

    def Inst3f(self, opc, name, instName, subop, expr, hasPacked=True):
        O_f64 = [Args_vvv(T_f64), Args_vsv(T_f64)]
        O_f32 = [Args_vvv(T_f32), Args_vsv(T_f32)]
        O_pf32 = [Args_vvv(T_f32), [VX(T_f32), SY(T_u64), VZ(T_f32)]]

        O_f64 = self.addMask(O_f64)
        O_f32 = self.addMask(O_f32)
        O_pf32 = self.addMask(O_pf32, VM512)

        self.Def(opc, instName, subop+"d", name+".d", O_f64, expr)
        self.Def(opc, instName, subop+"s", name+".s", O_f32, expr)
        if hasPacked:
            self.Def(opc, instName, subop+"p", "p"+name, O_pf32, expr)

    # 3 operands, u64/u32
    def Inst3u(self, opc, name, instName, expr, hasPacked=True):
        O_u64 = [Args_vvv(T_u64), Args_vsv(T_u64), Args_vIv(T_u64)]
        O_u32 = [Args_vvv(T_u32), Args_vsv(T_u32), Args_vIv(T_u32)]
        O_pu32 = [Args_vvv(T_u32), [VX(T_u32), SY(T_u64), VZ(T_u32)]]

        O_u64 = self.addMask(O_u64)
        O_u32 = self.addMask(O_u32)
        O_pu32 = self.addMask(O_pu32, VM512)

        self.Def(opc, instName, "l", name+".l", O_u64, expr)
        self.Def(opc, instName, "w", name+".w", O_u32, expr)
        if hasPacked:
            self.Def(opc, instName, "p", "p"+name, O_pu32, expr)

    # 3 operands, i64
    def Inst3l(self, opc, name, instName, subop, expr):
        OL = [Args_vvv(T_i64), Args_vsv(T_i64), Args_vIv(T_i64)]
        OL = self.addMask(OL)
        self.Def(opc, instName, subop+"l", name+".l", OL, expr)

    # 3 operands, i32
    def Inst3w(self, opc, name, instName, subop, expr, hasPacked=True):
        O_i32 = [Args_vvv(T_i32), Args_vsv(T_i32), Args_vIv(T_i32)]
        O_pi32 = [Args_vvv(T_i32), [VX(T_i32), SY(T_u64), VZ(T_i32)]]

        O_i32 = self.addMask(O_i32)
        O_pi32 = self.addMask(O_pi32, VM512)

        self.Def(opc, instName, subop + "wsx", name+".w.sx", O_i32, expr)
        self.Def(opc, instName, subop + "wzx", name+".w.zx", O_i32, expr)
        if hasPacked:
            self.Def(opc, instName, subop + "p", "p"+name, O_pi32, expr)

    def Inst3divbys(self, opc, name, instName, subop, ty):
        O_s = [VX(ty), VY(ty), SY(ty)]
        O_i = [VX(ty), VY(ty), ImmI(ty)]
        O = [O_s, O_i]
        O = self.addMask(O)
        self.Def(opc, instName, subop, name, O, "{0} = {1} / {2}")

    def Logical2u(self, opc, name, instName):
        O_u64 = [[VX(T_u64), VZ(T_u64)]]
        O_u32 = [[VX(T_u32), VZ(T_u32)]]
        O_pu32 = [[VX(T_u32), VZ(T_u32)]]

        O_u64 = self.addMask(O_u64)
        O_u32 = self.addMask(O_u32)
        O_pu32 = self.addMask(O_pu32, VM512)

        self.Def(opc, instName, "", name, O_u64).noTest()
        self.Def(opc, instName, "p", "p" + name + ".lo", O_u32).noTest()
        self.Def(opc, instName, "p", "p" + name + ".up", O_u32).noTest()
        self.Def(opc, instName, "p", "p" + name, O_pu32).noTest()

    def Logical3u(self, opc, name, instName, expr):
        O_u32_vsv = [VX(T_u32), SY(T_u64), VZ(T_u32)]

        O_u64 = [Args_vvv(T_u64), Args_vsv(T_u64)]
        O_u64 = self.addMask(O_u64)

        O_pu32 = [Args_vvv(T_u32), O_u32_vsv]
        O_pu32 = self.addMask(O_pu32, VM512)

        self.Def(opc, instName, "", name, O_u64, expr)
        # self.Def(opc, instName, "p", "p"+name+".lo", O_pu32, expr).noTest()
        # self.Def(opc, instName, "p", "p"+name+".up", O_pu32, expr).noTest()
        self.Def(opc, instName, "p", "p" + name, O_pu32, expr)

    def Shift(self, opc, name, instName, ty, expr):
        O_vvv = [VX(ty), VZ(ty), VY(T_u64)]
        O_vvs = [VX(ty), VZ(ty), SY(ty)]
        O_vvN = [VX(ty), VZ(ty), ImmN(T_u64)]

        OL = [O_vvv, O_vvs, O_vvN]
        OL = self.addMask(OL)

        self.Def(opc, instName, "", name, OL, expr)

    def ShiftPacked(self, opc, name, instName, ty, expr):
        O_vvv = [VX(ty), VZ(ty), VY(T_u32)]
        O_vvs = [VX(ty), VZ(ty), SY(T_u64)]

        OL = [O_vvv, O_vvs]
        OL = self.addMask(OL, VM512)

        # self.Def(opc, instName, "p", "p"+name+".lo", OL, expr).noTest()
        # self.Def(opc, instName, "p", "p"+name+".up", OL, expr).noTest()
        self.Def(opc, instName, "p", "p"+name, OL, expr)

    def Inst4f(self, opc, name, instName, expr):
        O_f64_vvvv = [VX(T_f64), VY(T_f64), VZ(T_f64), VW(T_f64)]
        O_f64_vsvv = [VX(T_f64), SY(T_f64), VZ(T_f64), VW(T_f64)]
        O_f64_vvsv = [VX(T_f64), VY(T_f64), SY(T_f64), VW(T_f64)]

        O_f32_vvvv = [VX(T_f32), VY(T_f32), VZ(T_f32), VW(T_f32)]
        O_f32_vsvv = [VX(T_f32), SY(T_f32), VZ(T_f32), VW(T_f32)]
        O_f32_vvsv = [VX(T_f32), VY(T_f32), SY(T_f32), VW(T_f32)]

        O_pf32_vsvv = [VX(T_f32), SY(T_u64), VZ(T_f32), VW(T_f32)]
        O_pf32_vvsv = [VX(T_f32), VY(T_f32), SY(T_u64), VW(T_f32)]

        O_f64 = [O_f64_vvvv, O_f64_vsvv, O_f64_vvsv]
        O_f32 = [O_f32_vvvv, O_f32_vsvv, O_f32_vvsv]
        O_pf32 = [O_f32_vvvv, O_pf32_vsvv, O_pf32_vvsv]

        O_f64 = self.addMask(O_f64)
        O_f32 = self.addMask(O_f32)
        O_pf32 = self.addMask(O_pf32, VM512)

        self.Def(opc, instName, "d", name+".d", O_f64, expr)
        self.Def(opc, instName, "s", name+".s", O_f32, expr)
        self.Def(opc, instName, "p", "p"+name, O_pf32, expr)

    def FLm(self, opc, inst, subop, asm, args):
        self.Def(opc, inst, subop.format(fl="f"), asm.format(fl=".fst"), args)
        self.Def(opc, inst, subop.format(fl="l"), asm.format(fl=".lst"),
                 args).noTest()

    def VGTm(self, opc, inst, subop, asm):
        OL = []
        OL.append([VX(T_u64), VY(T_u64), SY(T_u64), SZ(T_u64)])
        OL.append([VX(T_u64), VY(T_u64), SY(T_u64), ImmZ(T_u64)])
        OL.append([VX(T_u64), VY(T_u64), ImmI(T_u64), SZ(T_u64)])
        OL.append([VX(T_u64), VY(T_u64), ImmI(T_u64), ImmZ(T_u64)])
        OL = self.addMask(OL, VM, False)
        self.Def(opc, inst, subop, asm, OL).noTest().readMem()
        self.Def(opc, inst, subop+"nc", asm+".nc", OL).noTest().readMem()

    def VSCm(self, opc, inst0, inst, asm):
        OL = []
        OL.append([None, VX(T_u64), VY(T_u64), SY(T_u64), SZ(T_u64)])
        OL.append([None, VX(T_u64), VY(T_u64), SY(T_u64), ImmZ(T_u64)])
        OL.append([None, VX(T_u64), VY(T_u64), ImmI(T_u64), SZ(T_u64)])
        OL.append([None, VX(T_u64), VY(T_u64), ImmI(T_u64), ImmZ(T_u64)])
        OL = self.addMask(OL, VM, False)
        self.Def(opc, inst0, "", asm, OL).noTest().writeMem()
        self.Def(opc, inst0, "nc", asm+".nc", OL).noTest().writeMem()
        self.Def(opc, inst0, "ot", asm+".ot", OL).noTest().writeMem()
        self.Def(opc, inst0, "ncot", asm+".nc.ot", OL).noTest().writeMem()

    def VSUM(self, opc, inst, subop, asm, baseOps):
        OL = []
        for op in baseOps:
            OL.append(op)
            OL.append(op + [VM])
        self.Def(opc, inst, subop, asm, OL, noPassThrough=True)

    def VFIX(self, opc, inst, subop, asm, OL, ty):
        expr = "{0} = (" + ty + ")({1}+0.5)"
        self.DefM(opc, inst, subop, asm, OL, expr, rd='RD_NONE').noLLVMInstDefine()
        expr = "{0} = (" + ty + ")({1})"
        self.DefM(opc, inst, subop + "rz", asm+".rz", OL, expr, rd='RD_RZ').noLLVMInstDefine()


class InstTableVEL(InstTable):
    def __init__(self):
        super(InstTableVEL, self).__init__(InstVEL)

    def Def(self, opc, inst, subop, asm, ary, expr=None, **kwargs):
        # append dummyOp(pass through Op) and VL
        newary = []
        for args in ary:
            outs = [args[0]]
            ins = args[1:]
            if ('noVL' not in kwargs) or (not kwargs['noVL']):
                newary.append(outs + ins + [VL])
                noPassThrough = ('noPassThrough' in kwargs) and (kwargs['noPassThrough'])
                hasPassThroughOp = any([op.regName() == "pt" for op in ins])
                if (not noPassThrough) and (not hasPassThroughOp) and (outs[0] and outs[0].kind == "v"):
                    newary.append(outs + ins + [VD(outs[0].elemType()), VL])
            else:
                newary.append(args)

        return super(InstTableVEL, self).Def(opc, inst, subop, asm, newary, expr, **kwargs)


def createInstructionTable():
    T = InstTableVEL()

    #
    # Start of instruction definition
    #

    T.Section("Table 3-15 Vector Transfer Instructions", 22)
    T.VLDm(0x81, "VLD", "", "vld")
    T.VLDm(0x82, "VLDU", "", "vldu")
    T.VLDm(0x83, "VLDL", "sx", "vldl.sx")
    T.VLDm(0x83, "VLDL", "zx", "vldl.zx")
    T.VLDm(0xC1, "VLD2D", "", "vld2d")
    T.VLDm(0xC2, "VLDU2D", "", "vldu2d")
    T.VLDm(0xC3, "VLDL2D", "sx", "vldl2d.sx")
    T.VLDm(0xC3, "VLDL2D", "zx", "vldl2d.zx")
    T.VSTm(0x91, "VST", "vst")
    T.VSTm(0x92, "VSTU", "vstu")
    T.VSTm(0x93, "VSTL", "vstl")
    T.VSTm(0xD1, "VST2D", "vst2d")
    T.VSTm(0xD2, "VSTU2D", "vstu2d")
    T.VSTm(0xD3, "VSTL2D", "vstl2d")
    T.Def(0x80, "PFCHV", "", "pfchv", [[None, SY(T_i64), SZ(T_voidcp)]]).noTest().inaccessibleMemOrArgMemOnly()
    T.Def(0x80, "PFCHV", "", "pfchv", [[None, ImmI(T_i64), SZ(T_voidcp)]]).noTest().inaccessibleMemOrArgMemOnly()
    T.Def(0x80, "PFCHV", "nc", "pfchv.nc", [[None, SY(T_i64), SZ(T_voidcp)]]).noTest().inaccessibleMemOrArgMemOnly()
    T.Def(0x80, "PFCHV", "nc", "pfchv.nc", [[None, ImmI(T_i64), SZ(T_voidcp)]]).noTest().inaccessibleMemOrArgMemOnly()
    T.Def(0x8E, "LSV", "", "lsv", [[VX(T_u64), VD(T_u64), SY(T_u32), SZ(T_u64)]], noVL=True).noTest().noLLVMInstDefine().noPat()
    T.LVSm(0x9E)
    T.Def(0xB7, "LVM", "r", "lvm", [[VMX, VMD, SY(T_u64), SZ(T_u64)]], noVL=True, llvmInst="LVMrr_m").noTest().NYI().old()
    T.Def(0xB7, "LVM", "i", "lvm", [[VMX, VMD, ImmN(T_u64), SZ(T_u64)]], noVL=True, llvmInst="LVMir_m").noTest()
    T.Def(None, "LVM", "pr", "lvm", [[VMX512, VMD512, SY(T_u64), SZ(T_u64)]], noVL=True, llvmInst="LVMyrr_y").noTest().NYI().old()
    T.Def(None, "LVM", "pi", "lvm", [[VMX512, VMD512, ImmN(T_u64), SZ(T_u64)]], noVL=True, llvmInst="LVMyir_y").noTest()
    T.Def(0xA7, "SVM", "r", "svm", [[SX(T_u64), VMZ, SY(T_u64)]], noVL=True).noTest().NYI()
    T.Def(0xA7, "SVM", "i", "svm", [[SX(T_u64), VMZ, ImmN(T_u64)]], noVL=True).noTest()
    T.Def(None, "SVM", "pr", "svm", [[SX(T_u64), VMZ512, SY(T_u64)]], noVL=True, llvmInst="SVMyr").noTest().NYI().old()
    T.Def(None, "SVM", "pi", "svm", [[SX(T_u64), VMZ512, ImmN(T_u64)]], noVL=True, llvmInst="SVMyi").noTest()
    T.VBRDm(0x8C)
    T.VMVm()

    O_VMPD = [[VX(T_i64), VY(T_i32), VZ(T_i32)],
              [VX(T_i64), SY(T_i32), VZ(T_i32)],
              [VX(T_i64), ImmI(T_i32), VZ(T_i32)]]

    T.Section("Table 3-16. Vector Fixed-Point Arithmetic Operation Instructions", 23)  # noqa
    T.Inst3u(0xC8, "vaddu", "VADD", "{0} = {1} + {2}")  # u32, u64
    T.Inst3w(0xCA, "vadds", "VADS", "", "{0} = {1} + {2}")  # i32
    T.Inst3l(0x8B, "vadds", "VADX", "", "{0} = {1} + {2}")  # i64
    T.Inst3u(0xC8, "vsubu", "VSUB", "{0} = {1} - {2}")  # u32, u64
    T.Inst3w(0xCA, "vsubs", "VSBS", "", "{0} = {1} - {2}")  # i32
    T.Inst3l(0x8B, "vsubs", "VSBX", "", "{0} = {1} - {2}")  # i64
    T.Inst3u(0xC9, "vmulu", "VMPY", "{0} = {1} * {2}", False)
    T.Inst3w(0xCB, "vmuls", "VMPS", "", "{0} = {1} * {2}", False)
    T.Inst3l(0xDB, "vmuls", "VMPX", "", "{0} = {1} * {2}")
    T.Def(0xD9, "VMPD", "", "vmuls.l.w", O_VMPD, "{0} = {1} * {2}")
    T.Inst3u(0xE9, "vdivu", "VDIV", "{0} = {1} / {2}", False)
    T.Inst3divbys(0xE9, "vdivu.l", "VDIV", "l", T_u64)
    T.Inst3divbys(0xE9, "vdivu.w", "VDIV", "w", T_u32)
    T.Inst3w(0xEB, "vdivs", "VDVS", "", "{0} = {1} / {2}", False)
    T.Inst3divbys(0xEB, "vdivs.w.sx", "VDVS", "wsx", T_i32)
    T.Inst3divbys(0xEB, "vdivs.w.zx", "VDVS", "wzx", T_i32)
    T.Inst3l(0xFB, "vdivs", "VDVX", "", "{0} = {1} / {2}")
    T.Inst3divbys(0xEB, "vdivs.l", "VDVX", "l", T_i64)
    T.Inst3u(0xB9, "vcmpu", "VCMP", "{0} = compare({1}, {2})")
    T.Inst3w(0xFA, "vcmps", "VCPS", "", "{0} = compare({1}, {2})")
    T.Inst3l(0xBA, "vcmps", "VCPX", "", "{0} = compare({1}, {2})")
    T.Inst3w(0x8A, "vmaxs", "VCMS", "a", "{0} = max({1}, {2})")
    T.Inst3w(0x8A, "vmins", "VCMS", "i", "{0} = min({1}, {2})")
    T.Inst3l(0x9A, "vmaxs", "VCMX", "a", "{0} = max({1}, {2})")
    T.Inst3l(0x9A, "vmins", "VCMX", "i", "{0} = min({1}, {2})")

    T.Section("Table 3-17 Vector Logical Arithmetic Operation Instructions", 25)
    T.Logical3u(0xC4, "vand", "VAND", "{0} = {1} & {2}")
    T.Logical3u(0xC5, "vor",  "VOR",  "{0} = {1} | {2}")
    T.Logical3u(0xC6, "vxor", "VXOR", "{0} = {1} ^ {2}")
    T.Logical3u(0xC7, "veqv", "VEQV", "{0} = ~({1} ^ {2})")
    T.Logical2u(0xe7, "vldz", "VLDZ")
    T.Logical2u(0xac, "vpcnt", "VPCNT")
    T.Logical2u(0xf7, "vbrv", "VBRV")
    T.Def(0x99, "VSEQ", "", "vseq", [[VX(T_u64)]], "{0} = i").noTest()
    T.Def(0x99, "VSEQ", "l", "pvseq.lo", [[VX(T_u64)]], "{0} = i").noTest()
    T.Def(0x99, "VSEQ", "u", "pvseq.up", [[VX(T_u64)]], "{0} = i").noTest()
    T.Def(0x99, "VSEQ", "p", "pvseq", [[VX(T_u64)]], "{0} = i").noTest()

    T.Section("Table 3-18 Vector Shift Instructions", 27)
    T.Shift(0xE5, "vsll", "VSLL", T_u64, "{0} = {1} << ({2} & 0x3f)")
    T.ShiftPacked(0xE5, "vsll", "VSLL", T_u32, "{0} = {1} << ({2} & 0x1f)")
    T.NoImpl("VSLD")
    T.Shift(0xF5, "vsrl", "VSRL", T_u64, "{0} = {1} >> ({2} & 0x3f)")
    T.ShiftPacked(0xF5, "vsrl", "VSRL", T_u32, "{0} = {1} >> ({2} & 0x1f)")
    T.NoImpl("VSRD")
    T.Shift(0xE6, "vsla.w.sx", "VSLA", T_i32, "{0} = {1} << ({2} & 0x1f)")
    T.Shift(0xE6, "vsla.w.zx", "VSLA", T_i32, "{0} = {1} << ({2} & 0x1f)")
    T.ShiftPacked(0xE6, "vsla", "VSLA", T_i32, "{0} = {1} << ({2} & 0x1f)")
    T.Shift(0xD4, "vsla.l", "VSLAX", T_i64, "{0} = {1} << ({2} & 0x3f)")
    T.Shift(0xF6, "vsra.w.sx", "VSRA", T_i32, "{0} = {1} >> ({2} & 0x1f)")
    T.Shift(0xF6, "vsra.w.zx", "VSRA", T_i32, "{0} = {1} >> ({2} & 0x1f)")
    T.ShiftPacked(0xF6, "vsra", "VSRA", T_i32, "{0} = {1} >> ({2} & 0x1f)")
    T.Shift(0xD5, "vsra.l", "VSRAX", T_i64, "{0} = {1} >> ({2} & 0x3f)")

    O_vsfa = [[VX(T_u64), VZ(T_u64), SY(T_u64), SZ(T_u64)],
              [VX(T_u64), VZ(T_u64), ImmI(T_u64), SZ(T_u64)]]
    O_vsfa = T.addMask(O_vsfa)
    T.Def(0xD7, "VSFA", "", "vsfa", O_vsfa, "{0} = ({1} << ({2} & 0x7)) + {3}")

    T.Section("Table 3-19 Vector Floating-Point Operation Instructions", 28)
    T.Inst3f(0xCC, "vfadd", "VFAD", "", "{0} = {1} + {2}")
    T.Inst3f(0xDC, "vfsub", "VFSB", "", "{0} = {1} - {2}")
    T.Inst3f(0xCD, "vfmul", "VFMP", "", "{0} = {1} * {2}")
    T.Inst3f(0xDD, "vfdiv", "VFDV", "", "{0} = {1} / {2}", False)
    T.Inst2f(0xED, "vfsqrt", "VFSQRT", "{0} = std::sqrt({1})", False)
    T.Inst3f(0xFC, "vfcmp", "VFCP", "", "{0} = compare({1}, {2})")
    T.Inst3f(0xBD, "vfmax", "VFCM", "a", "{0} = max({1}, {2})")
    T.Inst3f(0xBD, "vfmin", "VFCM", "i", "{0} = min({1}, {2})")
    T.Inst4f(0xE2, "vfmad", "VFMAD", "{0} = {2} * {3} + {1}")
    T.Inst4f(0xF2, "vfmsb", "VFMSB", "{0} = {2} * {3} - {1}")
    T.Inst4f(0xE3, "vfnmad", "VFNMAD", "{0} =  - ({2} * {3} + {1})")
    T.Inst4f(0xF3, "vfnmsb", "VFNMSB", "{0} =  - ({2} * {3} - {1})")
    T.Inst2f(0xE1, "vrcp", "VRCP", "{0} = 1.0f / {1}")
    T.Inst2f(0xF1, "vrsqrt", "VRSQRT", "{0} = 1.0f / std::sqrt({1})", True, True)
    T.VFIX(0xE8, "VFIX", "dsx", "vcvt.w.d.sx", [[VX(T_i32), VY(T_f64)]], "int")
    T.VFIX(0xE8, "VFIX", "dzx", "vcvt.w.d.zx", [[VX(T_i32), VY(T_f64)]], "unsigned int")
    T.VFIX(0xE8, "VFIX", "ssx", "vcvt.w.s.sx", [[VX(T_i32), VY(T_f32)]], "int")
    T.VFIX(0xE8, "VFIX", "szx", "vcvt.w.s.zx", [[VX(T_i32), VY(T_f32)]], "unsigned int")
    T.VFIX(0xE8, "VFIX", "p", "pvcvt.w.s", [[VX(T_i32), VY(T_f32)]], "int")
    T.VFIX(0xA8, "VFIXX", "", "vcvt.l.d", [[VX(T_i64), VY(T_f64)]], "long long")
    T.Def(0xF8, "VFLT", "d", "vcvt.d.w", [[VX(T_f64), VY(T_i32)]], "{0} = (double){1}")
    T.Def(0xF8, "VFLT", "s", "vcvt.s.w", [[VX(T_f32), VY(T_i32)]], "{0} = (float){1}")
    T.Def(0xF8, "VFLT", "p", "pvcvt.s.w", [[VX(T_f32), VY(T_i32)]], "{0} = (float){1}")
    T.Def(0xB8, "VFLTX", "", "vcvt.d.l", [[VX(T_f64), VY(T_i64)]], "{0} = (double){1}")
    T.Def(0x8F, "VCVD", "", "vcvt.d.s", [[VX(T_f64), VY(T_f32)]], "{0} = (double){1}")
    T.Def(0x9F, "VCVS", "", "vcvt.s.d", [[VX(T_f32), VY(T_f64)]], "{0} = (float){1}")

    T.Section("Table 3-20 Vector Mask Arithmetic Instructions", 32)
    T.Def(0xD6, "VMRG", "", "vmrg", [[VX(T_u64), VY(T_u64), VZ(T_u64), VM]]).noTest()
    T.Def(0xD6, "VMRG", "", "vmrg", [[VX(T_u64), SY(T_u64), VZ(T_u64), VM]]).noTest()
    T.Def(0xD6, "VMRG", "", "vmrg", [[VX(T_u64), ImmI(T_u64), VZ(T_u64), VM]]).noTest()
    T.Def(0xD6, "VMRG", "p", "vmrg.w", [[VX(T_u32), VY(T_u32), VZ(T_u32), VM512]]).noTest()
    T.Def(0xD6, "VMRG", "p", "vmrg.w", [[VX(T_u32), SY(T_u32), VZ(T_u32), VM512]]).noTest().noPat()
    T.Def(0xBC, "VSHF", "", "vshf", [[VX(T_u64), VY(T_u64), VZ(T_u64), SY(T_u64)], [VX(T_u64), VY(T_u64), VZ(T_u64), ImmN(T_u64)]])
    T.Def(0x8D, "VCP", "", "vcp", [[VX(T_u64), VZ(T_u64), VM, VD(T_u64)]]).noTest()
    T.Def(0x9D, "VEX", "", "vex", [[VX(T_u64), VZ(T_u64), VM, VD(T_u64)]]).noTest()

    tmp = ["gt", "lt", "ne", "eq", "ge", "le", "num", "nan", "gtnan", "ltnan", "nenan", "eqnan", "genan", "lenan"]
    T.Def(0xB4, "VFMK", "", "vfmk.l.at", [[VMX]], cc=CC_INT['at'], llvmInst='VFMKLal').noTest()  # i64
    T.Def(0xB4, "VFMK", "", "vfmk.l.af", [[VMX]], cc=CC_INT['af'], llvmInst='VFMKLnal').noTest()  # i64
    # T.Def(0xB5, "VFMK", "", "pvfmk.w.lo.at", [[VMX]], cc=CC_INT['at'], llvmInst='VFMKWal').noTest() # i32
    # T.Def(0xB5, "VFMK", "", "pvfmk.w.up.at", [[VMX]], cc=CC_INT['at'], llvmInst='PVFMKWUPal').noTest() # i32
    # T.Def(0xB5, "VFMK", "", "pvfmk.w.lo.af", [[VMX]], cc=CC_INT['af'], llvmInst='VFMKWLOnal').noTest() # i32
    # T.Def(0xB5, "VFMK", "", "pvfmk.w.up.af", [[VMX]], cc=CC_INT['af'], llvmInst='PVFMKWUPnal').noTest() # i32
    T.Def(None, "VFMK", "pat", "pvfmk.at", [[VMX512]], cc=CC_INT['at'], llvmInst='VFMKyal').noTest().noLLVMInstDefine()  # i32, Pseudo
    T.Def(None, "VFMK", "paf", "pvfmk.af", [[VMX512]], cc=CC_INT['af'], llvmInst='VFMKynal').noTest().noLLVMInstDefine()  # i32, Pseudo

    # i64
    for cc in tmp:
        T.Def(0xB4, "VFMK", "", "vfmk.l."+cc, [[VMX, VZ(T_i64)]], cc=CC_INT[cc], llvmInst='VFMKLvl').noTest().noLLVMInstDefine()
        T.Def(0xB4, "VFMK", "", "vfmk.l."+cc, [[VMX, VZ(T_i64), VM]], cc=CC_INT[cc], llvmInst='VFMKLvml').noTest().noLLVMInstDefine()

    # i32
    for cc in tmp:
        T.Def(0xB5, "VFMS", "", "vfmk.w."+cc, [[VMX, VZ(T_i32)]], cc=CC_INT[cc], llvmInst='VFMKWvl').noTest().noLLVMInstDefine()
        T.Def(0xB5, "VFMS", "", "vfmk.w."+cc, [[VMX, VZ(T_i32), VM]], cc=CC_INT[cc], llvmInst='VFMKWvml').noTest().noLLVMInstDefine()
    for cc in tmp:
        T.Def(0xB5, "VFMS", "", "pvfmk.w.lo."+cc, [[VMX, VZ(T_i32)]], cc=CC_INT[cc], llvmInst='PVFMKWLOvl').noTest().noLLVMInstDefine()
        T.Def(0xB5, "VFMS", "", "pvfmk.w.up."+cc, [[VMX, VZ(T_i32)]], cc=CC_INT[cc], llvmInst='PVFMKWUPvl').noTest().noLLVMInstDefine()
        T.Def(0xB5, "VFMS", "", "pvfmk.w.lo."+cc, [[VMX, VZ(T_i32), VM]], cc=CC_INT[cc], llvmInst='PVFMKWLOvml').noTest().noLLVMInstDefine()
        T.Def(0xB5, "VFMS", "", "pvfmk.w.up."+cc, [[VMX, VZ(T_i32), VM]], cc=CC_INT[cc], llvmInst='PVFMKWUPvml').noTest().noLLVMInstDefine()
    for cc in tmp:
        T.Def(None, "VFMS", "p", "pvfmk.w."+cc, [[VMX512, VZ(T_i32)]], cc=CC_INT[cc], llvmInst='VFMKWyvl').noTest().noLLVMInstDefine()  # i32, Pseudo
        T.Def(None, "VFMS", "p", "pvfmk.w."+cc, [[VMX512, VZ(T_i32), VM512]], cc=CC_INT[cc], llvmInst='VFMKWyvyl').noTest().noLLVMInstDefine()  # 32, Pseudo

    # f64
    for cc in tmp:
        T.Def(0xB6, "VFMF", "d", "vfmk.d."+cc, [[VMX, VZ(T_f64)]], cc=CC_FLOAT[cc], llvmInst='VFMKDvl').noTest().noLLVMInstDefine()
        T.Def(0xB6, "VFMF", "d", "vfmk.d."+cc, [[VMX, VZ(T_f64), VM]], cc=CC_FLOAT[cc], llvmInst='VFMKDvml').noTest().noLLVMInstDefine()

    # f32
    for cc in tmp:
        T.Def(0xB6, "VFMF", "s", "vfmk.s."+cc, [[VMX, VZ(T_f32)]], cc=CC_FLOAT[cc], llvmInst='VFMKSvl').noTest().noLLVMInstDefine()
        T.Def(0xB6, "VFMF", "s", "vfmk.s."+cc, [[VMX, VZ(T_f32), VM]], cc=CC_FLOAT[cc], llvmInst='VFMKSvml').noTest().noLLVMInstDefine()
    for cc in tmp:
        T.Def(0xB6, "VFMF", "s", "pvfmk.s.lo."+cc, [[VMX, VZ(T_f32)]], cc=CC_FLOAT[cc], llvmInst='PVFMKSLOvl').noTest().noLLVMInstDefine()
        T.Def(0xB6, "VFMF", "s", "pvfmk.s.up."+cc, [[VMX, VZ(T_f32)]], cc=CC_FLOAT[cc], llvmInst='PVFMKSUPvl').noTest().noLLVMInstDefine()
        T.Def(0xB6, "VFMF", "s", "pvfmk.s.lo."+cc, [[VMX, VZ(T_f32), VM]], cc=CC_FLOAT[cc], llvmInst='PVFMKSLOvml').noTest().noLLVMInstDefine()
        T.Def(0xB6, "VFMF", "s", "pvfmk.s.up."+cc, [[VMX, VZ(T_f32), VM]], cc=CC_FLOAT[cc], llvmInst='PVFMKSUPvml').noTest().noLLVMInstDefine()
    for cc in tmp:
        T.Def(None, "VFMF", "p", "pvfmk.s."+cc, [[VMX512, VZ(T_f32)]], cc=CC_FLOAT[cc], llvmInst='VFMKSyvl').noTest().noLLVMInstDefine()  # Pseudo
        T.Def(None, "VFMF", "p", "pvfmk.s."+cc, [[VMX512, VZ(T_f32), VM512]], cc=CC_FLOAT[cc], llvmInst='VFMKSyvyl').noTest().noLLVMInstDefine()  # Pseudo

    T.Section("Table 3-21 Vector Recursive Relation Instructions", 32)
    T.VSUM(0xEA, "VSUMS", "sx", "vsum.w.sx", [[VX(T_i32), VY(T_i32)]])
    T.VSUM(0xEA, "VSUMS", "zx", "vsum.w.zx", [[VX(T_i32), VY(T_i32)]])
    T.VSUM(0xAA, "VSUMX", "", "vsum.l", [[VX(T_i64), VY(T_i64)]])
    T.VSUM(0xEC, "VFSUM", "d", "vfsum.d", [[VX(T_f64), VY(T_f64)]])
    T.VSUM(0xEC, "VFSUM", "s", "vfsum.s", [[VX(T_f32), VY(T_f32)]])
    T.FLm(0xBB, "VMAXS", "a{fl}sx", "vrmaxs.w{fl}.sx", [[VX(T_i32), VY(T_i32)]])
    T.FLm(0xBB, "VMAXS", "a{fl}zx", "vrmaxs.w{fl}.zx", [[VX(T_u32), VY(T_u32)]])
    T.FLm(0xBB, "VMAXS", "i{fl}sx", "vrmins.w{fl}.sx", [[VX(T_i32), VY(T_i32)]])
    T.FLm(0xBB, "VMAXS", "i{fl}zx", "vrmins.w{fl}.zx", [[VX(T_u32), VY(T_u32)]])
    T.FLm(0xAB, "VMAXX", "a{fl}", "vrmaxs.l{fl}", [[VX(T_i64), VY(T_i64)]])
    T.FLm(0xAB, "VMAXX", "i{fl}", "vrmins.l{fl}", [[VX(T_i64), VY(T_i64)]])
    T.FLm(0xAD, "VFMAX", "ad{fl}", "vfrmax.d{fl}", [[VX(T_f64), VY(T_f64)]])
    T.FLm(0xAD, "VFMAX", "as{fl}", "vfrmax.s{fl}", [[VX(T_f32), VY(T_f32)]])
    T.FLm(0xAD, "VFMAX", "id{fl}", "vfrmin.d{fl}", [[VX(T_f64), VY(T_f64)]])
    T.FLm(0xAD, "VFMAX", "is{fl}", "vfrmin.s{fl}", [[VX(T_f32), VY(T_f32)]])
    T.VSUM(0x88, "VRAND", "", "vrand", [[VX(T_u64), VY(T_u64)]])
    T.VSUM(0x98, "VROR",  "", "vror",  [[VX(T_u64), VY(T_u64)]])
    T.VSUM(0x89, "VRXOR", "", "vrxor", [[VX(T_u64), VY(T_u64)]])
    T.NoImpl("VFIA")
    T.NoImpl("VFIS")
    T.NoImpl("VFIM")
    T.NoImpl("VFIAM")
    T.NoImpl("VFISM")
    T.NoImpl("VFIMA")
    T.NoImpl("VFIMS")

    T.Section("Table 3-22 Vector Gathering/Scattering Instructions", 34)
    T.VGTm(0xA1, "VGT", "", "vgt")
    T.VGTm(0xA2, "VGTU", "", "vgtu")
    T.VGTm(0xA3, "VGTL", "sx", "vgtl.sx")
    T.VGTm(0xA3, "VGTL", "zx", "vgtl.zx")
    T.VSCm(0xB1, "VSC", "VSC", "vsc")
    T.VSCm(0xB2, "VSCU", "VSCU", "vscu")
    T.VSCm(0xB3, "VSCL", "VSCL", "vscl")

    T.Section("Table 3-23 Vector Mask Register Instructions", 34)
    T.Def(0x84, "ANDM", "", "andm", [[VMX, VMY, VMZ]], "{0} = {1} & {2}", noVL=True)
    T.Def(None, "ANDM", "p", "andm", [[VMX512, VMY512, VMZ512]], "{0} = {1} & {2}", noVL=True, llvmInst="ANDMyy")
    T.Def(0x85, "ORM", "",  "orm",  [[VMX, VMY, VMZ]], "{0} = {1} | {2}", noVL=True)
    T.Def(None, "ORM", "p",  "orm",  [[VMX512, VMY512, VMZ512]], "{0} = {1} | {2}", noVL=True, llvmInst="ORMyy")
    T.Def(0x86, "XORM", "", "xorm", [[VMX, VMY, VMZ]], "{0} = {1} ^ {2}", noVL=True)
    T.Def(None, "XORM", "p", "xorm", [[VMX512, VMY512, VMZ512]], "{0} = {1} ^ {2}", noVL=True, llvmInst="XORMyy")
    T.Def(0x87, "EQVM", "", "eqvm", [[VMX, VMY, VMZ]], "{0} = ~({1} ^ {2})", noVL=True)
    T.Def(None, "EQVM", "p", "eqvm", [[VMX512, VMY512, VMZ512]], "{0} = ~({1} ^ {2})", noVL=True, llvmInst="EQVMyy")
    T.Def(0x94, "NNDM", "", "nndm", [[VMX, VMY, VMZ]], "{0} = (~{1}) & {2}", noVL=True)
    T.Def(None, "NNDM", "p", "nndm", [[VMX512, VMY512, VMZ512]], "{0} = (~{1}) & {2}", noVL=True, llvmInst="NNDMyy")
    T.Def(0x95, "NEGM", "", "negm", [[VMX, VMY]], "{0} = ~{1}", noVL=True)
    T.Def(None, "NEGM", "p", "negm", [[VMX512, VMY512]], "{0} = ~{1}", noVL=True, llvmInst="NEGMy")
    T.Def(0xA4, "PCVM", "", "pcvm", [[SX(T_u64), VMY]]).noTest()
    T.Def(0xA5, "LZVM", "", "lzvm", [[SX(T_u64), VMY]]).noTest()
    T.Def(0xA6, "TOVM", "", "tovm", [[SX(T_u64), VMY]]).noTest()

    T.Section("Table 3-24 Vector Control Instructions", 35)
    T.NoImpl("SMVL")
    T.NoImpl("LVIX")

    T.Section("Table 3-25 Control Instructions", 35)
    T.DefS(0x40, "LCR", "", "lcr",
           [[SX(T_u64), SY(T_u64), SZ(T_u64)],
            [SX(T_u64), SY(T_u64), ImmZ(T_u64)],
            [SX(T_u64), UImm7(T_u64), SZ(T_u64)],
            [SX(T_u64), UImm7(T_u64), ImmZ(T_u64)]]).noTest()

    T.DefS(0x50, "SCR", "", "scr",
           [[None, SX(T_u64), SY(T_u64), SZ(T_u64)],
            [None, SX(T_u64), SY(T_u64), ImmZ(T_u64)],
            [None, SX(T_u64), UImm7(T_u64), SZ(T_u64)],
            [None, SX(T_u64), UImm7(T_u64), ImmZ(T_u64)]]
           ).hasSideEffects().noTest()

    T.DefS(0x41, "TSCR", "", "tscr",
           [[SW(T_u64), SX(T_u64), SY(T_u64), SZ(T_u64)],
            [SW(T_u64), SX(T_u64), SY(T_u64), ImmZ(T_u64)],
            [SW(T_u64), SX(T_u64), UImm7(T_u64), SZ(T_u64)],
            [SW(T_u64), SX(T_u64), UImm7(T_u64), ImmZ(T_u64)]]
           ).hasSideEffects().noTest()

    T.DefS(0x51, "FIDCR", "", "fidcr",
           [[SX(T_u64), SY(T_u64), UImm3(T_u32)],
            [SX(T_u64), UImm7(T_u64), UImm3(T_u32)]]).hasSideEffects().noTest()

    T.DefS(0x20, "FENCE", "", "fencei", [[None]]).hasSideEffects().noTest()
    T.DefS(0x20, "FENCE", "", "fencem", [[None, UImm2(T_u32)]],
           llvmInst="FENCEM").hasSideEffects().noTest()
    T.DefS(0x20, "FENCE", "", "fencec", [[None, UImm3(T_u32)]],
           llvmInst="FENCEC").hasSideEffects().noTest()
    T.DefS(0x30, "SVOB", "", "svob", [[None]]).hasSideEffects().noTest()

    T.Section("Approximate Operations", None)
    T.Def(None, None, "", "approx_vfdivs", [[VX(T_f32), VY(T_f32), VZ(T_f32)]], expr="{0} = {1} / {2}", noPassThrough=True).noLLVM()
    T.Def(None, None, "", "approx_vfdivs", [[VX(T_f32), SY(T_f32), VZ(T_f32)]], expr="{0} = {1} / {2}", noPassThrough=True).noLLVM()
    T.Def(None, None, "", "approx_vfdivs", [[VX(T_f32), VY(T_f32), SZ(T_f32)]], expr="{0} = {1} / {2}", noPassThrough=True).noLLVM()
    T.Def(None, None, "", "approx_vfdivd", [[VX(T_f64), SY(T_f64), VZ(T_f64)]], expr="{0} = {1} / {2}", noPassThrough=True).noLLVM()
    T.Def(None, None, "", "approx_pvfdiv", [[VX(T_f32), VY(T_f32), VZ(T_f32)]], expr="{0} = {1} / {2}", noPassThrough=True).noLLVM()
    T.Def(None, None, "", "approx_vfsqrtd", [[VX(T_f64), VY(T_f64)]], expr="{0} = sqrtf({1})", noPassThrough=True).noLLVM()
    T.Def(None, None, "", "approx_vfsqrts", [[VX(T_f32), VY(T_f32)]], expr="{0} = sqrtf({1})", noPassThrough=True).noLLVM()

    T.Section("Others", None)
    T.Dummy("unsigned long int _vel_pack_f32p(float const* p0, float const* p1)", "ldu,ldl,or")
    T.Dummy("unsigned long int _vel_pack_f32a(float const* p)", "load and mul")
    T.Dummy("unsigned long int _vel_pack_i32(int a, int b)", "sll,add,or")

    T.Dummy("__vm256 _vel_extract_vm512u(__vm512 vm)", "")
    T.Dummy("__vm256 _vel_extract_vm512l(__vm512 vm)", "")
    T.Dummy("__vm512 _vel_insert_vm512u(__vm512 vmx, __vm256 vmy)", "")
    T.Dummy("__vm512 _vel_insert_vm512l(__vm512 vmx, __vm256 vmy)", "")

    return T

#
# End of instruction definition
#


def cmpwrite(filename, data):
    need_write = True
    try:
        with open(filename, "r") as f:
            old = f.read()
            need_write = old != data
    except:
        pass
    if need_write:
        print("write " + filename)
        with open(filename, "w") as f:
            f.write(data)


def gen_test(insts, directory):
    for I in insts:
        if I.hasPassThroughOp() and (not I.hasMask()):
            continue
        if I.hasTest():
            data = getTestGenerator(I).gen(I).definition()
            if directory and (directory != "-"):
                filename = "{}/{}.c".format(directory, I.intrinsicName())
                if I.hasImmOp():
                    filename = "{}/{}_imm.c".format(directory, I.intrinsicName())
                cmpwrite(filename, data)
            else:
                print(data)


def gen_intrinsic_def(insts):
    done = []
    for I in insts:
        intrinName = I.intrinsicName()
        if I.hasIntrinsicDef() and intrinName not in done:
            done.append(intrinName)
            print(I.intrinsicDefine())


def gen_pattern(insts):
    for I in insts:
        if I.hasInst() and I.hasPat() and (not I.isNotYetImplemented()):
            print(I.pattern())


def gen_builtin(insts):
    done = []
    for I in insts:
        intrinName = I.intrinsicName()
        if I.hasBuiltin() and intrinName not in done:
            done.append(intrinName)
            print(I.builtin())


def gen_veintrin_h(insts):
    done = []
    for I in insts:
        intrinName = I.intrinsicName()
        if I.hasBuiltin() and intrinName not in done:
            done.append(intrinName)
            print(I.veintrin())


def gen_decl(insts):
    for I in insts:
        if I.hasTest():
            print(getTestGenerator(I).gen(I).decl())


def gen_reference(insts):
    print('#include <math.h>')
    print('#include <algorithm>')
    print('using namespace std;')
    print('#include "../refutils.h"')
    print('namespace ref {')
    for I in insts:  # noqa
        if I.isNotYetImplemented():
            continue
        if I.hasTest():
            f = getTestGenerator(I).gen(I).reference()
            if f:
                print(f)
    print('}')


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--intrin', dest="opt_intrin", action="store_true")
    parser.add_argument('-p', "--pattern", dest="opt_pat", action="store_true")
    parser.add_argument('-b', dest="opt_builtin", action="store_true")
    parser.add_argument('--veintrin', dest="opt_veintrin", action="store_true")
    parser.add_argument('--decl', dest="opt_decl", action="store_true")
    parser.add_argument('-t', dest="opt_test", action="store_true")
    parser.add_argument('-r', dest="opt_reference", action="store_true")
    parser.add_argument('-f', dest="opt_filter", action="store")
    parser.add_argument('--html', dest="opt_html", action="store_true")
    parser.add_argument('--html-no-link', action="store_true")
    parser.add_argument('--test-dir', default="../../llvm-ve-intrinsic-test/gen/tests")
    args, others = parser.parse_known_args()

    T = createInstructionTable()
    insts = T.insts()

    if args.opt_filter:
        insts = [i for i in insts if re.search(args.opt_filter, i.intrinsicName())]
        print("filter: {} -> {}".format(args.opt_filter, len(insts)))

    if args.opt_intrin:
        gen_intrinsic_def(insts)
    if args.opt_pat:
        gen_pattern(insts)
    if args.opt_builtin:
        gen_builtin(insts)
    if args.opt_veintrin:
        gen_veintrin_h(insts)
    if args.opt_decl:
        gen_decl(insts)
    if args.opt_test:
        gen_test(insts, args.test_dir)
    if args.opt_reference:
        gen_reference(insts)
    if args.opt_html:
        HtmlManualPrinter().printAll(T, False)
    if args.html_no_link:
        HtmlManualPrinter().printAll(T, True)


if __name__ == "__main__":
    main()

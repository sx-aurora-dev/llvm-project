#include "types.h"

/// Test ‘fneg’ Instruction
///
/// Syntax:
///   <result> = fneg [fast-math flags]* <ty> <op1>   ; yields ty:result
///
/// Overview:
///    The ‘fneg’ instruction returns the negation of its operand.
///
/// Arguments:
///   The argument to the ‘fneg’ instruction must be a floating-point or
///   vector of floating-point values.
///
/// Semantics:
///
///   The value produced is a copy of the operand with its sign bit flipped.
///   This instruction can also take any number of fast-math flags, which are
///   optimization hints to enable otherwise unsafe floating-point
///   optimizations.
///
/// Example:
///   <result> = fneg float %val          ; yields float:result = -%var
///
/// Note:
///   We test only float/double/fp128.

#define FP_FNEG(TY) \
TY fneg_ ## TY(TY a) { \
  return  -a; \
}

FP_FNEG(float)
FP_FNEG(double)
FP_FNEG(quad)

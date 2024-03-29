//===- DLTIBase.td - Target information dialect base defs ---*- tablegen -*-==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef DLTI_BASE
#define DLTI_BASE

include "mlir/IR/OpBase.td"

def DLTI_Dialect : Dialect {
  let name = "dlti";
  let cppNamespace = "::mlir";
  let hasOperationAttrVerify = 1;

  let description = [{
    The Data Layout and Target Information (DLTI) dialect is intended to hold
    attributes and other components pertaining to descriptions of in-memory
    data layout and compilation targets.
  }];

  let extraClassDeclaration = [{
    // Top level attribute name.
    constexpr const static ::llvm::StringLiteral
    kDataLayoutAttrName = "dlti.dl_spec";

    // Constants used in entries.
    constexpr const static ::llvm::StringLiteral
    kDataLayoutEndiannessKey = "dlti.endianness";

    constexpr const static ::llvm::StringLiteral
    kDataLayoutEndiannessBig = "big";

    constexpr const static ::llvm::StringLiteral
    kDataLayoutEndiannessLittle = "little";

    constexpr const static ::llvm::StringLiteral
    kDataLayoutAllocaMemorySpaceKey = "dlti.alloca_memory_space";
    
    constexpr const static ::llvm::StringLiteral
    kDataLayoutProgramMemorySpaceKey = "dlti.program_memory_space";

    constexpr const static ::llvm::StringLiteral
    kDataLayoutGlobalMemorySpaceKey = "dlti.global_memory_space";

    constexpr const static ::llvm::StringLiteral
    kDataLayoutStackAlignmentKey = "dlti.stack_alignment";
  }];

  let useDefaultAttributePrinterParser = 1;
}

def DLTI_DataLayoutEntryAttr : DialectAttr<
    DLTI_Dialect,
    CPred<"::llvm::isa<::mlir::DataLayoutEntryAttr>($_self)">,
    "Target data layout entry"> {
  let storageType = "::mlir::DataLayoutEntryAttr";
  let returnType = "::mlir::DataLayoutEntryAttr";
  let convertFromStorage = "$_self";
}

def DLTI_DataLayoutSpecAttr : DialectAttr<
    DLTI_Dialect,
    CPred<"::llvm::isa<::mlir::DataLayoutSpecAttr>($_self)">,
    "Target data layout specification"> {
  let storageType = "::mlir::DataLayoutSpecAttr";
  let returnType = "::mlir::DataLayoutSpecAttr";
  let convertFromStorage = "$_self";
}

def HasDefaultDLTIDataLayout : NativeOpTrait<"HasDefaultDLTIDataLayout"> {
  let cppNamespace = "::mlir";
}

#endif // DLTI_BASE

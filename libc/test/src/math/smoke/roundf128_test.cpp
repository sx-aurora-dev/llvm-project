//===-- Unittests for roundf128 -------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "RoundTest.h"

#include "src/math/roundf128.h"

LIST_ROUND_TESTS(float128, LIBC_NAMESPACE::roundf128)

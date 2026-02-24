//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: c++03, c++11, c++14, c++17
// UNSUPPORTED: no-localization
// UNSUPPORTED: no-threads
// UNSUPPORTED: libcpp-has-no-experimental-syncstream

// VE supports a maximum of 63 threads per process; this test creates ~70.
// XFAIL: target=ve-{{.*}}

// <syncstream>

// template <class charT, class traits, class Allocator>
// class basic_osyncstream;

// The test writes all elements in test_strings in a random order in ss. Every
// write is done by an osyncstream. This means the output is in random order,
// but the words should be written without interleaving. To increment the
// change of interleaving words are written one character at a time.

#include <cassert>
#include <chrono>
#include <mutex>
#include <sstream>
#include <string>
#include <syncstream>
#include <thread>
#include <unordered_set>
#include <vector>

#include "test_macros.h"

static std::ostringstream ss;

static std::unordered_multiset<std::string> test_strings = {
    "C++ ",
    "is ",
    "a ",
    "general-purpose ",
    "programming ",
    "language ",
    "created ",
    "by ",
    "Bjarne ",
    "Stroustrup ",
    "as ",
    "an ",
    "extension ",
    "of ",
    "the ",
    "C ",
    "programming ",
    "language, ",
    "or ",
    "C ",
    "with ",
    "Classes. ",
    "The ",
    "language ",
    "has ",
    "expanded ",
    "significantly ",
    "over ",
    "time, ",
    "and ",
    "modern ",
    "C++ ",
    "has ",
    "object-oriented, ",
    "generic, ",
    "and ",
    "functional ",
    "features ",
    "in ",
    "addition ",
    "to ",
    "facilities ",
    "for ",
    "low-level ",
    "memory ",
    "manipulation. ",
    "It ",
    "is ",
    "almost ",
    "always ",
    "implemented ",
    "as ",
    "a ",
    "compiled ",
    "language, ",
    "and ",
    "many ",
    "vendors ",
    "provide ",
    "C++ ",
    "compilers, ",
    "including ",
    "the ",
    "Free ",
    "Software ",
    "Foundation, ",
    "LLVM, ",
    "Microsoft, ",
    "Intel, ",
    "and ",
    "IBM, ",
    "so ",
    "it ",
    "is ",
    "available ",
    "on ",
    "many ",
    "platforms."};

void f(std::string text) {
  std::osyncstream out(ss);
  for (char c : text)
    out << c;
}

void test() {
  ss = std::basic_ostringstream<char>();
  std::vector<std::thread> threads;
  for (std::string const& word : test_strings)
    threads.push_back(std::thread(f, word));

  for (auto& thread : threads)
    thread.join();

  std::string output = ss.str();
  for (const std::string& word : test_strings)
    assert(output.find(word) != std::string::npos);
}

int main(int, char**) {
  // The more we test, the more likely we catch an error.
  // VE has only 8 cores, so ~70 threads per iteration is heavily
  // oversubscribed.  Reduce iteration count to avoid timeout.
  // A better long-term fix would be to scale based on
  // std::thread::hardware_concurrency().
#ifdef __ve__
  constexpr size_t iterations = 64;
#else
  constexpr size_t iterations = 1024;
#endif
  for (size_t i = 0; i < iterations; ++i)
    test();

  return 0;
}

//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: no-threads
// UNSUPPORTED: c++03, c++11, c++14, c++17

// This is a regression test for https://llvm.org/PR47013.

// <semaphore>

#include <barrier>
#include <semaphore>
#include <thread>
#include <vector>

#include "make_test_thread.h"

// VE has 8 cores, so spawning 8+ threads causes severe oversubscription.
// A better long-term fix would be to use std::thread::hardware_concurrency()
// to determine the thread count at runtime.
#ifdef __ve__
static constexpr int num_acquirers = 4;
#else
static constexpr int num_acquirers = 8;
#endif

static std::counting_semaphore<> s(0);
static std::barrier<> b(num_acquirers + 1);

// VE's current atomic synchronization routes every operation through the
// host, because the communication-register-based hardware sync is not yet
// implemented.  With the original counts (10,000 x 20) this test takes
// far longer than the 120 s timeout on VE.
#ifdef __ve__
static constexpr int inner_iterations = 2'000;
static constexpr int outer_iterations = 4;
#else
static constexpr int inner_iterations = 10'000;
static constexpr int outer_iterations = 20;
#endif

void acquire() {
  for (int i = 0; i < inner_iterations; ++i) {
    s.acquire();
    b.arrive_and_wait();
  }
}

void release() {
  for (int i = 0; i < inner_iterations; ++i) {
    for (int j = 0; j < num_acquirers; ++j)
      s.release(1);

    b.arrive_and_wait();
  }
}

int main(int, char**) {
  for (int run = 0; run < outer_iterations; ++run) {
    std::vector<std::thread> threads;
    for (int i = 0; i < num_acquirers; ++i)
      threads.push_back(support::make_test_thread(acquire));

    threads.push_back(support::make_test_thread(release));

    for (auto& thread : threads)
      thread.join();
  }

  return 0;
}

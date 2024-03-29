//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: c++03, c++11, c++14, c++17

// std::views::take

#include <ranges>

#include <cassert>
#include <concepts>
#include <span>
#include <string_view>
#include <utility>

#include "test_iterators.h"
#include "test_range.h"

struct SizedView : std::ranges::view_base {
  int* begin_ = nullptr;
  int* end_ = nullptr;
  constexpr SizedView(int* begin, int* end) : begin_(begin), end_(end) {}

  constexpr auto begin() const { return forward_iterator<int*>(begin_); }
  constexpr auto end() const { return sized_sentinel<forward_iterator<int*>>(forward_iterator<int*>(end_)); }
};
static_assert(std::ranges::forward_range<SizedView>);
static_assert(std::ranges::sized_range<SizedView>);
static_assert(std::ranges::view<SizedView>);

template <class T>
constexpr void test_small_range(const T& input) {
  constexpr int N = 100;
  auto size = std::ranges::size(input);

  auto result = input | std::views::take(N);
  assert(size < N);
  assert(result.size() == size);
}

constexpr bool test() {
  constexpr int N = 8;
  int buf[N] = {1, 2, 3, 4, 5, 6, 7, 8};

  // Test that `std::views::take` is a range adaptor.
  {
    using SomeView = SizedView;

    // Test `view | views::take`
    {
      SomeView view(buf, buf + N);
      std::same_as<std::ranges::take_view<SomeView>> decltype(auto) result = view | std::views::take(3);
      assert(result.base().begin_ == buf);
      assert(result.base().end_ == buf + N);
      assert(result.size() == 3);
    }

    // Test `adaptor | views::take`
    {
      SomeView view(buf, buf + N);
      auto f = [](int i) { return i; };
      auto const partial = std::views::transform(f) | std::views::take(3);

      using Result = std::ranges::take_view<std::ranges::transform_view<SomeView, decltype(f)>>;
      std::same_as<Result> decltype(auto) result = partial(view);
      assert(result.base().base().begin_ == buf);
      assert(result.base().base().end_ == buf + N);
      assert(result.size() == 3);
    }

    // Test `views::take | adaptor`
    {
      SomeView view(buf, buf + N);
      auto f = [](int i) { return i; };
      auto const partial = std::views::take(3) | std::views::transform(f);

      using Result = std::ranges::transform_view<std::ranges::take_view<SomeView>, decltype(f)>;
      std::same_as<Result> decltype(auto) result = partial(view);
      assert(result.base().base().begin_ == buf);
      assert(result.base().base().end_ == buf + N);
      assert(result.size() == 3);
    }

    // Check SFINAE friendliness
    {
      struct NotAView { };
      static_assert(!std::is_invocable_v<decltype(std::views::take)>);
      static_assert(!std::is_invocable_v<decltype(std::views::take), NotAView, int>);
      static_assert( CanBePiped<SomeView&,   decltype(std::views::take(3))>);
      static_assert( CanBePiped<int(&)[10],  decltype(std::views::take(3))>);
      static_assert(!CanBePiped<int(&&)[10], decltype(std::views::take(3))>);
      static_assert(!CanBePiped<NotAView,    decltype(std::views::take(3))>);

      static_assert(!CanBePiped<SomeView&,   decltype(std::views::take(/*n=*/NotAView{}))>);
    }
  }

  {
    static_assert(std::same_as<decltype(std::views::take), decltype(std::ranges::views::take)>);
  }

  // `views::take(empty_view, n)` returns an `empty_view`.
  {
    using Result = std::ranges::empty_view<int>;
    [[maybe_unused]] std::same_as<Result> decltype(auto) result = std::views::empty<int> | std::views::take(3);
  }

  // `views::take(span, n)` returns a `span`.
  {
    std::span<int> s(buf);
    std::same_as<decltype(s)> decltype(auto) result = s | std::views::take(3);
    assert(result.size() == 3);
  }

  // `views::take(span, n)` returns a `span` with a dynamic extent, regardless of the input `span`.
  {
    std::span<int, 8> s(buf);
    std::same_as<std::span<int, std::dynamic_extent>> decltype(auto) result = s | std::views::take(3);
    assert(result.size() == 3);
  }

  // `views::take(string_view, n)` returns a `string_view`.
  {
    {
      std::string_view sv = "abcdef";
      std::same_as<decltype(sv)> decltype(auto) result = sv | std::views::take(3);
      assert(result.size() == 3);
    }

    {
      std::u32string_view sv = U"abcdef";
      std::same_as<decltype(sv)> decltype(auto) result = sv | std::views::take(3);
      assert(result.size() == 3);
    }
  }

  // `views::take(subrange, n)` returns a `subrange`.
  {
    auto subrange = std::ranges::subrange(buf, buf + N);
    using Result = std::ranges::subrange<int*>;
    std::same_as<Result> decltype(auto) result = subrange | std::views::take(3);
    assert(result.size() == 3);
  }

  // `views::take(subrange, n)` doesn't return a `subrange` if it's not a random access range.
  {
    SizedView v(buf, buf + N);
    auto subrange = std::ranges::subrange(v.begin(), v.end());

    using Result = std::ranges::take_view<std::ranges::subrange<forward_iterator<int*>,
        sized_sentinel<forward_iterator<int*>>>>;
    std::same_as<Result> decltype(auto) result = subrange | std::views::take(3);
    assert(result.size() == 3);
  }

  // `views::take(subrange, n)` returns a `subrange` with all default template arguments.
  {
    std::ranges::subrange<int*, sized_sentinel<int*>, std::ranges::subrange_kind::sized> subrange;

    using Result = std::ranges::subrange<int*, int*, std::ranges::subrange_kind::sized>;
    [[maybe_unused]] std::same_as<Result> decltype(auto) result = subrange | std::views::take(3);
  }

  // `views::take(iota_view, n)` returns an `iota_view`.
  {
    auto iota = std::views::iota(1, 8);
    // The second template argument of the resulting `iota_view` is same as the first.
    using Result                               = std::ranges::iota_view<int, int>;
    std::same_as<Result> decltype(auto) result = iota | std::views::take(3);
    assert(result.size() == 3);
  }

#if TEST_STD_VER >= 23
  // `views::take(repeat_view, n)` returns a `repeat_view` when `repeat_view` models `sized_range`.
  {
    auto repeat                                = std::ranges::repeat_view<int, int>(1, 8);
    using Result                               = std::ranges::repeat_view<int, int>;
    std::same_as<Result> decltype(auto) result = repeat | std::views::take(3);
    static_assert(std::ranges::sized_range<Result>);
    assert(result.size() == 3);
    assert(*result.begin() == 1);
  }

  // `views::take(repeat_view, n)` returns a `repeat_view` when `repeat_view` doesn't model `sized_range`.
  {
    auto repeat  = std::ranges::repeat_view<int>(1);
    using Result = std::ranges::repeat_view<int, std::ranges::range_difference_t<decltype(repeat)>>;
    std::same_as<Result> decltype(auto) result = repeat | std::views::take(3);
    assert(result.size() == 3);
    assert(*result.begin() == 1);
  }
#endif

  // When the size of the input range `s` is shorter than `n`, only `s` elements are taken.
  {
    test_small_range(std::span(buf));
    test_small_range(std::string_view("abcdef"));
    test_small_range(std::ranges::subrange(buf, buf + N));
    test_small_range(std::views::iota(1, 8));
  }

  // Test that it's possible to call `std::views::take` with any single argument as long as the resulting closure is
  // never invoked. There is no good use case for it, but it's valid.
  {
    struct X { };
    [[maybe_unused]] auto partial = std::views::take(X{});
  }

  // Test when `subrange<Iter>` is not well formed
  {
    int input[] = {1, 2, 3};
    using Iter  = cpp20_input_iterator<int*>;
    using Sent  = sentinel_wrapper<Iter>;
    std::ranges::subrange r{Iter{input}, Sent{Iter{input + 3}}};
    auto tv = std::views::take(std::move(r), 1);
    auto it                  = tv.begin();
    assert(*it == 1);
    ++it;
    assert(it == tv.end());
  }

  return true;
}

int main(int, char**) {
  test();
  static_assert(test());

  return 0;
}

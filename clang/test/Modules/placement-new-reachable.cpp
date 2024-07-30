// RUN: rm -rf %t
// RUN: mkdir -p %t
// RUN: split-file %s %t
//
// RUN: %clang_cc1 -std=c++20 %t/A.cppm -emit-module-interface -o %t/A.pcm
// RUN: %clang_cc1 -std=c++20 %t/Use.cpp -fprebuilt-module-path=%t -fsyntax-only -verify

// RUN: %clang_cc1 -std=c++20 %t/A.cppm -emit-reduced-module-interface -o %t/A.pcm
// RUN: %clang_cc1 -std=c++20 %t/Use.cpp -fprebuilt-module-path=%t -fsyntax-only -verify

//--- placement.h
namespace std {
  using size_t = decltype(sizeof(0));
}
void *operator new(std::size_t, void *p) { return p; }

//--- A.cppm
module;
#include "placement.h"
export module A;
export template<class T>
struct A {
    A(void *p) : ptr(new (p) T(43)) {}
private:
    void *ptr;
};

export struct B {
    B(void *p) : ptr(new (p) int(43)) {}
private:
    void *ptr;
};

// The use of operator new in the current module unit is only in the non-inline
// function definitions. So it may be optimized out.
using ::operator new;

//--- Use.cpp
// expected-no-diagnostics
import A;
void bar(int *);
void foo(void *ptr) {
    A<int> a(nullptr); // Good. It should be OK to construct A.
    B b(nullptr);
    void *p = ::operator new(sizeof(int), ptr); // Bad. The placement allocation in module A is not visible.
    void *q = new (ptr) int(43); // Good. We don't call the placement allocation function directly.
}

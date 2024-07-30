// RUN: %clang_analyze_cc1 -analyzer-checker=alpha.webkit.UncountedLocalVarsChecker -verify %s

#include "mock-types.h"
#include "mock-system-header.h"

void someFunction();

namespace raw_ptr {
void foo() {
  RefCountable *bar;
  // FIXME: later on we might warn on uninitialized vars too
}

void bar(RefCountable *) {}
} // namespace raw_ptr

namespace reference {
void foo_ref() {
  RefCountable automatic;
  RefCountable &bar = automatic;
  // expected-warning@-1{{Local variable 'bar' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
  someFunction();
  bar.method();
}

void foo_ref_trivial() {
  RefCountable automatic;
  RefCountable &bar = automatic;
}

void bar_ref(RefCountable &) {}
} // namespace reference

namespace guardian_scopes {
void foo1() {
  RefPtr<RefCountable> foo;
  { RefCountable *bar = foo.get(); }
}

void foo2() {
  RefPtr<RefCountable> foo;
  // missing embedded scope here
  RefCountable *bar = foo.get();
  // expected-warning@-1{{Local variable 'bar' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
  someFunction();
  bar->method();
}

void foo3() {
  RefPtr<RefCountable> foo;
  {
    { RefCountable *bar = foo.get(); }
  }
}

void foo4() {
  {
    RefPtr<RefCountable> foo;
    { RefCountable *bar = foo.get(); }
  }
}

void foo5() {
  RefPtr<RefCountable> foo;
  auto* bar = foo.get();
  bar->trivial();
}

void foo6() {
  RefPtr<RefCountable> foo;
  auto* bar = foo.get();
  // expected-warning@-1{{Local variable 'bar' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
  bar->method();
}

struct SelfReferencingStruct {
  SelfReferencingStruct* ptr;
  RefCountable* obj { nullptr };
};

void foo7(RefCountable* obj) {
  SelfReferencingStruct bar = { &bar, obj };
  bar.obj->method();
}

} // namespace guardian_scopes

namespace auto_keyword {
class Foo {
  RefCountable *provide_ref_ctnbl();

  void evil_func() {
    RefCountable *bar = provide_ref_ctnbl();
    // expected-warning@-1{{Local variable 'bar' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
    auto *baz = provide_ref_ctnbl();
    // expected-warning@-1{{Local variable 'baz' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
    auto *baz2 = this->provide_ref_ctnbl();
    // expected-warning@-1{{Local variable 'baz2' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
    [[clang::suppress]] auto *baz_suppressed = provide_ref_ctnbl(); // no-warning
  }

  void func() {
    RefCountable *bar = provide_ref_ctnbl();
    // expected-warning@-1{{Local variable 'bar' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
    if (bar)
      bar->method();
  }
};
} // namespace auto_keyword

namespace guardian_casts {
void foo1() {
  RefPtr<RefCountable> foo;
  {
    RefCountable *bar = downcast<RefCountable>(foo.get());
    bar->method();
  }
  foo->method();
}

void foo2() {
  RefPtr<RefCountable> foo;
  {
    RefCountable *bar =
        static_cast<RefCountable *>(downcast<RefCountable>(foo.get()));
    someFunction();
  }
}
} // namespace guardian_casts

namespace guardian_ref_conversion_operator {
void foo() {
  Ref<RefCountable> rc;
  {
    RefCountable &rr = rc;
    rr.method();
    someFunction();
  }
}
} // namespace guardian_ref_conversion_operator

namespace ignore_for_if {
RefCountable *provide_ref_ctnbl() { return nullptr; }

void foo() {
  // no warnings
  if (RefCountable *a = provide_ref_ctnbl())
    a->trivial();
  for (RefCountable *b = provide_ref_ctnbl(); b != nullptr;)
    b->trivial();
  RefCountable *array[1];
  for (RefCountable *c : array)
    c->trivial();
  while (RefCountable *d = provide_ref_ctnbl())
    d->trivial();
  do {
    RefCountable *e = provide_ref_ctnbl();
    e->trivial();
  } while (1);
  someFunction();
}

void bar() {
  if (RefCountable *a = provide_ref_ctnbl()) {
    // expected-warning@-1{{Local variable 'a' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
    a->method();    
  }
  for (RefCountable *b = provide_ref_ctnbl(); b != nullptr;) {
    // expected-warning@-1{{Local variable 'b' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
    b->method();
  }
  RefCountable *array[1];
  for (RefCountable *c : array) {
    // expected-warning@-1{{Local variable 'c' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
    c->method();
  }

  while (RefCountable *d = provide_ref_ctnbl()) {
    // expected-warning@-1{{Local variable 'd' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
    d->method();
  }
  do {
    RefCountable *e = provide_ref_ctnbl();
    // expected-warning@-1{{Local variable 'e' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
    e->method();
  } while (1);
  someFunction();
}

} // namespace ignore_for_if

namespace ignore_system_headers {

RefCountable *provide_ref_ctnbl();

void system_header() {
  localVar<RefCountable>(provide_ref_ctnbl);
}

} // ignore_system_headers

namespace conditional_op {
RefCountable *provide_ref_ctnbl();
bool bar();

void foo() {
  RefCountable *a = bar() ? nullptr : provide_ref_ctnbl();
  // expected-warning@-1{{Local variable 'a' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
  RefPtr<RefCountable> b = provide_ref_ctnbl();
  {
    RefCountable* c = bar() ? nullptr : b.get();
    c->method();
    RefCountable* d = bar() ? b.get() : nullptr;
    d->method();
  }
}

} // namespace conditional_op

namespace local_assignment_basic {

RefCountable *provide_ref_cntbl();

void foo(RefCountable* a) {
  RefCountable* b = a;
  // expected-warning@-1{{Local variable 'b' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
  if (b->trivial())
    b = provide_ref_cntbl();
}

void bar(RefCountable* a) {
  RefCountable* b;
  // expected-warning@-1{{Local variable 'b' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
  b = provide_ref_cntbl();
}

void baz() {
  RefPtr a = provide_ref_cntbl();
  {
    RefCountable* b = a.get();
    // expected-warning@-1{{Local variable 'b' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
    b = provide_ref_cntbl();
  }
}

} // namespace local_assignment_basic

namespace local_assignment_to_parameter {

RefCountable *provide_ref_cntbl();
void someFunction();

void foo(RefCountable* a) {
  a = provide_ref_cntbl();
  // expected-warning@-1{{Assignment to an uncounted parameter 'a' is unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
  someFunction();
  a->method();
}

} // namespace local_assignment_to_parameter

namespace local_assignment_to_static_local {

RefCountable *provide_ref_cntbl();
void someFunction();

void foo() {
  static RefCountable* a = nullptr;
  // expected-warning@-1{{Static local variable 'a' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}
  a = provide_ref_cntbl();
  someFunction();
  a->method();
}

} // namespace local_assignment_to_static_local

namespace local_assignment_to_global {

RefCountable *provide_ref_cntbl();
void someFunction();

RefCountable* g_a = nullptr;
// expected-warning@-1{{Global variable 'local_assignment_to_global::g_a' is uncounted and unsafe [alpha.webkit.UncountedLocalVarsChecker]}}

void foo() {
  g_a = provide_ref_cntbl();
  someFunction();
  g_a->method();
}

} // namespace local_assignment_to_global

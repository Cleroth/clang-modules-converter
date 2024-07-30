; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

target datalayout = "E-p:64:64:64-p1:16:16:16-a0:0:8-f32:32:32-f64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-v64:64:64-v128:128:128"

; Simple case, argument translatable without changing the value
declare void @test1a(ptr)

define void @test1(ptr %A) {
; CHECK-LABEL: define void @test1
; CHECK-SAME: (ptr [[A:%.*]]) {
; CHECK-NEXT:    call void @test1a(ptr [[A]])
; CHECK-NEXT:    ret void
;
  call void @test1a( ptr %A )
  ret void
}


; Should not do because of change in address space of the parameter
define void @test1_as1_illegal(ptr addrspace(1) %A) {
; CHECK-LABEL: define void @test1_as1_illegal
; CHECK-SAME: (ptr addrspace(1) [[A:%.*]]) {
; CHECK-NEXT:    call void @test1a(ptr addrspace(1) [[A]])
; CHECK-NEXT:    ret void
;
  call void @test1a(ptr addrspace(1) %A)
  ret void
}

; Test1, but the argument has a different sized address-space
declare void @test1a_as1(ptr addrspace(1))

; This one is OK to perform
define void @test1_as1(ptr addrspace(1) %A) {
; CHECK-LABEL: define void @test1_as1
; CHECK-SAME: (ptr addrspace(1) [[A:%.*]]) {
; CHECK-NEXT:    call void @test1a_as1(ptr addrspace(1) [[A]])
; CHECK-NEXT:    ret void
;
  call void @test1a_as1(ptr addrspace(1) %A )
  ret void
}

; More complex case, translate argument because of resolution.  This is safe
; because we have the body of the function
define void @test2a(i8 %A) {
; CHECK-LABEL: define void @test2a
; CHECK-SAME: (i8 [[A:%.*]]) {
; CHECK-NEXT:    ret void
;
  ret void
}

define i32 @test2(i32 %A) {
; CHECK-LABEL: define i32 @test2
; CHECK-SAME: (i32 [[A:%.*]]) {
; CHECK-NEXT:    call void @test2a(i32 [[A]])
; CHECK-NEXT:    ret i32 [[A]]
;
  call void @test2a( i32 %A )
  ret i32 %A
}


; Resolving this should insert a cast from sbyte to int, following the C
; promotion rules.
define void @test3a(i8, ...) {unreachable }
; CHECK-LABEL: define void @test3a
; CHECK-SAME: (i8 [[TMP0:%.*]], ...) {
; CHECK-NEXT:    unreachable
;
define void @test3(i8 %A, i8 %B) {
  call void @test3a( i8 %A, i8 %B)
  ret void
}

; test conversion of return value...
define i8 @test4a() {
; CHECK-LABEL: define i8 @test4a() {
; CHECK-NEXT:    ret i8 0
;
  ret i8 0
}

define i32 @test4() {
; CHECK-LABEL: define i32 @test4() {
; CHECK-NEXT:    [[X:%.*]] = call i32 @test4a()
; CHECK-NEXT:    ret i32 [[X]]
;
  %X = call i32 @test4a( )            ; <i32> [#uses=1]
  ret i32 %X
}

; test conversion of return value... no value conversion occurs so we can do
; this with just a prototype...
declare i32 @test5a()

define i32 @test5() {
; CHECK-LABEL: define i32 @test5() {
; CHECK-NEXT:    [[X:%.*]] = call i32 @test5a()
; CHECK-NEXT:    ret i32 [[X]]
;
  %X = call i32 @test5a( )                ; <i32> [#uses=1]
  ret i32 %X
}

; test addition of new arguments...
declare i32 @test6a(i32)

define i32 @test6() {
; CHECK-LABEL: define i32 @test6() {
; CHECK-NEXT:    [[X:%.*]] = call i32 @test6a(i32 0)
; CHECK-NEXT:    ret i32 [[X]]
;
  %X = call i32 @test6a( )
  ret i32 %X
}

; test removal of arguments, only can happen with a function body
define void @test7a() {
; CHECK-LABEL: define void @test7a() {
; CHECK-NEXT:    ret void
;
  ret void
}

define void @test7() {
; CHECK-LABEL: define void @test7() {
; CHECK-NEXT:    call void @test7a()
; CHECK-NEXT:    ret void
;
  call void @test7a( i32 5 )
  ret void
}


; rdar://7590304
declare void @test8a()

define ptr @test8() personality ptr @__gxx_personality_v0 {
; CHECK-LABEL: define ptr @test8() personality ptr @__gxx_personality_v0 {
; CHECK-NEXT:    invoke void @test8a()
; CHECK-NEXT:    to label [[INVOKE_CONT:%.*]] unwind label [[TRY_HANDLER:%.*]]
; CHECK:       invoke.cont:
; CHECK-NEXT:    unreachable
; CHECK:       try.handler:
; CHECK-NEXT:    [[EXN:%.*]] = landingpad { ptr, i32 }
; CHECK-NEXT:    cleanup
; CHECK-NEXT:    ret ptr null
;
; Don't turn this into "unreachable": the callee and caller don't agree in
; calling conv, but the implementation of test8a may actually end up using the
; right calling conv.
  invoke void @test8a()
  to label %invoke.cont unwind label %try.handler

invoke.cont:                                      ; preds = %entry
  unreachable

try.handler:                                      ; preds = %entry
  %exn = landingpad {ptr, i32}
  cleanup
  ret ptr null
}

declare i32 @__gxx_personality_v0(...)


; Don't turn this into a direct call, because test9x is just a prototype and
; doing so will make it varargs.
; rdar://9038601
declare ptr @test9x(ptr, ptr, ...) noredzone
define ptr @test9(ptr %arg, ptr %tmp3) nounwind ssp noredzone {
; CHECK-LABEL: define ptr @test9
; CHECK-SAME: (ptr [[ARG:%.*]], ptr [[TMP3:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = call ptr @test9x(ptr [[ARG]], ptr [[TMP3]]) #[[ATTR2:[0-9]+]]
; CHECK-NEXT:    ret ptr [[CALL]]
;
entry:
  %call = call ptr @test9x(ptr %arg, ptr %tmp3) noredzone
  ret ptr %call
}


; Parameter that's a vector of pointers
declare void @test10a(<2 x ptr>)

define void @test10(<2 x ptr> %A) {
; CHECK-LABEL: define void @test10
; CHECK-SAME: (<2 x ptr> [[A:%.*]]) {
; CHECK-NEXT:    call void @test10a(<2 x ptr> [[A]])
; CHECK-NEXT:    ret void
;
  call void @test10a(<2 x ptr> %A)
  ret void
}

; Don't transform because different address spaces
declare void @test10a_mixed_as(<2 x ptr addrspace(1)>)

define void @test10_mixed_as(<2 x ptr> %A) {
; CHECK-LABEL: define void @test10_mixed_as
; CHECK-SAME: (<2 x ptr> [[A:%.*]]) {
; CHECK-NEXT:    call void @test10a_mixed_as(<2 x ptr> [[A]])
; CHECK-NEXT:    ret void
;
  call void @test10a_mixed_as(<2 x ptr> %A)
  ret void
}

; Return type that's a pointer
define ptr @test11a() {
; CHECK-LABEL: define ptr @test11a() {
; CHECK-NEXT:    ret ptr null
;
  ret ptr zeroinitializer
}

define ptr @test11() {
; CHECK-LABEL: define ptr @test11() {
; CHECK-NEXT:    [[X:%.*]] = call ptr @test11a()
; CHECK-NEXT:    ret ptr [[X]]
;
  %X = call ptr @test11a()
  ret ptr %X
}

; Return type that's a pointer with a different address space
define ptr addrspace(1) @test11a_mixed_as() {
; CHECK-LABEL: define ptr addrspace(1) @test11a_mixed_as() {
; CHECK-NEXT:    ret ptr addrspace(1) null
;
  ret ptr addrspace(1) zeroinitializer
}

define ptr @test11_mixed_as() {
; CHECK-LABEL: define ptr @test11_mixed_as() {
; CHECK-NEXT:    [[X:%.*]] = call ptr @test11a_mixed_as()
; CHECK-NEXT:    ret ptr [[X]]
;
  %X = call ptr @test11a_mixed_as()
  ret ptr %X
}

; Return type that's a vector of pointers
define <2 x ptr> @test12a() {
; CHECK-LABEL: define <2 x ptr> @test12a() {
; CHECK-NEXT:    ret <2 x ptr> zeroinitializer
;
  ret <2 x ptr> zeroinitializer
}

define <2 x ptr> @test12() {
; CHECK-LABEL: define <2 x ptr> @test12() {
; CHECK-NEXT:    [[X:%.*]] = call <2 x ptr> @test12a()
; CHECK-NEXT:    ret <2 x ptr> [[X]]
;
  %X = call <2 x ptr> @test12a()
  ret <2 x ptr> %X
}

define <2 x ptr addrspace(1)> @test12a_mixed_as() {
; CHECK-LABEL: define <2 x ptr addrspace(1)> @test12a_mixed_as() {
; CHECK-NEXT:    ret <2 x ptr addrspace(1)> zeroinitializer
;
  ret <2 x ptr addrspace(1)> zeroinitializer
}

define <2 x ptr> @test12_mixed_as() {
; CHECK-LABEL: define <2 x ptr> @test12_mixed_as() {
; CHECK-NEXT:    [[X:%.*]] = call <2 x ptr> @test12a_mixed_as()
; CHECK-NEXT:    ret <2 x ptr> [[X]]
;
  %X = call <2 x ptr> @test12a_mixed_as()
  ret <2 x ptr> %X
}


; Mix parameter that's a vector of integers and pointers of the same size
declare void @test13a(<2 x i64>)

define void @test13(<2 x ptr> %A) {
; CHECK-LABEL: define void @test13
; CHECK-SAME: (<2 x ptr> [[A:%.*]]) {
; CHECK-NEXT:    call void @test13a(<2 x ptr> [[A]])
; CHECK-NEXT:    ret void
;
  call void @test13a(<2 x ptr> %A)
  ret void
}

; Mix parameter that's a vector of integers and pointers of the same
; size, but the other way around
declare void @test14a(<2 x ptr>)

define void @test14(<2 x i64> %A) {
; CHECK-LABEL: define void @test14
; CHECK-SAME: (<2 x i64> [[A:%.*]]) {
; CHECK-NEXT:    call void @test14a(<2 x i64> [[A]])
; CHECK-NEXT:    ret void
;
  call void @test14a(<2 x i64> %A)
  ret void
}


; Return type that's a vector
define <2 x i16> @test15a() {
; CHECK-LABEL: define <2 x i16> @test15a() {
; CHECK-NEXT:    ret <2 x i16> zeroinitializer
;
  ret <2 x i16> zeroinitializer
}

define i32 @test15() {
; CHECK-LABEL: define i32 @test15() {
; CHECK-NEXT:    [[X:%.*]] = call <2 x i16> @test15a()
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <2 x i16> [[X]] to i32
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %X = call i32 @test15a( )
  ret i32 %X
}

define i32 @test16a() {
; CHECK-LABEL: define i32 @test16a() {
; CHECK-NEXT:    ret i32 0
;
  ret i32 0
}

define <2 x i16> @test16() {
; CHECK-LABEL: define <2 x i16> @test16() {
; CHECK-NEXT:    [[X:%.*]] = call i32 @test16a()
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32 [[X]] to <2 x i16>
; CHECK-NEXT:    ret <2 x i16> [[TMP1]]
;
  %X = call <2 x i16> @test16a( )
  ret <2 x i16> %X
}

declare i32 @pr28655(i32 returned %V)

define i32 @test17() {
; CHECK-LABEL: define i32 @test17() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C:%.*]] = call i32 @pr28655(i32 0)
; CHECK-NEXT:    ret i32 0
;
entry:
  %C = call i32 @pr28655(i32 0)
  ret i32 %C
}

define void @non_vararg(ptr, i32) {
; CHECK-LABEL: define void @non_vararg
; CHECK-SAME: (ptr [[TMP0:%.*]], i32 [[TMP1:%.*]]) {
; CHECK-NEXT:    ret void
;
  ret void
}

define void @test_cast_to_vararg(ptr %this) {
; CHECK-LABEL: define void @test_cast_to_vararg
; CHECK-SAME: (ptr [[THIS:%.*]]) {
; CHECK-NEXT:    call void @non_vararg(ptr [[THIS]], i32 42)
; CHECK-NEXT:    ret void
;
  call void (ptr, ...) @non_vararg(ptr %this, i32 42)
  ret void
}

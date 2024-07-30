; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes='loop(indvars,loop-unroll-full)' -S %s | FileCheck %s

; FIXME: The function is mis-compiled at the moment,
; store i64 [[SEL_2_LCSSA]], ptr [[DST_2:%.*]] writes the wrong value.
define i8 @test_pr58340(ptr %dst.1, ptr %dst.2) {
; CHECK-LABEL: @test_pr58340(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[OUTER_HEADER:%.*]]
; CHECK:       outer.header:
; CHECK-NEXT:    br label [[INNER_1_HEADER:%.*]]
; CHECK:       inner.1.header:
; CHECK-NEXT:    br i1 true, label [[MERGE:%.*]], label [[THEN:%.*]]
; CHECK:       then:
; CHECK-NEXT:    br label [[MERGE]]
; CHECK:       merge:
; CHECK-NEXT:    [[SEL_1:%.*]] = phi i32 [ 0, [[INNER_1_HEADER]] ], [ 2, [[THEN]] ]
; CHECK-NEXT:    store i32 [[SEL_1]], ptr [[DST_1:%.*]], align 4
; CHECK-NEXT:    br label [[INNER_1_LATCH:%.*]]
; CHECK:       inner.2.header.preheader:
; CHECK-NEXT:    br label [[INNER_2_HEADER:%.*]]
; CHECK:       inner.1.latch:
; CHECK-NEXT:    br i1 false, label [[MERGE_1:%.*]], label [[THEN_1:%.*]]
; CHECK:       then.1:
; CHECK-NEXT:    br label [[MERGE_1]]
; CHECK:       merge.1:
; CHECK-NEXT:    [[SEL_1_1:%.*]] = phi i32 [ 0, [[INNER_1_LATCH]] ], [ 2, [[THEN_1]] ]
; CHECK-NEXT:    store i32 [[SEL_1_1]], ptr [[DST_1]], align 4
; CHECK-NEXT:    br i1 false, label [[INNER_1_LATCH_1:%.*]], label [[INNER_2_HEADER_PREHEADER:%.*]]
; CHECK:       inner.1.latch.1:
; CHECK-NEXT:    unreachable
; CHECK:       inner.2.header:
; CHECK-NEXT:    br label [[INNER_3:%.*]]
; CHECK:       inner.3:
; CHECK-NEXT:    store i32 0, ptr [[DST_1]], align 4
; CHECK-NEXT:    store i64 0, ptr [[DST_2:%.*]], align 8
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[OUTER_HEADER]]
;
entry:
  br label %outer.header

outer.header:
  %p.1 = phi i64 [ 0, %entry ], [ %sel.2, %outer.latch ]
  br label %inner.1.header

inner.1.header:
  %p.2 = phi i64 [ %p.1, %outer.header ], [ 0, %inner.1.latch ]
  %b = phi i1 [ true, %outer.header ], [ false, %inner.1.latch ]
  br i1 %b, label %merge, label %then

then:
  br label %merge

merge:
  %sel.1 = phi i32 [ 0, %inner.1.header ], [ 2, %then ]
  store i32 %sel.1, ptr %dst.1, align 4
  br i1 %b, label %inner.1.latch, label %inner.2.header

inner.1.latch:
  br label %inner.1.header

inner.2.header:
  br label %inner.3

inner.3:
  %sel.2 = phi i64 [ %sel.1.ext, %inner.3 ], [ 0, %inner.2.header ]
  %c.1 = icmp ult i32 %sel.1, 1
  %sel.1.ext = sext i32 %sel.1 to i64
  br i1 %c.1, label %inner.3, label %inner.2.latch

inner.2.latch:
  br i1 false, label %inner.2.header, label %outer.latch

outer.latch:
  store i32 0, ptr %dst.1, align 4
  store i64 %sel.2, ptr %dst.2, align 8
  call void @clobber()
  br label %outer.header
}

declare void @clobber()

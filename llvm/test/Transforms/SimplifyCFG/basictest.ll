; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Test CFG simplify removal of branch instructions.
;
; RUN: opt < %s -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 -S | FileCheck %s
; RUN: opt < %s -passes=simplifycfg -S | FileCheck %s

define void @test1() {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    ret void
;
  br label %1
  ret void
}

define void @test2() {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    ret void
;
  ret void
  ret void
}

define void @test3(i1 %T) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    ret void
;
  br i1 %T, label %1, label %1
  ret void
}

; Folding branch to a common destination.
define void @test4_fold(i32 %a, i32 %b) {
; CHECK-LABEL: @test4_fold(
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ugt i32 [[A]], 0
; CHECK-NEXT:    [[OR_COND:%.*]] = and i1 [[CMP1]], [[CMP2]]
; CHECK-NEXT:    br i1 [[OR_COND]], label [[ELSE:%.*]], label [[COMMON_RET:%.*]]
; CHECK:       common.ret:
; CHECK-NEXT:    ret void
; CHECK:       else:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    br label [[COMMON_RET]]
;
  %cmp1 = icmp eq i32 %a, %b
  br i1 %cmp1, label %taken, label %untaken

taken:
  %cmp2 = icmp ugt i32 %a, 0
  br i1 %cmp2, label %else, label %untaken

else:
  call void @foo()
  ret void

untaken:
  ret void
}

; Prefer a simplification based on a dominating condition rather than folding a
; branch to a common destination.
define void @test4_no_fold(i32 %a, i32 %b) {
; CHECK-LABEL: @test4_no_fold(
; CHECK-NEXT:  untaken:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret void
;
  %cmp1 = icmp eq i32 %a, %b
  br i1 %cmp1, label %taken, label %untaken

taken:
  %cmp2 = icmp ugt i32 %a, %b
  br i1 %cmp2, label %else, label %untaken

else:
  call void @foo()
  ret void

untaken:
  ret void
}

declare void @foo()

; PR5795
define void @test5(i32 %A) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  common.ret:
; CHECK-NEXT:    ret void
;
  switch i32 %A, label %return [
  i32 2, label %1
  i32 10, label %2
  ]

  ret void

  ret void

return:                                           ; preds = %entry
  ret void
}


; PR14893
define i8 @test6f() {
; CHECK-LABEL: @test6f(
; CHECK-NEXT:  bb0:
; CHECK-NEXT:    [[R:%.*]] = alloca i8, align 1
; CHECK-NEXT:    [[TMP:%.*]] = call i8 @test6g(ptr [[R]])
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i8 [[TMP]], 0
; CHECK-NEXT:    [[TMP3:%.*]] = load i8, ptr [[R]], align 1, !range [[RNG5:![0-9]+]]
; CHECK-NEXT:    [[TMP4:%.*]] = icmp eq i8 [[TMP3]], 1
; CHECK-NEXT:    [[OR_COND:%.*]] = select i1 [[TMP1]], i1 true, i1 [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = select i1 [[OR_COND]], i8 0, i8 1
; CHECK-NEXT:    ret i8 [[TMP6]]
;

bb0:
  %r = alloca i8, align 1
  %tmp = call i8 @test6g(ptr %r)
  %tmp1 = icmp eq i8 %tmp, 0
  br i1 %tmp1, label %bb2, label %bb1
bb1:
  %tmp3 = load i8, ptr %r, align 1, !range !2, !tbaa !10, !dbg !5
  %tmp4 = icmp eq i8 %tmp3, 1
  br i1 %tmp4, label %bb2, label %bb3
bb2:
  br label %bb3
bb3:
  %tmp6 = phi i8 [ 0, %bb2 ], [ 1, %bb1 ]
  ret i8 %tmp6
}
declare i8 @test6g(ptr)

!llvm.dbg.cu = !{!3}
!llvm.module.flags = !{!8, !9}

!0 = !{!10, !10, i64 0}
!1 = !{!"foo"}
!2 = !{i8 0, i8 2}
!3 = distinct !DICompileUnit(language: DW_LANG_C99, file: !7, producer: "clang", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !4)
!4 = !{}
!5 = !DILocation(line: 23, scope: !6)
!6 = distinct !DISubprogram(name: "foo", scope: !3, file: !7, line: 1, type: !DISubroutineType(types: !4), isLocal: false, isDefinition: true, scopeLine: 1, flags: DIFlagPrototyped, isOptimized: false, unit: !3, retainedNodes: !4)
!7 = !DIFile(filename: "foo.c", directory: "/")
!8 = !{i32 2, !"Dwarf Version", i32 2}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{!"scalar type", !1}

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S -passes='require<profile-summary>,function(codegenprepare)' %s | FileCheck %s

target triple = "x86_64--linux-gnu"

@foo = dso_local thread_local(localexec) global i32 0, align 4

declare void @effect()
declare nonnull ptr @llvm.threadlocal.address.p0(ptr nonnull)

define i32 @func0(i32 %arg) {
; CHECK-LABEL: define i32 @func0(
; CHECK-SAME: i32 [[ARG:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADDR:%.*]] = tail call ptr @llvm.threadlocal.address.p0(ptr @foo)
; CHECK-NEXT:    [[LOAD0:%.*]] = load i32, ptr [[ADDR]], align 4
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[ARG]], 0
; CHECK-NEXT:    br i1 [[COND]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @effect()
; CHECK-NEXT:    [[TMP0:%.*]] = call align 4 ptr @llvm.threadlocal.address.p0(ptr align 4 @foo)
; CHECK-NEXT:    [[LOAD1:%.*]] = load i32, ptr [[TMP0]], align 4
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[PHI:%.*]] = phi i32 [ [[LOAD1]], [[IF_THEN]] ], [ [[LOAD0]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[RET:%.*]] = add i32 [[PHI]], [[LOAD0]]
; CHECK-NEXT:    ret i32 [[RET]]
;
entry:
  %addr = tail call ptr @llvm.threadlocal.address.p0(ptr @foo)
  %load0 = load i32, ptr %addr, align 4
  %cond = icmp eq i32 %arg, 0
  br i1 %cond, label %if.then, label %if.end

if.then:
  tail call void @effect()
  %load1 = load i32, ptr %addr, align 4
  br label %if.end

if.end:
  %phi = phi i32 [ %load1, %if.then ], [ %load0, %entry ]
  %ret = add i32 %phi, %load0
  ret i32 %ret
}

define i32 @func1(i32 %arg0, i32 %arg1) {
; CHECK-LABEL: define i32 @func1(
; CHECK-SAME: i32 [[ARG0:%.*]], i32 [[ARG1:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADDR:%.*]] = tail call ptr @llvm.threadlocal.address.p0(ptr @foo)
; CHECK-NEXT:    [[LOAD0:%.*]] = load i32, ptr [[ADDR]], align 4
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[ARG0]], 0
; CHECK-NEXT:    br i1 [[COND]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @effect()
; CHECK-NEXT:    [[X:%.*]] = add i32 [[ARG1]], 42
; CHECK-NEXT:    [[X64:%.*]] = sext i32 [[X]] to i64
; CHECK-NEXT:    [[TMP0:%.*]] = call align 4 ptr @llvm.threadlocal.address.p0(ptr align 4 @foo)
; CHECK-NEXT:    [[SUNKADDR:%.*]] = mul i64 [[X64]], 4
; CHECK-NEXT:    [[ADDR1:%.*]] = getelementptr inbounds i8, ptr [[TMP0]], i64 [[SUNKADDR]]
; CHECK-NEXT:    [[LOAD1:%.*]] = load i32, ptr [[ADDR1]], align 4
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[PHI:%.*]] = phi i32 [ [[LOAD1]], [[IF_THEN]] ], [ [[LOAD0]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[RET:%.*]] = add i32 [[PHI]], [[LOAD0]]
; CHECK-NEXT:    ret i32 [[RET]]
;
entry:
  %addr = tail call ptr @llvm.threadlocal.address.p0(ptr @foo)
  %load0 = load i32, ptr %addr, align 4
  %cond = icmp eq i32 %arg0, 0
  br i1 %cond, label %if.then, label %if.end

if.then:
  tail call void @effect()
  %x = add i32 %arg1, 42
  %x64 = sext i32 %x to i64
  %addr1 = getelementptr inbounds i32, ptr %addr, i64 %x64
  %load1 = load i32, ptr %addr1, align 4
  br label %if.end

if.end:
  %phi = phi i32 [ %load1, %if.then ], [ %load0, %entry ]
  %ret = add i32 %phi, %load0
  ret i32 %ret
}

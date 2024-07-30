; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S -passes=verify,iroutliner -ir-outlining-no-cost < %s | FileCheck %s
; RUN: opt -S -passes=verify,iroutliner -ir-outlining-no-cost < %s --try-experimental-debuginfo-iterators | FileCheck %s

target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7-none-linux-android19"

define i32 @r() {
; CHECK-LABEL: define i32 @r() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DOTLOC:%.*]] = alloca ptr, align 4
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 -1, ptr [[DOTLOC]])
; CHECK-NEXT:    [[TMP0:%.*]] = call i1 @outlined_ir_func_0(ptr [[DOTLOC]], i32 0)
; CHECK-NEXT:    [[DOTRELOAD:%.*]] = load ptr, ptr [[DOTLOC]], align 4
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 -1, ptr [[DOTLOC]])
; CHECK-NEXT:    br i1 [[TMP0]], label [[IF_END8:%.*]], label [[ENTRY_AFTER_OUTLINE:%.*]]
; CHECK:       entry_after_outline:
; CHECK-NEXT:    [[CALL7:%.*]] = call i32 [[DOTRELOAD]]()
; CHECK-NEXT:    br label [[IF_END8]]
; CHECK:       if.end8:
; CHECK-NEXT:    ret i32 0
;
entry:
  %.fca.2.insert = insertvalue [5 x i32] zeroinitializer, i32 0, 2
  %.fca.3.load = load i32, ptr null, align 4
  %.fca.3.insert = insertvalue [5 x i32] zeroinitializer, i32 0, 3
  %.fca.4.load = load i32, ptr null, align 4
  %.fca.4.insert = insertvalue [5 x i32] zeroinitializer, i32 0, 4
  %call = call i32 @p()
  %tobool.not = icmp eq i32 0, 0
  br i1 false, label %if.end8, label %if.then

if.then:                                          ; preds = %entry
  %0 = load i32, ptr null, align 4
  %tobool1.not = icmp eq i32 0, 0
  %1 = load i32, ptr null, align 4
  %2 = load i32, ptr null, align 4
  %cond = select i1 false, i32 0, i32 0
  %tobool5.not = icmp eq i32 0, 0
  br i1 false, label %if.end8, label %if.then6

if.then6:                                         ; preds = %if.then
  %3 = load ptr, ptr null, align 4
  %call7 = call i32 %3()
  br label %if.end8

if.end8:                                          ; preds = %if.then6, %if.then, %entry
  ret i32 0
}

declare i32 @p()

define i32 @u() {
; CHECK-LABEL: define i32 @u() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i1 @outlined_ir_func_0(ptr null, i32 -1)
; CHECK-NEXT:    br i1 [[TMP0]], label [[IF_END8:%.*]], label [[ENTRY_AFTER_OUTLINE:%.*]]
; CHECK:       entry_after_outline:
; CHECK-NEXT:    br label [[IF_END8]]
; CHECK:       if.end8:
; CHECK-NEXT:    ret i32 0
;
entry:
  %.fca.2.insert = insertvalue [5 x i32] zeroinitializer, i32 0, 2
  %.fca.3.load = load i32, ptr null, align 4
  %.fca.3.insert = insertvalue [5 x i32] zeroinitializer, i32 0, 3
  %.fca.4.load = load i32, ptr null, align 4
  %.fca.4.insert = insertvalue [5 x i32] zeroinitializer, i32 0, 4
  %call = call i32 @p()
  %tobool.not = icmp eq i32 0, 0
  br i1 false, label %if.end8, label %if.then

if.then:                                          ; preds = %entry
  %0 = load i32, ptr null, align 4
  %tobool1.not = icmp eq i32 0, 0
  %1 = load i32, ptr null, align 4
  %2 = load i32, ptr null, align 4
  %cond = select i1 false, i32 0, i32 0
  %tobool5.not = icmp eq i32 0, 0
  br i1 false, label %if.end8, label %if.then6

if.then6:                                         ; preds = %if.then
  %3 = load ptr, ptr null, align 4
  br label %if.end8

if.end8:                                          ; preds = %if.then6, %if.then, %entry
  ret i32 0
}

define i32 @w() !dbg !8 {
; CHECK-LABEL: define i32 @w(
; CHECK-SAME: ) !dbg [[DBG8:![0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[RETVAL_1_CE_LOC:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 -1, ptr [[RETVAL_1_CE_LOC]])
; CHECK-NEXT:    [[TMP0:%.*]] = call i1 @outlined_ir_func_0(ptr [[RETVAL_1_CE_LOC]], i32 1), !dbg [[DBG11:![0-9]+]]
; CHECK-NEXT:    [[RETVAL_1_CE_RELOAD:%.*]] = load i32, ptr [[RETVAL_1_CE_LOC]], align 4
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 -1, ptr [[RETVAL_1_CE_LOC]])
; CHECK-NEXT:    br i1 [[TMP0]], label [[CLEANUP10:%.*]], label [[ENTRY_AFTER_OUTLINE:%.*]]
; CHECK:       entry_after_outline:
; CHECK-NEXT:    [[CALL8:%.*]] = call i32 @llvm.bswap.i32(i32 0)
; CHECK-NEXT:    br label [[CLEANUP10]]
; CHECK:       cleanup10:
; CHECK-NEXT:    [[RETVAL_1:%.*]] = phi i32 [ 0, [[ENTRY_AFTER_OUTLINE]] ], [ [[RETVAL_1_CE_RELOAD]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret i32 0
;
entry:
  %.fca.2.insert = insertvalue [5 x i32] zeroinitializer, i32 0, 2
  %.fca.3.load = load i32, ptr null, align 4
  %.fca.3.insert = insertvalue [5 x i32] zeroinitializer, i32 0, 3
  %.fca.4.load = load i32, ptr null, align 4
  %.fca.4.insert = insertvalue [5 x i32] zeroinitializer, i32 0, 4
  %call = call i32 @p()
  %tobool.not = icmp eq i32 0, 0
  br i1 false, label %cleanup10, label %if.then

if.then:                                          ; preds = %entry
  call void @llvm.dbg.value(metadata i32 0, metadata !11, metadata !DIExpression()), !dbg !15
  %0 = load i32, ptr null, align 4
  %tobool1.not = icmp eq i32 0, 0
  %1 = load i32, ptr null, align 4
  %2 = load i32, ptr null, align 4
  %cond = select i1 false, i32 0, i32 0
  %tobool5.not = icmp eq i32 0, 0
  br i1 false, label %cleanup10, label %cleanup

cleanup:                                          ; preds = %if.then
  %3 = load ptr, ptr null, align 4
  %call8 = call i32 @llvm.bswap.i32(i32 0)
  br label %cleanup10

cleanup10:                                        ; preds = %cleanup, %if.then, %entry
  %retval.1 = phi i32 [ 0, %cleanup ], [ 0, %entry ], [ 0, %if.then ]
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.bswap.i32(i32) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "clang version 18.0.0 (https://github.com/llvm/llvm-project.git 2ca028ce7c6de5f1350440012355a65383b8729a)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, globals: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/foo.c", directory: "/home/davidino/llvm-build-upstream")
!2 = !{!3}
!3 = !DIGlobalVariableExpression(var: !4, expr: !DIExpression())
!4 = distinct !DIGlobalVariable(name: "n", scope: !0, file: !5, line: 19, type: !6, isLocal: false, isDefinition: true)
!5 = !DIFile(filename: "/tmp/foo.c", directory: "")
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = distinct !DISubprogram(name: "w", scope: !5, file: !5, line: 54, type: !9, scopeLine: 54, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !10)
!9 = !DISubroutineType(types: !10)
!10 = !{}
!11 = !DILocalVariable(name: "t", scope: !12, file: !5, line: 57, type: !14)
!12 = distinct !DILexicalBlock(scope: !13, file: !5, line: 56, column: 17)
!13 = distinct !DILexicalBlock(scope: !8, file: !5, line: 56, column: 11)
!14 = !DIDerivedType(tag: DW_TAG_typedef, name: "a", file: !5, line: 2, baseType: !6)
!15 = !DILocation(line: 0, scope: !12)
;.
; CHECK: [[META0:![0-9]+]] = distinct !DICompileUnit(language: DW_LANG_C11, file: [[META1:![0-9]+]], producer: "{{.*}}clang version {{.*}}", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, globals: [[META2:![0-9]+]], splitDebugInlining: false, nameTableKind: None)
; CHECK: [[META1]] = !DIFile(filename: "/tmp/foo.c", directory: {{.*}})
; CHECK: [[META2]] = !{[[META3:![0-9]+]]}
; CHECK: [[META3]] = !DIGlobalVariableExpression(var: [[META4:![0-9]+]], expr: !DIExpression())
; CHECK: [[META4]] = distinct !DIGlobalVariable(name: "n", scope: [[META0]], file: [[META5:![0-9]+]], line: 19, type: [[META6:![0-9]+]], isLocal: false, isDefinition: true)
; CHECK: [[META5]] = !DIFile(filename: "/tmp/foo.c", directory: "")
; CHECK: [[META6]] = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
; CHECK: [[DBG8]] = distinct !DISubprogram(name: "w", scope: [[META5]], file: [[META5]], line: 54, type: [[META9:![0-9]+]], scopeLine: 54, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: [[META0]], retainedNodes: [[META10:![0-9]+]])
; CHECK: [[META9]] = !DISubroutineType(types: [[META10]])
; CHECK: [[META10]] = !{}
; CHECK: [[DBG11]] = !DILocation(line: 0, scope: [[DBG8]])
;.

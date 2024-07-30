; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-annotate-decl-cs  -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

; Test cases specifically designed for the "nofree" function attribute.
; We use FIXME's to indicate problems and missing attributes.

; Free functions
declare void @free(ptr nocapture) local_unnamed_addr #1
declare noalias ptr @realloc(ptr nocapture, i64) local_unnamed_addr #0
declare void @_ZdaPv(ptr) local_unnamed_addr #2


; TEST 1 (positive case)
define void @only_return() #0 {
; CHECK: Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
; CHECK-LABEL: define {{[^@]+}}@only_return
; CHECK-SAME: () #[[ATTR3:[0-9]+]] {
; CHECK-NEXT:    ret void
;
  ret void
}


; TEST 2 (negative case)
; Only free
; void only_free(char* p) {
;    free(p);
; }

define void @only_free(ptr nocapture %0) local_unnamed_addr #0 {
; CHECK: Function Attrs: noinline nounwind uwtable
; CHECK-LABEL: define {{[^@]+}}@only_free
; CHECK-SAME: (ptr nocapture [[TMP0:%.*]]) local_unnamed_addr #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    tail call void @free(ptr nocapture [[TMP0]]) #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    ret void
;
  tail call void @free(ptr %0) #1
  ret void
}


; TEST 3 (negative case)
; Free occurs in same scc.
; void free_in_scc1(char*p){
;    free_in_scc2(p);
; }
; void free_in_scc2(char*p){
;    free_in_scc1(p);
;    free(p);
; }


define void @free_in_scc1(ptr nocapture %0) local_unnamed_addr #0 {
; CHECK: Function Attrs: noinline nounwind uwtable
; CHECK-LABEL: define {{[^@]+}}@free_in_scc1
; CHECK-SAME: (ptr nocapture [[TMP0:%.*]]) local_unnamed_addr #[[ATTR1]] {
; CHECK-NEXT:    tail call void @free_in_scc2(ptr nocapture [[TMP0]]) #[[ATTR0]]
; CHECK-NEXT:    ret void
;
  tail call void @free_in_scc2(ptr %0) #1
  ret void
}


define void @free_in_scc2(ptr nocapture %0) local_unnamed_addr #0 {
; CHECK: Function Attrs: noinline nounwind uwtable
; CHECK-LABEL: define {{[^@]+}}@free_in_scc2
; CHECK-SAME: (ptr nocapture [[TMP0:%.*]]) local_unnamed_addr #[[ATTR1]] {
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq ptr [[TMP0]], null
; CHECK-NEXT:    br i1 [[CMP]], label [[REC:%.*]], label [[CALL:%.*]]
; CHECK:       call:
; CHECK-NEXT:    tail call void @free(ptr nocapture nonnull [[TMP0]]) #[[ATTR0]]
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       rec:
; CHECK-NEXT:    tail call void @free_in_scc1(ptr nocapture [[TMP0]]) #[[ATTR0]]
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %cmp = icmp eq ptr %0, null
  br i1 %cmp, label %rec, label %call
call:
  tail call void @free(ptr %0) #1
  br label %end
rec:
  tail call void @free_in_scc1(ptr %0)
  br label %end
end:
  ret void
}


; TEST 4 (positive case)
; Free doesn't occur.
; void mutual_recursion1(){
;    mutual_recursion2();
; }
; void mutual_recursion2(){
;     mutual_recursion1();
; }


define void @mutual_recursion1() #0 {
; TUNIT: Function Attrs: mustprogress nofree noinline nosync nounwind willreturn memory(none) uwtable
; TUNIT-LABEL: define {{[^@]+}}@mutual_recursion1
; TUNIT-SAME: () #[[ATTR4:[0-9]+]] {
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
; CGSCC-LABEL: define {{[^@]+}}@mutual_recursion1
; CGSCC-SAME: () #[[ATTR3]] {
; CGSCC-NEXT:    ret void
;
  call void @mutual_recursion2()
  ret void
}

define void @mutual_recursion2() #0 {
; TUNIT: Function Attrs: mustprogress nofree noinline nosync nounwind willreturn memory(none) uwtable
; TUNIT-LABEL: define {{[^@]+}}@mutual_recursion2
; TUNIT-SAME: () #[[ATTR4]] {
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
; CGSCC-LABEL: define {{[^@]+}}@mutual_recursion2
; CGSCC-SAME: () #[[ATTR3]] {
; CGSCC-NEXT:    ret void
;
  call void @mutual_recursion1()
  ret void
}


; TEST 5
; C++ delete operation (negative case)
; void delete_op (char p[]){
;     delete [] p;
; }

define void @_Z9delete_opPc(ptr %0) local_unnamed_addr #0 {
; CHECK: Function Attrs: noinline nounwind uwtable
; CHECK-LABEL: define {{[^@]+}}@_Z9delete_opPc
; CHECK-SAME: (ptr [[TMP0:%.*]]) local_unnamed_addr #[[ATTR1]] {
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq ptr [[TMP0]], null
; CHECK-NEXT:    br i1 [[TMP2]], label [[TMP4:%.*]], label [[TMP3:%.*]]
; CHECK:       3:
; CHECK-NEXT:    tail call void @_ZdaPv(ptr nonnull [[TMP0]]) #[[ATTR2:[0-9]+]]
; CHECK-NEXT:    br label [[TMP4]]
; CHECK:       4:
; CHECK-NEXT:    ret void
;
  %2 = icmp eq ptr %0, null
  br i1 %2, label %4, label %3

; <label>:3:                                      ; preds = %1
  tail call void @_ZdaPv(ptr nonnull %0) #2
  br label %4

; <label>:4:                                      ; preds = %3, %1
  ret void
}


; TEST 6 (negative case)
; Call realloc
define noalias ptr @call_realloc(ptr nocapture %0, i64 %1) local_unnamed_addr #0 {
; CHECK: Function Attrs: noinline nounwind uwtable
; CHECK-LABEL: define {{[^@]+}}@call_realloc
; CHECK-SAME: (ptr nocapture [[TMP0:%.*]], i64 [[TMP1:%.*]]) local_unnamed_addr #[[ATTR1]] {
; CHECK-NEXT:    [[RET:%.*]] = tail call ptr @realloc(ptr nocapture [[TMP0]], i64 [[TMP1]]) #[[ATTR2]]
; CHECK-NEXT:    ret ptr [[RET]]
;
  %ret = tail call ptr @realloc(ptr %0, i64 %1) #2
  ret ptr %ret
}


; TEST 7 (positive case)
; Call function declaration with "nofree"


; CHECK: Function Attrs:  nofree noinline nounwind memory(none) uwtable
declare void @nofree_function() nofree readnone #0

define void @call_nofree_function() #0 {
; TUNIT: Function Attrs: mustprogress nofree noinline nosync nounwind willreturn memory(none) uwtable
; TUNIT-LABEL: define {{[^@]+}}@call_nofree_function
; TUNIT-SAME: () #[[ATTR4]] {
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: mustprogress nofree noinline nosync nounwind willreturn memory(none) uwtable
; CGSCC-LABEL: define {{[^@]+}}@call_nofree_function
; CGSCC-SAME: () #[[ATTR5:[0-9]+]] {
; CGSCC-NEXT:    ret void
;
  tail call void @nofree_function()
  ret void
}

; TEST 8 (negative case)
; Call function declaration without "nofree"


; CHECK: Function Attrs: noinline nounwind uwtable
declare void @maybe_free() #0


define void @call_maybe_free() #0 {
; CHECK: Function Attrs: noinline nounwind uwtable
; CHECK-LABEL: define {{[^@]+}}@call_maybe_free
; CHECK-SAME: () #[[ATTR1]] {
; CHECK-NEXT:    tail call void @maybe_free() #[[ATTR0]]
; CHECK-NEXT:    ret void
;
  tail call void @maybe_free()
  ret void
}


; TEST 9 (negative case)
; Call both of above functions

define void @call_both() #0 {
; CHECK: Function Attrs: noinline nounwind uwtable
; CHECK-LABEL: define {{[^@]+}}@call_both
; CHECK-SAME: () #[[ATTR1]] {
; CHECK-NEXT:    tail call void @maybe_free() #[[ATTR0]]
; CHECK-NEXT:    ret void
;
  tail call void @maybe_free()
  tail call void @nofree_function()
  ret void
}


; TEST 10 (positive case)
; Call intrinsic function
; CHECK: Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.floor.f32(float)

define void @call_floor(float %a) #0 {
; CHECK: Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
; CHECK-LABEL: define {{[^@]+}}@call_floor
; CHECK-SAME: (float [[A:%.*]]) #[[ATTR3]] {
; CHECK-NEXT:    ret void
;
  tail call float @llvm.floor.f32(float %a)
  ret void
}

define float @call_floor2(float %a) #0 {
; CHECK: Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
; CHECK-LABEL: define {{[^@]+}}@call_floor2
; CHECK-SAME: (float [[A:%.*]]) #[[ATTR3]] {
; CHECK-NEXT:    [[C:%.*]] = tail call nofpclass(sub) float @llvm.floor.f32(float [[A]]) #[[ATTR14:[0-9]+]]
; CHECK-NEXT:    ret float [[C]]
;
  %c = tail call float @llvm.floor.f32(float %a)
  ret float %c
}

; TEST 11 (positive case)
; Check propagation.

define void @f1() #0 {
; TUNIT: Function Attrs: mustprogress nofree noinline nosync nounwind willreturn memory(none) uwtable
; TUNIT-LABEL: define {{[^@]+}}@f1
; TUNIT-SAME: () #[[ATTR4]] {
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: mustprogress nofree noinline nosync nounwind willreturn memory(none) uwtable
; CGSCC-LABEL: define {{[^@]+}}@f1
; CGSCC-SAME: () #[[ATTR5]] {
; CGSCC-NEXT:    ret void
;
  tail call void @nofree_function()
  ret void
}

define void @f2() #0 {
; TUNIT: Function Attrs: mustprogress nofree noinline nosync nounwind willreturn memory(none) uwtable
; TUNIT-LABEL: define {{[^@]+}}@f2
; TUNIT-SAME: () #[[ATTR4]] {
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: mustprogress nofree noinline nosync nounwind willreturn memory(none) uwtable
; CGSCC-LABEL: define {{[^@]+}}@f2
; CGSCC-SAME: () #[[ATTR5]] {
; CGSCC-NEXT:    ret void
;
  tail call void @f1()
  ret void
}

; TEST 12 NoFree argument - positive.
define double @test12(ptr nocapture readonly %a) {
; CHECK: Function Attrs: nofree nounwind
; CHECK-LABEL: define {{[^@]+}}@test12
; CHECK-SAME: (ptr nocapture nofree noundef nonnull readonly align 8 dereferenceable(8) [[A:%.*]]) #[[ATTR7:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load double, ptr [[A]], align 8
; CHECK-NEXT:    [[CALL:%.*]] = tail call double @cos(double [[TMP0]]) #[[ATTR8:[0-9]+]]
; CHECK-NEXT:    ret double [[CALL]]
;
entry:
  %0 = load double, ptr %a, align 8
  %call = tail call double @cos(double %0) #2
  ret double %call
}

declare double @cos(double) nobuiltin nounwind nofree

; FIXME: %a should be nofree.
; TEST 13 NoFree argument - positive.
define noalias ptr @test13(ptr nocapture readonly %a) {
; CHECK: Function Attrs: nounwind
; CHECK-LABEL: define {{[^@]+}}@test13
; CHECK-SAME: (ptr nocapture nofree noundef nonnull readonly align 8 dereferenceable(8) [[A:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr [[A]], align 8
; CHECK-NEXT:    [[CALL:%.*]] = tail call noalias ptr @malloc(i64 [[TMP0]]) #[[ATTR2]]
; CHECK-NEXT:    ret ptr [[CALL]]
;
entry:
  %0 = load i64, ptr %a, align 8
  %call = tail call noalias ptr @malloc(i64 %0) #2
  ret ptr %call
}

define void @test14(ptr nocapture %0, ptr nocapture %1) {
; CHECK: Function Attrs: nounwind
; CHECK-LABEL: define {{[^@]+}}@test14
; CHECK-SAME: (ptr nocapture [[TMP0:%.*]], ptr nocapture nofree readnone [[TMP1:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    tail call void @free(ptr nocapture [[TMP0]]) #[[ATTR0]]
; CHECK-NEXT:    ret void
;
  tail call void @free(ptr %0) #1
  ret void
}

; UTC_ARGS: --enable

define void @nonnull_assume_pos(ptr %arg1, ptr %arg2, ptr %arg3, ptr %arg4) {
; ATTRIBUTOR-LABEL: define {{[^@]+}}@nonnull_assume_pos
; ATTRIBUTOR-SAME: (ptr nofree [[ARG1:%.*]], ptr [[ARG2:%.*]], ptr nofree [[ARG3:%.*]], ptr [[ARG4:%.*]])
; ATTRIBUTOR-NEXT:    call void @llvm.assume(i1 true) #11 [ "nofree"(ptr [[ARG1]]), "nofree"(ptr [[ARG3]]) ]
; ATTRIBUTOR-NEXT:    call void @unknown(ptr nofree [[ARG1]], ptr [[ARG2]], ptr nofree [[ARG3]], ptr [[ARG4]])
; ATTRIBUTOR-NEXT:    ret void
;
; CHECK-LABEL: define {{[^@]+}}@nonnull_assume_pos
; CHECK-SAME: (ptr nofree [[ARG1:%.*]], ptr [[ARG2:%.*]], ptr nofree [[ARG3:%.*]], ptr [[ARG4:%.*]]) {
; CHECK-NEXT:    call void @llvm.assume(i1 noundef true) #[[ATTR15:[0-9]+]] [ "nofree"(ptr [[ARG1]]), "nofree"(ptr [[ARG3]]) ]
; CHECK-NEXT:    call void @unknown(ptr nofree [[ARG1]], ptr [[ARG2]], ptr nofree [[ARG3]], ptr [[ARG4]])
; CHECK-NEXT:    ret void
;
  call void @llvm.assume(i1 true) ["nofree"(ptr %arg1), "nofree"(ptr %arg3)]
  call void @unknown(ptr %arg1, ptr %arg2, ptr %arg3, ptr %arg4)
  ret void
}
define void @nonnull_assume_neg(ptr %arg1, ptr %arg2, ptr %arg3, ptr %arg4) {
; ATTRIBUTOR-LABEL: define {{[^@]+}}@nonnull_assume_neg
; ATTRIBUTOR-SAME: (ptr [[ARG1:%.*]], ptr [[ARG2:%.*]], ptr [[ARG3:%.*]], ptr [[ARG4:%.*]])
; ATTRIBUTOR-NEXT:    call void @unknown(ptr [[ARG1]], ptr [[ARG2]], ptr [[ARG3]], ptr [[ARG4]])
; ATTRIBUTOR-NEXT:    call void @llvm.assume(i1 true) [ "nofree"(ptr [[ARG1]]), "nofree"(ptr [[ARG3]]) ]
; ATTRIBUTOR-NEXT:    ret void
;
; CHECK-LABEL: define {{[^@]+}}@nonnull_assume_neg
; CHECK-SAME: (ptr [[ARG1:%.*]], ptr [[ARG2:%.*]], ptr [[ARG3:%.*]], ptr [[ARG4:%.*]]) {
; CHECK-NEXT:    call void @unknown(ptr [[ARG1]], ptr [[ARG2]], ptr [[ARG3]], ptr [[ARG4]])
; CHECK-NEXT:    call void @llvm.assume(i1 noundef true) [ "nofree"(ptr [[ARG1]]), "nofree"(ptr [[ARG3]]) ]
; CHECK-NEXT:    ret void
;
  call void @unknown(ptr %arg1, ptr %arg2, ptr %arg3, ptr %arg4)
  call void @llvm.assume(i1 true) ["nofree"(ptr %arg1), "nofree"(ptr %arg3)]
  ret void
}
define void @nonnull_assume_call(ptr %arg1, ptr %arg2, ptr %arg3, ptr %arg4) {
; ATTRIBUTOR-LABEL: define {{[^@]+}}@nonnull_assume_call
; ATTRIBUTOR-SAME: (ptr [[ARG1:%.*]], ptr [[ARG2:%.*]], ptr [[ARG3:%.*]], ptr [[ARG4:%.*]])
; ATTRIBUTOR-NEXT:    call void @unknown(ptr [[ARG1]], ptr [[ARG2]], ptr [[ARG3]], ptr [[ARG4]])
; ATTRIBUTOR-NEXT:    call void @use_i8_ptr(ptr noalias readnone [[ARG1]])
; ATTRIBUTOR-NEXT:    call void @use_i8_ptr(ptr noalias readnone [[ARG2]])
; ATTRIBUTOR-NEXT:    call void @llvm.assume(i1 true) [ "nofree"(ptr [[ARG1]]), "nofree"(ptr [[ARG3]]) ]
; ATTRIBUTOR-NEXT:    call void @use_i8_ptr(ptr noalias nofree readnone [[ARG3]])
; ATTRIBUTOR-NEXT:    call void @use_i8_ptr(ptr noalias readnone [[ARG4]])
; ATTRIBUTOR-NEXT:    call void @use_i8_ptr_ret(ptr noalias nofree readnone [[ARG1]])
; ATTRIBUTOR-NEXT:    call void @use_i8_ptr_ret(ptr noalias readnone [[ARG2]])
; ATTRIBUTOR-NEXT:    call void @llvm.assume(i1 true) [ "nofree"(ptr [[ARG1]]), "nofree"(ptr [[ARG4]]) ]
; ATTRIBUTOR-NEXT:    call void @use_i8_ptr_ret(ptr noalias nofree readnone [[ARG3]])
; ATTRIBUTOR-NEXT:    call void @use_i8_ptr_ret(ptr noalias nofree readnone [[ARG4]])
; ATTRIBUTOR-NEXT:    ret void
;
; CHECK-LABEL: define {{[^@]+}}@nonnull_assume_call
; CHECK-SAME: (ptr [[ARG1:%.*]], ptr [[ARG2:%.*]], ptr [[ARG3:%.*]], ptr [[ARG4:%.*]]) {
; CHECK-NEXT:    call void @unknown(ptr [[ARG1]], ptr [[ARG2]], ptr [[ARG3]], ptr [[ARG4]])
; CHECK-NEXT:    call void @use_i8_ptr(ptr noalias nocapture nofree readnone [[ARG1]]) #[[ATTR0]]
; CHECK-NEXT:    call void @use_i8_ptr(ptr noalias nocapture nofree readnone [[ARG2]]) #[[ATTR0]]
; CHECK-NEXT:    call void @llvm.assume(i1 noundef true) [ "nofree"(ptr [[ARG1]]), "nofree"(ptr [[ARG3]]) ]
; CHECK-NEXT:    call void @use_i8_ptr(ptr noalias nocapture nofree readnone [[ARG3]]) #[[ATTR0]]
; CHECK-NEXT:    call void @use_i8_ptr(ptr noalias nocapture nofree readnone [[ARG4]]) #[[ATTR0]]
; CHECK-NEXT:    call void @use_i8_ptr_ret(ptr noalias nocapture nofree readnone [[ARG1]]) #[[ATTR0]]
; CHECK-NEXT:    call void @use_i8_ptr_ret(ptr noalias nocapture nofree readnone [[ARG2]]) #[[ATTR0]]
; CHECK-NEXT:    call void @llvm.assume(i1 noundef true) [ "nofree"(ptr [[ARG1]]), "nofree"(ptr [[ARG4]]) ]
; CHECK-NEXT:    call void @use_i8_ptr_ret(ptr noalias nocapture nofree readnone [[ARG3]]) #[[ATTR0]]
; CHECK-NEXT:    call void @use_i8_ptr_ret(ptr noalias nocapture nofree readnone [[ARG4]]) #[[ATTR0]]
; CHECK-NEXT:    ret void
;
  call void @unknown(ptr %arg1, ptr %arg2, ptr %arg3, ptr %arg4)
  call void @use_i8_ptr(ptr %arg1)
  call void @use_i8_ptr(ptr %arg2)
  call void @llvm.assume(i1 true) ["nofree"(ptr %arg1), "nofree"(ptr %arg3)]
  call void @use_i8_ptr(ptr %arg3)
  call void @use_i8_ptr(ptr %arg4)
  call void @use_i8_ptr_ret(ptr %arg1)
  call void @use_i8_ptr_ret(ptr %arg2)
  call void @llvm.assume(i1 true) ["nofree"(ptr %arg1), "nofree"(ptr %arg4)]
  call void @use_i8_ptr_ret(ptr %arg3)
  call void @use_i8_ptr_ret(ptr %arg4)
  ret void
}

; FIXME: function is nofree
define weak void @implied_nofree1() readnone {
; CHECK: Function Attrs: nosync memory(none)
; CHECK-LABEL: define {{[^@]+}}@implied_nofree1
; CHECK-SAME: () #[[ATTR9:[0-9]+]] {
; CHECK-NEXT:    ret void
;
  ret void
}
; FIXME: function is nofree
define weak void @implied_nofree2() readonly {
; CHECK: Function Attrs: nosync memory(read)
; CHECK-LABEL: define {{[^@]+}}@implied_nofree2
; CHECK-SAME: () #[[ATTR10:[0-9]+]] {
; CHECK-NEXT:    ret void
;
  ret void
}
define weak void @implied_nofree3(ptr readnone %a) {
; CHECK-LABEL: define {{[^@]+}}@implied_nofree3
; CHECK-SAME: (ptr nofree readnone [[A:%.*]]) {
; CHECK-NEXT:    ret void
;
  ret void
}
define weak void @implied_nofree4(ptr readonly %a) {
; CHECK-LABEL: define {{[^@]+}}@implied_nofree4
; CHECK-SAME: (ptr nofree readonly [[A:%.*]]) {
; CHECK-NEXT:    ret void
;
  ret void
}
; FIXME: %a is nofree
define weak void @implied_nofree5(ptr %a) readonly {
; CHECK: Function Attrs: nosync memory(read)
; CHECK-LABEL: define {{[^@]+}}@implied_nofree5
; CHECK-SAME: (ptr [[A:%.*]]) #[[ATTR10]] {
; CHECK-NEXT:    ret void
;
  ret void
}
define weak void @implied_nofree6(ptr %a) nofree {
; CHECK: Function Attrs: nofree
; CHECK-LABEL: define {{[^@]+}}@implied_nofree6
; CHECK-SAME: (ptr nofree [[A:%.*]]) #[[ATTR11:[0-9]+]] {
; CHECK-NEXT:    ret void
;
  ret void
}

declare void @llvm.assume(i1)
declare void @unknown(ptr, ptr, ptr, ptr)
declare void @use_i8_ptr(ptr nocapture readnone) nounwind
declare void @use_i8_ptr_ret(ptr nocapture readnone) nounwind willreturn

declare noalias ptr @malloc(i64)

attributes #0 = { nounwind uwtable noinline }
attributes #1 = { nounwind }
attributes #2 = { nobuiltin nounwind }
;.
; TUNIT: attributes #[[ATTR0]] = { nounwind }
; TUNIT: attributes #[[ATTR1]] = { noinline nounwind uwtable }
; TUNIT: attributes #[[ATTR2]] = { nobuiltin nounwind }
; TUNIT: attributes #[[ATTR3]] = { mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable }
; TUNIT: attributes #[[ATTR4]] = { mustprogress nofree noinline nosync nounwind willreturn memory(none) uwtable }
; TUNIT: attributes #[[ATTR5:[0-9]+]] = { nofree noinline nounwind memory(none) uwtable }
; TUNIT: attributes #[[ATTR6:[0-9]+]] = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
; TUNIT: attributes #[[ATTR7]] = { nofree nounwind }
; TUNIT: attributes #[[ATTR8]] = { nobuiltin nofree nounwind }
; TUNIT: attributes #[[ATTR9]] = { nosync memory(none) }
; TUNIT: attributes #[[ATTR10]] = { nosync memory(read) }
; TUNIT: attributes #[[ATTR11]] = { nofree }
; TUNIT: attributes #[[ATTR12:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
; TUNIT: attributes #[[ATTR13:[0-9]+]] = { nounwind willreturn }
; TUNIT: attributes #[[ATTR14]] = { nofree nosync willreturn }
; TUNIT: attributes #[[ATTR15]] = { nofree willreturn memory(write) }
;.
; CGSCC: attributes #[[ATTR0]] = { nounwind }
; CGSCC: attributes #[[ATTR1]] = { noinline nounwind uwtable }
; CGSCC: attributes #[[ATTR2]] = { nobuiltin nounwind }
; CGSCC: attributes #[[ATTR3]] = { mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable }
; CGSCC: attributes #[[ATTR4:[0-9]+]] = { nofree noinline nounwind memory(none) uwtable }
; CGSCC: attributes #[[ATTR5]] = { mustprogress nofree noinline nosync nounwind willreturn memory(none) uwtable }
; CGSCC: attributes #[[ATTR6:[0-9]+]] = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
; CGSCC: attributes #[[ATTR7]] = { nofree nounwind }
; CGSCC: attributes #[[ATTR8]] = { nobuiltin nofree nounwind }
; CGSCC: attributes #[[ATTR9]] = { nosync memory(none) }
; CGSCC: attributes #[[ATTR10]] = { nosync memory(read) }
; CGSCC: attributes #[[ATTR11]] = { nofree }
; CGSCC: attributes #[[ATTR12:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
; CGSCC: attributes #[[ATTR13:[0-9]+]] = { nounwind willreturn }
; CGSCC: attributes #[[ATTR14]] = { nofree nosync willreturn }
; CGSCC: attributes #[[ATTR15]] = { nofree willreturn memory(write) }
;.

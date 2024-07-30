; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals all --version 4
; RUN: opt -passes=pgo-instr-gen -profile-context-root=an_entrypoint \
; RUN:   -S < %s | FileCheck --check-prefix=INSTRUMENT %s
; RUN: opt -passes=pgo-instr-gen,ctx-instr-lower -profile-context-root=an_entrypoint \
; RUN:   -profile-context-root=another_entrypoint_no_callees \
; RUN:   -S < %s | FileCheck --check-prefix=LOWERING %s


declare void @bar()

;.
; INSTRUMENT: @__profn_foo = private constant [3 x i8] c"foo"
; INSTRUMENT: @__profn_an_entrypoint = private constant [13 x i8] c"an_entrypoint"
; INSTRUMENT: @__profn_another_entrypoint_no_callees = private constant [29 x i8] c"another_entrypoint_no_callees"
; INSTRUMENT: @__profn_simple = private constant [6 x i8] c"simple"
; INSTRUMENT: @__profn_no_callsites = private constant [12 x i8] c"no_callsites"
; INSTRUMENT: @__profn_no_counters = private constant [11 x i8] c"no_counters"
;.
; LOWERING: @__profn_foo = private constant [3 x i8] c"foo"
; LOWERING: @__profn_an_entrypoint = private constant [13 x i8] c"an_entrypoint"
; LOWERING: @__profn_another_entrypoint_no_callees = private constant [29 x i8] c"another_entrypoint_no_callees"
; LOWERING: @__profn_simple = private constant [6 x i8] c"simple"
; LOWERING: @__profn_no_callsites = private constant [12 x i8] c"no_callsites"
; LOWERING: @__profn_no_counters = private constant [11 x i8] c"no_counters"
; LOWERING: @an_entrypoint_ctx_root = global { ptr, ptr, ptr, i8 } zeroinitializer
; LOWERING: @another_entrypoint_no_callees_ctx_root = global { ptr, ptr, ptr, i8 } zeroinitializer
; LOWERING: @__llvm_ctx_profile_callsite = external hidden thread_local global ptr
; LOWERING: @__llvm_ctx_profile_expected_callee = external hidden thread_local global ptr
;.
define void @foo(i32 %a, ptr %fct) {
; INSTRUMENT-LABEL: define void @foo(
; INSTRUMENT-SAME: i32 [[A:%.*]], ptr [[FCT:%.*]]) {
; INSTRUMENT-NEXT:    call void @llvm.instrprof.increment(ptr @__profn_foo, i64 728453322856651412, i32 2, i32 0)
; INSTRUMENT-NEXT:    [[T:%.*]] = icmp eq i32 [[A]], 0
; INSTRUMENT-NEXT:    br i1 [[T]], label [[YES:%.*]], label [[NO:%.*]]
; INSTRUMENT:       yes:
; INSTRUMENT-NEXT:    call void @llvm.instrprof.increment(ptr @__profn_foo, i64 728453322856651412, i32 2, i32 1)
; INSTRUMENT-NEXT:    call void @llvm.instrprof.callsite(ptr @__profn_foo, i64 728453322856651412, i32 2, i32 0, ptr [[FCT]])
; INSTRUMENT-NEXT:    call void [[FCT]](i32 [[A]])
; INSTRUMENT-NEXT:    br label [[EXIT:%.*]]
; INSTRUMENT:       no:
; INSTRUMENT-NEXT:    call void @llvm.instrprof.callsite(ptr @__profn_foo, i64 728453322856651412, i32 2, i32 1, ptr @bar)
; INSTRUMENT-NEXT:    call void @bar()
; INSTRUMENT-NEXT:    br label [[EXIT]]
; INSTRUMENT:       exit:
; INSTRUMENT-NEXT:    ret void
;
; LOWERING-LABEL: define void @foo(
; LOWERING-SAME: i32 [[A:%.*]], ptr [[FCT:%.*]]) {
; LOWERING-NEXT:    [[TMP1:%.*]] = call ptr @__llvm_ctx_profile_get_context(ptr @foo, i64 6699318081062747564, i32 2, i32 2)
; LOWERING-NEXT:    [[TMP2:%.*]] = ptrtoint ptr [[TMP1]] to i64
; LOWERING-NEXT:    [[TMP3:%.*]] = and i64 [[TMP2]], 1
; LOWERING-NEXT:    [[TMP4:%.*]] = call ptr @llvm.threadlocal.address.p0(ptr @__llvm_ctx_profile_expected_callee)
; LOWERING-NEXT:    [[TMP5:%.*]] = getelementptr ptr, ptr [[TMP4]], i64 [[TMP3]]
; LOWERING-NEXT:    [[TMP6:%.*]] = call ptr @llvm.threadlocal.address.p0(ptr @__llvm_ctx_profile_callsite)
; LOWERING-NEXT:    [[TMP7:%.*]] = getelementptr i32, ptr [[TMP6]], i64 [[TMP3]]
; LOWERING-NEXT:    [[TMP8:%.*]] = and i64 [[TMP2]], -2
; LOWERING-NEXT:    [[TMP9:%.*]] = inttoptr i64 [[TMP8]] to ptr
; LOWERING-NEXT:    [[T:%.*]] = icmp eq i32 [[A]], 0
; LOWERING-NEXT:    br i1 [[T]], label [[YES:%.*]], label [[NO:%.*]]
; LOWERING:       yes:
; LOWERING-NEXT:    [[TMP10:%.*]] = getelementptr { { i64, ptr, i32, i32 }, [2 x i64], [2 x ptr] }, ptr [[TMP9]], i32 0, i32 1, i32 1
; LOWERING-NEXT:    [[TMP11:%.*]] = load i64, ptr [[TMP10]], align 4
; LOWERING-NEXT:    [[TMP12:%.*]] = add i64 [[TMP11]], 1
; LOWERING-NEXT:    store i64 [[TMP12]], ptr [[TMP10]], align 4
; LOWERING-NEXT:    store volatile ptr [[FCT]], ptr [[TMP5]], align 8
; LOWERING-NEXT:    [[TMP13:%.*]] = getelementptr { { i64, ptr, i32, i32 }, [2 x i64], [2 x ptr] }, ptr [[TMP1]], i32 0, i32 2, i32 0
; LOWERING-NEXT:    store volatile ptr [[TMP13]], ptr [[TMP7]], align 8
; LOWERING-NEXT:    call void [[FCT]](i32 [[A]])
; LOWERING-NEXT:    br label [[EXIT:%.*]]
; LOWERING:       no:
; LOWERING-NEXT:    store volatile ptr @bar, ptr [[TMP5]], align 8
; LOWERING-NEXT:    [[TMP14:%.*]] = getelementptr { { i64, ptr, i32, i32 }, [2 x i64], [2 x ptr] }, ptr [[TMP1]], i32 0, i32 2, i32 1
; LOWERING-NEXT:    store volatile ptr [[TMP14]], ptr [[TMP7]], align 8
; LOWERING-NEXT:    call void @bar()
; LOWERING-NEXT:    br label [[EXIT]]
; LOWERING:       exit:
; LOWERING-NEXT:    ret void
;
  %t = icmp eq i32 %a, 0
  br i1 %t, label %yes, label %no
yes:
  call void %fct(i32 %a)
  br label %exit
no:
  call void @bar()
  br label %exit
exit:
  ret void
}

define void @an_entrypoint(i32 %a) {
; INSTRUMENT-LABEL: define void @an_entrypoint(
; INSTRUMENT-SAME: i32 [[A:%.*]]) {
; INSTRUMENT-NEXT:    call void @llvm.instrprof.increment(ptr @__profn_an_entrypoint, i64 784007058953177093, i32 2, i32 0)
; INSTRUMENT-NEXT:    [[T:%.*]] = icmp eq i32 [[A]], 0
; INSTRUMENT-NEXT:    br i1 [[T]], label [[YES:%.*]], label [[NO:%.*]]
; INSTRUMENT:       yes:
; INSTRUMENT-NEXT:    call void @llvm.instrprof.increment(ptr @__profn_an_entrypoint, i64 784007058953177093, i32 2, i32 1)
; INSTRUMENT-NEXT:    call void @llvm.instrprof.callsite(ptr @__profn_an_entrypoint, i64 784007058953177093, i32 1, i32 0, ptr @foo)
; INSTRUMENT-NEXT:    call void @foo(i32 1, ptr null)
; INSTRUMENT-NEXT:    ret void
; INSTRUMENT:       no:
; INSTRUMENT-NEXT:    ret void
;
; LOWERING-LABEL: define void @an_entrypoint(
; LOWERING-SAME: i32 [[A:%.*]]) {
; LOWERING-NEXT:    [[TMP1:%.*]] = call ptr @__llvm_ctx_profile_start_context(ptr @an_entrypoint_ctx_root, i64 4909520559318251808, i32 2, i32 1)
; LOWERING-NEXT:    [[TMP2:%.*]] = ptrtoint ptr [[TMP1]] to i64
; LOWERING-NEXT:    [[TMP3:%.*]] = and i64 [[TMP2]], 1
; LOWERING-NEXT:    [[TMP4:%.*]] = call ptr @llvm.threadlocal.address.p0(ptr @__llvm_ctx_profile_expected_callee)
; LOWERING-NEXT:    [[TMP5:%.*]] = getelementptr ptr, ptr [[TMP4]], i64 [[TMP3]]
; LOWERING-NEXT:    [[TMP6:%.*]] = call ptr @llvm.threadlocal.address.p0(ptr @__llvm_ctx_profile_callsite)
; LOWERING-NEXT:    [[TMP7:%.*]] = getelementptr i32, ptr [[TMP6]], i64 [[TMP3]]
; LOWERING-NEXT:    [[TMP8:%.*]] = and i64 [[TMP2]], -2
; LOWERING-NEXT:    [[TMP9:%.*]] = inttoptr i64 [[TMP8]] to ptr
; LOWERING-NEXT:    [[T:%.*]] = icmp eq i32 [[A]], 0
; LOWERING-NEXT:    br i1 [[T]], label [[YES:%.*]], label [[NO:%.*]]
; LOWERING:       yes:
; LOWERING-NEXT:    [[TMP10:%.*]] = getelementptr { { i64, ptr, i32, i32 }, [2 x i64], [1 x ptr] }, ptr [[TMP9]], i32 0, i32 1, i32 1
; LOWERING-NEXT:    [[TMP11:%.*]] = load i64, ptr [[TMP10]], align 4
; LOWERING-NEXT:    [[TMP12:%.*]] = add i64 [[TMP11]], 1
; LOWERING-NEXT:    store i64 [[TMP12]], ptr [[TMP10]], align 4
; LOWERING-NEXT:    store volatile ptr @foo, ptr [[TMP5]], align 8
; LOWERING-NEXT:    [[TMP13:%.*]] = getelementptr { { i64, ptr, i32, i32 }, [2 x i64], [1 x ptr] }, ptr [[TMP1]], i32 0, i32 2, i32 0
; LOWERING-NEXT:    store volatile ptr [[TMP13]], ptr [[TMP7]], align 8
; LOWERING-NEXT:    call void @foo(i32 1, ptr null)
; LOWERING-NEXT:    call void @__llvm_ctx_profile_release_context(ptr @an_entrypoint_ctx_root)
; LOWERING-NEXT:    ret void
; LOWERING:       no:
; LOWERING-NEXT:    call void @__llvm_ctx_profile_release_context(ptr @an_entrypoint_ctx_root)
; LOWERING-NEXT:    ret void
;
  %t = icmp eq i32 %a, 0
  br i1 %t, label %yes, label %no

yes:
  call void @foo(i32 1, ptr null)
  ret void
no:
  ret void
}

define void @another_entrypoint_no_callees(i32 %a) {
; INSTRUMENT-LABEL: define void @another_entrypoint_no_callees(
; INSTRUMENT-SAME: i32 [[A:%.*]]) {
; INSTRUMENT-NEXT:    call void @llvm.instrprof.increment(ptr @__profn_another_entrypoint_no_callees, i64 784007058953177093, i32 2, i32 0)
; INSTRUMENT-NEXT:    [[T:%.*]] = icmp eq i32 [[A]], 0
; INSTRUMENT-NEXT:    br i1 [[T]], label [[YES:%.*]], label [[NO:%.*]]
; INSTRUMENT:       yes:
; INSTRUMENT-NEXT:    call void @llvm.instrprof.increment(ptr @__profn_another_entrypoint_no_callees, i64 784007058953177093, i32 2, i32 1)
; INSTRUMENT-NEXT:    ret void
; INSTRUMENT:       no:
; INSTRUMENT-NEXT:    ret void
;
; LOWERING-LABEL: define void @another_entrypoint_no_callees(
; LOWERING-SAME: i32 [[A:%.*]]) {
; LOWERING-NEXT:    [[TMP1:%.*]] = call ptr @__llvm_ctx_profile_start_context(ptr @another_entrypoint_no_callees_ctx_root, i64 -6371873725078000974, i32 2, i32 0)
; LOWERING-NEXT:    [[TMP2:%.*]] = ptrtoint ptr [[TMP1]] to i64
; LOWERING-NEXT:    [[TMP3:%.*]] = and i64 [[TMP2]], -2
; LOWERING-NEXT:    [[TMP4:%.*]] = inttoptr i64 [[TMP3]] to ptr
; LOWERING-NEXT:    [[T:%.*]] = icmp eq i32 [[A]], 0
; LOWERING-NEXT:    br i1 [[T]], label [[YES:%.*]], label [[NO:%.*]]
; LOWERING:       yes:
; LOWERING-NEXT:    [[TMP5:%.*]] = getelementptr { { i64, ptr, i32, i32 }, [2 x i64], [0 x ptr] }, ptr [[TMP4]], i32 0, i32 1, i32 1
; LOWERING-NEXT:    [[TMP6:%.*]] = load i64, ptr [[TMP5]], align 4
; LOWERING-NEXT:    [[TMP7:%.*]] = add i64 [[TMP6]], 1
; LOWERING-NEXT:    store i64 [[TMP7]], ptr [[TMP5]], align 4
; LOWERING-NEXT:    call void @__llvm_ctx_profile_release_context(ptr @another_entrypoint_no_callees_ctx_root)
; LOWERING-NEXT:    ret void
; LOWERING:       no:
; LOWERING-NEXT:    call void @__llvm_ctx_profile_release_context(ptr @another_entrypoint_no_callees_ctx_root)
; LOWERING-NEXT:    ret void
;
  %t = icmp eq i32 %a, 0
  br i1 %t, label %yes, label %no

yes:
  ret void
no:
  ret void
}

define void @simple(i32 %a) {
; INSTRUMENT-LABEL: define void @simple(
; INSTRUMENT-SAME: i32 [[A:%.*]]) {
; INSTRUMENT-NEXT:    call void @llvm.instrprof.increment(ptr @__profn_simple, i64 742261418966908927, i32 1, i32 0)
; INSTRUMENT-NEXT:    ret void
;
; LOWERING-LABEL: define void @simple(
; LOWERING-SAME: i32 [[A:%.*]]) {
; LOWERING-NEXT:    [[TMP1:%.*]] = call ptr @__llvm_ctx_profile_get_context(ptr @simple, i64 -3006003237940970099, i32 1, i32 0)
; LOWERING-NEXT:    [[TMP2:%.*]] = ptrtoint ptr [[TMP1]] to i64
; LOWERING-NEXT:    [[TMP3:%.*]] = and i64 [[TMP2]], -2
; LOWERING-NEXT:    [[TMP4:%.*]] = inttoptr i64 [[TMP3]] to ptr
; LOWERING-NEXT:    ret void
;
  ret void
}


define i32 @no_callsites(i32 %a) {
; INSTRUMENT-LABEL: define i32 @no_callsites(
; INSTRUMENT-SAME: i32 [[A:%.*]]) {
; INSTRUMENT-NEXT:    call void @llvm.instrprof.increment(ptr @__profn_no_callsites, i64 784007058953177093, i32 2, i32 0)
; INSTRUMENT-NEXT:    [[C:%.*]] = icmp eq i32 [[A]], 0
; INSTRUMENT-NEXT:    br i1 [[C]], label [[YES:%.*]], label [[NO:%.*]]
; INSTRUMENT:       yes:
; INSTRUMENT-NEXT:    call void @llvm.instrprof.increment(ptr @__profn_no_callsites, i64 784007058953177093, i32 2, i32 1)
; INSTRUMENT-NEXT:    ret i32 1
; INSTRUMENT:       no:
; INSTRUMENT-NEXT:    ret i32 0
;
; LOWERING-LABEL: define i32 @no_callsites(
; LOWERING-SAME: i32 [[A:%.*]]) {
; LOWERING-NEXT:    [[TMP1:%.*]] = call ptr @__llvm_ctx_profile_get_context(ptr @no_callsites, i64 5679753335911435902, i32 2, i32 0)
; LOWERING-NEXT:    [[TMP2:%.*]] = ptrtoint ptr [[TMP1]] to i64
; LOWERING-NEXT:    [[TMP3:%.*]] = and i64 [[TMP2]], -2
; LOWERING-NEXT:    [[TMP4:%.*]] = inttoptr i64 [[TMP3]] to ptr
; LOWERING-NEXT:    [[C:%.*]] = icmp eq i32 [[A]], 0
; LOWERING-NEXT:    br i1 [[C]], label [[YES:%.*]], label [[NO:%.*]]
; LOWERING:       yes:
; LOWERING-NEXT:    [[TMP5:%.*]] = getelementptr { { i64, ptr, i32, i32 }, [2 x i64], [0 x ptr] }, ptr [[TMP4]], i32 0, i32 1, i32 1
; LOWERING-NEXT:    [[TMP6:%.*]] = load i64, ptr [[TMP5]], align 4
; LOWERING-NEXT:    [[TMP7:%.*]] = add i64 [[TMP6]], 1
; LOWERING-NEXT:    store i64 [[TMP7]], ptr [[TMP5]], align 4
; LOWERING-NEXT:    ret i32 1
; LOWERING:       no:
; LOWERING-NEXT:    ret i32 0
;
  %c = icmp eq i32 %a, 0
  br i1 %c, label %yes, label %no
yes:
  ret i32 1
no:
  ret i32 0
}

define void @no_counters() {
; INSTRUMENT-LABEL: define void @no_counters() {
; INSTRUMENT-NEXT:    call void @llvm.instrprof.increment(ptr @__profn_no_counters, i64 742261418966908927, i32 1, i32 0)
; INSTRUMENT-NEXT:    call void @llvm.instrprof.callsite(ptr @__profn_no_counters, i64 742261418966908927, i32 1, i32 0, ptr @bar)
; INSTRUMENT-NEXT:    call void @bar()
; INSTRUMENT-NEXT:    ret void
;
; LOWERING-LABEL: define void @no_counters() {
; LOWERING-NEXT:    [[TMP1:%.*]] = call ptr @__llvm_ctx_profile_get_context(ptr @no_counters, i64 5458232184388660970, i32 1, i32 1)
; LOWERING-NEXT:    [[TMP2:%.*]] = ptrtoint ptr [[TMP1]] to i64
; LOWERING-NEXT:    [[TMP3:%.*]] = and i64 [[TMP2]], 1
; LOWERING-NEXT:    [[TMP4:%.*]] = call ptr @llvm.threadlocal.address.p0(ptr @__llvm_ctx_profile_expected_callee)
; LOWERING-NEXT:    [[TMP5:%.*]] = getelementptr ptr, ptr [[TMP4]], i64 [[TMP3]]
; LOWERING-NEXT:    [[TMP6:%.*]] = call ptr @llvm.threadlocal.address.p0(ptr @__llvm_ctx_profile_callsite)
; LOWERING-NEXT:    [[TMP7:%.*]] = getelementptr i32, ptr [[TMP6]], i64 [[TMP3]]
; LOWERING-NEXT:    [[TMP8:%.*]] = and i64 [[TMP2]], -2
; LOWERING-NEXT:    [[TMP9:%.*]] = inttoptr i64 [[TMP8]] to ptr
; LOWERING-NEXT:    store volatile ptr @bar, ptr [[TMP5]], align 8
; LOWERING-NEXT:    [[TMP10:%.*]] = getelementptr { { i64, ptr, i32, i32 }, [1 x i64], [1 x ptr] }, ptr [[TMP1]], i32 0, i32 2, i32 0
; LOWERING-NEXT:    store volatile ptr [[TMP10]], ptr [[TMP7]], align 8
; LOWERING-NEXT:    call void @bar()
; LOWERING-NEXT:    ret void
;
  call void @bar()
  ret void
}
;.
; INSTRUMENT: attributes #[[ATTR0:[0-9]+]] = { nounwind }
;.
; LOWERING: attributes #[[ATTR0:[0-9]+]] = { nounwind }
; LOWERING: attributes #[[ATTR1:[0-9]+]] = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
;.

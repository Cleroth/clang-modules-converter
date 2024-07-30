; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-annotate-decl-cs  -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC


@x = global i32 0

declare void @test1_1(ptr %x1_1, ptr readonly %y1_1, ...)

; NOTE: readonly for %y1_2 would be OK here but not for the similar situation in test13.
;
;.
; CHECK: @x = global i32 0
; CHECK: @constant_mem = external dso_local constant i32, align 4
;.
define void @test1_2(ptr %x1_2, ptr %y1_2, ptr %z1_2) {
; CHECK-LABEL: define {{[^@]+}}@test1_2
; CHECK-SAME: (ptr [[X1_2:%.*]], ptr nofree [[Y1_2:%.*]], ptr [[Z1_2:%.*]]) {
; CHECK-NEXT:    call void (ptr, ptr, ...) @test1_1(ptr [[X1_2]], ptr nofree readonly [[Y1_2]], ptr [[Z1_2]])
; CHECK-NEXT:    store i32 0, ptr @x, align 4
; CHECK-NEXT:    ret void
;
  call void (ptr, ptr, ...) @test1_1(ptr %x1_2, ptr %y1_2, ptr %z1_2)
  store i32 0, ptr @x
  ret void
}

define ptr @test2(ptr %p) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write)
; CHECK-LABEL: define {{[^@]+}}@test2
; CHECK-SAME: (ptr nofree readnone returned "no-capture-maybe-returned" [[P:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    store i32 0, ptr @x, align 4
; CHECK-NEXT:    ret ptr [[P]]
;
  store i32 0, ptr @x
  ret ptr %p
}

define i1 @test3(ptr %p, ptr %q) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CHECK-LABEL: define {{[^@]+}}@test3
; CHECK-SAME: (ptr nofree readnone [[P:%.*]], ptr nofree readnone [[Q:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    [[A:%.*]] = icmp ult ptr [[P]], [[Q]]
; CHECK-NEXT:    ret i1 [[A]]
;
  %A = icmp ult ptr %p, %q
  ret i1 %A
}

declare void @test4_1(ptr nocapture) readonly

define void @test4_2(ptr %p) {
; CHECK: Function Attrs: nosync memory(read)
; CHECK-LABEL: define {{[^@]+}}@test4_2
; CHECK-SAME: (ptr nocapture readonly [[P:%.*]]) #[[ATTR3:[0-9]+]] {
; CHECK-NEXT:    call void @test4_1(ptr nocapture readonly [[P]]) #[[ATTR3]]
; CHECK-NEXT:    ret void
;
  call void @test4_1(ptr %p)
  ret void
}

; Missed optz'n: we could make %q readnone, but don't break test6!
define void @test5(ptr %p, ptr %q) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
; CHECK-LABEL: define {{[^@]+}}@test5
; CHECK-SAME: (ptr nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[P:%.*]], ptr nofree writeonly [[Q:%.*]]) #[[ATTR4:[0-9]+]] {
; CHECK-NEXT:    store ptr [[Q]], ptr [[P]], align 8
; CHECK-NEXT:    ret void
;
  store ptr %q, ptr %p
  ret void
}

declare void @test6_1()
; This is not a missed optz'n.
define void @test6_2(ptr %p, ptr %q) {
; CHECK-LABEL: define {{[^@]+}}@test6_2
; CHECK-SAME: (ptr nocapture nofree noundef nonnull writeonly align 8 dereferenceable(8) [[P:%.*]], ptr nofree [[Q:%.*]]) {
; CHECK-NEXT:    store ptr [[Q]], ptr [[P]], align 8
; CHECK-NEXT:    call void @test6_1()
; CHECK-NEXT:    ret void
;
  store ptr %q, ptr %p
  call void @test6_1()
  ret void
}

; inalloca parameters are always considered written
define void @test7_1(ptr inalloca(i32) %a) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CHECK-LABEL: define {{[^@]+}}@test7_1
; CHECK-SAME: (ptr nocapture nofree nonnull writeonly inalloca(i32) dereferenceable(4) [[A:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    ret void
;
  ret void
}

define ptr @test8_1(ptr %p) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CHECK-LABEL: define {{[^@]+}}@test8_1
; CHECK-SAME: (ptr nofree readnone returned "no-capture-maybe-returned" [[P:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret ptr [[P]]
;
entry:
  ret ptr %p
}

define void @test8_2(ptr %p) {
; TUNIT: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
; TUNIT-LABEL: define {{[^@]+}}@test8_2
; TUNIT-SAME: (ptr nocapture nofree writeonly [[P:%.*]]) #[[ATTR4]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    store i32 10, ptr [[P]], align 4
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: mustprogress nofree nosync nounwind willreturn memory(argmem: write)
; CGSCC-LABEL: define {{[^@]+}}@test8_2
; CGSCC-SAME: (ptr nofree writeonly [[P:%.*]]) #[[ATTR5:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[CALL:%.*]] = call align 4 ptr @test8_1(ptr noalias nofree readnone [[P]]) #[[ATTR17:[0-9]+]]
; CGSCC-NEXT:    store i32 10, ptr [[CALL]], align 4
; CGSCC-NEXT:    ret void
;
entry:
  %call = call ptr @test8_1(ptr %p)
  store i32 10, ptr %call, align 4
  ret void
}

declare void @llvm.masked.scatter.v4i32.v4p0(<4 x i32>%val, <4 x ptr>, i32, <4 x i1>)

; CHECK-NOT: readnone
; CHECK-NOT: readonly
define void @test9(<4 x ptr> %ptrs, <4 x i32>%val) {
; TUNIT: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write)
; TUNIT-LABEL: define {{[^@]+}}@test9
; TUNIT-SAME: (<4 x ptr> [[PTRS:%.*]], <4 x i32> [[VAL:%.*]]) #[[ATTR0]] {
; TUNIT-NEXT:    call void @llvm.masked.scatter.v4i32.v4p0(<4 x i32> [[VAL]], <4 x ptr> [[PTRS]], i32 noundef 4, <4 x i1> noundef <i1 true, i1 false, i1 true, i1 false>) #[[ATTR16:[0-9]+]]
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write)
; CGSCC-LABEL: define {{[^@]+}}@test9
; CGSCC-SAME: (<4 x ptr> [[PTRS:%.*]], <4 x i32> [[VAL:%.*]]) #[[ATTR0]] {
; CGSCC-NEXT:    call void @llvm.masked.scatter.v4i32.v4p0(<4 x i32> [[VAL]], <4 x ptr> [[PTRS]], i32 noundef 4, <4 x i1> noundef <i1 true, i1 false, i1 true, i1 false>) #[[ATTR18:[0-9]+]]
; CGSCC-NEXT:    ret void
;
  call void @llvm.masked.scatter.v4i32.v4p0(<4 x i32>%val, <4 x ptr> %ptrs, i32 4, <4 x i1><i1 true, i1 false, i1 true, i1 false>)
  ret void
}

declare <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr>, i32, <4 x i1>, <4 x i32>)
define <4 x i32> @test10(<4 x ptr> %ptrs) {
; TUNIT: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(read)
; TUNIT-LABEL: define {{[^@]+}}@test10
; TUNIT-SAME: (<4 x ptr> [[PTRS:%.*]]) #[[ATTR7:[0-9]+]] {
; TUNIT-NEXT:    [[RES:%.*]] = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> [[PTRS]], i32 noundef 4, <4 x i1> noundef <i1 true, i1 false, i1 true, i1 false>, <4 x i32> undef) #[[ATTR17:[0-9]+]]
; TUNIT-NEXT:    ret <4 x i32> [[RES]]
;
; CGSCC: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(read)
; CGSCC-LABEL: define {{[^@]+}}@test10
; CGSCC-SAME: (<4 x ptr> [[PTRS:%.*]]) #[[ATTR8:[0-9]+]] {
; CGSCC-NEXT:    [[RES:%.*]] = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> [[PTRS]], i32 noundef 4, <4 x i1> noundef <i1 true, i1 false, i1 true, i1 false>, <4 x i32> undef) #[[ATTR19:[0-9]+]]
; CGSCC-NEXT:    ret <4 x i32> [[RES]]
;
  %res = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> %ptrs, i32 4, <4 x i1><i1 true, i1 false, i1 true, i1 false>, <4 x i32>undef)
  ret <4 x i32> %res
}

declare <4 x i32> @test11_1(<4 x ptr>) argmemonly nounwind readonly
define <4 x i32> @test11_2(<4 x ptr> %ptrs) {
; TUNIT: Function Attrs: nosync nounwind memory(argmem: read)
; TUNIT-LABEL: define {{[^@]+}}@test11_2
; TUNIT-SAME: (<4 x ptr> [[PTRS:%.*]]) #[[ATTR9:[0-9]+]] {
; TUNIT-NEXT:    [[RES:%.*]] = call <4 x i32> @test11_1(<4 x ptr> [[PTRS]]) #[[ATTR15:[0-9]+]]
; TUNIT-NEXT:    ret <4 x i32> [[RES]]
;
; CGSCC: Function Attrs: nosync nounwind memory(argmem: read)
; CGSCC-LABEL: define {{[^@]+}}@test11_2
; CGSCC-SAME: (<4 x ptr> [[PTRS:%.*]]) #[[ATTR10:[0-9]+]] {
; CGSCC-NEXT:    [[RES:%.*]] = call <4 x i32> @test11_1(<4 x ptr> [[PTRS]]) #[[ATTR16:[0-9]+]]
; CGSCC-NEXT:    ret <4 x i32> [[RES]]
;
  %res = call <4 x i32> @test11_1(<4 x ptr> %ptrs)
  ret <4 x i32> %res
}

declare <4 x i32> @test12_1(<4 x ptr>) argmemonly nounwind
; CHECK-NOT: readnone
define <4 x i32> @test12_2(<4 x ptr> %ptrs) {
; TUNIT: Function Attrs: nounwind memory(argmem: readwrite)
; TUNIT-LABEL: define {{[^@]+}}@test12_2
; TUNIT-SAME: (<4 x ptr> [[PTRS:%.*]]) #[[ATTR10:[0-9]+]] {
; TUNIT-NEXT:    [[RES:%.*]] = call <4 x i32> @test12_1(<4 x ptr> [[PTRS]]) #[[ATTR18:[0-9]+]]
; TUNIT-NEXT:    ret <4 x i32> [[RES]]
;
; CGSCC: Function Attrs: nounwind memory(argmem: readwrite)
; CGSCC-LABEL: define {{[^@]+}}@test12_2
; CGSCC-SAME: (<4 x ptr> [[PTRS:%.*]]) #[[ATTR11:[0-9]+]] {
; CGSCC-NEXT:    [[RES:%.*]] = call <4 x i32> @test12_1(<4 x ptr> [[PTRS]]) #[[ATTR20:[0-9]+]]
; CGSCC-NEXT:    ret <4 x i32> [[RES]]
;
  %res = call <4 x i32> @test12_1(<4 x ptr> %ptrs)
  ret <4 x i32> %res
}

define i32 @volatile_load(ptr %p) {
; TUNIT: Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
; TUNIT-LABEL: define {{[^@]+}}@volatile_load
; TUNIT-SAME: (ptr nofree noundef align 4 [[P:%.*]]) #[[ATTR11:[0-9]+]] {
; TUNIT-NEXT:    [[LOAD:%.*]] = load volatile i32, ptr [[P]], align 4
; TUNIT-NEXT:    ret i32 [[LOAD]]
;
; CGSCC: Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
; CGSCC-LABEL: define {{[^@]+}}@volatile_load
; CGSCC-SAME: (ptr nofree noundef align 4 [[P:%.*]]) #[[ATTR12:[0-9]+]] {
; CGSCC-NEXT:    [[LOAD:%.*]] = load volatile i32, ptr [[P]], align 4
; CGSCC-NEXT:    ret i32 [[LOAD]]
;
  %load = load volatile i32, ptr %p
  ret i32 %load
}

declare void @escape_readnone_ptr(ptr %addr, ptr readnone %ptr)
declare void @escape_readonly_ptr(ptr %addr, ptr readonly %ptr)

; The argument pointer %escaped_then_written cannot be marked readnone/only even
; though the only direct use, in @escape_readnone_ptr/@escape_readonly_ptr,
; is marked as readnone/only. However, the functions can write the pointer into
; %addr, causing the store to write to %escaped_then_written.
;
define void @unsound_readnone(ptr %ignored, ptr %escaped_then_written) {
; CHECK-LABEL: define {{[^@]+}}@unsound_readnone
; CHECK-SAME: (ptr nocapture nofree readnone [[IGNORED:%.*]], ptr nofree [[ESCAPED_THEN_WRITTEN:%.*]]) {
; CHECK-NEXT:    [[ADDR:%.*]] = alloca ptr, align 8
; CHECK-NEXT:    call void @escape_readnone_ptr(ptr noundef nonnull align 8 dereferenceable(8) [[ADDR]], ptr noalias nofree readnone [[ESCAPED_THEN_WRITTEN]])
; CHECK-NEXT:    [[ADDR_LD:%.*]] = load ptr, ptr [[ADDR]], align 8
; CHECK-NEXT:    store i8 0, ptr [[ADDR_LD]], align 1
; CHECK-NEXT:    ret void
;
  %addr = alloca ptr
  call void @escape_readnone_ptr(ptr %addr, ptr %escaped_then_written)
  %addr.ld = load ptr, ptr %addr
  store i8 0, ptr %addr.ld
  ret void
}

define void @unsound_readonly(ptr %ignored, ptr %escaped_then_written) {
; CHECK-LABEL: define {{[^@]+}}@unsound_readonly
; CHECK-SAME: (ptr nocapture nofree readnone [[IGNORED:%.*]], ptr nofree [[ESCAPED_THEN_WRITTEN:%.*]]) {
; CHECK-NEXT:    [[ADDR:%.*]] = alloca ptr, align 8
; CHECK-NEXT:    call void @escape_readonly_ptr(ptr noundef nonnull align 8 dereferenceable(8) [[ADDR]], ptr nofree readonly [[ESCAPED_THEN_WRITTEN]])
; CHECK-NEXT:    [[ADDR_LD:%.*]] = load ptr, ptr [[ADDR]], align 8
; CHECK-NEXT:    store i8 0, ptr [[ADDR_LD]], align 1
; CHECK-NEXT:    ret void
;
  %addr = alloca ptr
  call void @escape_readonly_ptr(ptr %addr, ptr %escaped_then_written)
  %addr.ld = load ptr, ptr %addr
  store i8 0, ptr %addr.ld
  ret void
}

; Byval but not readonly/none tests
;
;{
declare void @escape_i8(ptr %ptr)

define void @byval_not_readonly_1(ptr byval(i8) %written) readonly {
; CHECK: Function Attrs: nosync memory(read)
; CHECK-LABEL: define {{[^@]+}}@byval_not_readonly_1
; CHECK-SAME: (ptr noalias nonnull byval(i8) dereferenceable(1) [[WRITTEN:%.*]]) #[[ATTR3]] {
; CHECK-NEXT:    call void @escape_i8(ptr nonnull dereferenceable(1) [[WRITTEN]])
; CHECK-NEXT:    ret void
;
  call void @escape_i8(ptr %written)
  ret void
}

define void @byval_not_readonly_2(ptr byval(i8) %written) readonly {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CHECK-LABEL: define {{[^@]+}}@byval_not_readonly_2
; CHECK-SAME: (ptr noalias nocapture nofree noundef nonnull writeonly byval(i8) dereferenceable(1) [[WRITTEN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    store i8 0, ptr [[WRITTEN]], align 1
; CHECK-NEXT:    ret void
;
  store i8 0, ptr %written
  ret void
}

define void @byval_not_readnone_1(ptr byval(i8) %written) readnone {
; TUNIT: Function Attrs: nosync memory(none)
; TUNIT-LABEL: define {{[^@]+}}@byval_not_readnone_1
; TUNIT-SAME: (ptr noalias nonnull byval(i8) dereferenceable(1) [[WRITTEN:%.*]]) #[[ATTR12:[0-9]+]] {
; TUNIT-NEXT:    call void @escape_i8(ptr nonnull dereferenceable(1) [[WRITTEN]])
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: nosync memory(none)
; CGSCC-LABEL: define {{[^@]+}}@byval_not_readnone_1
; CGSCC-SAME: (ptr noalias nonnull byval(i8) dereferenceable(1) [[WRITTEN:%.*]]) #[[ATTR13:[0-9]+]] {
; CGSCC-NEXT:    call void @escape_i8(ptr nonnull dereferenceable(1) [[WRITTEN]])
; CGSCC-NEXT:    ret void
;
  call void @escape_i8(ptr %written)
  ret void
}

define void @byval_not_readnone_2(ptr byval(i8) %written) readnone {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CHECK-LABEL: define {{[^@]+}}@byval_not_readnone_2
; CHECK-SAME: (ptr noalias nocapture nofree noundef nonnull writeonly byval(i8) dereferenceable(1) [[WRITTEN:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    store i8 0, ptr [[WRITTEN]], align 1
; CHECK-NEXT:    ret void
;
  store i8 0, ptr %written
  ret void
}

define void @byval_no_fnarg(ptr byval(i8) %written) {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
; CHECK-LABEL: define {{[^@]+}}@byval_no_fnarg
; CHECK-SAME: (ptr noalias nocapture nofree noundef nonnull writeonly byval(i8) dereferenceable(1) [[WRITTEN:%.*]]) #[[ATTR4]] {
; CHECK-NEXT:    store i8 0, ptr [[WRITTEN]], align 1
; CHECK-NEXT:    ret void
;
  store i8 0, ptr %written
  ret void
}

define void @testbyval(ptr %read_only) {
; TUNIT: Function Attrs: nosync
; TUNIT-LABEL: define {{[^@]+}}@testbyval
; TUNIT-SAME: (ptr nocapture nonnull readonly [[READ_ONLY:%.*]]) #[[ATTR13:[0-9]+]] {
; TUNIT-NEXT:    call void @byval_not_readonly_1(ptr noalias nocapture nonnull readonly byval(i8) [[READ_ONLY]]) #[[ATTR3]]
; TUNIT-NEXT:    call void @byval_not_readnone_1(ptr noalias nocapture nonnull readnone byval(i8) [[READ_ONLY]]) #[[ATTR13]]
; TUNIT-NEXT:    call void @byval_no_fnarg(ptr noalias nocapture nofree noundef nonnull readonly byval(i8) [[READ_ONLY]]) #[[ATTR19:[0-9]+]]
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: nosync
; CGSCC-LABEL: define {{[^@]+}}@testbyval
; CGSCC-SAME: (ptr nocapture noundef nonnull readonly dereferenceable(1) [[READ_ONLY:%.*]]) #[[ATTR14:[0-9]+]] {
; CGSCC-NEXT:    call void @byval_not_readonly_1(ptr noalias nocapture noundef nonnull readonly byval(i8) dereferenceable(1) [[READ_ONLY]]) #[[ATTR2:[0-9]+]]
; CGSCC-NEXT:    call void @byval_not_readnone_1(ptr noalias nocapture noundef nonnull readnone byval(i8) dereferenceable(1) [[READ_ONLY]]) #[[ATTR14]]
; CGSCC-NEXT:    call void @byval_no_fnarg(ptr noalias nocapture nofree noundef nonnull readnone byval(i8) dereferenceable(1) [[READ_ONLY]]) #[[ATTR21:[0-9]+]]
; CGSCC-NEXT:    ret void
;
  call void @byval_not_readonly_1(ptr byval(i8) %read_only)
  call void @byval_not_readonly_2(ptr byval(i8) %read_only)
  call void @byval_not_readnone_1(ptr byval(i8) %read_only)
  call void @byval_not_readnone_2(ptr byval(i8) %read_only)
  call void @byval_no_fnarg(ptr byval(i8) %read_only)
  ret void
}
;}

declare ptr @maybe_returned_ptr(ptr readonly %ptr) readonly nounwind
declare i8 @maybe_returned_val(ptr %ptr) readonly nounwind
declare void @val_use(i8 %ptr) readonly nounwind

define void @ptr_uses(ptr %ptr) {
; TUNIT: Function Attrs: nosync nounwind memory(read)
; TUNIT-LABEL: define {{[^@]+}}@ptr_uses
; TUNIT-SAME: (ptr nocapture nofree readonly [[PTR:%.*]]) #[[ATTR15]] {
; TUNIT-NEXT:    [[CALL_PTR:%.*]] = call ptr @maybe_returned_ptr(ptr nofree readonly [[PTR]]) #[[ATTR15]]
; TUNIT-NEXT:    [[CALL_VAL:%.*]] = call i8 @maybe_returned_val(ptr readonly [[CALL_PTR]]) #[[ATTR15]]
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: nosync nounwind memory(read)
; CGSCC-LABEL: define {{[^@]+}}@ptr_uses
; CGSCC-SAME: (ptr nocapture nofree readonly [[PTR:%.*]]) #[[ATTR16]] {
; CGSCC-NEXT:    [[CALL_PTR:%.*]] = call ptr @maybe_returned_ptr(ptr nofree readonly [[PTR]]) #[[ATTR16]]
; CGSCC-NEXT:    [[CALL_VAL:%.*]] = call i8 @maybe_returned_val(ptr readonly [[CALL_PTR]]) #[[ATTR16]]
; CGSCC-NEXT:    ret void
;
  %call_ptr = call ptr @maybe_returned_ptr(ptr %ptr)
  %call_val = call i8 @maybe_returned_val(ptr %call_ptr)
  call void @val_use(i8 %call_val)
  ret void
}

define void @ptr_use_chain(ptr %ptr) {
; CHECK-LABEL: define {{[^@]+}}@ptr_use_chain
; CHECK-SAME: (ptr [[PTR:%.*]]) {
; CHECK-NEXT:    call void @escape_i8(ptr [[PTR]])
; CHECK-NEXT:    ret void
;
  call void @escape_i8(ptr %ptr)
  ret void
}

@constant_mem = external dso_local constant i32, align 4
define i32 @read_only_constant_mem() {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CHECK-LABEL: define {{[^@]+}}@read_only_constant_mem
; CHECK-SAME: () #[[ATTR1]] {
; CHECK-NEXT:    [[L:%.*]] = load i32, ptr @constant_mem, align 4
; CHECK-NEXT:    ret i32 [[L]]
;
  %l = load i32, ptr @constant_mem
  ret i32 %l
}
;.
; TUNIT: attributes #[[ATTR0]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(write) }
; TUNIT: attributes #[[ATTR1]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
; TUNIT: attributes #[[ATTR2:[0-9]+]] = { memory(read) }
; TUNIT: attributes #[[ATTR3]] = { nosync memory(read) }
; TUNIT: attributes #[[ATTR4]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) }
; TUNIT: attributes #[[ATTR5:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(write) }
; TUNIT: attributes #[[ATTR6:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(read) }
; TUNIT: attributes #[[ATTR7]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(read) }
; TUNIT: attributes #[[ATTR8:[0-9]+]] = { nounwind memory(argmem: read) }
; TUNIT: attributes #[[ATTR9]] = { nosync nounwind memory(argmem: read) }
; TUNIT: attributes #[[ATTR10]] = { nounwind memory(argmem: readwrite) }
; TUNIT: attributes #[[ATTR11]] = { mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite) }
; TUNIT: attributes #[[ATTR12]] = { nosync memory(none) }
; TUNIT: attributes #[[ATTR13]] = { nosync }
; TUNIT: attributes #[[ATTR14:[0-9]+]] = { nounwind memory(read) }
; TUNIT: attributes #[[ATTR15]] = { nosync nounwind memory(read) }
; TUNIT: attributes #[[ATTR16]] = { nofree willreturn memory(write) }
; TUNIT: attributes #[[ATTR17]] = { nofree willreturn memory(read) }
; TUNIT: attributes #[[ATTR18]] = { nounwind }
; TUNIT: attributes #[[ATTR19]] = { nosync nounwind memory(write) }
;.
; CGSCC: attributes #[[ATTR0]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(write) }
; CGSCC: attributes #[[ATTR1]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
; CGSCC: attributes #[[ATTR2]] = { memory(read) }
; CGSCC: attributes #[[ATTR3]] = { nosync memory(read) }
; CGSCC: attributes #[[ATTR4]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) }
; CGSCC: attributes #[[ATTR5]] = { mustprogress nofree nosync nounwind willreturn memory(argmem: write) }
; CGSCC: attributes #[[ATTR6:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(write) }
; CGSCC: attributes #[[ATTR7:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(read) }
; CGSCC: attributes #[[ATTR8]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(read) }
; CGSCC: attributes #[[ATTR9:[0-9]+]] = { nounwind memory(argmem: read) }
; CGSCC: attributes #[[ATTR10]] = { nosync nounwind memory(argmem: read) }
; CGSCC: attributes #[[ATTR11]] = { nounwind memory(argmem: readwrite) }
; CGSCC: attributes #[[ATTR12]] = { mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite) }
; CGSCC: attributes #[[ATTR13]] = { nosync memory(none) }
; CGSCC: attributes #[[ATTR14]] = { nosync }
; CGSCC: attributes #[[ATTR15:[0-9]+]] = { nounwind memory(read) }
; CGSCC: attributes #[[ATTR16]] = { nosync nounwind memory(read) }
; CGSCC: attributes #[[ATTR17]] = { nofree nosync willreturn }
; CGSCC: attributes #[[ATTR18]] = { nofree willreturn memory(write) }
; CGSCC: attributes #[[ATTR19]] = { nofree willreturn memory(read) }
; CGSCC: attributes #[[ATTR20]] = { nounwind }
; CGSCC: attributes #[[ATTR21]] = { nounwind memory(write) }
;.

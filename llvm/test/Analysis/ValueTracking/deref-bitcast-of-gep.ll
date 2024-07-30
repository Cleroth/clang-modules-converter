; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=licm < %s | FileCheck %s

; Note: the !invariant.load is there just solely to let us call @use()
; to add a fake use, and still have the aliasing work out.  The call
; to @use(0) is just to provide a may-unwind exit out of the loop, so
; that LICM cannot hoist out the load simply because it is guaranteed
; to execute.

declare void @use(i32)

define void @f_0(ptr align 4 dereferenceable(1024) %ptr) nofree nosync {
; CHECK-LABEL: @f_0(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR_GEP:%.*]] = getelementptr i8, ptr [[PTR:%.*]], i32 32
; CHECK-NEXT:    [[VAL:%.*]] = load i32, ptr [[PTR_GEP]], align 4
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    call void @use(i32 0)
; CHECK-NEXT:    call void @use(i32 [[VAL]])
; CHECK-NEXT:    br label [[LOOP]]
;


entry:
  %ptr.gep = getelementptr i8, ptr %ptr, i32 32
  br label %loop

loop:
  call void @use(i32 0)
  %val = load i32, ptr %ptr.gep, !invariant.load !{}
  call void @use(i32 %val)
  br label %loop
}

define void @f_1(ptr align 4 dereferenceable_or_null(1024) %ptr) nofree nosync {
; CHECK-LABEL: @f_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR_GEP:%.*]] = getelementptr i8, ptr [[PTR:%.*]], i32 32
; CHECK-NEXT:    [[PTR_IS_NULL:%.*]] = icmp eq ptr [[PTR]], null
; CHECK-NEXT:    br i1 [[PTR_IS_NULL]], label [[LEAVE:%.*]], label [[LOOP_PREHEADER:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    [[VAL:%.*]] = load i32, ptr [[PTR_GEP]], align 4
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    call void @use(i32 0)
; CHECK-NEXT:    call void @use(i32 [[VAL]])
; CHECK-NEXT:    br label [[LOOP]]
; CHECK:       leave:
; CHECK-NEXT:    ret void
;
entry:
  %ptr.gep = getelementptr i8, ptr %ptr, i32 32
  %ptr_is_null = icmp eq ptr %ptr, null
  br i1 %ptr_is_null, label %leave, label %loop


loop:
  call void @use(i32 0)
  %val = load i32, ptr %ptr.gep, !invariant.load !{}
  call void @use(i32 %val)
  br label %loop

leave:
  ret void
}

define void @f_2(ptr align 4 dereferenceable_or_null(1024) %ptr) {
; CHECK-LABEL: @f_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR_GEP:%.*]] = getelementptr i8, ptr [[PTR:%.*]], i32 30
; CHECK-NEXT:    [[PTR_IS_NULL:%.*]] = icmp eq ptr [[PTR]], null
; CHECK-NEXT:    br i1 [[PTR_IS_NULL]], label [[LEAVE:%.*]], label [[LOOP_PREHEADER:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    call void @use(i32 0)
; CHECK-NEXT:    [[VAL:%.*]] = load i32, ptr [[PTR_GEP]], align 4, !invariant.load !0
; CHECK-NEXT:    call void @use(i32 [[VAL]])
; CHECK-NEXT:    br label [[LOOP]]
; CHECK:       leave:
; CHECK-NEXT:    ret void
;

entry:
  ;; Can't hoist, since the alignment does not work out -- (<4 byte
  ;; aligned> + 30) is not necessarily 4 byte aligned.

  %ptr.gep = getelementptr i8, ptr %ptr, i32 30
  %ptr_is_null = icmp eq ptr %ptr, null
  br i1 %ptr_is_null, label %leave, label %loop

loop:
  call void @use(i32 0)
  %val = load i32, ptr %ptr.gep, !invariant.load !{}
  call void @use(i32 %val)
  br label %loop

leave:
  ret void
}

define void @checkLaunder(ptr align 4 dereferenceable(1024) %p) nofree nosync {
; CHECK-LABEL: @checkLaunder(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[L:%.*]] = call ptr @llvm.launder.invariant.group.p0(ptr [[P:%.*]])
; CHECK-NEXT:    [[VAL:%.*]] = load i8, ptr [[L]], align 1
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    call void @use(i32 0)
; CHECK-NEXT:    call void @use8(i8 [[VAL]])
; CHECK-NEXT:    br label [[LOOP]]
;

entry:
  %l = call ptr @llvm.launder.invariant.group.p0(ptr %p)
  br label %loop

loop:
  call void @use(i32 0)
  %val = load i8, ptr %l, !invariant.load !{}
  call void @use8(i8 %val)
  br label %loop
}

declare ptr @llvm.launder.invariant.group.p0(ptr)

declare void @use8(i8)

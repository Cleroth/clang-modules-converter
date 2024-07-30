; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN:  opt -S -mtriple=amdgcn-- -amdgpu-atomic-optimizer-strategy=Iterative -passes='amdgpu-atomic-optimizer,verify<domtree>' %s | FileCheck -check-prefix=IR %s

define amdgpu_kernel void @uniform_value(ptr addrspace(1) , ptr addrspace(1) %val) #0 {
; IR-LABEL: @uniform_value(
; IR-NEXT:  entry:
; IR-NEXT:    [[UNIFORM_VALUE_KERNARG_SEGMENT:%.*]] = call nonnull align 16 dereferenceable(52) ptr addrspace(4) @llvm.amdgcn.kernarg.segment.ptr()
; IR-NEXT:    [[OUT_KERNARG_OFFSET:%.*]] = getelementptr inbounds i8, ptr addrspace(4) [[UNIFORM_VALUE_KERNARG_SEGMENT]], i64 36
; IR-NEXT:    [[LOADED_OUT_KERNARG_OFFSET:%.*]] = load <2 x i64>, ptr addrspace(4) [[OUT_KERNARG_OFFSET]], align 4
; IR-NEXT:    [[OUT_LOAD1:%.*]] = extractelement <2 x i64> [[LOADED_OUT_KERNARG_OFFSET]], i32 0
; IR-NEXT:    [[MEM_LOCATION:%.*]] = inttoptr i64 [[OUT_LOAD1]] to ptr addrspace(1)
; IR-NEXT:    [[VAL_LOAD2:%.*]] = extractelement <2 x i64> [[LOADED_OUT_KERNARG_OFFSET]], i32 1
; IR-NEXT:    [[VALUE_ADDRESS:%.*]] = inttoptr i64 [[VAL_LOAD2]] to ptr addrspace(1)
; IR-NEXT:    [[LANE:%.*]] = tail call i32 @llvm.amdgcn.workgroup.id.x()
; IR-NEXT:    [[IDXPROM:%.*]] = sext i32 [[LANE]] to i64
; IR-NEXT:    [[ELE:%.*]] = getelementptr i32, ptr addrspace(1) [[VALUE_ADDRESS]], i64 [[IDXPROM]]
; IR-NEXT:    [[VALUE:%.*]] = load i32, ptr addrspace(1) [[ELE]], align 4
; IR-NEXT:    [[GEP:%.*]] = getelementptr i32, ptr addrspace(1) [[MEM_LOCATION]], i32 4
; IR-NEXT:    [[TMP1:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 true)
; IR-NEXT:    [[TMP2:%.*]] = trunc i64 [[TMP1]] to i32
; IR-NEXT:    [[TMP3:%.*]] = lshr i64 [[TMP1]], 32
; IR-NEXT:    [[TMP4:%.*]] = trunc i64 [[TMP3]] to i32
; IR-NEXT:    [[TMP5:%.*]] = call i32 @llvm.amdgcn.mbcnt.lo(i32 [[TMP2]], i32 0)
; IR-NEXT:    [[TMP6:%.*]] = call i32 @llvm.amdgcn.mbcnt.hi(i32 [[TMP4]], i32 [[TMP5]])
; IR-NEXT:    [[TMP7:%.*]] = call i64 @llvm.ctpop.i64(i64 [[TMP1]])
; IR-NEXT:    [[TMP8:%.*]] = trunc i64 [[TMP7]] to i32
; IR-NEXT:    [[TMP9:%.*]] = mul i32 [[VALUE]], [[TMP8]]
; IR-NEXT:    [[TMP10:%.*]] = icmp eq i32 [[TMP6]], 0
; IR-NEXT:    br i1 [[TMP10]], label [[TMP11:%.*]], label [[TMP13:%.*]]
; IR:       11:
; IR-NEXT:    [[TMP12:%.*]] = atomicrmw volatile add ptr addrspace(1) [[GEP]], i32 [[TMP9]] seq_cst, align 4
; IR-NEXT:    br label [[TMP13]]
; IR:       13:
; IR-NEXT:    ret void
;
entry:
  %uniform_value.kernarg.segment = call nonnull align 16 dereferenceable(52) ptr addrspace(4) @llvm.amdgcn.kernarg.segment.ptr()
  %out.kernarg.offset = getelementptr inbounds i8, ptr addrspace(4) %uniform_value.kernarg.segment, i64 36
  %loaded.out.kernarg.offset = load <2 x i64>, ptr addrspace(4) %out.kernarg.offset, align 4
  %out.load1 = extractelement <2 x i64> %loaded.out.kernarg.offset, i32 0
  %mem.location = inttoptr i64 %out.load1 to ptr addrspace(1)
  %val.load2 = extractelement <2 x i64> %loaded.out.kernarg.offset, i32 1
  %value.address = inttoptr i64 %val.load2 to ptr addrspace(1)
  %lane = tail call i32 @llvm.amdgcn.workgroup.id.x()
  %idxprom = sext i32 %lane to i64
  %ele = getelementptr i32, ptr addrspace(1) %value.address, i64 %idxprom
  %value = load i32, ptr addrspace(1) %ele, align 4
  %gep = getelementptr i32, ptr addrspace(1) %mem.location, i32 4
  %old = atomicrmw volatile add ptr addrspace(1) %gep, i32 %value seq_cst, align 4
  ret void
}

define amdgpu_kernel void @divergent_value(ptr addrspace(1) %out, ptr addrspace(1) %val) #0 {
; IR-LABEL: @divergent_value(
; IR-NEXT:  entry:
; IR-NEXT:    [[DIVERGENT_VALUE_KERNARG_SEGMENT:%.*]] = call nonnull align 16 dereferenceable(52) ptr addrspace(4) @llvm.amdgcn.kernarg.segment.ptr()
; IR-NEXT:    [[OUT_KERNARG_OFFSET:%.*]] = getelementptr inbounds i8, ptr addrspace(4) [[DIVERGENT_VALUE_KERNARG_SEGMENT]], i64 36
; IR-NEXT:    [[LOADED_OUT_KERNARG_OFFSET:%.*]] = load <2 x i64>, ptr addrspace(4) [[OUT_KERNARG_OFFSET]], align 4
; IR-NEXT:    [[OUT_LOAD1:%.*]] = extractelement <2 x i64> [[LOADED_OUT_KERNARG_OFFSET]], i32 0
; IR-NEXT:    [[MEM_LOCATION:%.*]] = inttoptr i64 [[OUT_LOAD1]] to ptr addrspace(1)
; IR-NEXT:    [[VAL_LOAD2:%.*]] = extractelement <2 x i64> [[LOADED_OUT_KERNARG_OFFSET]], i32 1
; IR-NEXT:    [[VALUE_ADDRESS:%.*]] = inttoptr i64 [[VAL_LOAD2]] to ptr addrspace(1)
; IR-NEXT:    [[LANE:%.*]] = tail call i32 @llvm.amdgcn.workitem.id.x()
; IR-NEXT:    [[IDXPROM:%.*]] = sext i32 [[LANE]] to i64
; IR-NEXT:    [[ELE:%.*]] = getelementptr i32, ptr addrspace(1) [[VALUE_ADDRESS]], i64 [[IDXPROM]]
; IR-NEXT:    [[VALUE:%.*]] = load i32, ptr addrspace(1) [[ELE]], align 4
; IR-NEXT:    [[GEP:%.*]] = getelementptr i32, ptr addrspace(1) [[MEM_LOCATION]], i32 4
; IR-NEXT:    [[TMP0:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 true)
; IR-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
; IR-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0]], 32
; IR-NEXT:    [[TMP3:%.*]] = trunc i64 [[TMP2]] to i32
; IR-NEXT:    [[TMP4:%.*]] = call i32 @llvm.amdgcn.mbcnt.lo(i32 [[TMP1]], i32 0)
; IR-NEXT:    [[TMP5:%.*]] = call i32 @llvm.amdgcn.mbcnt.hi(i32 [[TMP3]], i32 [[TMP4]])
; IR-NEXT:    [[TMP6:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 true)
; IR-NEXT:    br label [[COMPUTELOOP:%.*]]
; IR:       7:
; IR-NEXT:    [[TMP8:%.*]] = atomicrmw volatile add ptr addrspace(1) [[GEP]], i32 [[TMP13:%.*]] seq_cst, align 4
; IR-NEXT:    br label [[TMP9:%.*]]
; IR:       9:
; IR-NEXT:    ret void
; IR:       ComputeLoop:
; IR-NEXT:    [[ACCUMULATOR:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[TMP13]], [[COMPUTELOOP]] ]
; IR-NEXT:    [[ACTIVEBITS:%.*]] = phi i64 [ [[TMP6]], [[ENTRY]] ], [ [[TMP16:%.*]], [[COMPUTELOOP]] ]
; IR-NEXT:    [[TMP10:%.*]] = call i64 @llvm.cttz.i64(i64 [[ACTIVEBITS]], i1 true)
; IR-NEXT:    [[TMP11:%.*]] = trunc i64 [[TMP10]] to i32
; IR-NEXT:    [[TMP12:%.*]] = call i32 @llvm.amdgcn.readlane.i32(i32 [[VALUE]], i32 [[TMP11]])
; IR-NEXT:    [[TMP13]] = add i32 [[ACCUMULATOR]], [[TMP12]]
; IR-NEXT:    [[TMP14:%.*]] = shl i64 1, [[TMP10]]
; IR-NEXT:    [[TMP15:%.*]] = xor i64 [[TMP14]], -1
; IR-NEXT:    [[TMP16]] = and i64 [[ACTIVEBITS]], [[TMP15]]
; IR-NEXT:    [[TMP17:%.*]] = icmp eq i64 [[TMP16]], 0
; IR-NEXT:    br i1 [[TMP17]], label [[COMPUTEEND:%.*]], label [[COMPUTELOOP]]
; IR:       ComputeEnd:
; IR-NEXT:    [[TMP18:%.*]] = icmp eq i32 [[TMP5]], 0
; IR-NEXT:    br i1 [[TMP18]], label [[TMP7:%.*]], label [[TMP9]]
;
entry:
  %divergent_value.kernarg.segment = call nonnull align 16 dereferenceable(52) ptr addrspace(4) @llvm.amdgcn.kernarg.segment.ptr()
  %out.kernarg.offset = getelementptr inbounds i8, ptr addrspace(4) %divergent_value.kernarg.segment, i64 36
  %loaded.out.kernarg.offset = load <2 x i64>, ptr addrspace(4) %out.kernarg.offset, align 4
  %out.load1 = extractelement <2 x i64> %loaded.out.kernarg.offset, i32 0
  %mem.location = inttoptr i64 %out.load1 to ptr addrspace(1)
  %val.load2 = extractelement <2 x i64>  %loaded.out.kernarg.offset, i32 1
  %value.address = inttoptr i64 %val.load2 to ptr addrspace(1)
  %lane = tail call i32 @llvm.amdgcn.workitem.id.x()
  %idxprom = sext i32 %lane to i64
  %ele = getelementptr i32, ptr addrspace(1) %value.address, i64 %idxprom
  %value = load i32, ptr addrspace(1) %ele, align 4
  %gep = getelementptr i32, ptr addrspace(1) %mem.location, i32 4
  %old = atomicrmw volatile add ptr addrspace(1) %gep, i32 %value seq_cst, align 4
  ret void
}

declare i32 @llvm.amdgcn.workitem.id.x() #1
declare i32 @llvm.amdgcn.workgroup.id.x() #1

declare align 4 ptr addrspace(4) @llvm.amdgcn.kernarg.segment.ptr()

attributes #0 = {"target-cpu"="gfx906"}
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none)}


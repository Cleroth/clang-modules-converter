// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --check-globals all --no-generate-body-for-unused-prefixes --version 4
// RUN: %clang_cc1 -I%S %s -triple amdgcn-amd-amdhsa -emit-llvm -fcxx-exceptions -fexceptions -o - | FileCheck %s
// RUN: %clang_cc1 -I%S %s -triple spirv64-unknown-unknown -fsycl-is-device -emit-llvm -fcxx-exceptions -fexceptions -o - | FileCheck %s --check-prefix=WITH-NONZERO-DEFAULT-AS

struct A { virtual void f(); };
struct B : A { };

B fail;
//.
// CHECK: @_ZTV1B = linkonce_odr unnamed_addr addrspace(1) constant { [3 x ptr addrspace(1)] } { [3 x ptr addrspace(1)] [ptr addrspace(1) null, ptr addrspace(1) @_ZTI1B, ptr addrspace(1) addrspacecast (ptr @_ZN1A1fEv to ptr addrspace(1))] }, comdat, align 8
// CHECK: @fail = addrspace(1) global { ptr addrspace(1) } { ptr addrspace(1) getelementptr inbounds inrange(-16, 8) ({ [3 x ptr addrspace(1)] }, ptr addrspace(1) @_ZTV1B, i32 0, i32 0, i32 2) }, align 8
// CHECK: @_ZTI1A = external addrspace(1) constant ptr addrspace(1)
// CHECK: @_ZTVN10__cxxabiv120__si_class_type_infoE = external addrspace(1) global [0 x ptr addrspace(1)]
// CHECK: @_ZTS1B = linkonce_odr addrspace(1) constant [3 x i8] c"1B\00", comdat, align 1
// CHECK: @_ZTI1B = linkonce_odr addrspace(1) constant { ptr addrspace(1), ptr addrspace(1), ptr addrspace(1) } { ptr addrspace(1) getelementptr inbounds (ptr addrspace(1), ptr addrspace(1) @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr addrspace(1) @_ZTS1B, ptr addrspace(1) @_ZTI1A }, comdat, align 8
// CHECK: @__oclc_ABI_version = weak_odr hidden local_unnamed_addr addrspace(4) constant i32 500
//.
// WITH-NONZERO-DEFAULT-AS: @_ZTV1B = linkonce_odr unnamed_addr addrspace(1) constant { [3 x ptr addrspace(1)] } { [3 x ptr addrspace(1)] [ptr addrspace(1) null, ptr addrspace(1) @_ZTI1B, ptr addrspace(1) addrspacecast (ptr @_ZN1A1fEv to ptr addrspace(1))] }, comdat, align 8
// WITH-NONZERO-DEFAULT-AS: @fail = addrspace(1) global { ptr addrspace(1) } { ptr addrspace(1) getelementptr inbounds inrange(-16, 8) ({ [3 x ptr addrspace(1)] }, ptr addrspace(1) @_ZTV1B, i32 0, i32 0, i32 2) }, align 8
// WITH-NONZERO-DEFAULT-AS: @_ZTI1A = external addrspace(1) constant ptr addrspace(1)
// WITH-NONZERO-DEFAULT-AS: @_ZTVN10__cxxabiv120__si_class_type_infoE = external addrspace(1) global [0 x ptr addrspace(1)]
// WITH-NONZERO-DEFAULT-AS: @_ZTS1B = linkonce_odr addrspace(1) constant [3 x i8] c"1B\00", comdat, align 1
// WITH-NONZERO-DEFAULT-AS: @_ZTI1B = linkonce_odr addrspace(1) constant { ptr addrspace(1), ptr addrspace(1), ptr addrspace(1) } { ptr addrspace(1) getelementptr inbounds (ptr addrspace(1), ptr addrspace(1) @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr addrspace(1) @_ZTS1B, ptr addrspace(1) @_ZTI1A }, comdat, align 8
//.
// CHECK-LABEL: define dso_local noundef nonnull align 8 dereferenceable(8) ptr @_Z1fP1A(
// CHECK-SAME: ptr noundef [[A:%.*]]) #[[ATTR0:[0-9]+]] personality ptr @__gxx_personality_v0 {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[RETVAL:%.*]] = alloca ptr, align 8, addrspace(5)
// CHECK-NEXT:    [[A_ADDR:%.*]] = alloca ptr, align 8, addrspace(5)
// CHECK-NEXT:    [[EXN_SLOT:%.*]] = alloca ptr, align 8, addrspace(5)
// CHECK-NEXT:    [[EHSELECTOR_SLOT:%.*]] = alloca i32, align 4, addrspace(5)
// CHECK-NEXT:    [[RETVAL_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[RETVAL]] to ptr
// CHECK-NEXT:    [[A_ADDR_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[A_ADDR]] to ptr
// CHECK-NEXT:    store ptr [[A]], ptr [[A_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[A_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = call ptr @__dynamic_cast(ptr [[TMP0]], ptr addrspace(1) @_ZTI1A, ptr addrspace(1) @_ZTI1B, i64 0) #[[ATTR3:[0-9]+]]
// CHECK-NEXT:    [[TMP2:%.*]] = icmp eq ptr [[TMP1]], null
// CHECK-NEXT:    br i1 [[TMP2]], label [[DYNAMIC_CAST_BAD_CAST:%.*]], label [[DYNAMIC_CAST_END:%.*]]
// CHECK:       dynamic_cast.bad_cast:
// CHECK-NEXT:    invoke void @__cxa_bad_cast() #[[ATTR4:[0-9]+]]
// CHECK-NEXT:            to label [[INVOKE_CONT:%.*]] unwind label [[LPAD:%.*]]
// CHECK:       invoke.cont:
// CHECK-NEXT:    unreachable
// CHECK:       dynamic_cast.end:
// CHECK-NEXT:    br label [[TRY_CONT:%.*]]
// CHECK:       lpad:
// CHECK-NEXT:    [[TMP3:%.*]] = landingpad { ptr, i32 }
// CHECK-NEXT:            catch ptr null
// CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { ptr, i32 } [[TMP3]], 0
// CHECK-NEXT:    store ptr [[TMP4]], ptr addrspace(5) [[EXN_SLOT]], align 8
// CHECK-NEXT:    [[TMP5:%.*]] = extractvalue { ptr, i32 } [[TMP3]], 1
// CHECK-NEXT:    store i32 [[TMP5]], ptr addrspace(5) [[EHSELECTOR_SLOT]], align 4
// CHECK-NEXT:    br label [[CATCH:%.*]]
// CHECK:       catch:
// CHECK-NEXT:    [[EXN:%.*]] = load ptr, ptr addrspace(5) [[EXN_SLOT]], align 8
// CHECK-NEXT:    [[TMP6:%.*]] = call ptr @__cxa_begin_catch(ptr [[EXN]]) #[[ATTR3]]
// CHECK-NEXT:    call void @__cxa_end_catch()
// CHECK-NEXT:    br label [[TRY_CONT]]
// CHECK:       try.cont:
// CHECK-NEXT:    ret ptr addrspacecast (ptr addrspace(1) @fail to ptr)
//
// WITH-NONZERO-DEFAULT-AS-LABEL: define spir_func noundef align 8 dereferenceable(8) ptr addrspace(4) @_Z1fP1A(
// WITH-NONZERO-DEFAULT-AS-SAME: ptr addrspace(4) noundef [[A:%.*]]) #[[ATTR0:[0-9]+]] personality ptr @__gxx_personality_v0 {
// WITH-NONZERO-DEFAULT-AS-NEXT:  entry:
// WITH-NONZERO-DEFAULT-AS-NEXT:    [[RETVAL:%.*]] = alloca ptr addrspace(4), align 8
// WITH-NONZERO-DEFAULT-AS-NEXT:    [[A_ADDR:%.*]] = alloca ptr addrspace(4), align 8
// WITH-NONZERO-DEFAULT-AS-NEXT:    [[EXN_SLOT:%.*]] = alloca ptr addrspace(4), align 8
// WITH-NONZERO-DEFAULT-AS-NEXT:    [[EHSELECTOR_SLOT:%.*]] = alloca i32, align 4
// WITH-NONZERO-DEFAULT-AS-NEXT:    [[RETVAL_ASCAST:%.*]] = addrspacecast ptr [[RETVAL]] to ptr addrspace(4)
// WITH-NONZERO-DEFAULT-AS-NEXT:    [[A_ADDR_ASCAST:%.*]] = addrspacecast ptr [[A_ADDR]] to ptr addrspace(4)
// WITH-NONZERO-DEFAULT-AS-NEXT:    store ptr addrspace(4) [[A]], ptr addrspace(4) [[A_ADDR_ASCAST]], align 8
// WITH-NONZERO-DEFAULT-AS-NEXT:    [[TMP0:%.*]] = load ptr addrspace(4), ptr addrspace(4) [[A_ADDR_ASCAST]], align 8
// WITH-NONZERO-DEFAULT-AS-NEXT:    [[TMP1:%.*]] = call spir_func ptr addrspace(4) @__dynamic_cast(ptr addrspace(4) [[TMP0]], ptr addrspace(1) @_ZTI1A, ptr addrspace(1) @_ZTI1B, i64 0) #[[ATTR3:[0-9]+]]
// WITH-NONZERO-DEFAULT-AS-NEXT:    [[TMP2:%.*]] = icmp eq ptr addrspace(4) [[TMP1]], null
// WITH-NONZERO-DEFAULT-AS-NEXT:    br i1 [[TMP2]], label [[DYNAMIC_CAST_BAD_CAST:%.*]], label [[DYNAMIC_CAST_END:%.*]]
// WITH-NONZERO-DEFAULT-AS:       dynamic_cast.bad_cast:
// WITH-NONZERO-DEFAULT-AS-NEXT:    invoke spir_func void @__cxa_bad_cast() #[[ATTR4:[0-9]+]]
// WITH-NONZERO-DEFAULT-AS-NEXT:            to label [[INVOKE_CONT:%.*]] unwind label [[LPAD:%.*]]
// WITH-NONZERO-DEFAULT-AS:       invoke.cont:
// WITH-NONZERO-DEFAULT-AS-NEXT:    unreachable
// WITH-NONZERO-DEFAULT-AS:       dynamic_cast.end:
// WITH-NONZERO-DEFAULT-AS-NEXT:    br label [[TRY_CONT:%.*]]
// WITH-NONZERO-DEFAULT-AS:       lpad:
// WITH-NONZERO-DEFAULT-AS-NEXT:    [[TMP3:%.*]] = landingpad { ptr addrspace(4), i32 }
// WITH-NONZERO-DEFAULT-AS-NEXT:            catch ptr addrspace(4) null
// WITH-NONZERO-DEFAULT-AS-NEXT:    [[TMP4:%.*]] = extractvalue { ptr addrspace(4), i32 } [[TMP3]], 0
// WITH-NONZERO-DEFAULT-AS-NEXT:    store ptr addrspace(4) [[TMP4]], ptr [[EXN_SLOT]], align 8
// WITH-NONZERO-DEFAULT-AS-NEXT:    [[TMP5:%.*]] = extractvalue { ptr addrspace(4), i32 } [[TMP3]], 1
// WITH-NONZERO-DEFAULT-AS-NEXT:    store i32 [[TMP5]], ptr [[EHSELECTOR_SLOT]], align 4
// WITH-NONZERO-DEFAULT-AS-NEXT:    br label [[CATCH:%.*]]
// WITH-NONZERO-DEFAULT-AS:       catch:
// WITH-NONZERO-DEFAULT-AS-NEXT:    [[EXN:%.*]] = load ptr addrspace(4), ptr [[EXN_SLOT]], align 8
// WITH-NONZERO-DEFAULT-AS-NEXT:    [[TMP6:%.*]] = call spir_func ptr addrspace(4) @__cxa_begin_catch(ptr addrspace(4) [[EXN]]) #[[ATTR3]]
// WITH-NONZERO-DEFAULT-AS-NEXT:    call spir_func void @__cxa_end_catch()
// WITH-NONZERO-DEFAULT-AS-NEXT:    br label [[TRY_CONT]]
// WITH-NONZERO-DEFAULT-AS:       try.cont:
// WITH-NONZERO-DEFAULT-AS-NEXT:    ret ptr addrspace(4) addrspacecast (ptr addrspace(1) @fail to ptr addrspace(4))
//
const B& f(A *a) {
  try {
    dynamic_cast<const B&>(*a);
  } catch (...) {
  }
  return fail;
}


//.
// CHECK: attributes #[[ATTR0]] = { mustprogress noinline optnone "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
// CHECK: attributes #[[ATTR1:[0-9]+]] = { nounwind willreturn memory(read) }
// CHECK: attributes #[[ATTR2:[0-9]+]] = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
// CHECK: attributes #[[ATTR3]] = { nounwind }
// CHECK: attributes #[[ATTR4]] = { noreturn }
//.
// WITH-NONZERO-DEFAULT-AS: attributes #[[ATTR0]] = { convergent mustprogress noinline norecurse nounwind optnone "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
// WITH-NONZERO-DEFAULT-AS: attributes #[[ATTR1:[0-9]+]] = { nounwind willreturn memory(read) }
// WITH-NONZERO-DEFAULT-AS: attributes #[[ATTR2:[0-9]+]] = { convergent nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
// WITH-NONZERO-DEFAULT-AS: attributes #[[ATTR3]] = { nounwind }
// WITH-NONZERO-DEFAULT-AS: attributes #[[ATTR4]] = { noreturn }
//.
// CHECK: [[META0:![0-9]+]] = !{i32 1, !"amdhsa_code_object_version", i32 500}
// CHECK: [[META1:![0-9]+]] = !{i32 1, !"wchar_size", i32 4}
// CHECK: [[META2:![0-9]+]] = !{!"{{.*}}clang version {{.*}}"}
//.
// WITH-NONZERO-DEFAULT-AS: [[META0:![0-9]+]] = !{i32 1, !"wchar_size", i32 4}
// WITH-NONZERO-DEFAULT-AS: [[META1:![0-9]+]] = !{!"{{.*}}clang version {{.*}}"}
//.

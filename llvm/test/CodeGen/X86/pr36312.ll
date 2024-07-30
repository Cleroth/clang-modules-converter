; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu | FileCheck %s

%struct.anon = type { i32, i32 }

@c = common dso_local global %struct.anon zeroinitializer, align 4
@d = dso_local local_unnamed_addr global ptr @c, align 8
@a = common dso_local local_unnamed_addr global i32 0, align 4
@b = common dso_local local_unnamed_addr global i32 0, align 4

; Function Attrs: norecurse nounwind uwtable
define  void @g() local_unnamed_addr #0 {
; CHECK-LABEL: g:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq d(%rip), %rax
; CHECK-NEXT:    movl 4(%rax), %eax
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    incl b(%rip)
; CHECK-NEXT:    setne %cl
; CHECK-NEXT:    addl %eax, %ecx
; CHECK-NEXT:    movl %ecx, a(%rip)
; CHECK-NEXT:    retq
entry:
  %0 = load ptr, ptr @d, align 8
  %y = getelementptr inbounds %struct.anon, ptr %0, i64 0, i32 1
  %1 = load i32, ptr %y, align 4
  %2 = load i32, ptr @b, align 4
  %inc = add nsw i32 %2, 1
  store i32 %inc, ptr @b, align 4
  %tobool = icmp ne i32 %inc, 0
  %land.ext = zext i1 %tobool to i32
  %add = add nsw i32 %1, %land.ext
  store i32 %add, ptr @a, align 4
  ret void
}

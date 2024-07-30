; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt -passes=function-attrs -S < %s | FileCheck --check-prefixes=COMMON,FNATTRS %s
; RUN: opt -passes=attributor-light -S < %s | FileCheck --check-prefixes=COMMON,ATTRIBUTOR %s

define void @bar(ptr readonly %0) {
; FNATTRS-LABEL: define void @bar(
; FNATTRS-SAME: ptr nocapture readnone [[TMP0:%.*]]) #[[ATTR0:[0-9]+]] {
; FNATTRS-NEXT:    call void @foo(ptr [[TMP0]])
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR-LABEL: define void @bar(
; ATTRIBUTOR-SAME: ptr nocapture nofree readnone [[TMP0:%.*]]) #[[ATTR0:[0-9]+]] {
; ATTRIBUTOR-NEXT:    call void @foo(ptr nocapture nofree readnone [[TMP0]]) #[[ATTR0]]
; ATTRIBUTOR-NEXT:    ret void
;
  call void @foo(ptr %0)
  ret void
}

define void @foo(ptr readonly %0) {
; FNATTRS-LABEL: define void @foo(
; FNATTRS-SAME: ptr nocapture readnone [[TMP0:%.*]]) #[[ATTR0]] {
; FNATTRS-NEXT:    call void @bar(ptr [[TMP0]])
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR-LABEL: define void @foo(
; ATTRIBUTOR-SAME: ptr nocapture nofree readnone [[TMP0:%.*]]) #[[ATTR0]] {
; ATTRIBUTOR-NEXT:    call void @bar(ptr nocapture nofree readnone [[TMP0]]) #[[ATTR0]]
; ATTRIBUTOR-NEXT:    ret void
;
  call void @bar(ptr %0)
  ret void
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; COMMON: {{.*}}

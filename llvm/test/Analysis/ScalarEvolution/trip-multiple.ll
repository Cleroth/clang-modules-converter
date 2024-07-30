; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -passes='print<scalar-evolution>,verify<scalar-evolution>' -disable-output %s 2>&1 | FileCheck %s

; Test trip multiples with functions that look like:

; void foo();
; void square(unsigned num) {
;     if (num % 5 == 0)
;     for (unsigned i = 0; i < num; ++i)
;         foo();
; }

declare void @foo(...)

define void @trip_multiple_3(i32 noundef %num) {
; CHECK-LABEL: 'trip_multiple_3'
; CHECK-NEXT:  Classifying expressions for: @trip_multiple_3
; CHECK-NEXT:    %rem = urem i32 %num, 3
; CHECK-NEXT:    --> ((-3 * (%num /u 3)) + %num) U: full-set S: full-set
; CHECK-NEXT:    %or.cond = and i1 %cmp, %cmp14
; CHECK-NEXT:    --> (%cmp14 umin %cmp) U: full-set S: full-set
; CHECK-NEXT:    %i.05 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><%for.body> U: [0,-1) S: [0,-1) Exits: (-1 + %num) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %inc = add nuw i32 %i.05, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%for.body> U: [1,0) S: [1,0) Exits: %num LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @trip_multiple_3
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + %num)
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is i32 -2
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + %num)
; CHECK-NEXT:  Loop %for.body: Trip multiple is 3
;
entry:
  %rem = urem i32 %num, 3
  %cmp = icmp eq i32 %rem, 0
  %cmp14 = icmp ne i32 %num, 0
  %or.cond = and i1 %cmp, %cmp14
  br i1 %or.cond, label %for.body, label %if.end

for.body:                                         ; preds = %entry, %for.body
  %i.05 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  tail call void (...) @foo() #2
  %inc = add nuw i32 %i.05, 1
  %exitcond.not = icmp eq i32 %inc, %num
  br i1 %exitcond.not, label %if.end, label %for.body

if.end:                                           ; preds = %for.body, %entry
  ret void
}
define void @trip_multiple_4(i32 noundef %num) {
; CHECK-LABEL: 'trip_multiple_4'
; CHECK-NEXT:  Classifying expressions for: @trip_multiple_4
; CHECK-NEXT:    %rem = urem i32 %num, 4
; CHECK-NEXT:    --> (zext i2 (trunc i32 %num to i2) to i32) U: [0,4) S: [0,4)
; CHECK-NEXT:    %or.cond = and i1 %cmp, %cmp14
; CHECK-NEXT:    --> (%cmp14 umin %cmp) U: full-set S: full-set
; CHECK-NEXT:    %i.05 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><%for.body> U: [0,-4) S: [0,-4) Exits: (-1 + %num) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %inc = add nuw i32 %i.05, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%for.body> U: [1,-3) S: [1,-3) Exits: %num LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @trip_multiple_4
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + %num)
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is i32 -5
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + %num)
; CHECK-NEXT:  Loop %for.body: Trip multiple is 4
;
entry:
  %rem = urem i32 %num, 4
  %cmp = icmp eq i32 %rem, 0
  %cmp14 = icmp ne i32 %num, 0
  %or.cond = and i1 %cmp, %cmp14
  br i1 %or.cond, label %for.body, label %if.end

for.body:                                         ; preds = %entry, %for.body
  %i.05 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  tail call void (...) @foo() #2
  %inc = add nuw i32 %i.05, 1
  %exitcond.not = icmp eq i32 %inc, %num
  br i1 %exitcond.not, label %if.end, label %for.body

if.end:                                           ; preds = %for.body, %entry
  ret void
}

define void @trip_multiple_5(i32 noundef %num) {
; CHECK-LABEL: 'trip_multiple_5'
; CHECK-NEXT:  Classifying expressions for: @trip_multiple_5
; CHECK-NEXT:    %rem = urem i32 %num, 5
; CHECK-NEXT:    --> ((-5 * (%num /u 5)) + %num) U: full-set S: full-set
; CHECK-NEXT:    %or.cond = and i1 %cmp, %cmp14
; CHECK-NEXT:    --> (%cmp14 umin %cmp) U: full-set S: full-set
; CHECK-NEXT:    %i.05 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><%for.body> U: [0,-1) S: [0,-1) Exits: (-1 + %num) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %inc = add nuw i32 %i.05, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%for.body> U: [1,0) S: [1,0) Exits: %num LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @trip_multiple_5
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + %num)
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is i32 -2
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + %num)
; CHECK-NEXT:  Loop %for.body: Trip multiple is 5
;
entry:
  %rem = urem i32 %num, 5
  %cmp = icmp eq i32 %rem, 0
  %cmp14 = icmp ne i32 %num, 0
  %or.cond = and i1 %cmp, %cmp14
  br i1 %or.cond, label %for.body, label %if.end

for.body:                                         ; preds = %entry, %for.body
  %i.05 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  tail call void (...) @foo() #2
  %inc = add nuw i32 %i.05, 1
  %exitcond.not = icmp eq i32 %inc, %num
  br i1 %exitcond.not, label %if.end, label %for.body

if.end:                                           ; preds = %for.body, %entry
  ret void
}

define void @trip_multiple_6(i32 noundef %num) {
; CHECK-LABEL: 'trip_multiple_6'
; CHECK-NEXT:  Classifying expressions for: @trip_multiple_6
; CHECK-NEXT:    %rem = urem i32 %num, 6
; CHECK-NEXT:    --> ((-6 * (%num /u 6)) + %num) U: full-set S: full-set
; CHECK-NEXT:    %or.cond = and i1 %cmp, %cmp14
; CHECK-NEXT:    --> (%cmp14 umin %cmp) U: full-set S: full-set
; CHECK-NEXT:    %i.05 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><%for.body> U: [0,-4) S: [0,-4) Exits: (-1 + %num) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %inc = add nuw i32 %i.05, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%for.body> U: [1,-3) S: [1,-3) Exits: %num LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @trip_multiple_6
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + %num)
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is i32 -5
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + %num)
; CHECK-NEXT:  Loop %for.body: Trip multiple is 6
;
entry:
  %rem = urem i32 %num, 6
  %cmp = icmp eq i32 %rem, 0
  %cmp14 = icmp ne i32 %num, 0
  %or.cond = and i1 %cmp, %cmp14
  br i1 %or.cond, label %for.body, label %if.end

for.body:                                         ; preds = %entry, %for.body
  %i.05 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  tail call void (...) @foo() #2
  %inc = add nuw i32 %i.05, 1
  %exitcond.not = icmp eq i32 %inc, %num
  br i1 %exitcond.not, label %if.end, label %for.body

if.end:                                           ; preds = %for.body, %entry
  ret void
}

define void @trip_multiple_7(i32 noundef %num) {
; CHECK-LABEL: 'trip_multiple_7'
; CHECK-NEXT:  Classifying expressions for: @trip_multiple_7
; CHECK-NEXT:    %rem = urem i32 %num, 7
; CHECK-NEXT:    --> ((-7 * (%num /u 7)) + %num) U: full-set S: full-set
; CHECK-NEXT:    %or.cond = and i1 %cmp, %cmp14
; CHECK-NEXT:    --> (%cmp14 umin %cmp) U: full-set S: full-set
; CHECK-NEXT:    %i.05 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><%for.body> U: [0,-4) S: [0,-4) Exits: (-1 + %num) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %inc = add nuw i32 %i.05, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%for.body> U: [1,-3) S: [1,-3) Exits: %num LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @trip_multiple_7
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + %num)
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is i32 -5
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + %num)
; CHECK-NEXT:  Loop %for.body: Trip multiple is 7
;
entry:
  %rem = urem i32 %num, 7
  %cmp = icmp eq i32 %rem, 0
  %cmp14 = icmp ne i32 %num, 0
  %or.cond = and i1 %cmp, %cmp14
  br i1 %or.cond, label %for.body, label %if.end

for.body:                                         ; preds = %entry, %for.body
  %i.05 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  tail call void (...) @foo() #2
  %inc = add nuw i32 %i.05, 1
  %exitcond.not = icmp eq i32 %inc, %num
  br i1 %exitcond.not, label %if.end, label %for.body

if.end:                                           ; preds = %for.body, %entry
  ret void
}

define void @trip_multiple_8(i32 noundef %num) {
; CHECK-LABEL: 'trip_multiple_8'
; CHECK-NEXT:  Classifying expressions for: @trip_multiple_8
; CHECK-NEXT:    %rem = urem i32 %num, 8
; CHECK-NEXT:    --> (zext i3 (trunc i32 %num to i3) to i32) U: [0,8) S: [0,8)
; CHECK-NEXT:    %or.cond = and i1 %cmp, %cmp14
; CHECK-NEXT:    --> (%cmp14 umin %cmp) U: full-set S: full-set
; CHECK-NEXT:    %i.05 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><%for.body> U: [0,-8) S: [0,-8) Exits: (-1 + %num) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %inc = add nuw i32 %i.05, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%for.body> U: [1,-7) S: [1,-7) Exits: %num LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @trip_multiple_8
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + %num)
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is i32 -9
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + %num)
; CHECK-NEXT:  Loop %for.body: Trip multiple is 8
;
entry:
  %rem = urem i32 %num, 8
  %cmp = icmp eq i32 %rem, 0
  %cmp14 = icmp ne i32 %num, 0
  %or.cond = and i1 %cmp, %cmp14
  br i1 %or.cond, label %for.body, label %if.end

for.body:                                         ; preds = %entry, %for.body
  %i.05 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  tail call void (...) @foo() #2
  %inc = add nuw i32 %i.05, 1
  %exitcond.not = icmp eq i32 %inc, %num
  br i1 %exitcond.not, label %if.end, label %for.body

if.end:                                           ; preds = %for.body, %entry
  ret void
}
define void @trip_multiple_9(i32 noundef %num) {
; CHECK-LABEL: 'trip_multiple_9'
; CHECK-NEXT:  Classifying expressions for: @trip_multiple_9
; CHECK-NEXT:    %rem = urem i32 %num, 9
; CHECK-NEXT:    --> ((-9 * (%num /u 9)) + %num) U: full-set S: full-set
; CHECK-NEXT:    %or.cond = and i1 %cmp, %cmp14
; CHECK-NEXT:    --> (%cmp14 umin %cmp) U: full-set S: full-set
; CHECK-NEXT:    %i.05 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><%for.body> U: [0,-4) S: [0,-4) Exits: (-1 + %num) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %inc = add nuw i32 %i.05, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%for.body> U: [1,-3) S: [1,-3) Exits: %num LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @trip_multiple_9
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + %num)
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is i32 -5
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + %num)
; CHECK-NEXT:  Loop %for.body: Trip multiple is 9
;
entry:
  %rem = urem i32 %num, 9
  %cmp = icmp eq i32 %rem, 0
  %cmp14 = icmp ne i32 %num, 0
  %or.cond = and i1 %cmp, %cmp14
  br i1 %or.cond, label %for.body, label %if.end

for.body:                                         ; preds = %entry, %for.body
  %i.05 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  tail call void (...) @foo() #2
  %inc = add nuw i32 %i.05, 1
  %exitcond.not = icmp eq i32 %inc, %num
  br i1 %exitcond.not, label %if.end, label %for.body

if.end:                                           ; preds = %for.body, %entry
  ret void
}
define void @trip_multiple_10(i32 noundef %num) {
; CHECK-LABEL: 'trip_multiple_10'
; CHECK-NEXT:  Classifying expressions for: @trip_multiple_10
; CHECK-NEXT:    %rem = urem i32 %num, 10
; CHECK-NEXT:    --> ((-10 * (%num /u 10)) + %num) U: full-set S: full-set
; CHECK-NEXT:    %or.cond = and i1 %cmp, %cmp14
; CHECK-NEXT:    --> (%cmp14 umin %cmp) U: full-set S: full-set
; CHECK-NEXT:    %i.05 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><%for.body> U: [0,-6) S: [0,-6) Exits: (-1 + %num) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %inc = add nuw i32 %i.05, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%for.body> U: [1,-5) S: [1,-5) Exits: %num LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @trip_multiple_10
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + %num)
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is i32 -7
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + %num)
; CHECK-NEXT:  Loop %for.body: Trip multiple is 10
;
entry:
  %rem = urem i32 %num, 10
  %cmp = icmp eq i32 %rem, 0
  %cmp14 = icmp ne i32 %num, 0
  %or.cond = and i1 %cmp, %cmp14
  br i1 %or.cond, label %for.body, label %if.end

for.body:                                         ; preds = %entry, %for.body
  %i.05 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  tail call void (...) @foo() #2
  %inc = add nuw i32 %i.05, 1
  %exitcond.not = icmp eq i32 %inc, %num
  br i1 %exitcond.not, label %if.end, label %for.body

if.end:                                           ; preds = %for.body, %entry
  ret void
}

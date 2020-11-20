; ModuleID = 'slash/main.a.i.p.s.r.i.h.p.s.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"one\00", align 1
@.str.1 = private constant [4 x i8] c"two\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"three\00", align 1
@.str.3 = private unnamed_addr constant [17 x i8] c"Final retval=%d\0A\00", align 1
@new_argv = private constant [5 x i8] c"main\00"

; Function Attrs: nounwind readonly
declare dso_local i64 @strlen(i8*) local_unnamed_addr #0

; Function Attrs: nounwind readonly
declare dso_local i32 @strncmp(i8*, i8*, i64) local_unnamed_addr #0

declare dso_local i32 @printf(i8*, ...) local_unnamed_addr #1

define i32 @main(i32 %0, i8** nocapture readonly %1) local_unnamed_addr {
entry:
  %2 = icmp eq i32 %0, 1
  br i1 %2, label %entry1, label %incorrect_argc

entry1:                                           ; preds = %entry
  %malloccall = tail call i8* @malloc(i64 24)
  %3 = bitcast i8* %malloccall to i8**
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv, i64 0, i64 0), i8** %3, align 8
  %4 = getelementptr i8, i8* %malloccall, i64 8
  %5 = bitcast i8* %4 to i8**
  store i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), i8** %5, align 8
  %6 = getelementptr inbounds i8, i8* %malloccall, i64 16
  %7 = bitcast i8* %6 to i8**
  store i8* null, i8** %7, align 8
  %8 = tail call i64 @strlen(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0)) #2
  %9 = tail call i64 @strlen(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0)) #2
  %10 = icmp ult i64 %8, %9
  %. = select i1 %10, i64 %8, i64 %9
  %sext = shl i64 %., 32
  %11 = ashr exact i64 %sext, 32
  %12 = tail call i32 @strncmp(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i64 %11) #2
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %if.true.direct_targ, label %14

incorrect_argc:                                   ; preds = %entry
  ret i32 1

14:                                               ; preds = %entry1
  %sext8 = shl i64 %8, 32
  %15 = ashr exact i64 %sext8, 32
  %16 = tail call i32 @strncmp(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), i64 %15) #2
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %if.false.orig_indirect2, label %18

18:                                               ; preds = %14
  %19 = tail call i64 @strlen(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0)) #2
  %20 = icmp ult i64 %8, %19
  %.11 = select i1 %20, i64 %8, i64 %19
  %sext9 = shl i64 %.11, 32
  %21 = ashr exact i64 %sext9, 32
  %22 = tail call i32 @strncmp(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i64 %21) #2
  %23 = icmp eq i32 %22, 0
  br i1 %23, label %if.true.direct_targ1, label %.exit

if.true.direct_targ:                              ; preds = %entry1
  %24 = tail call i32 @"__occam_spec.add_one(0x5,0x2)"()
  br label %.exit

if.true.direct_targ1:                             ; preds = %18
  %25 = tail call i32 @"__occam_spec.add_three(0x5,0x2)"()
  br label %.exit

if.false.orig_indirect2:                          ; preds = %14
  %26 = tail call i32 @"__occam_spec.add_two(0x5,0x2)"()
  br label %.exit

.exit:                                            ; preds = %if.true.direct_targ, %if.false.orig_indirect2, %if.true.direct_targ1, %18
  %.01.i = phi i32 [ 0, %18 ], [ %24, %if.true.direct_targ ], [ %26, %if.false.orig_indirect2 ], [ %25, %if.true.direct_targ1 ]
  %27 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.3, i64 0, i64 0), i32 %.01.i) #3
  ret i32 %.01.i
}

declare noalias i8* @malloc(i64) local_unnamed_addr

declare i32 @"__occam_spec.add_one(0x5,0x2)"() local_unnamed_addr

declare i32 @"__occam_spec.add_three(0x5,0x2)"() local_unnamed_addr

declare i32 @"__occam_spec.add_two(0x5,0x2)"() local_unnamed_addr

attributes #0 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

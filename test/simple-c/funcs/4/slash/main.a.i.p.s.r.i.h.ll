; ModuleID = 'slash/main.a.i.p.s.r.i.h.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@str = private unnamed_addr constant [20 x i8] c"add_three is called\00", align 1
@.str.3 = private unnamed_addr constant [17 x i8] c"Final retval=%d\0A\00", align 1
@new_argv = private constant [5 x i8] c"main\00"
@new_argv.1 = private constant [2 x i8] c"1\00"
@new_argv.2 = private constant [2 x i8] c"5\00"
@new_argv.3 = private constant [3 x i8] c"10\00"

declare dso_local i32 @add_three(i32, i32) local_unnamed_addr #0

; Function Attrs: nofree nounwind
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

define i32 @main(i32 %0, i8** nocapture readonly %1) local_unnamed_addr {
entry:
  %2 = icmp eq i32 %0, 1
  br i1 %2, label %entry1, label %incorrect_argc

entry1:                                           ; preds = %entry
  %malloccall = tail call i8* @malloc(i64 40)
  %3 = bitcast i8* %malloccall to i8**
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv, i64 0, i64 0), i8** %3, align 8
  %4 = getelementptr i8, i8* %malloccall, i64 8
  %5 = bitcast i8* %4 to i8**
  store i8* getelementptr inbounds ([2 x i8], [2 x i8]* @new_argv.1, i64 0, i64 0), i8** %5, align 8
  %6 = getelementptr i8, i8* %malloccall, i64 16
  %7 = bitcast i8* %6 to i8**
  store i8* getelementptr inbounds ([2 x i8], [2 x i8]* @new_argv.2, i64 0, i64 0), i8** %7, align 8
  %8 = getelementptr i8, i8* %malloccall, i64 24
  %9 = bitcast i8* %8 to i8**
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @new_argv.3, i64 0, i64 0), i8** %9, align 8
  %10 = getelementptr inbounds i8, i8* %malloccall, i64 32
  %11 = bitcast i8* %10 to i8**
  store i8* null, i8** %11, align 8
  %12 = tail call i32 @"__occam_spec.add_three(0x8,0x4)"()
  %13 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([20 x i8], [20 x i8]* @str, i64 0, i64 0)) #3
  %14 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([17 x i8], [17 x i8]* @.str.3, i64 0, i64 0), i32 %12) #3
  ret i32 %12

incorrect_argc:                                   ; preds = %entry
  ret i32 1
}

declare noalias i8* @malloc(i64) local_unnamed_addr

declare i32 @"__occam_spec.add_three(0x8,0x4)"()

attributes #0 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nounwind }
attributes #2 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

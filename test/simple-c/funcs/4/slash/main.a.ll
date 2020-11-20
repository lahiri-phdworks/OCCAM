; ModuleID = 'slash/main.a.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@str.5 = private unnamed_addr constant [18 x i8] c"add_one is called\00", align 1
@str = private unnamed_addr constant [20 x i8] c"add_three is called\00", align 1
@str.4 = private unnamed_addr constant [18 x i8] c"add_two is called\00", align 1
@.str.3 = private unnamed_addr constant [17 x i8] c"Final retval=%d\0A\00", align 1
@new_argv = private constant [5 x i8] c"main\00"
@new_argv.1 = private constant [2 x i8] c"1\00"
@new_argv.2 = private constant [2 x i8] c"5\00"
@new_argv.3 = private constant [3 x i8] c"10\00"

; Function Attrs: alwaysinline nofree norecurse nounwind uwtable writeonly
define dso_local void @init_callbacks(i32 (i32, i32)** nocapture %0) local_unnamed_addr #0 {
  store i32 (i32, i32)* @add_one, i32 (i32, i32)** %0, align 8, !tbaa !2
  %2 = getelementptr inbounds i32 (i32, i32)*, i32 (i32, i32)** %0, i64 1
  store i32 (i32, i32)* @add_two, i32 (i32, i32)** %2, align 8, !tbaa !2
  %3 = getelementptr inbounds i32 (i32, i32)*, i32 (i32, i32)** %0, i64 2
  store i32 (i32, i32)* @add_three, i32 (i32, i32)** %3, align 8, !tbaa !2
  ret void
}

declare dso_local i32 @add_one(i32, i32) #1

declare dso_local i32 @add_two(i32, i32) #1

declare dso_local i32 @add_three(i32, i32) #1

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @0(i32 %0, i8** nocapture readnone %1) local_unnamed_addr #2 {
  switch i32 %0, label %13 [
    i32 4, label %7
    i32 2, label %3
    i32 3, label %5
  ]

3:                                                ; preds = %2
  %4 = tail call i32 @add_one(i32 4, i32 2) #6
  br label %9

5:                                                ; preds = %2
  %6 = tail call i32 @add_two(i32 6, i32 3) #6
  br label %9

7:                                                ; preds = %2
  %8 = tail call i32 @add_three(i32 8, i32 4) #6
  br label %9

9:                                                ; preds = %5, %7, %3
  %10 = phi i8* [ getelementptr inbounds ([18 x i8], [18 x i8]* @str.5, i64 0, i64 0), %3 ], [ getelementptr inbounds ([20 x i8], [20 x i8]* @str, i64 0, i64 0), %7 ], [ getelementptr inbounds ([18 x i8], [18 x i8]* @str.4, i64 0, i64 0), %5 ]
  %11 = phi i32 [ %4, %3 ], [ %8, %7 ], [ %6, %5 ]
  %12 = tail call i32 @puts(i8* nonnull dereferenceable(1) %10)
  br label %13

13:                                               ; preds = %9, %2
  %14 = phi i32 [ 0, %2 ], [ %11, %9 ]
  %15 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([17 x i8], [17 x i8]* @.str.3, i64 0, i64 0), i32 %14)
  ret i32 %14
}

; Function Attrs: nofree nounwind
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #4

define i32 @main(i32 %0, i8** %1) {
entry:
  %2 = icmp eq i32 %0, 1
  br i1 %2, label %entry1, label %incorrect_argc

entry1:                                           ; preds = %entry
  %new_argc = add i32 %0, 3
  %3 = icmp eq i32 %0, 1
  call void @llvm.assume(i1 %3)
  %4 = add i32 %new_argc, 1
  %5 = sext i32 %4 to i64
  %mallocsize = mul i64 %5, 8
  %malloccall = tail call i8* @malloc(i64 %mallocsize)
  %6 = bitcast i8* %malloccall to i8**
  %7 = getelementptr i8*, i8** %6, i32 0
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv, i32 0, i32 0), i8** %7
  %8 = getelementptr i8*, i8** %6, i32 1
  store i8* getelementptr inbounds ([2 x i8], [2 x i8]* @new_argv.1, i32 0, i32 0), i8** %8
  %9 = getelementptr i8*, i8** %6, i32 2
  store i8* getelementptr inbounds ([2 x i8], [2 x i8]* @new_argv.2, i32 0, i32 0), i8** %9
  %10 = getelementptr i8*, i8** %6, i32 3
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @new_argv.3, i32 0, i32 0), i8** %10
  %11 = getelementptr inbounds i8*, i8** %6, i32 %new_argc
  store i8* null, i8** %11
  br label %pre_header

incorrect_argc:                                   ; preds = %entry
  ret i32 1

pre_header:                                       ; preds = %entry1
  %12 = alloca i32
  store i32 1, i32* %12
  br label %header

header:                                           ; preds = %body, %pre_header
  %13 = load i32, i32* %12
  %14 = icmp slt i32 %13, %0
  br i1 %14, label %body, label %tail

body:                                             ; preds = %header
  %15 = add i32 3, %13
  %16 = zext i32 %15 to i64
  %17 = getelementptr inbounds i8*, i8** %6, i64 %16
  %18 = zext i32 %13 to i64
  %19 = getelementptr inbounds i8*, i8** %1, i64 %18
  %20 = load i8*, i8** %19
  store i8* %20, i8** %17
  %21 = add i32 %13, 1
  store i32 %21, i32* %12
  br label %header

tail:                                             ; preds = %header
  switch i32 %new_argc, label %.exit [
    i32 4, label %26
    i32 2, label %22
    i32 3, label %24
  ]

22:                                               ; preds = %tail
  %23 = call i32 @add_one(i32 4, i32 2) #6
  br label %28

24:                                               ; preds = %tail
  %25 = call i32 @add_two(i32 6, i32 3) #6
  br label %28

26:                                               ; preds = %tail
  %27 = call i32 @add_three(i32 8, i32 4) #6
  br label %28

28:                                               ; preds = %26, %24, %22
  %29 = phi i8* [ getelementptr inbounds ([18 x i8], [18 x i8]* @str.5, i64 0, i64 0), %22 ], [ getelementptr inbounds ([20 x i8], [20 x i8]* @str, i64 0, i64 0), %26 ], [ getelementptr inbounds ([18 x i8], [18 x i8]* @str.4, i64 0, i64 0), %24 ]
  %30 = phi i32 [ %23, %22 ], [ %27, %26 ], [ %25, %24 ]
  %31 = call i32 @puts(i8* nonnull dereferenceable(1) %29) #6
  br label %.exit

.exit:                                            ; preds = %tail, %28
  %32 = phi i32 [ 0, %tail ], [ %30, %28 ]
  %33 = call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([17 x i8], [17 x i8]* @.str.3, i64 0, i64 0), i32 %32) #6
  ret i32 %32
}

; Function Attrs: nounwind willreturn
declare void @llvm.assume(i1) #5

declare noalias i8* @malloc(i64)

attributes #0 = { alwaysinline nofree norecurse nounwind uwtable writeonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nofree nounwind }
attributes #4 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind willreturn }
attributes #6 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{!3, !3, i64 0}
!3 = !{!"any pointer", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}

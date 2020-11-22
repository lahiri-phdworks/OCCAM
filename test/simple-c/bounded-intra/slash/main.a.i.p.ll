; ModuleID = 'slash/main.a.i.p.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [16 x i8] c"%d %d %d %d %d\0A\00", align 1
@new_argv = private constant [5 x i8] c"main\00"
@new_argv.1 = private constant [5 x i8] c"8181\00"

; Function Attrs: noinline nounwind uwtable
define internal fastcc i32 @nd_int() unnamed_addr #0 {
  %1 = tail call i64 @time(i64* null) #3
  %2 = trunc i64 %1 to i32
  tail call void @srand(i32 %2) #3
  %3 = tail call i32 @rand() #3
  ret i32 %3
}

; Function Attrs: nounwind
declare dso_local i64 @time(i64*) local_unnamed_addr #1

; Function Attrs: nounwind
declare dso_local void @srand(i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare dso_local i32 @rand() local_unnamed_addr #1

; Function Attrs: noinline nounwind uwtable
define internal fastcc i32 @libcall(i32 %0) unnamed_addr #0 {
  switch i32 %0, label %11 [
    i32 0, label %2
    i32 1, label %5
    i32 2, label %8
  ]

2:                                                ; preds = %1
  %3 = tail call fastcc i32 @nd_int()
  %4 = add nsw i32 %3, 1
  br label %13

5:                                                ; preds = %1
  %6 = tail call fastcc i32 @nd_int()
  %7 = add nsw i32 %6, 2
  br label %13

8:                                                ; preds = %1
  %9 = tail call fastcc i32 @nd_int()
  %10 = add nsw i32 %9, 3
  br label %13

11:                                               ; preds = %1
  %12 = tail call fastcc i32 @nd_int()
  br label %13

13:                                               ; preds = %11, %8, %5, %2
  %.0 = phi i32 [ %4, %2 ], [ %7, %5 ], [ %10, %8 ], [ %12, %11 ]
  ret i32 %.0
}

declare dso_local i32 @printf(i8*, ...) local_unnamed_addr #2

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
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv.1, i64 0, i64 0), i8** %5, align 8
  %6 = getelementptr inbounds i8, i8* %malloccall, i64 16
  %7 = bitcast i8* %6 to i8**
  store i8* null, i8** %7, align 8
  %8 = tail call fastcc i32 @nd_int() #3
  %9 = tail call fastcc i32 @nd_int() #3
  %10 = tail call fastcc i32 @libcall(i32 %8) #3
  %11 = tail call fastcc i32 @libcall(i32 1) #3
  %12 = tail call fastcc i32 @libcall(i32 3) #3
  %13 = tail call fastcc i32 @"__occam_spec.libcall(0x5)"()
  %14 = tail call fastcc i32 @"__occam_spec.libcall(0x7)"()
  %15 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str, i64 0, i64 0), i32 %10, i32 %11, i32 %12, i32 %13, i32 %14) #3
  ret i32 0

incorrect_argc:                                   ; preds = %entry
  ret i32 1
}

declare noalias i8* @malloc(i64) local_unnamed_addr

; Function Attrs: noinline nounwind uwtable
define internal fastcc i32 @"__occam_spec.libcall(0x7)"() unnamed_addr #0 {
  %1 = tail call fastcc i32 @nd_int()
  ret i32 %1
}

; Function Attrs: noinline nounwind uwtable
define internal fastcc i32 @"__occam_spec.libcall(0x5)"() unnamed_addr #0 {
  %1 = tail call fastcc i32 @nd_int()
  ret i32 %1
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

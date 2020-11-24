; ModuleID = 'slash/main.o.a.i.p.i.h.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@.str = private unnamed_addr constant [2 x i8] c"Z\00", align 1
@stderr = external dso_local local_unnamed_addr global %struct._IO_FILE*, align 8
@.str.1 = private unnamed_addr constant [19 x i8] c"main returning %d\0A\00", align 1
@new_argv = private constant [5 x i8] c"main\00"
@new_argv.1 = private constant [5 x i8] c"8181\00"

; Function Attrs: alwaysinline nounwind uwtable
define internal i32 @0(i32 %0, i8** nocapture readonly %1) #0 {
  %3 = icmp eq i32 %0, 2
  br i1 %3, label %6, label %4

4:                                                ; preds = %2
  %5 = tail call i32 @libcall(i32 %0, i32 %0) #3
  br label %23

6:                                                ; preds = %2
  %7 = getelementptr inbounds i8*, i8** %1, i64 1
  %8 = load i8*, i8** %7, align 8
  %9 = tail call i64 @atol(i8* %8) #4
  %10 = trunc i64 %9 to i32
  %11 = tail call i32 @libcall(i32 %10, i32 1) #3
  %12 = load i8*, i8** %7, align 8
  %13 = tail call i64 @atol(i8* %12) #4
  %14 = trunc i64 %13 to i32
  %15 = tail call i32 @libcall(i32 %14, i32 2) #3
  %16 = mul nsw i32 %15, %11
  %17 = tail call i32 @internal_api(i32 3, i8* bitcast (i32 (i32, i8**)* @0 to i8*), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0)) #3
  %18 = mul nsw i32 %16, %17
  %19 = tail call i32 @internal_api(i32 4, i8* null, i8* bitcast (i32 (i32, i8**)* @0 to i8*)) #3
  %20 = mul nsw i32 %18, %19
  %21 = tail call i32 @internal_api(i32 5, i8* bitcast (i32 (i32, i8**)* @0 to i8*), i8* bitcast (i32 (i32, i8**)* @0 to i8*)) #3
  %22 = mul nsw i32 %20, %21
  br label %23

23:                                               ; preds = %6, %4
  %.0 = phi i32 [ %5, %4 ], [ %22, %6 ]
  %24 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %25 = tail call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %24, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i64 0, i64 0), i32 %.0) #3
  ret i32 %.0
}

declare dso_local i32 @libcall(i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind readonly
declare dso_local i64 @atol(i8*) local_unnamed_addr #2

declare dso_local i32 @internal_api(i32, i8*, i8*) local_unnamed_addr #1

declare dso_local i32 @fprintf(%struct._IO_FILE*, i8*, ...) local_unnamed_addr #1

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
  %8 = tail call i64 @atol(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv.1, i64 0, i64 0)) #4
  %9 = trunc i64 %8 to i32
  %10 = tail call i32 @libcall(i32 %9, i32 1) #3
  %11 = tail call i64 @atol(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv.1, i64 0, i64 0)) #4
  %12 = trunc i64 %11 to i32
  %13 = tail call i32 @libcall(i32 %12, i32 2) #3
  %14 = mul nsw i32 %13, %10
  %15 = tail call i32 @internal_api(i32 3, i8* bitcast (i32 (i32, i8**)* @0 to i8*), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0)) #3
  %16 = mul nsw i32 %14, %15
  %17 = tail call i32 @internal_api(i32 4, i8* null, i8* bitcast (i32 (i32, i8**)* @0 to i8*)) #3
  %18 = mul nsw i32 %16, %17
  %19 = tail call i32 @internal_api(i32 5, i8* bitcast (i32 (i32, i8**)* @0 to i8*), i8* bitcast (i32 (i32, i8**)* @0 to i8*)) #3
  %20 = mul nsw i32 %18, %19
  %21 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %22 = tail call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %21, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i64 0, i64 0), i32 %20) #3
  ret i32 %20

incorrect_argc:                                   ; preds = %entry
  ret i32 1
}

declare noalias i8* @malloc(i64) local_unnamed_addr

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

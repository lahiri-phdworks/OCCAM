; ModuleID = 'slash/main.a.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [13 x i8] c"%d %d %d %d\0A\00", align 1
@new_argv = private constant [5 x i8] c"main\00"
@new_argv.1 = private constant [5 x i8] c"8181\00"

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @0(i32 %0, i8** %1) #0 {
  %3 = call i32 @libcall1(i32 1, i32 2)
  %4 = call i32 @libcall2(i32 3, i32 4)
  %5 = call i32 @libcall1(i32 5, i32 6)
  %6 = call i32 @libcall1(i32 7, i32 8)
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i64 0, i64 0), i32 %3, i32 %4, i32 %5, i32 %6)
  ret i32 0
}

declare dso_local i32 @libcall1(i32, i32) #1

declare dso_local i32 @libcall2(i32, i32) #1

declare dso_local i32 @printf(i8*, ...) #1

define i32 @main(i32 %0, i8** %1) {
entry:
  %2 = icmp eq i32 %0, 1
  br i1 %2, label %entry1, label %incorrect_argc

entry1:                                           ; preds = %entry
  %new_argc = add i32 %0, 1
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
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv.1, i32 0, i32 0), i8** %8
  %9 = getelementptr inbounds i8*, i8** %6, i32 %new_argc
  store i8* null, i8** %9
  br label %pre_header

incorrect_argc:                                   ; preds = %entry
  ret i32 1

pre_header:                                       ; preds = %entry1
  %10 = alloca i32
  store i32 1, i32* %10
  br label %header

header:                                           ; preds = %body, %pre_header
  %11 = load i32, i32* %10
  %12 = icmp slt i32 %11, %0
  br i1 %12, label %body, label %tail

body:                                             ; preds = %header
  %13 = add i32 1, %11
  %14 = zext i32 %13 to i64
  %15 = getelementptr inbounds i8*, i8** %6, i64 %14
  %16 = zext i32 %11 to i64
  %17 = getelementptr inbounds i8*, i8** %1, i64 %16
  %18 = load i8*, i8** %17
  store i8* %18, i8** %15
  %19 = add i32 %11, 1
  store i32 %19, i32* %10
  br label %header

tail:                                             ; preds = %header
  %20 = call i32 @libcall1(i32 1, i32 2) #3
  %21 = call i32 @libcall2(i32 3, i32 4) #3
  %22 = call i32 @libcall1(i32 5, i32 6) #3
  %23 = call i32 @libcall1(i32 7, i32 8) #3
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i64 0, i64 0), i32 %20, i32 %21, i32 %22, i32 %23) #3
  ret i32 0
}

; Function Attrs: nounwind willreturn
declare void @llvm.assume(i1) #2

declare noalias i8* @malloc(i64)

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind willreturn }
attributes #3 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

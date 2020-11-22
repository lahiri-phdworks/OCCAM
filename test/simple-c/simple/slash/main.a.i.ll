; ModuleID = 'slash/main.a.i.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@stderr = external dso_local global %struct._IO_FILE*, align 8
@.str = private unnamed_addr constant [19 x i8] c"main returning %d\0A\00", align 1
@new_argv = private constant [5 x i8] c"main\00"
@new_argv.1 = private constant [5 x i8] c"8181\00"

declare dso_local i32 @libcall(i32, i32) #0

; Function Attrs: nounwind readonly
declare dso_local i64 @atol(i8*) #1

declare dso_local i32 @fprintf(%struct._IO_FILE*, i8*, ...) #0

define i32 @main(i32 %0, i8** %1) {
entry:
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i8**, align 8
  %5 = alloca i32, align 4
  %6 = icmp eq i32 %0, 1
  br i1 %6, label %entry1, label %incorrect_argc

entry1:                                           ; preds = %entry
  %new_argc = add i32 %0, 1
  %7 = icmp eq i32 %0, 1
  call void @llvm.assume(i1 %7)
  %8 = add i32 %new_argc, 1
  %9 = sext i32 %8 to i64
  %mallocsize = mul i64 %9, 8
  %malloccall = tail call i8* @malloc(i64 %mallocsize)
  %10 = bitcast i8* %malloccall to i8**
  %11 = getelementptr i8*, i8** %10, i32 0
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv, i32 0, i32 0), i8** %11
  %12 = getelementptr i8*, i8** %10, i32 1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv.1, i32 0, i32 0), i8** %12
  %13 = getelementptr inbounds i8*, i8** %10, i32 %new_argc
  store i8* null, i8** %13
  br label %pre_header

incorrect_argc:                                   ; preds = %entry
  ret i32 1

pre_header:                                       ; preds = %entry1
  %14 = alloca i32
  store i32 1, i32* %14
  br label %header

header:                                           ; preds = %body, %pre_header
  %15 = load i32, i32* %14
  %16 = icmp slt i32 %15, %0
  br i1 %16, label %body, label %tail

body:                                             ; preds = %header
  %17 = add i32 1, %15
  %18 = zext i32 %17 to i64
  %19 = getelementptr inbounds i8*, i8** %10, i64 %18
  %20 = zext i32 %15 to i64
  %21 = getelementptr inbounds i8*, i8** %1, i64 %20
  %22 = load i8*, i8** %21
  store i8* %22, i8** %19
  %23 = add i32 %15, 1
  store i32 %23, i32* %14
  br label %header

tail:                                             ; preds = %header
  %24 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %24)
  %25 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %25)
  %26 = bitcast i8*** %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* %26)
  %27 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %27)
  store i32 0, i32* %2, align 4
  store i32 %new_argc, i32* %3, align 4
  store i8** %10, i8*** %4, align 8
  store i32 0, i32* %5, align 4
  %28 = load i32, i32* %3, align 4
  %29 = icmp ne i32 %28, 2
  br i1 %29, label %30, label %34

30:                                               ; preds = %tail
  %31 = load i32, i32* %3, align 4
  %32 = load i32, i32* %3, align 4
  %33 = call i32 @libcall(i32 %31, i32 %32) #4
  store i32 %33, i32* %5, align 4
  br label %.exit

34:                                               ; preds = %tail
  %35 = load i8**, i8*** %4, align 8
  %36 = getelementptr inbounds i8*, i8** %35, i64 1
  %37 = load i8*, i8** %36, align 8
  %38 = call i64 @atol(i8* %37) #5
  %39 = trunc i64 %38 to i32
  %40 = call i32 @libcall(i32 %39, i32 1) #4
  %41 = load i8**, i8*** %4, align 8
  %42 = getelementptr inbounds i8*, i8** %41, i64 1
  %43 = load i8*, i8** %42, align 8
  %44 = call i64 @atol(i8* %43) #5
  %45 = trunc i64 %44 to i32
  %46 = call i32 @libcall(i32 %45, i32 2) #4
  %47 = mul nsw i32 %40, %46
  store i32 %47, i32* %5, align 4
  br label %.exit

.exit:                                            ; preds = %30, %34
  %48 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %49 = load i32, i32* %5, align 4
  %50 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %48, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str, i64 0, i64 0), i32 %49) #4
  %51 = load i32, i32* %5, align 4
  %52 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %52)
  %53 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %53)
  %54 = bitcast i8*** %4 to i8*
  call void @llvm.lifetime.end.p0i8(i64 8, i8* %54)
  %55 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %55)
  ret i32 %51
}

; Function Attrs: nounwind willreturn
declare void @llvm.assume(i1) #2

declare noalias i8* @malloc(i64)

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #3

attributes #0 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind willreturn }
attributes #3 = { argmemonly nounwind willreturn }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

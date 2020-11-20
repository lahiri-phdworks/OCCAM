; ModuleID = 'slash/main.o.a.i.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@.str.1 = private unnamed_addr constant [7 x i8] c"Nope!\0A\00", align 1
@new_argv = private constant [5 x i8] c"main\00"
@new_argv.1 = private constant [6 x i8] c"argv1\00"

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @test(i32 %0, i8* %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8*, align 8
  store i32 %0, i32* %4, align 4
  store i8* %1, i8** %5, align 8
  %6 = load i32, i32* %4, align 4
  %7 = icmp eq i32 %6, 1
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load i8*, i8** %5, align 8
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i8* %9)
  store i32 0, i32* %3, align 4
  br label %13

11:                                               ; preds = %2
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i64 0, i64 0))
  store i32 -1, i32* %3, align 4
  br label %13

13:                                               ; preds = %11, %8
  %14 = load i32, i32* %3, align 4
  ret i32 %14
}

declare dso_local i32 @call(i32 (i32, i8*)*, i32, i8*) #1

declare dso_local i32 @printf(i8*, ...) #1

define i32 @main(i32 %0, i8** %1) {
entry:
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i8**, align 8
  %5 = icmp eq i32 %0, 1
  br i1 %5, label %entry1, label %incorrect_argc

entry1:                                           ; preds = %entry
  %new_argc = add i32 %0, 1
  %6 = icmp eq i32 %0, 1
  call void @llvm.assume(i1 %6)
  %7 = add i32 %new_argc, 1
  %8 = sext i32 %7 to i64
  %mallocsize = mul i64 %8, 8
  %malloccall = tail call i8* @malloc(i64 %mallocsize)
  %9 = bitcast i8* %malloccall to i8**
  %10 = getelementptr i8*, i8** %9, i32 0
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv, i32 0, i32 0), i8** %10
  %11 = getelementptr i8*, i8** %9, i32 1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @new_argv.1, i32 0, i32 0), i8** %11
  %12 = getelementptr inbounds i8*, i8** %9, i32 %new_argc
  store i8* null, i8** %12
  br label %pre_header

incorrect_argc:                                   ; preds = %entry
  ret i32 1

pre_header:                                       ; preds = %entry1
  %13 = alloca i32
  store i32 1, i32* %13
  br label %header

header:                                           ; preds = %body, %pre_header
  %14 = load i32, i32* %13
  %15 = icmp slt i32 %14, %0
  br i1 %15, label %body, label %tail

body:                                             ; preds = %header
  %16 = add i32 1, %14
  %17 = zext i32 %16 to i64
  %18 = getelementptr inbounds i8*, i8** %9, i64 %17
  %19 = zext i32 %14 to i64
  %20 = getelementptr inbounds i8*, i8** %1, i64 %19
  %21 = load i8*, i8** %20
  store i8* %21, i8** %18
  %22 = add i32 %14, 1
  store i32 %22, i32* %13
  br label %header

tail:                                             ; preds = %header
  %23 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %23)
  %24 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %24)
  %25 = bitcast i8*** %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* %25)
  store i32 0, i32* %2, align 4
  store i32 %new_argc, i32* %3, align 4
  store i8** %9, i8*** %4, align 8
  %26 = load i32, i32* %3, align 4
  %27 = load i8**, i8*** %4, align 8
  %28 = load i8*, i8** %27, align 8
  %29 = call i32 @call(i32 (i32, i8*)* @test, i32 %26, i8* %28) #4
  %30 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %30)
  %31 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %31)
  %32 = bitcast i8*** %4 to i8*
  call void @llvm.lifetime.end.p0i8(i64 8, i8* %32)
  ret i32 %29
}

; Function Attrs: nounwind willreturn
declare void @llvm.assume(i1) #2

declare noalias i8* @malloc(i64)

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind willreturn }
attributes #3 = { argmemonly nounwind willreturn }
attributes #4 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

; ModuleID = 'slash/main.a.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [19 x i8] c"add_one is called\0A\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"add_two is called\0A\00", align 1
@.str.2 = private unnamed_addr constant [21 x i8] c"add_three is called\0A\00", align 1
@.str.3 = private unnamed_addr constant [17 x i8] c"Final retval=%d\0A\00", align 1
@new_argv = private constant [5 x i8] c"main\00"
@new_argv.1 = private constant [2 x i8] c"1\00"
@new_argv.2 = private constant [2 x i8] c"5\00"
@new_argv.3 = private constant [3 x i8] c"10\00"

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @0(i32 %0, i8** %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8**, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32 (i32, i32)*, align 8
  store i32 0, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  store i8** %1, i8*** %5, align 8
  store i32 0, i32* %6, align 4
  store i32 (i32, i32)* null, i32 (i32, i32)** %7, align 8
  %8 = load i32, i32* %4, align 4
  %9 = icmp eq i32 %8, 1
  br i1 %9, label %10, label %11

10:                                               ; preds = %2
  br label %30

11:                                               ; preds = %2
  %12 = load i32, i32* %4, align 4
  %13 = icmp eq i32 %12, 2
  br i1 %13, label %14, label %16

14:                                               ; preds = %11
  store i32 (i32, i32)* @add_one, i32 (i32, i32)** %7, align 8
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str, i64 0, i64 0))
  br label %29

16:                                               ; preds = %11
  %17 = load i32, i32* %4, align 4
  %18 = icmp eq i32 %17, 3
  br i1 %18, label %19, label %21

19:                                               ; preds = %16
  store i32 (i32, i32)* @add_two, i32 (i32, i32)** %7, align 8
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i64 0, i64 0))
  br label %28

21:                                               ; preds = %16
  %22 = load i32, i32* %4, align 4
  %23 = icmp eq i32 %22, 4
  br i1 %23, label %24, label %26

24:                                               ; preds = %21
  store i32 (i32, i32)* @add_three, i32 (i32, i32)** %7, align 8
  %25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.2, i64 0, i64 0))
  br label %27

26:                                               ; preds = %21
  br label %27

27:                                               ; preds = %26, %24
  br label %28

28:                                               ; preds = %27, %19
  br label %29

29:                                               ; preds = %28, %14
  br label %30

30:                                               ; preds = %29, %10
  %31 = load i32 (i32, i32)*, i32 (i32, i32)** %7, align 8
  %32 = icmp ne i32 (i32, i32)* %31, null
  br i1 %32, label %33, label %38

33:                                               ; preds = %30
  %34 = load i32 (i32, i32)*, i32 (i32, i32)** %7, align 8
  %35 = load i32, i32* %4, align 4
  %36 = load i32, i32* %4, align 4
  %37 = call i32 %34(i32 %35, i32 %36)
  store i32 %37, i32* %6, align 4
  br label %39

38:                                               ; preds = %30
  br label %39

39:                                               ; preds = %38, %33
  %40 = load i32, i32* %6, align 4
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.3, i64 0, i64 0), i32 %40)
  %42 = load i32, i32* %6, align 4
  ret i32 %42
}

declare dso_local i32 @add_one(i32, i32) #1

declare dso_local i32 @printf(i8*, ...) #1

declare dso_local i32 @add_two(i32, i32) #1

declare dso_local i32 @add_three(i32, i32) #1

define i32 @main(i32 %0, i8** %1) {
entry:
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i8**, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32 (i32, i32)*, align 8
  %7 = icmp eq i32 %0, 1
  br i1 %7, label %entry1, label %incorrect_argc

entry1:                                           ; preds = %entry
  %new_argc = add i32 %0, 3
  %8 = icmp eq i32 %0, 1
  call void @llvm.assume(i1 %8)
  %9 = add i32 %new_argc, 1
  %10 = sext i32 %9 to i64
  %mallocsize = mul i64 %10, 8
  %malloccall = tail call i8* @malloc(i64 %mallocsize)
  %11 = bitcast i8* %malloccall to i8**
  %12 = getelementptr i8*, i8** %11, i32 0
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv, i32 0, i32 0), i8** %12
  %13 = getelementptr i8*, i8** %11, i32 1
  store i8* getelementptr inbounds ([2 x i8], [2 x i8]* @new_argv.1, i32 0, i32 0), i8** %13
  %14 = getelementptr i8*, i8** %11, i32 2
  store i8* getelementptr inbounds ([2 x i8], [2 x i8]* @new_argv.2, i32 0, i32 0), i8** %14
  %15 = getelementptr i8*, i8** %11, i32 3
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @new_argv.3, i32 0, i32 0), i8** %15
  %16 = getelementptr inbounds i8*, i8** %11, i32 %new_argc
  store i8* null, i8** %16
  br label %pre_header

incorrect_argc:                                   ; preds = %entry
  ret i32 1

pre_header:                                       ; preds = %entry1
  %17 = alloca i32
  store i32 1, i32* %17
  br label %header

header:                                           ; preds = %body, %pre_header
  %18 = load i32, i32* %17
  %19 = icmp slt i32 %18, %0
  br i1 %19, label %body, label %tail

body:                                             ; preds = %header
  %20 = add i32 3, %18
  %21 = zext i32 %20 to i64
  %22 = getelementptr inbounds i8*, i8** %11, i64 %21
  %23 = zext i32 %18 to i64
  %24 = getelementptr inbounds i8*, i8** %1, i64 %23
  %25 = load i8*, i8** %24
  store i8* %25, i8** %22
  %26 = add i32 %18, 1
  store i32 %26, i32* %17
  br label %header

tail:                                             ; preds = %header
  %27 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %27)
  %28 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %28)
  %29 = bitcast i8*** %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* %29)
  %30 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %30)
  %31 = bitcast i32 (i32, i32)** %6 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* %31)
  store i32 0, i32* %2, align 4
  store i32 %new_argc, i32* %3, align 4
  store i8** %11, i8*** %4, align 8
  store i32 0, i32* %5, align 4
  store i32 (i32, i32)* null, i32 (i32, i32)** %6, align 8
  %32 = load i32, i32* %3, align 4
  %33 = icmp eq i32 %32, 1
  br i1 %33, label %34, label %35

34:                                               ; preds = %tail
  br label %54

35:                                               ; preds = %tail
  %36 = load i32, i32* %3, align 4
  %37 = icmp eq i32 %36, 2
  br i1 %37, label %38, label %40

38:                                               ; preds = %35
  store i32 (i32, i32)* @add_one, i32 (i32, i32)** %6, align 8
  %39 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str, i64 0, i64 0)) #4
  br label %53

40:                                               ; preds = %35
  %41 = load i32, i32* %3, align 4
  %42 = icmp eq i32 %41, 3
  br i1 %42, label %43, label %45

43:                                               ; preds = %40
  store i32 (i32, i32)* @add_two, i32 (i32, i32)** %6, align 8
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i64 0, i64 0)) #4
  br label %52

45:                                               ; preds = %40
  %46 = load i32, i32* %3, align 4
  %47 = icmp eq i32 %46, 4
  br i1 %47, label %48, label %50

48:                                               ; preds = %45
  store i32 (i32, i32)* @add_three, i32 (i32, i32)** %6, align 8
  %49 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.2, i64 0, i64 0)) #4
  br label %51

50:                                               ; preds = %45
  br label %51

51:                                               ; preds = %50, %48
  br label %52

52:                                               ; preds = %51, %43
  br label %53

53:                                               ; preds = %52, %38
  br label %54

54:                                               ; preds = %53, %34
  %55 = load i32 (i32, i32)*, i32 (i32, i32)** %6, align 8
  %56 = icmp ne i32 (i32, i32)* %55, null
  br i1 %56, label %57, label %62

57:                                               ; preds = %54
  %58 = load i32 (i32, i32)*, i32 (i32, i32)** %6, align 8
  %59 = load i32, i32* %3, align 4
  %60 = load i32, i32* %3, align 4
  %61 = call i32 %58(i32 %59, i32 %60) #4
  store i32 %61, i32* %5, align 4
  br label %.exit

62:                                               ; preds = %54
  br label %.exit

.exit:                                            ; preds = %57, %62
  %63 = load i32, i32* %5, align 4
  %64 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.3, i64 0, i64 0), i32 %63) #4
  %65 = load i32, i32* %5, align 4
  %66 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %66)
  %67 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %67)
  %68 = bitcast i8*** %4 to i8*
  call void @llvm.lifetime.end.p0i8(i64 8, i8* %68)
  %69 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %69)
  %70 = bitcast i32 (i32, i32)** %6 to i8*
  call void @llvm.lifetime.end.p0i8(i64 8, i8* %70)
  ret i32 %65
}

; Function Attrs: nounwind willreturn
declare void @llvm.assume(i1) #2

declare noalias i8* @malloc(i64)

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #3

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind willreturn }
attributes #3 = { argmemonly nounwind willreturn }
attributes #4 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

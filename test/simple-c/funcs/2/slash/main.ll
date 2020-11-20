; ModuleID = 'slash/main.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [19 x i8] c"add_one is called\0A\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"add_two is called\0A\00", align 1
@.str.2 = private unnamed_addr constant [21 x i8] c"add_three is called\0A\00", align 1
@.str.3 = private unnamed_addr constant [17 x i8] c"Final retval=%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 %0, i8** %1) #0 {
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

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

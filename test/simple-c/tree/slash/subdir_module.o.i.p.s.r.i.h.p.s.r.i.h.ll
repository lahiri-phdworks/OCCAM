; ModuleID = 'slash/subdir_module.o.i.p.s.r.i.h.p.s.r.i.h.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@0 = private constant [2 x i8] c"Z\00"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"__occam_spec.internal_api(0x3,?,S:B9A)"(i8* %0) local_unnamed_addr #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  store i32 3, i32* %3, align 4
  store i8* %0, i8** %4, align 8
  store i8* getelementptr inbounds ([2 x i8], [2 x i8]* @0, i32 0, i32 0), i8** %5, align 8
  %6 = load i32, i32* %3, align 4
  %7 = icmp eq i32 %6, 5
  br i1 %7, label %26, label %8

8:                                                ; preds = %1
  %9 = load i8*, i8** %4, align 8
  %10 = icmp eq i8* %9, null
  br i1 %10, label %26, label %11

11:                                               ; preds = %8
  %12 = load i8*, i8** %5, align 8
  %13 = icmp ne i8* %12, null
  br i1 %13, label %14, label %27

14:                                               ; preds = %11
  %15 = load i8*, i8** %5, align 8
  %16 = getelementptr inbounds i8, i8* %15, i64 0
  %17 = load i8, i8* %16, align 1
  %18 = sext i8 %17 to i32
  %19 = icmp eq i32 %18, 90
  br i1 %19, label %20, label %27

20:                                               ; preds = %14
  %21 = load i8*, i8** %5, align 8
  %22 = getelementptr inbounds i8, i8* %21, i64 1
  %23 = load i8, i8* %22, align 1
  %24 = sext i8 %23 to i32
  %25 = icmp eq i32 %24, 0
  br i1 %25, label %26, label %27

26:                                               ; preds = %20, %8, %1
  store i32 666, i32* %2, align 4
  br label %35

27:                                               ; preds = %20, %14, %11
  %28 = load i8*, i8** %4, align 8
  %29 = ptrtoint i8* %28 to i64
  %30 = load i8*, i8** %5, align 8
  %31 = ptrtoint i8* %30 to i64
  %32 = add i64 %29, %31
  %33 = udiv i64 %32, 2
  %34 = trunc i64 %33 to i32
  store i32 %34, i32* %2, align 4
  br label %35

35:                                               ; preds = %27, %26
  %36 = load i32, i32* %2, align 4
  ret i32 %36
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"__occam_spec.internal_api(0x4,null,?)"(i8* %0) local_unnamed_addr #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  store i32 4, i32* %3, align 4
  store i8* null, i8** %4, align 8
  store i8* %0, i8** %5, align 8
  %6 = load i32, i32* %3, align 4
  %7 = icmp eq i32 %6, 5
  br i1 %7, label %26, label %8

8:                                                ; preds = %1
  %9 = load i8*, i8** %4, align 8
  %10 = icmp eq i8* %9, null
  br i1 %10, label %26, label %11

11:                                               ; preds = %8
  %12 = load i8*, i8** %5, align 8
  %13 = icmp ne i8* %12, null
  br i1 %13, label %14, label %27

14:                                               ; preds = %11
  %15 = load i8*, i8** %5, align 8
  %16 = getelementptr inbounds i8, i8* %15, i64 0
  %17 = load i8, i8* %16, align 1
  %18 = sext i8 %17 to i32
  %19 = icmp eq i32 %18, 90
  br i1 %19, label %20, label %27

20:                                               ; preds = %14
  %21 = load i8*, i8** %5, align 8
  %22 = getelementptr inbounds i8, i8* %21, i64 1
  %23 = load i8, i8* %22, align 1
  %24 = sext i8 %23 to i32
  %25 = icmp eq i32 %24, 0
  br i1 %25, label %26, label %27

26:                                               ; preds = %20, %8, %1
  store i32 666, i32* %2, align 4
  br label %35

27:                                               ; preds = %20, %14, %11
  %28 = load i8*, i8** %4, align 8
  %29 = ptrtoint i8* %28 to i64
  %30 = load i8*, i8** %5, align 8
  %31 = ptrtoint i8* %30 to i64
  %32 = add i64 %29, %31
  %33 = udiv i64 %32, 2
  %34 = trunc i64 %33 to i32
  store i32 %34, i32* %2, align 4
  br label %35

35:                                               ; preds = %27, %26
  %36 = load i32, i32* %2, align 4
  ret i32 %36
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"__occam_spec.internal_api(0x5,?,?)"(i8* %0, i8* %1) local_unnamed_addr #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  store i32 5, i32* %4, align 4
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  %7 = load i32, i32* %4, align 4
  %8 = icmp eq i32 %7, 5
  br i1 %8, label %27, label %9

9:                                                ; preds = %2
  %10 = load i8*, i8** %5, align 8
  %11 = icmp eq i8* %10, null
  br i1 %11, label %27, label %12

12:                                               ; preds = %9
  %13 = load i8*, i8** %6, align 8
  %14 = icmp ne i8* %13, null
  br i1 %14, label %15, label %28

15:                                               ; preds = %12
  %16 = load i8*, i8** %6, align 8
  %17 = getelementptr inbounds i8, i8* %16, i64 0
  %18 = load i8, i8* %17, align 1
  %19 = sext i8 %18 to i32
  %20 = icmp eq i32 %19, 90
  br i1 %20, label %21, label %28

21:                                               ; preds = %15
  %22 = load i8*, i8** %6, align 8
  %23 = getelementptr inbounds i8, i8* %22, i64 1
  %24 = load i8, i8* %23, align 1
  %25 = sext i8 %24 to i32
  %26 = icmp eq i32 %25, 0
  br i1 %26, label %27, label %28

27:                                               ; preds = %21, %9, %2
  store i32 666, i32* %3, align 4
  br label %36

28:                                               ; preds = %21, %15, %12
  %29 = load i8*, i8** %5, align 8
  %30 = ptrtoint i8* %29 to i64
  %31 = load i8*, i8** %6, align 8
  %32 = ptrtoint i8* %31 to i64
  %33 = add i64 %30, %32
  %34 = udiv i64 %33, 2
  %35 = trunc i64 %34 to i32
  store i32 %35, i32* %3, align 4
  br label %36

36:                                               ; preds = %28, %27
  %37 = load i32, i32* %3, align 4
  ret i32 %37
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

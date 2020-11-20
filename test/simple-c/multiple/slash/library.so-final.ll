; ModuleID = 'slash/library.so-final.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@global2 = local_unnamed_addr global i32 555, align 4
@0 = private constant [2 x i8] c"Z\00"

; Function Attrs: noinline nounwind optnone uwtable
define i32 @libcall_int(i32 %0, i32 %1) local_unnamed_addr #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  %6 = load i32, i32* %4, align 4
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %9

8:                                                ; preds = %2
  store i32 1, i32* %3, align 4
  br label %23

9:                                                ; preds = %2
  %10 = load i32, i32* %4, align 4
  %11 = icmp eq i32 %10, 1
  br i1 %11, label %12, label %13

12:                                               ; preds = %9
  store i32 2, i32* %3, align 4
  br label %23

13:                                               ; preds = %9
  %14 = load i32, i32* %4, align 4
  %15 = icmp eq i32 %14, 2
  br i1 %15, label %16, label %17

16:                                               ; preds = %13
  store i32 3, i32* %3, align 4
  br label %23

17:                                               ; preds = %13
  %18 = call fastcc i32 @1()
  %19 = load i32, i32* %4, align 4
  %20 = load i32, i32* %5, align 4
  %21 = add nsw i32 %19, %20
  %22 = srem i32 %18, %21
  store i32 %22, i32* %3, align 4
  br label %23

23:                                               ; preds = %17, %16, %12, %8
  %24 = load i32, i32* %3, align 4
  ret i32 %24
}

; Function Attrs: noinline nounwind optnone uwtable
define internal fastcc i32 @1() unnamed_addr #0 {
  %1 = call i64 @time(i64* null) #2
  %2 = trunc i64 %1 to i32
  call void @srand(i32 %2) #2
  %3 = call i32 @rand() #2
  ret i32 %3
}

; Function Attrs: nounwind
declare i64 @time(i64*) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @srand(i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare i32 @rand() local_unnamed_addr #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @libcall_global_pointer(i32 %0, i8* %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8*, align 8
  store i32 %0, i32* %4, align 4
  store i8* %1, i8** %5, align 8
  %6 = load i8*, i8** %5, align 8
  %7 = icmp eq i8* %6, bitcast (i32 (i32, i8*)* @libcall_global_pointer to i8*)
  br i1 %7, label %8, label %9

8:                                                ; preds = %2
  store i32 13, i32* %3, align 4
  br label %13

9:                                                ; preds = %2
  %10 = call fastcc i32 @1()
  %11 = load i32, i32* %4, align 4
  %12 = mul nsw i32 %10, %11
  store i32 %12, i32* %3, align 4
  br label %13

13:                                               ; preds = %9, %8
  %14 = load i32, i32* %3, align 4
  ret i32 %14
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @"__occam_spec.libcall_global_pointer(?,null)"(i32 %0) local_unnamed_addr #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i8*, align 8
  store i32 %0, i32* %3, align 4
  store i8* null, i8** %4, align 8
  %5 = load i8*, i8** %4, align 8
  %6 = icmp eq i8* %5, bitcast (i32 (i32, i8*)* @libcall_global_pointer to i8*)
  br i1 %6, label %7, label %8

7:                                                ; preds = %1
  store i32 13, i32* %2, align 4
  br label %12

8:                                                ; preds = %1
  %9 = call fastcc i32 @1()
  %10 = load i32, i32* %3, align 4
  %11 = mul nsw i32 %9, %10
  store i32 %11, i32* %2, align 4
  br label %12

12:                                               ; preds = %8, %7
  %13 = load i32, i32* %2, align 4
  ret i32 %13
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @"__occam_spec.libcall_float(?,0x1p-1)"(i32 %0) local_unnamed_addr #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca float, align 4
  store i32 %0, i32* %3, align 4
  store float 5.000000e-01, float* %4, align 4
  %5 = load float, float* %4, align 4
  %6 = fcmp oeq float %5, 5.000000e-01
  br i1 %6, label %7, label %8

7:                                                ; preds = %1
  store i32 7, i32* %2, align 4
  br label %17

8:                                                ; preds = %1
  %9 = call fastcc i32 @1()
  %10 = sitofp i32 %9 to float
  %11 = load float, float* %4, align 4
  %12 = fmul float %10, %11
  %13 = load i32, i32* %3, align 4
  %14 = sitofp i32 %13 to float
  %15 = fmul float %12, %14
  %16 = fptosi float %15 to i32
  store i32 %16, i32* %2, align 4
  br label %17

17:                                               ; preds = %8, %7
  %18 = load i32, i32* %2, align 4
  ret i32 %18
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @"__occam_spec.libcall_string(0x5,S:B9A)"() local_unnamed_addr #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8*, align 8
  store i32 5, i32* %2, align 4
  store i8* getelementptr inbounds ([2 x i8], [2 x i8]* @0, i32 0, i32 0), i8** %3, align 8
  %4 = load i8*, i8** %3, align 8
  %5 = icmp ne i8* %4, null
  br i1 %5, label %6, label %19

6:                                                ; preds = %0
  %7 = load i8*, i8** %3, align 8
  %8 = getelementptr inbounds i8, i8* %7, i64 0
  %9 = load i8, i8* %8, align 1
  %10 = sext i8 %9 to i32
  %11 = icmp eq i32 %10, 90
  br i1 %11, label %12, label %19

12:                                               ; preds = %6
  %13 = load i8*, i8** %3, align 8
  %14 = getelementptr inbounds i8, i8* %13, i64 1
  %15 = load i8, i8* %14, align 1
  %16 = sext i8 %15 to i32
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %18, label %19

18:                                               ; preds = %12
  store i32 11, i32* %1, align 4
  br label %23

19:                                               ; preds = %12, %6, %0
  %20 = call fastcc i32 @1()
  %21 = load i32, i32* %2, align 4
  %22 = mul nsw i32 %20, %21
  store i32 %22, i32* %1, align 4
  br label %23

23:                                               ; preds = %19, %18
  %24 = load i32, i32* %1, align 4
  ret i32 %24
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @"__occam_spec.libcall_null_pointer(0x4,null)"() local_unnamed_addr #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8*, align 8
  store i32 4, i32* %2, align 4
  store i8* null, i8** %3, align 8
  %4 = load i8*, i8** %3, align 8
  %5 = icmp eq i8* %4, null
  br i1 %5, label %6, label %7

6:                                                ; preds = %0
  store i32 5, i32* %1, align 4
  br label %11

7:                                                ; preds = %0
  %8 = call fastcc i32 @1()
  %9 = load i32, i32* %2, align 4
  %10 = mul nsw i32 %8, %9
  store i32 %10, i32* %1, align 4
  br label %11

11:                                               ; preds = %7, %6
  %12 = load i32, i32* %1, align 4
  ret i32 %12
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @"__occam_spec.libcall_double(?,0x1.8p-1)"(i32 %0) local_unnamed_addr #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca double, align 8
  store i32 %0, i32* %3, align 4
  store double 7.500000e-01, double* %4, align 8
  %5 = load double, double* %4, align 8
  %6 = fcmp oeq double %5, 7.500000e-01
  br i1 %6, label %7, label %8

7:                                                ; preds = %1
  store i32 17, i32* %2, align 4
  br label %17

8:                                                ; preds = %1
  %9 = call fastcc i32 @1()
  %10 = sitofp i32 %9 to double
  %11 = load double, double* %4, align 8
  %12 = fmul double %10, %11
  %13 = load i32, i32* %3, align 4
  %14 = sitofp i32 %13 to double
  %15 = fmul double %12, %14
  %16 = fptosi double %15 to i32
  store i32 %16, i32* %2, align 4
  br label %17

17:                                               ; preds = %8, %7
  %18 = load i32, i32* %2, align 4
  ret i32 %18
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @"__occam_spec.libcall_int(0x1,?)"(i32 %0) local_unnamed_addr #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 1, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %7, label %8

7:                                                ; preds = %1
  store i32 1, i32* %2, align 4
  br label %22

8:                                                ; preds = %1
  %9 = load i32, i32* %3, align 4
  %10 = icmp eq i32 %9, 1
  br i1 %10, label %11, label %12

11:                                               ; preds = %8
  store i32 2, i32* %2, align 4
  br label %22

12:                                               ; preds = %8
  %13 = load i32, i32* %3, align 4
  %14 = icmp eq i32 %13, 2
  br i1 %14, label %15, label %16

15:                                               ; preds = %12
  store i32 3, i32* %2, align 4
  br label %22

16:                                               ; preds = %12
  %17 = call fastcc i32 @1()
  %18 = load i32, i32* %3, align 4
  %19 = load i32, i32* %4, align 4
  %20 = add nsw i32 %18, %19
  %21 = srem i32 %17, %20
  store i32 %21, i32* %2, align 4
  br label %22

22:                                               ; preds = %16, %15, %11, %7
  %23 = load i32, i32* %2, align 4
  ret i32 %23
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @"__occam_spec.libcall_int(0x2,?)"(i32 %0) local_unnamed_addr #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 2, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %7, label %8

7:                                                ; preds = %1
  store i32 1, i32* %2, align 4
  br label %22

8:                                                ; preds = %1
  %9 = load i32, i32* %3, align 4
  %10 = icmp eq i32 %9, 1
  br i1 %10, label %11, label %12

11:                                               ; preds = %8
  store i32 2, i32* %2, align 4
  br label %22

12:                                               ; preds = %8
  %13 = load i32, i32* %3, align 4
  %14 = icmp eq i32 %13, 2
  br i1 %14, label %15, label %16

15:                                               ; preds = %12
  store i32 3, i32* %2, align 4
  br label %22

16:                                               ; preds = %12
  %17 = call fastcc i32 @1()
  %18 = load i32, i32* %3, align 4
  %19 = load i32, i32* %4, align 4
  %20 = add nsw i32 %18, %19
  %21 = srem i32 %17, %20
  store i32 %21, i32* %2, align 4
  br label %22

22:                                               ; preds = %16, %15, %11, %7
  %23 = load i32, i32* %2, align 4
  ret i32 %23
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @"__occam_spec.libcall_int(0x29A,?)"(i32 %0) local_unnamed_addr #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 666, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %7, label %8

7:                                                ; preds = %1
  store i32 1, i32* %2, align 4
  br label %22

8:                                                ; preds = %1
  %9 = load i32, i32* %3, align 4
  %10 = icmp eq i32 %9, 1
  br i1 %10, label %11, label %12

11:                                               ; preds = %8
  store i32 2, i32* %2, align 4
  br label %22

12:                                               ; preds = %8
  %13 = load i32, i32* %3, align 4
  %14 = icmp eq i32 %13, 2
  br i1 %14, label %15, label %16

15:                                               ; preds = %12
  store i32 3, i32* %2, align 4
  br label %22

16:                                               ; preds = %12
  %17 = call fastcc i32 @1()
  %18 = load i32, i32* %3, align 4
  %19 = load i32, i32* %4, align 4
  %20 = add nsw i32 %18, %19
  %21 = srem i32 %17, %20
  store i32 %21, i32* %2, align 4
  br label %22

22:                                               ; preds = %16, %15, %11, %7
  %23 = load i32, i32* %2, align 4
  ret i32 %23
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}

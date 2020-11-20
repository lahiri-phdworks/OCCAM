; ModuleID = 'slash/main.o.a.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@_fun1 = common dso_local global i32 (i32)* null, align 8
@fun1 = dso_local global i32 (i32)** @_fun1, align 8
@_fun2 = common dso_local global i32 (i32)* null, align 8
@fun2 = dso_local global i32 (i32)** @_fun2, align 8
@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @nd_int() #0 {
  %1 = call i64 @time(i64* null) #3
  %2 = trunc i64 %1 to i32
  call void @srand(i32 %2) #3
  %3 = call i32 @rand() #3
  ret i32 %3
}

; Function Attrs: nounwind
declare dso_local i64 @time(i64*) #1

; Function Attrs: nounwind
declare dso_local void @srand(i32) #1

; Function Attrs: nounwind
declare dso_local i32 @rand() #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @incr(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = add nsw i32 %3, 1
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @decr(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = sub nsw i32 %3, 1
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @square(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = load i32, i32* %2, align 4
  %5 = mul nsw i32 %3, %4
  ret i32 %5
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @init() #0 {
  br label %1

1:                                                ; preds = %4, %0
  %2 = call i32 @nd_int()
  %3 = icmp ne i32 %2, 0
  br i1 %3, label %4, label %5

4:                                                ; preds = %1
  br label %1

5:                                                ; preds = %1
  %6 = call i32 @nd_int()
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %10

8:                                                ; preds = %5
  %9 = load i32 (i32)**, i32 (i32)*** @fun1, align 8
  store i32 (i32)* @incr, i32 (i32)** %9, align 8
  br label %12

10:                                               ; preds = %5
  %11 = load i32 (i32)**, i32 (i32)*** @fun1, align 8
  store i32 (i32)* @decr, i32 (i32)** %11, align 8
  br label %12

12:                                               ; preds = %10, %8
  %13 = load i32 (i32)**, i32 (i32)*** @fun2, align 8
  store i32 (i32)* @square, i32 (i32)** %13, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @init()
  %4 = load i32 (i32)**, i32 (i32)*** @fun2, align 8
  %5 = load i32 (i32)*, i32 (i32)** %4, align 8
  %6 = call i32 %5(i32 7)
  store i32 %6, i32* %2, align 4
  %7 = load i32 (i32)**, i32 (i32)*** @fun1, align 8
  %8 = load i32 (i32)*, i32 (i32)** %7, align 8
  %9 = call i32 @execute_call(i32 (i32)* %8, i32 5)
  store i32 %9, i32* %3, align 4
  %10 = load i32, i32* %2, align 4
  %11 = load i32, i32* %3, align 4
  %12 = add nsw i32 %10, %11
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 %12)
  ret i32 0
}

declare dso_local i32 @execute_call(i32 (i32)*, i32) #2

declare dso_local i32 @printf(i8*, ...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

; ModuleID = 'slash/main.o.a.i.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.class_t = type { {}*, {}* }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(%struct.class_t* %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca %struct.class_t*, align 8
  %5 = alloca i32, align 4
  store %struct.class_t* %0, %struct.class_t** %4, align 8
  store i32 %1, i32* %5, align 4
  %6 = load i32, i32* %5, align 4
  %7 = icmp sgt i32 %6, 10
  br i1 %7, label %8, label %17

8:                                                ; preds = %2
  %9 = load %struct.class_t*, %struct.class_t** %4, align 8
  %10 = getelementptr inbounds %struct.class_t, %struct.class_t* %9, i32 0, i32 1
  %11 = bitcast {}** %10 to i32 (%struct.class_t*, i32)**
  %12 = load i32 (%struct.class_t*, i32)*, i32 (%struct.class_t*, i32)** %11, align 8
  %13 = load %struct.class_t*, %struct.class_t** %4, align 8
  %14 = load i32, i32* %5, align 4
  %15 = add nsw i32 %14, 1
  %16 = call i32 %12(%struct.class_t* %13, i32 %15)
  store i32 %16, i32* %3, align 4
  br label %19

17:                                               ; preds = %2
  %18 = load i32, i32* %5, align 4
  store i32 %18, i32* %3, align 4
  br label %19

19:                                               ; preds = %17, %8
  %20 = load i32, i32* %3, align 4
  ret i32 %20
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @bar(%struct.class_t* %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca %struct.class_t*, align 8
  %5 = alloca i32, align 4
  store %struct.class_t* %0, %struct.class_t** %4, align 8
  store i32 %1, i32* %5, align 4
  %6 = load i32, i32* %5, align 4
  %7 = icmp slt i32 %6, 100
  br i1 %7, label %8, label %17

8:                                                ; preds = %2
  %9 = load i32, i32* %5, align 4
  %10 = load %struct.class_t*, %struct.class_t** %4, align 8
  %11 = getelementptr inbounds %struct.class_t, %struct.class_t* %10, i32 0, i32 0
  %12 = bitcast {}** %11 to i32 (%struct.class_t*, i32)**
  %13 = load i32 (%struct.class_t*, i32)*, i32 (%struct.class_t*, i32)** %12, align 8
  %14 = load %struct.class_t*, %struct.class_t** %4, align 8
  %15 = call i32 %13(%struct.class_t* %14, i32 10)
  %16 = add nsw i32 %9, %15
  store i32 %16, i32* %3, align 4
  br label %20

17:                                               ; preds = %2
  %18 = load i32, i32* %5, align 4
  %19 = sub nsw i32 %18, 5
  store i32 %19, i32* %3, align 4
  br label %20

20:                                               ; preds = %17, %8
  %21 = load i32, i32* %3, align 4
  ret i32 %21
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.class_t, align 8
  %3 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %4 = getelementptr inbounds %struct.class_t, %struct.class_t* %2, i32 0, i32 0
  %5 = bitcast {}** %4 to i32 (%struct.class_t*, i32)**
  store i32 (%struct.class_t*, i32)* @foo, i32 (%struct.class_t*, i32)** %5, align 8
  %6 = getelementptr inbounds %struct.class_t, %struct.class_t* %2, i32 0, i32 1
  %7 = bitcast {}** %6 to i32 (%struct.class_t*, i32)**
  store i32 (%struct.class_t*, i32)* @bar, i32 (%struct.class_t*, i32)** %7, align 8
  %8 = getelementptr inbounds %struct.class_t, %struct.class_t* %2, i32 0, i32 0
  %9 = bitcast {}** %8 to i32 (%struct.class_t*, i32)**
  %10 = load i32 (%struct.class_t*, i32)*, i32 (%struct.class_t*, i32)** %9, align 8
  %11 = call i32 %10(%struct.class_t* %2, i32 42)
  store i32 %11, i32* %3, align 4
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

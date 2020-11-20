; ModuleID = 'slash/main.o-final.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.class_t = type { {}*, {}* }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(%struct.class_t* %0, i32 %1) #0 {
  %3 = icmp sgt i32 %1, 10
  br i1 %3, label %4, label %10

4:                                                ; preds = %2
  %5 = getelementptr inbounds %struct.class_t, %struct.class_t* %0, i64 0, i32 1
  %6 = bitcast {}** %5 to i32 (%struct.class_t*, i32)**
  %7 = load i32 (%struct.class_t*, i32)*, i32 (%struct.class_t*, i32)** %6, align 8
  %8 = add nuw nsw i32 %1, 1
  %9 = tail call i32 @bar(%struct.class_t* %0, i32 %8) #1
  br label %10

10:                                               ; preds = %2, %4
  %.0 = phi i32 [ %9, %4 ], [ %1, %2 ]
  ret i32 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @bar(%struct.class_t* %0, i32 %1) #0 {
  %3 = icmp slt i32 %1, 100
  br i1 %3, label %4, label %8

4:                                                ; preds = %2
  %5 = bitcast %struct.class_t* %0 to i32 (%struct.class_t*, i32)**
  %6 = load i32 (%struct.class_t*, i32)*, i32 (%struct.class_t*, i32)** %5, align 8
  %7 = tail call i32 @foo(%struct.class_t* %0, i32 10) #1
  br label %8

8:                                                ; preds = %2, %4
  %.pn = phi i32 [ %7, %4 ], [ -5, %2 ]
  %.0 = add nsw i32 %.pn, %1
  ret i32 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.class_t, align 8
  %2 = bitcast %struct.class_t* %1 to i32 (%struct.class_t*, i32)**
  store i32 (%struct.class_t*, i32)* @foo, i32 (%struct.class_t*, i32)** %2, align 8
  %3 = getelementptr inbounds %struct.class_t, %struct.class_t* %1, i64 0, i32 1
  %4 = bitcast {}** %3 to i32 (%struct.class_t*, i32)**
  store i32 (%struct.class_t*, i32)* @bar, i32 (%struct.class_t*, i32)** %4, align 8
  %5 = call i32 @foo(%struct.class_t* nonnull %1, i32 42)
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

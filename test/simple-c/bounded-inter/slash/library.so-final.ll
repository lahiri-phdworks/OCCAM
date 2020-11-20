; ModuleID = 'slash/library.so-final.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @libcall(i32 %0, i32 %1) local_unnamed_addr #0 {
  switch i32 %0, label %4 [
    i32 0, label %8
    i32 1, label %3
  ]

3:                                                ; preds = %2
  br label %8

4:                                                ; preds = %2
  %5 = icmp eq i32 %0, 2
  %6 = tail call fastcc i32 @nd_int()
  %7 = add nsw i32 %6, 3
  %spec.select = select i1 %5, i32 %7, i32 %6
  ret i32 %spec.select

8:                                                ; preds = %2, %3
  %.sink5 = phi i32 [ 2, %3 ], [ 1, %2 ]
  %9 = tail call fastcc i32 @nd_int()
  %10 = add nsw i32 %9, %.sink5
  ret i32 %10
}

; Function Attrs: noinline nounwind uwtable
define internal fastcc i32 @nd_int() unnamed_addr #0 {
  %1 = tail call i64 @time(i64* null) #2
  %2 = trunc i64 %1 to i32
  tail call void @srand(i32 %2) #2
  %3 = tail call i32 @rand() #2
  ret i32 %3
}

; Function Attrs: nounwind
declare i64 @time(i64*) local_unnamed_addr #1

; Function Attrs: nounwind
declare void @srand(i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare i32 @rand() local_unnamed_addr #1

; Function Attrs: noinline nounwind uwtable
define i32 @"__occam_spec.libcall(0x1,0x2)"() local_unnamed_addr #0 {
  %1 = tail call fastcc i32 @nd_int()
  %2 = add nsw i32 %1, 2
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define i32 @"__occam_spec.libcall(0x3,0x4)"() local_unnamed_addr #0 {
  %1 = tail call fastcc i32 @nd_int()
  ret i32 %1
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}

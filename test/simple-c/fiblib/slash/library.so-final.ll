; ModuleID = 'slash/library.so-final.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind readnone uwtable
define internal i32 @fibo_lib(i32 %0) local_unnamed_addr #0 {
  %2 = icmp slt i32 %0, 2
  br i1 %2, label %9, label %3

3:                                                ; preds = %1
  %4 = add nsw i32 %0, -1
  %5 = tail call i32 @fibo_lib(i32 %4)
  %6 = add nsw i32 %0, -2
  %7 = tail call i32 @fibo_lib(i32 %6)
  %8 = add nsw i32 %7, %5
  ret i32 %8

9:                                                ; preds = %1
  ret i32 %0
}

; Function Attrs: nounwind readnone uwtable
define i32 @"__occam_spec.fibo_lib(0xF)"() local_unnamed_addr #0 {
  %1 = tail call i32 @fibo_lib(i32 14)
  %2 = tail call i32 @fibo_lib(i32 13)
  %3 = add nsw i32 %2, %1
  ret i32 %3
}

attributes #0 = { nounwind readnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}

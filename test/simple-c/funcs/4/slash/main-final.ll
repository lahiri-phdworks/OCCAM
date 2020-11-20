; ModuleID = 'slash/main-final.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@0 = private unnamed_addr constant [20 x i8] c"add_three is called\00", align 1
@1 = private unnamed_addr constant [17 x i8] c"Final retval=%d\0A\00", align 1
@2 = private constant [5 x i8] c"main\00"
@3 = private constant [2 x i8] c"1\00"
@4 = private constant [2 x i8] c"5\00"
@5 = private constant [3 x i8] c"10\00"

; Function Attrs: nofree nounwind
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #0

; Function Attrs: nofree nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #1

define i32 @main(i32 %0, i8** nocapture readonly %1) local_unnamed_addr {
  %3 = icmp eq i32 %0, 1
  br i1 %3, label %4, label %18

4:                                                ; preds = %2
  %5 = tail call i8* @malloc(i64 40)
  %6 = bitcast i8* %5 to i8**
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @2, i64 0, i64 0), i8** %6, align 8
  %7 = getelementptr i8, i8* %5, i64 8
  %8 = bitcast i8* %7 to i8**
  store i8* getelementptr inbounds ([2 x i8], [2 x i8]* @3, i64 0, i64 0), i8** %8, align 8
  %9 = getelementptr i8, i8* %5, i64 16
  %10 = bitcast i8* %9 to i8**
  store i8* getelementptr inbounds ([2 x i8], [2 x i8]* @4, i64 0, i64 0), i8** %10, align 8
  %11 = getelementptr i8, i8* %5, i64 24
  %12 = bitcast i8* %11 to i8**
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @5, i64 0, i64 0), i8** %12, align 8
  %13 = getelementptr inbounds i8, i8* %5, i64 32
  %14 = bitcast i8* %13 to i8**
  store i8* null, i8** %14, align 8
  %15 = tail call i32 @"__occam_spec.add_three(0x8,0x4)"()
  %16 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([20 x i8], [20 x i8]* @0, i64 0, i64 0)) #2
  %17 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([17 x i8], [17 x i8]* @1, i64 0, i64 0), i32 %15) #2
  ret i32 %15

18:                                               ; preds = %2
  ret i32 1
}

declare noalias i8* @malloc(i64) local_unnamed_addr

declare i32 @"__occam_spec.add_three(0x8,0x4)"() local_unnamed_addr

attributes #0 = { nofree nounwind }
attributes #1 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

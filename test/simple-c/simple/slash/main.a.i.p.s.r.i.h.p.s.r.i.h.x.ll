; ModuleID = 'slash/main.a.i.p.s.r.i.h.p.s.r.i.h.x.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%0 = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %1*, %0*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%1 = type { %1*, %0*, i32 }

@stderr = external dso_local local_unnamed_addr global %0*, align 8
@0 = private unnamed_addr constant [19 x i8] c"main returning %d\0A\00", align 1
@1 = private constant [5 x i8] c"main\00"
@2 = private constant [5 x i8] c"8181\00"

; Function Attrs: nounwind readonly
declare dso_local i64 @atol(i8*) local_unnamed_addr #0

declare dso_local i32 @fprintf(%0*, i8*, ...) local_unnamed_addr #1

define i32 @main(i32 %0, i8** nocapture readonly %1) local_unnamed_addr {
  %3 = icmp eq i32 %0, 1
  br i1 %3, label %4, label %20

4:                                                ; preds = %2
  %5 = tail call i8* @malloc(i64 24)
  %6 = bitcast i8* %5 to i8**
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @1, i64 0, i64 0), i8** %6, align 8
  %7 = getelementptr i8, i8* %5, i64 8
  %8 = bitcast i8* %7 to i8**
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @2, i64 0, i64 0), i8** %8, align 8
  %9 = getelementptr inbounds i8, i8* %5, i64 16
  %10 = bitcast i8* %9 to i8**
  store i8* null, i8** %10, align 8
  %11 = tail call i64 @atol(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @2, i64 0, i64 0)) #2
  %12 = trunc i64 %11 to i32
  %13 = tail call i32 @"__occam_spec.libcall(?,0x1)"(i32 %12)
  %14 = tail call i64 @atol(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @2, i64 0, i64 0)) #2
  %15 = trunc i64 %14 to i32
  %16 = tail call i32 @"__occam_spec.libcall(?,0x2)"(i32 %15)
  %17 = mul nsw i32 %16, %13
  %18 = load %0*, %0** @stderr, align 8
  %19 = tail call i32 (%0*, i8*, ...) @fprintf(%0* %18, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @0, i64 0, i64 0), i32 %17) #3
  ret i32 %17

20:                                               ; preds = %2
  ret i32 1
}

declare noalias i8* @malloc(i64) local_unnamed_addr

declare i32 @"__occam_spec.libcall(?,0x2)"(i32) local_unnamed_addr

declare i32 @"__occam_spec.libcall(?,0x1)"(i32) local_unnamed_addr

attributes #0 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}
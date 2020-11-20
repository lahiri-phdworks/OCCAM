; ModuleID = 'slash/call.o.i.p.s.r.i.h.p.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@0 = private constant [5 x i8] c"main\00"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @call(i32 (i32, i8*)* %0, i32 %1, i8* %2) local_unnamed_addr #0 {
  %4 = alloca i32 (i32, i8*)*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i8*, align 8
  store i32 (i32, i8*)* %0, i32 (i32, i8*)** %4, align 8
  store i32 %1, i32* %5, align 4
  store i8* %2, i8** %6, align 8
  %7 = load i32 (i32, i8*)*, i32 (i32, i8*)** %4, align 8
  %8 = load i32, i32* %5, align 4
  %9 = load i8*, i8** %6, align 8
  %10 = call i32 %7(i32 %8, i8* %9)
  ret i32 %10
}

declare i32 @test(i32, i8*)

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @"__occam_spec.call(test,0x2,S:7EB6C85)"() local_unnamed_addr #0 {
  %1 = alloca i32 (i32, i8*)*, align 8
  %2 = alloca i32, align 4
  %3 = alloca i8*, align 8
  store i32 (i32, i8*)* @test, i32 (i32, i8*)** %1, align 8
  store i32 2, i32* %2, align 4
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @0, i32 0, i32 0), i8** %3, align 8
  %4 = load i32 (i32, i8*)*, i32 (i32, i8*)** %1, align 8
  %5 = load i32, i32* %2, align 4
  %6 = load i8*, i8** %3, align 8
  %7 = call i32 %4(i32 %5, i8* %6)
  ret i32 %7
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

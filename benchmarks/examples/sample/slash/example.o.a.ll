; ModuleID = 'slash/example.o.a.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@new_argv = private constant [8 x i8] c"example\00"
@new_argv.1 = private constant [6 x i8] c"sumit\00"
@new_argv.2 = private constant [7 x i8] c"lahiri\00"

; Function Attrs: alwaysinline nounwind uwtable
define i32 @0(i32 %0, i8** %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8**, align 8
  %6 = alloca i32, align 4
  store i32 0, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  store i8** %1, i8*** %5, align 8
  store i32 0, i32* %6, align 4
  %7 = load i32, i32* %4, align 4
  %8 = icmp ne i32 %7, 2
  br i1 %8, label %9, label %10

9:                                                ; preds = %2
  store i32 -1, i32* %3, align 4
  br label %11

10:                                               ; preds = %2
  store i32 -1, i32* %3, align 4
  br label %11

11:                                               ; preds = %10, %9
  %12 = load i32, i32* %3, align 4
  ret i32 %12
}

define i32 @main(i32 %0, i8** %1) {
entry:
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i8**, align 8
  %5 = alloca i32, align 4
  %6 = icmp eq i32 %0, 1
  br i1 %6, label %entry1, label %incorrect_argc

entry1:                                           ; preds = %entry
  %new_argc = add i32 %0, 2
  %7 = icmp eq i32 %0, 1
  call void @llvm.assume(i1 %7)
  %8 = add i32 %new_argc, 1
  %9 = sext i32 %8 to i64
  %mallocsize = mul i64 %9, 8
  %malloccall = tail call i8* @malloc(i64 %mallocsize)
  %10 = bitcast i8* %malloccall to i8**
  %11 = getelementptr i8*, i8** %10, i32 0
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @new_argv, i32 0, i32 0), i8** %11
  %12 = getelementptr i8*, i8** %10, i32 1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @new_argv.1, i32 0, i32 0), i8** %12
  %13 = getelementptr i8*, i8** %10, i32 2
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @new_argv.2, i32 0, i32 0), i8** %13
  %14 = getelementptr inbounds i8*, i8** %10, i32 %new_argc
  store i8* null, i8** %14
  br label %pre_header

incorrect_argc:                                   ; preds = %entry
  ret i32 1

pre_header:                                       ; preds = %entry1
  %15 = alloca i32
  store i32 1, i32* %15
  br label %header

header:                                           ; preds = %body, %pre_header
  %16 = load i32, i32* %15
  %17 = icmp slt i32 %16, %0
  br i1 %17, label %body, label %tail

body:                                             ; preds = %header
  %18 = add i32 2, %16
  %19 = zext i32 %18 to i64
  %20 = getelementptr inbounds i8*, i8** %10, i64 %19
  %21 = zext i32 %16 to i64
  %22 = getelementptr inbounds i8*, i8** %1, i64 %21
  %23 = load i8*, i8** %22
  store i8* %23, i8** %20
  %24 = add i32 %16, 1
  store i32 %24, i32* %15
  br label %header

tail:                                             ; preds = %header
  %25 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %25)
  %26 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %26)
  %27 = bitcast i8*** %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* %27)
  %28 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %28)
  store i32 0, i32* %2, align 4
  store i32 %new_argc, i32* %3, align 4
  store i8** %10, i8*** %4, align 8
  store i32 0, i32* %5, align 4
  %29 = load i32, i32* %3, align 4
  %30 = icmp ne i32 %29, 2
  br i1 %30, label %31, label %32

31:                                               ; preds = %tail
  store i32 -1, i32* %2, align 4
  br label %.exit

32:                                               ; preds = %tail
  store i32 -1, i32* %2, align 4
  br label %.exit

.exit:                                            ; preds = %31, %32
  %33 = load i32, i32* %2, align 4
  %34 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %34)
  %35 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %35)
  %36 = bitcast i8*** %4 to i8*
  call void @llvm.lifetime.end.p0i8(i64 8, i8* %36)
  %37 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %37)
  ret i32 %33
}

; Function Attrs: nounwind willreturn
declare void @llvm.assume(i1) #1

declare noalias i8* @malloc(i64)

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind willreturn }
attributes #2 = { argmemonly nounwind willreturn }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}

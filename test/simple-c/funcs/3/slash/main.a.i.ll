; ModuleID = 'slash/main.a.i.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"one\00", align 1
@.str.1 = private constant [4 x i8] c"two\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"three\00", align 1
@.str.3 = private unnamed_addr constant [17 x i8] c"Final retval=%d\0A\00", align 1
@new_argv = private constant [5 x i8] c"main\00"

; Function Attrs: nounwind readonly
declare dso_local i64 @strlen(i8*) #0

; Function Attrs: nounwind readonly
declare dso_local i32 @strncmp(i8*, i8*, i64) #0

declare dso_local i32 @add_one(i32, i32) #1

declare dso_local i32 @add_two(i32, i32) #1

declare dso_local i32 @add_three(i32, i32) #1

declare dso_local i32 @printf(i8*, ...) #1

define i32 @main(i32 %0, i8** %1) {
entry:
  %2 = icmp eq i32 %0, 1
  br i1 %2, label %entry1, label %incorrect_argc

entry1:                                           ; preds = %entry
  %new_argc = add i32 %0, 1
  %3 = icmp eq i32 %0, 1
  call void @llvm.assume(i1 %3)
  %4 = add i32 %new_argc, 1
  %5 = sext i32 %4 to i64
  %mallocsize = mul i64 %5, 8
  %malloccall = tail call i8* @malloc(i64 %mallocsize)
  %6 = bitcast i8* %malloccall to i8**
  %7 = getelementptr i8*, i8** %6, i32 0
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv, i32 0, i32 0), i8** %7
  %8 = getelementptr i8*, i8** %6, i32 1
  store i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i32 0, i32 0), i8** %8
  %9 = getelementptr inbounds i8*, i8** %6, i32 %new_argc
  store i8* null, i8** %9
  br label %pre_header

incorrect_argc:                                   ; preds = %entry
  ret i32 1

pre_header:                                       ; preds = %entry1
  %10 = alloca i32
  store i32 1, i32* %10
  br label %header

header:                                           ; preds = %body, %pre_header
  %11 = load i32, i32* %10
  %12 = icmp slt i32 %11, %0
  br i1 %12, label %body, label %tail

body:                                             ; preds = %header
  %13 = add i32 1, %11
  %14 = zext i32 %13 to i64
  %15 = getelementptr inbounds i8*, i8** %6, i64 %14
  %16 = zext i32 %11 to i64
  %17 = getelementptr inbounds i8*, i8** %1, i64 %16
  %18 = load i8*, i8** %17
  store i8* %18, i8** %15
  %19 = add i32 %11, 1
  store i32 %19, i32* %10
  br label %header

tail:                                             ; preds = %header
  %20 = icmp eq i32 %new_argc, 1
  br i1 %20, label %21, label %22

21:                                               ; preds = %tail
  br label %84

22:                                               ; preds = %tail
  %23 = icmp eq i32 %new_argc, 2
  br i1 %23, label %24, label %82

24:                                               ; preds = %22
  %25 = getelementptr inbounds i8*, i8** %6, i64 1
  %26 = load i8*, i8** %25, align 8
  %27 = call i64 @strlen(i8* %26) #3
  %28 = call i64 @strlen(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0)) #3
  %29 = icmp ult i64 %27, %28
  br i1 %29, label %30, label %32

30:                                               ; preds = %24
  %31 = call i64 @strlen(i8* %26) #3
  br label %34

32:                                               ; preds = %24
  %33 = call i64 @strlen(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0)) #3
  br label %34

34:                                               ; preds = %32, %30
  %35 = phi i64 [ %31, %30 ], [ %33, %32 ]
  %36 = trunc i64 %35 to i32
  %37 = sext i32 %36 to i64
  %38 = call i32 @strncmp(i8* %26, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i64 %37) #3
  %39 = icmp eq i32 %38, 0
  %40 = zext i1 %39 to i32
  br i1 %39, label %41, label %42

41:                                               ; preds = %34
  br label %81

42:                                               ; preds = %34
  %43 = getelementptr inbounds i8*, i8** %6, i64 1
  %44 = load i8*, i8** %43, align 8
  %45 = call i64 @strlen(i8* %44) #3
  %46 = call i64 @strlen(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0)) #3
  %47 = icmp ult i64 %45, %46
  br i1 %47, label %48, label %50

48:                                               ; preds = %42
  %49 = call i64 @strlen(i8* %44) #3
  br label %52

50:                                               ; preds = %42
  %51 = call i64 @strlen(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0)) #3
  br label %52

52:                                               ; preds = %50, %48
  %53 = phi i64 [ %49, %48 ], [ %51, %50 ]
  %54 = trunc i64 %53 to i32
  %55 = sext i32 %54 to i64
  %56 = call i32 @strncmp(i8* %44, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), i64 %55) #3
  %57 = icmp eq i32 %56, 0
  %58 = zext i1 %57 to i32
  br i1 %57, label %59, label %60

59:                                               ; preds = %52
  br label %80

60:                                               ; preds = %52
  %61 = getelementptr inbounds i8*, i8** %6, i64 1
  %62 = load i8*, i8** %61, align 8
  %63 = call i64 @strlen(i8* %62) #3
  %64 = call i64 @strlen(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0)) #3
  %65 = icmp ult i64 %63, %64
  br i1 %65, label %66, label %68

66:                                               ; preds = %60
  %67 = call i64 @strlen(i8* %62) #3
  br label %70

68:                                               ; preds = %60
  %69 = call i64 @strlen(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0)) #3
  br label %70

70:                                               ; preds = %68, %66
  %71 = phi i64 [ %67, %66 ], [ %69, %68 ]
  %72 = trunc i64 %71 to i32
  %73 = sext i32 %72 to i64
  %74 = call i32 @strncmp(i8* %62, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i64 %73) #3
  %75 = icmp eq i32 %74, 0
  %76 = zext i1 %75 to i32
  br i1 %75, label %77, label %78

77:                                               ; preds = %70
  br label %79

78:                                               ; preds = %70
  br label %79

79:                                               ; preds = %78, %77
  %.0.i = phi i32 (i32, i32)* [ @add_three, %77 ], [ null, %78 ]
  br label %80

80:                                               ; preds = %79, %59
  %.1.i = phi i32 (i32, i32)* [ @add_two, %59 ], [ %.0.i, %79 ]
  br label %81

81:                                               ; preds = %80, %41
  %.2.i = phi i32 (i32, i32)* [ @add_one, %41 ], [ %.1.i, %80 ]
  br label %83

82:                                               ; preds = %22
  br label %83

83:                                               ; preds = %82, %81
  %.3.i = phi i32 (i32, i32)* [ %.2.i, %81 ], [ null, %82 ]
  br label %84

84:                                               ; preds = %83, %21
  %.4.i = phi i32 (i32, i32)* [ null, %21 ], [ %.3.i, %83 ]
  %85 = icmp ne i32 (i32, i32)* %.4.i, null
  br i1 %85, label %86, label %89

86:                                               ; preds = %84
  %87 = add nsw i32 %new_argc, 3
  %88 = call i32 %.4.i(i32 %87, i32 %new_argc) #4
  br label %.exit

89:                                               ; preds = %84
  br label %.exit

.exit:                                            ; preds = %86, %89
  %.01.i = phi i32 [ %88, %86 ], [ 0, %89 ]
  %90 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.3, i64 0, i64 0), i32 %.01.i) #4
  ret i32 %.01.i
}

; Function Attrs: nounwind willreturn
declare void @llvm.assume(i1) #2

declare noalias i8* @malloc(i64)

attributes #0 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind willreturn }
attributes #3 = { nounwind readonly }
attributes #4 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

; ModuleID = 'slash/main.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"one\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"two\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"three\00", align 1
@.str.3 = private unnamed_addr constant [17 x i8] c"Final retval=%d\0A\00", align 1

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @equal_str(i8* %0, i8* %1) #0 {
  %3 = alloca i8*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i8* %1, i8** %4, align 8
  %6 = load i8*, i8** %3, align 8
  %7 = call i64 @strlen(i8* %6) #4
  %8 = load i8*, i8** %4, align 8
  %9 = call i64 @strlen(i8* %8) #4
  %10 = icmp ult i64 %7, %9
  br i1 %10, label %11, label %14

11:                                               ; preds = %2
  %12 = load i8*, i8** %3, align 8
  %13 = call i64 @strlen(i8* %12) #4
  br label %17

14:                                               ; preds = %2
  %15 = load i8*, i8** %4, align 8
  %16 = call i64 @strlen(i8* %15) #4
  br label %17

17:                                               ; preds = %14, %11
  %18 = phi i64 [ %13, %11 ], [ %16, %14 ]
  %19 = trunc i64 %18 to i32
  store i32 %19, i32* %5, align 4
  %20 = load i8*, i8** %3, align 8
  %21 = load i8*, i8** %4, align 8
  %22 = load i32, i32* %5, align 4
  %23 = sext i32 %22 to i64
  %24 = call i32 @strncmp(i8* %20, i8* %21, i64 %23) #4
  %25 = icmp eq i32 %24, 0
  %26 = zext i1 %25 to i32
  ret i32 %26
}

; Function Attrs: nounwind readonly
declare dso_local i64 @strlen(i8*) #1

; Function Attrs: nounwind readonly
declare dso_local i32 @strncmp(i8*, i8*, i64) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main(i32 %0, i8** %1) #2 {
  %3 = alloca i8*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i8*, align 8
  %10 = alloca i8*, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i8**, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32 (i32, i32)*, align 8
  store i32 0, i32* %12, align 4
  store i32 %0, i32* %13, align 4
  store i8** %1, i8*** %14, align 8
  store i32 0, i32* %15, align 4
  store i32 (i32, i32)* null, i32 (i32, i32)** %16, align 8
  %17 = load i32, i32* %13, align 4
  %18 = icmp eq i32 %17, 1
  br i1 %18, label %19, label %20

19:                                               ; preds = %2
  br label %110

20:                                               ; preds = %2
  %21 = load i32, i32* %13, align 4
  %22 = icmp eq i32 %21, 2
  br i1 %22, label %23, label %108

23:                                               ; preds = %20
  %24 = load i8**, i8*** %14, align 8
  %25 = getelementptr inbounds i8*, i8** %24, i64 1
  %26 = load i8*, i8** %25, align 8
  store i8* %26, i8** %9, align 8
  store i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i8** %10, align 8
  %27 = load i8*, i8** %9, align 8
  %28 = call i64 @strlen(i8* %27) #4
  %29 = load i8*, i8** %10, align 8
  %30 = call i64 @strlen(i8* %29) #4
  %31 = icmp ult i64 %28, %30
  br i1 %31, label %32, label %35

32:                                               ; preds = %23
  %33 = load i8*, i8** %9, align 8
  %34 = call i64 @strlen(i8* %33) #4
  br label %38

35:                                               ; preds = %23
  %36 = load i8*, i8** %10, align 8
  %37 = call i64 @strlen(i8* %36) #4
  br label %38

38:                                               ; preds = %32, %35
  %39 = phi i64 [ %34, %32 ], [ %37, %35 ]
  %40 = trunc i64 %39 to i32
  store i32 %40, i32* %11, align 4
  %41 = load i8*, i8** %9, align 8
  %42 = load i8*, i8** %10, align 8
  %43 = load i32, i32* %11, align 4
  %44 = sext i32 %43 to i64
  %45 = call i32 @strncmp(i8* %41, i8* %42, i64 %44) #4
  %46 = icmp eq i32 %45, 0
  %47 = zext i1 %46 to i32
  %48 = icmp ne i32 %47, 0
  br i1 %48, label %49, label %50

49:                                               ; preds = %38
  store i32 (i32, i32)* @add_one, i32 (i32, i32)** %16, align 8
  br label %107

50:                                               ; preds = %38
  %51 = load i8**, i8*** %14, align 8
  %52 = getelementptr inbounds i8*, i8** %51, i64 1
  %53 = load i8*, i8** %52, align 8
  store i8* %53, i8** %6, align 8
  store i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), i8** %7, align 8
  %54 = load i8*, i8** %6, align 8
  %55 = call i64 @strlen(i8* %54) #4
  %56 = load i8*, i8** %7, align 8
  %57 = call i64 @strlen(i8* %56) #4
  %58 = icmp ult i64 %55, %57
  br i1 %58, label %59, label %62

59:                                               ; preds = %50
  %60 = load i8*, i8** %6, align 8
  %61 = call i64 @strlen(i8* %60) #4
  br label %65

62:                                               ; preds = %50
  %63 = load i8*, i8** %7, align 8
  %64 = call i64 @strlen(i8* %63) #4
  br label %65

65:                                               ; preds = %59, %62
  %66 = phi i64 [ %61, %59 ], [ %64, %62 ]
  %67 = trunc i64 %66 to i32
  store i32 %67, i32* %8, align 4
  %68 = load i8*, i8** %6, align 8
  %69 = load i8*, i8** %7, align 8
  %70 = load i32, i32* %8, align 4
  %71 = sext i32 %70 to i64
  %72 = call i32 @strncmp(i8* %68, i8* %69, i64 %71) #4
  %73 = icmp eq i32 %72, 0
  %74 = zext i1 %73 to i32
  %75 = icmp ne i32 %74, 0
  br i1 %75, label %76, label %77

76:                                               ; preds = %65
  store i32 (i32, i32)* @add_two, i32 (i32, i32)** %16, align 8
  br label %106

77:                                               ; preds = %65
  %78 = load i8**, i8*** %14, align 8
  %79 = getelementptr inbounds i8*, i8** %78, i64 1
  %80 = load i8*, i8** %79, align 8
  store i8* %80, i8** %3, align 8
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i8** %4, align 8
  %81 = load i8*, i8** %3, align 8
  %82 = call i64 @strlen(i8* %81) #4
  %83 = load i8*, i8** %4, align 8
  %84 = call i64 @strlen(i8* %83) #4
  %85 = icmp ult i64 %82, %84
  br i1 %85, label %86, label %89

86:                                               ; preds = %77
  %87 = load i8*, i8** %3, align 8
  %88 = call i64 @strlen(i8* %87) #4
  br label %92

89:                                               ; preds = %77
  %90 = load i8*, i8** %4, align 8
  %91 = call i64 @strlen(i8* %90) #4
  br label %92

92:                                               ; preds = %86, %89
  %93 = phi i64 [ %88, %86 ], [ %91, %89 ]
  %94 = trunc i64 %93 to i32
  store i32 %94, i32* %5, align 4
  %95 = load i8*, i8** %3, align 8
  %96 = load i8*, i8** %4, align 8
  %97 = load i32, i32* %5, align 4
  %98 = sext i32 %97 to i64
  %99 = call i32 @strncmp(i8* %95, i8* %96, i64 %98) #4
  %100 = icmp eq i32 %99, 0
  %101 = zext i1 %100 to i32
  %102 = icmp ne i32 %101, 0
  br i1 %102, label %103, label %104

103:                                              ; preds = %92
  store i32 (i32, i32)* @add_three, i32 (i32, i32)** %16, align 8
  br label %105

104:                                              ; preds = %92
  br label %105

105:                                              ; preds = %104, %103
  br label %106

106:                                              ; preds = %105, %76
  br label %107

107:                                              ; preds = %106, %49
  br label %109

108:                                              ; preds = %20
  br label %109

109:                                              ; preds = %108, %107
  br label %110

110:                                              ; preds = %109, %19
  %111 = load i32 (i32, i32)*, i32 (i32, i32)** %16, align 8
  %112 = icmp ne i32 (i32, i32)* %111, null
  br i1 %112, label %113, label %119

113:                                              ; preds = %110
  %114 = load i32 (i32, i32)*, i32 (i32, i32)** %16, align 8
  %115 = load i32, i32* %13, align 4
  %116 = add nsw i32 %115, 3
  %117 = load i32, i32* %13, align 4
  %118 = call i32 %114(i32 %116, i32 %117)
  store i32 %118, i32* %15, align 4
  br label %120

119:                                              ; preds = %110
  br label %120

120:                                              ; preds = %119, %113
  %121 = load i32, i32* %15, align 4
  %122 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.3, i64 0, i64 0), i32 %121)
  %123 = load i32, i32* %15, align 4
  ret i32 %123
}

declare dso_local i32 @add_one(i32, i32) #3

declare dso_local i32 @add_two(i32, i32) #3

declare dso_local i32 @add_three(i32, i32) #3

declare dso_local i32 @printf(i8*, ...) #3

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

; ModuleID = 'slash/main.a.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@global = dso_local global i32 666, align 4
@global2 = external dso_local global i32, align 4
@.str = private unnamed_addr constant [2 x i8] c"Z\00", align 1
@p = internal global i8* null, align 8
@stderr = external dso_local global %struct._IO_FILE*, align 8
@.str.1 = private unnamed_addr constant [19 x i8] c"main returning %d\0A\00", align 1
@new_argv = private constant [5 x i8] c"main\00"
@new_argv.1 = private constant [5 x i8] c"8181\00"

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @0(i32 %0, i8** %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8**, align 8
  %6 = alloca i32, align 4
  store i32 0, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  store i8** %1, i8*** %5, align 8
  store i32 0, i32* %6, align 4
  %7 = load i32, i32* %4, align 4
  %8 = icmp eq i32 %7, 1
  br i1 %8, label %9, label %10

9:                                                ; preds = %2
  br label %80

10:                                               ; preds = %2
  %11 = load i32, i32* %4, align 4
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %75

13:                                               ; preds = %10
  %14 = load i8**, i8*** %5, align 8
  %15 = getelementptr inbounds i8*, i8** %14, i64 1
  %16 = load i8*, i8** %15, align 8
  %17 = call i64 @atol(i8* %16) #5
  %18 = trunc i64 %17 to i32
  %19 = call i32 @libcall_int(i32 1, i32 %18)
  %20 = load i8**, i8*** %5, align 8
  %21 = getelementptr inbounds i8*, i8** %20, i64 1
  %22 = load i8*, i8** %21, align 8
  %23 = call i64 @atol(i8* %22) #5
  %24 = trunc i64 %23 to i32
  %25 = call i32 @libcall_int(i32 2, i32 %24)
  %26 = mul nsw i32 %19, %25
  %27 = load i32, i32* @global, align 4
  %28 = load i8**, i8*** %5, align 8
  %29 = getelementptr inbounds i8*, i8** %28, i64 1
  %30 = load i8*, i8** %29, align 8
  %31 = call i64 @atol(i8* %30) #5
  %32 = trunc i64 %31 to i32
  %33 = call i32 @libcall_int(i32 %27, i32 %32)
  %34 = mul nsw i32 %26, %33
  %35 = load i32, i32* @global2, align 4
  %36 = load i8**, i8*** %5, align 8
  %37 = getelementptr inbounds i8*, i8** %36, i64 1
  %38 = load i8*, i8** %37, align 8
  %39 = call i64 @atol(i8* %38) #5
  %40 = trunc i64 %39 to i32
  %41 = call i32 @libcall_int(i32 %35, i32 %40)
  %42 = mul nsw i32 %34, %41
  %43 = load i8**, i8*** %5, align 8
  %44 = getelementptr inbounds i8*, i8** %43, i64 1
  %45 = load i8*, i8** %44, align 8
  %46 = call i64 @strlen(i8* %45) #5
  %47 = trunc i64 %46 to i32
  %48 = call i32 @libcall_float(i32 %47, float 5.000000e-01)
  %49 = mul nsw i32 %42, %48
  %50 = load i8**, i8*** %5, align 8
  %51 = getelementptr inbounds i8*, i8** %50, i64 1
  %52 = load i8*, i8** %51, align 8
  %53 = call i64 @strlen(i8* %52) #5
  %54 = trunc i64 %53 to i32
  %55 = call i32 @libcall_double(i32 %54, double 7.500000e-01)
  %56 = mul nsw i32 %49, %55
  %57 = call i32 @libcall_null_pointer(i32 4, i8* null)
  %58 = mul nsw i32 %56, %57
  %59 = call i32 @libcall_string(i32 5, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0))
  %60 = mul nsw i32 %58, %59
  %61 = load i8**, i8*** %5, align 8
  %62 = getelementptr inbounds i8*, i8** %61, i64 1
  %63 = load i8*, i8** %62, align 8
  %64 = call i64 @strlen(i8* %63) #5
  %65 = trunc i64 %64 to i32
  %66 = call i32 @libcall_global_pointer(i32 %65, i8* bitcast (i32 (i32, i8*)* @libcall_global_pointer to i8*))
  %67 = mul nsw i32 %60, %66
  store i32 %67, i32* %6, align 4
  %68 = load i8**, i8*** %5, align 8
  %69 = getelementptr inbounds i8*, i8** %68, i64 1
  %70 = load i8*, i8** %69, align 8
  %71 = call i64 @strlen(i8* %70) #5
  %72 = trunc i64 %71 to i32
  %73 = load i8*, i8** @p, align 8
  %74 = call i32 @libcall_global_pointer(i32 %72, i8* %73)
  br label %79

75:                                               ; preds = %10
  %76 = load i32, i32* %4, align 4
  %77 = load i32, i32* %4, align 4
  %78 = call i32 @libcall_int(i32 %76, i32 %77)
  store i32 %78, i32* %6, align 4
  br label %79

79:                                               ; preds = %75, %13
  br label %80

80:                                               ; preds = %79, %9
  %81 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %82 = load i32, i32* %6, align 4
  %83 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %81, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i64 0, i64 0), i32 %82)
  %84 = load i32, i32* %6, align 4
  ret i32 %84
}

; Function Attrs: nounwind readonly
declare dso_local i64 @atol(i8*) #1

declare dso_local i32 @libcall_int(i32, i32) #2

; Function Attrs: nounwind readonly
declare dso_local i64 @strlen(i8*) #1

declare dso_local i32 @libcall_float(i32, float) #2

declare dso_local i32 @libcall_double(i32, double) #2

declare dso_local i32 @libcall_null_pointer(i32, i8*) #2

declare dso_local i32 @libcall_string(i32, i8*) #2

declare dso_local i32 @libcall_global_pointer(i32, i8*) #2

declare dso_local i32 @fprintf(%struct._IO_FILE*, i8*, ...) #2

define i32 @main(i32 %0, i8** %1) {
entry:
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i8**, align 8
  %5 = alloca i32, align 4
  %6 = icmp eq i32 %0, 1
  br i1 %6, label %entry1, label %incorrect_argc

entry1:                                           ; preds = %entry
  %new_argc = add i32 %0, 1
  %7 = icmp eq i32 %0, 1
  call void @llvm.assume(i1 %7)
  %8 = add i32 %new_argc, 1
  %9 = sext i32 %8 to i64
  %mallocsize = mul i64 %9, 8
  %malloccall = tail call i8* @malloc(i64 %mallocsize)
  %10 = bitcast i8* %malloccall to i8**
  %11 = getelementptr i8*, i8** %10, i32 0
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv, i32 0, i32 0), i8** %11
  %12 = getelementptr i8*, i8** %10, i32 1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv.1, i32 0, i32 0), i8** %12
  %13 = getelementptr inbounds i8*, i8** %10, i32 %new_argc
  store i8* null, i8** %13
  br label %pre_header

incorrect_argc:                                   ; preds = %entry
  ret i32 1

pre_header:                                       ; preds = %entry1
  %14 = alloca i32
  store i32 1, i32* %14
  br label %header

header:                                           ; preds = %body, %pre_header
  %15 = load i32, i32* %14
  %16 = icmp slt i32 %15, %0
  br i1 %16, label %body, label %tail

body:                                             ; preds = %header
  %17 = add i32 1, %15
  %18 = zext i32 %17 to i64
  %19 = getelementptr inbounds i8*, i8** %10, i64 %18
  %20 = zext i32 %15 to i64
  %21 = getelementptr inbounds i8*, i8** %1, i64 %20
  %22 = load i8*, i8** %21
  store i8* %22, i8** %19
  %23 = add i32 %15, 1
  store i32 %23, i32* %14
  br label %header

tail:                                             ; preds = %header
  %24 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %24)
  %25 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %25)
  %26 = bitcast i8*** %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* %26)
  %27 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %27)
  store i32 0, i32* %2, align 4
  store i32 %new_argc, i32* %3, align 4
  store i8** %10, i8*** %4, align 8
  store i32 0, i32* %5, align 4
  %28 = load i32, i32* %3, align 4
  %29 = icmp eq i32 %28, 1
  br i1 %29, label %30, label %31

30:                                               ; preds = %tail
  br label %.exit

31:                                               ; preds = %tail
  %32 = load i32, i32* %3, align 4
  %33 = icmp eq i32 %32, 2
  br i1 %33, label %34, label %96

34:                                               ; preds = %31
  %35 = load i8**, i8*** %4, align 8
  %36 = getelementptr inbounds i8*, i8** %35, i64 1
  %37 = load i8*, i8** %36, align 8
  %38 = call i64 @atol(i8* %37) #5
  %39 = trunc i64 %38 to i32
  %40 = call i32 @libcall_int(i32 1, i32 %39) #6
  %41 = load i8**, i8*** %4, align 8
  %42 = getelementptr inbounds i8*, i8** %41, i64 1
  %43 = load i8*, i8** %42, align 8
  %44 = call i64 @atol(i8* %43) #5
  %45 = trunc i64 %44 to i32
  %46 = call i32 @libcall_int(i32 2, i32 %45) #6
  %47 = mul nsw i32 %40, %46
  %48 = load i32, i32* @global, align 4
  %49 = load i8**, i8*** %4, align 8
  %50 = getelementptr inbounds i8*, i8** %49, i64 1
  %51 = load i8*, i8** %50, align 8
  %52 = call i64 @atol(i8* %51) #5
  %53 = trunc i64 %52 to i32
  %54 = call i32 @libcall_int(i32 %48, i32 %53) #6
  %55 = mul nsw i32 %47, %54
  %56 = load i32, i32* @global2, align 4
  %57 = load i8**, i8*** %4, align 8
  %58 = getelementptr inbounds i8*, i8** %57, i64 1
  %59 = load i8*, i8** %58, align 8
  %60 = call i64 @atol(i8* %59) #5
  %61 = trunc i64 %60 to i32
  %62 = call i32 @libcall_int(i32 %56, i32 %61) #6
  %63 = mul nsw i32 %55, %62
  %64 = load i8**, i8*** %4, align 8
  %65 = getelementptr inbounds i8*, i8** %64, i64 1
  %66 = load i8*, i8** %65, align 8
  %67 = call i64 @strlen(i8* %66) #5
  %68 = trunc i64 %67 to i32
  %69 = call i32 @libcall_float(i32 %68, float 5.000000e-01) #6
  %70 = mul nsw i32 %63, %69
  %71 = load i8**, i8*** %4, align 8
  %72 = getelementptr inbounds i8*, i8** %71, i64 1
  %73 = load i8*, i8** %72, align 8
  %74 = call i64 @strlen(i8* %73) #5
  %75 = trunc i64 %74 to i32
  %76 = call i32 @libcall_double(i32 %75, double 7.500000e-01) #6
  %77 = mul nsw i32 %70, %76
  %78 = call i32 @libcall_null_pointer(i32 4, i8* null) #6
  %79 = mul nsw i32 %77, %78
  %80 = call i32 @libcall_string(i32 5, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0)) #6
  %81 = mul nsw i32 %79, %80
  %82 = load i8**, i8*** %4, align 8
  %83 = getelementptr inbounds i8*, i8** %82, i64 1
  %84 = load i8*, i8** %83, align 8
  %85 = call i64 @strlen(i8* %84) #5
  %86 = trunc i64 %85 to i32
  %87 = call i32 @libcall_global_pointer(i32 %86, i8* bitcast (i32 (i32, i8*)* @libcall_global_pointer to i8*)) #6
  %88 = mul nsw i32 %81, %87
  store i32 %88, i32* %5, align 4
  %89 = load i8**, i8*** %4, align 8
  %90 = getelementptr inbounds i8*, i8** %89, i64 1
  %91 = load i8*, i8** %90, align 8
  %92 = call i64 @strlen(i8* %91) #5
  %93 = trunc i64 %92 to i32
  %94 = load i8*, i8** @p, align 8
  %95 = call i32 @libcall_global_pointer(i32 %93, i8* %94) #6
  br label %100

96:                                               ; preds = %31
  %97 = load i32, i32* %3, align 4
  %98 = load i32, i32* %3, align 4
  %99 = call i32 @libcall_int(i32 %97, i32 %98) #6
  store i32 %99, i32* %5, align 4
  br label %100

100:                                              ; preds = %96, %34
  br label %.exit

.exit:                                            ; preds = %30, %100
  %101 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %102 = load i32, i32* %5, align 4
  %103 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %101, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i64 0, i64 0), i32 %102) #6
  %104 = load i32, i32* %5, align 4
  %105 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %105)
  %106 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %106)
  %107 = bitcast i8*** %4 to i8*
  call void @llvm.lifetime.end.p0i8(i64 8, i8* %107)
  %108 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %108)
  ret i32 %104
}

; Function Attrs: nounwind willreturn
declare void @llvm.assume(i1) #3

declare noalias i8* @malloc(i64)

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #4

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #4

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind willreturn }
attributes #4 = { argmemonly nounwind willreturn }
attributes #5 = { nounwind readonly }
attributes #6 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

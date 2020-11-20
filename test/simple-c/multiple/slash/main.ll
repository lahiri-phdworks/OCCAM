; ModuleID = 'slash/main.bc'
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

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 %0, i8** %1) #0 {
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
  %17 = call i64 @atol(i8* %16) #3
  %18 = trunc i64 %17 to i32
  %19 = call i32 @libcall_int(i32 1, i32 %18)
  %20 = load i8**, i8*** %5, align 8
  %21 = getelementptr inbounds i8*, i8** %20, i64 1
  %22 = load i8*, i8** %21, align 8
  %23 = call i64 @atol(i8* %22) #3
  %24 = trunc i64 %23 to i32
  %25 = call i32 @libcall_int(i32 2, i32 %24)
  %26 = mul nsw i32 %19, %25
  %27 = load i32, i32* @global, align 4
  %28 = load i8**, i8*** %5, align 8
  %29 = getelementptr inbounds i8*, i8** %28, i64 1
  %30 = load i8*, i8** %29, align 8
  %31 = call i64 @atol(i8* %30) #3
  %32 = trunc i64 %31 to i32
  %33 = call i32 @libcall_int(i32 %27, i32 %32)
  %34 = mul nsw i32 %26, %33
  %35 = load i32, i32* @global2, align 4
  %36 = load i8**, i8*** %5, align 8
  %37 = getelementptr inbounds i8*, i8** %36, i64 1
  %38 = load i8*, i8** %37, align 8
  %39 = call i64 @atol(i8* %38) #3
  %40 = trunc i64 %39 to i32
  %41 = call i32 @libcall_int(i32 %35, i32 %40)
  %42 = mul nsw i32 %34, %41
  %43 = load i8**, i8*** %5, align 8
  %44 = getelementptr inbounds i8*, i8** %43, i64 1
  %45 = load i8*, i8** %44, align 8
  %46 = call i64 @strlen(i8* %45) #3
  %47 = trunc i64 %46 to i32
  %48 = call i32 @libcall_float(i32 %47, float 5.000000e-01)
  %49 = mul nsw i32 %42, %48
  %50 = load i8**, i8*** %5, align 8
  %51 = getelementptr inbounds i8*, i8** %50, i64 1
  %52 = load i8*, i8** %51, align 8
  %53 = call i64 @strlen(i8* %52) #3
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
  %64 = call i64 @strlen(i8* %63) #3
  %65 = trunc i64 %64 to i32
  %66 = call i32 @libcall_global_pointer(i32 %65, i8* bitcast (i32 (i32, i8*)* @libcall_global_pointer to i8*))
  %67 = mul nsw i32 %60, %66
  store i32 %67, i32* %6, align 4
  %68 = load i8**, i8*** %5, align 8
  %69 = getelementptr inbounds i8*, i8** %68, i64 1
  %70 = load i8*, i8** %69, align 8
  %71 = call i64 @strlen(i8* %70) #3
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

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

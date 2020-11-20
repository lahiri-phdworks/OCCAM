; ModuleID = 'slash/main.a.i.p.s.r.i.h.p.s.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@global2 = external dso_local local_unnamed_addr global i32, align 4
@stderr = external dso_local local_unnamed_addr global %struct._IO_FILE*, align 8
@.str.1 = private unnamed_addr constant [19 x i8] c"main returning %d\0A\00", align 1
@new_argv = private constant [5 x i8] c"main\00"
@new_argv.1 = private constant [5 x i8] c"8181\00"

; Function Attrs: nounwind readonly
declare dso_local i64 @atol(i8*) local_unnamed_addr #0

declare dso_local i32 @libcall_int(i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind readonly
declare dso_local i64 @strlen(i8*) local_unnamed_addr #0

declare dso_local i32 @libcall_global_pointer(i32, i8*) #1

declare dso_local i32 @fprintf(%struct._IO_FILE*, i8*, ...) local_unnamed_addr #1

define i32 @main(i32 %0, i8** nocapture readonly %1) local_unnamed_addr {
entry:
  %2 = icmp eq i32 %0, 1
  br i1 %2, label %entry1, label %incorrect_argc

entry1:                                           ; preds = %entry
  %malloccall = tail call i8* @malloc(i64 24)
  %3 = bitcast i8* %malloccall to i8**
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv, i64 0, i64 0), i8** %3, align 8
  %4 = getelementptr i8, i8* %malloccall, i64 8
  %5 = bitcast i8* %4 to i8**
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv.1, i64 0, i64 0), i8** %5, align 8
  %6 = getelementptr inbounds i8, i8* %malloccall, i64 16
  %7 = bitcast i8* %6 to i8**
  store i8* null, i8** %7, align 8
  %8 = tail call i64 @atol(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv.1, i64 0, i64 0)) #2
  %9 = trunc i64 %8 to i32
  %10 = tail call i32 @"__occam_spec.libcall_int(0x1,?)"(i32 %9)
  %11 = tail call i64 @atol(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv.1, i64 0, i64 0)) #2
  %12 = trunc i64 %11 to i32
  %13 = tail call i32 @"__occam_spec.libcall_int(0x2,?)"(i32 %12)
  %14 = mul nsw i32 %13, %10
  %15 = tail call i64 @atol(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv.1, i64 0, i64 0)) #2
  %16 = trunc i64 %15 to i32
  %17 = tail call i32 @"__occam_spec.libcall_int(0x29A,?)"(i32 %16)
  %18 = mul nsw i32 %14, %17
  %19 = load i32, i32* @global2, align 4
  %20 = tail call i64 @atol(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv.1, i64 0, i64 0)) #2
  %21 = trunc i64 %20 to i32
  %22 = tail call i32 @libcall_int(i32 %19, i32 %21) #3
  %23 = mul nsw i32 %18, %22
  %24 = tail call i64 @strlen(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv.1, i64 0, i64 0)) #2
  %25 = trunc i64 %24 to i32
  %26 = tail call i32 @"__occam_spec.libcall_float(?,0x1p-1)"(i32 %25)
  %27 = mul nsw i32 %23, %26
  %28 = tail call i64 @strlen(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv.1, i64 0, i64 0)) #2
  %29 = trunc i64 %28 to i32
  %30 = tail call i32 @"__occam_spec.libcall_double(?,0x1.8p-1)"(i32 %29)
  %31 = mul nsw i32 %27, %30
  %32 = tail call i32 @"__occam_spec.libcall_null_pointer(0x4,null)"()
  %33 = mul nsw i32 %31, %32
  %34 = tail call i32 @"__occam_spec.libcall_string(0x5,S:B9A)"()
  %35 = mul nsw i32 %33, %34
  %36 = tail call i64 @strlen(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv.1, i64 0, i64 0)) #2
  %37 = trunc i64 %36 to i32
  %38 = tail call i32 @libcall_global_pointer(i32 %37, i8* bitcast (i32 (i32, i8*)* @libcall_global_pointer to i8*)) #3
  %39 = mul nsw i32 %35, %38
  %40 = tail call i64 @strlen(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @new_argv.1, i64 0, i64 0)) #2
  %41 = trunc i64 %40 to i32
  %42 = tail call i32 @"__occam_spec.libcall_global_pointer(?,null)"(i32 %41)
  %43 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %44 = tail call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %43, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i64 0, i64 0), i32 %39) #3
  ret i32 %39

incorrect_argc:                                   ; preds = %entry
  ret i32 1
}

declare noalias i8* @malloc(i64) local_unnamed_addr

declare i32 @"__occam_spec.libcall_double(?,0x1.8p-1)"(i32) local_unnamed_addr

declare i32 @"__occam_spec.libcall_float(?,0x1p-1)"(i32) local_unnamed_addr

declare i32 @"__occam_spec.libcall_global_pointer(?,null)"(i32) local_unnamed_addr

declare i32 @"__occam_spec.libcall_int(0x29A,?)"(i32) local_unnamed_addr

declare i32 @"__occam_spec.libcall_int(0x2,?)"(i32) local_unnamed_addr

declare i32 @"__occam_spec.libcall_int(0x1,?)"(i32) local_unnamed_addr

declare i32 @"__occam_spec.libcall_null_pointer(0x4,null)"() local_unnamed_addr

declare i32 @"__occam_spec.libcall_string(0x5,S:B9A)"() local_unnamed_addr

attributes #0 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

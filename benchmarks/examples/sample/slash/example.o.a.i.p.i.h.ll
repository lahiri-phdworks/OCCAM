; ModuleID = 'slash/example.o.a.i.p.i.h.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@new_argv = private constant [8 x i8] c"example\00"
@new_argv.1 = private constant [6 x i8] c"sumit\00"
@new_argv.2 = private constant [7 x i8] c"lahiri\00"

define i32 @main(i32 %0, i8** nocapture readonly %1) local_unnamed_addr {
entry:
  %2 = icmp eq i32 %0, 1
  br i1 %2, label %entry1, label %incorrect_argc

entry1:                                           ; preds = %entry
  %malloccall = tail call i8* @malloc(i64 32)
  %3 = bitcast i8* %malloccall to i8**
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @new_argv, i64 0, i64 0), i8** %3, align 8
  %4 = getelementptr i8, i8* %malloccall, i64 8
  %5 = bitcast i8* %4 to i8**
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @new_argv.1, i64 0, i64 0), i8** %5, align 8
  %6 = getelementptr i8, i8* %malloccall, i64 16
  %7 = bitcast i8* %6 to i8**
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @new_argv.2, i64 0, i64 0), i8** %7, align 8
  %8 = getelementptr inbounds i8, i8* %malloccall, i64 24
  %9 = bitcast i8* %8 to i8**
  store i8* null, i8** %9, align 8
  br label %incorrect_argc

incorrect_argc:                                   ; preds = %entry1, %entry
  %merge = phi i32 [ 1, %entry ], [ -1, %entry1 ]
  ret i32 %merge
}

declare noalias i8* @malloc(i64) local_unnamed_addr

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}

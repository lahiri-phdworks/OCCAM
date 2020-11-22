; ModuleID = 'slash/example.o-final.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@0 = private constant [8 x i8] c"example\00"
@1 = private constant [6 x i8] c"sumit\00"
@2 = private constant [7 x i8] c"lahiri\00"

define i32 @main(i32 %0, i8** nocapture readonly %1) local_unnamed_addr {
  %3 = icmp eq i32 %0, 1
  br i1 %3, label %4, label %13

4:                                                ; preds = %2
  %5 = tail call i8* @malloc(i64 32)
  %6 = bitcast i8* %5 to i8**
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @0, i64 0, i64 0), i8** %6, align 8
  %7 = getelementptr i8, i8* %5, i64 8
  %8 = bitcast i8* %7 to i8**
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @1, i64 0, i64 0), i8** %8, align 8
  %9 = getelementptr i8, i8* %5, i64 16
  %10 = bitcast i8* %9 to i8**
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @2, i64 0, i64 0), i8** %10, align 8
  %11 = getelementptr inbounds i8, i8* %5, i64 24
  %12 = bitcast i8* %11 to i8**
  store i8* null, i8** %12, align 8
  br label %13

13:                                               ; preds = %4, %2
  %14 = phi i32 [ 1, %2 ], [ -1, %4 ]
  ret i32 %14
}

declare noalias i8* @malloc(i64) local_unnamed_addr

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}

; ModuleID = 'slash/main.o.a.i.p.s.r.i.h.p.s.r.i.h.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@_fun = common dso_local local_unnamed_addr global i32 (i32)* null, align 8
@.str = private unnamed_addr constant [29 x i8] c"you should see this message\0A\00", align 1
@.str.1 = private unnamed_addr constant [33 x i8] c"you should NOT see this message\0A\00", align 1

; Function Attrs: noinline norecurse nounwind readnone uwtable
define dso_local i32 @incr(i32 %0) #0 {
  %2 = add nsw i32 %0, 1
  ret i32 %2
}

; Function Attrs: nofree noinline norecurse nounwind uwtable writeonly
define internal fastcc void @init() unnamed_addr #1 {
  store i32 (i32)* @incr, i32 (i32)** @_fun, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #2 {
  tail call fastcc void @init()
  %1 = tail call i32 @"__occam_spec.execute_call(incr,0x5)"() #4
  %2 = icmp eq i32 %1, 6
  %.sink = select i1 %2, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.1, i64 0, i64 0)
  %3 = tail call i32 (i8*, ...) @printf(i8* %.sink) #4
  ret i32 0
}

declare dso_local i32 @printf(i8*, ...) local_unnamed_addr #3

declare i32 @"__occam_spec.execute_call(incr,0x5)"() local_unnamed_addr

; Function Attrs: noinline norecurse nounwind readnone uwtable
define dso_local i32 @"__occam_spec.incr(0x5)"() #0 {
  %1 = add nsw i32 5, 1
  ret i32 %1
}

attributes #0 = { noinline norecurse nounwind readnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree noinline norecurse nounwind uwtable writeonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"Ubuntu clang version 10.0.1-++20201112101950+ef32c611aa2-1~exp1~20201112092551.202"}
!1 = !{i32 1, !"wchar_size", i32 4}

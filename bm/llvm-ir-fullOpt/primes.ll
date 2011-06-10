; ModuleID = 'fabl'

@int_format_string = internal constant [3 x i8] c"%d\00"
@string_format_string = internal constant [3 x i8] c"%s\00"
@true_string = internal constant [5 x i8] c"true\00"
@false_string = internal constant [6 x i8] c"false\00"
@__nil__ = internal global i32 0
@0 = internal constant [2 x i8] c"\0A\00"

declare i32 @printf(i8*, ...)

declare i32 @scanf(i8*, ...)

declare i8* @malloc(i32)

declare void @exit(i32)

define void @_read_int(i32*) {
  %int_store = alloca i32, align 4
  %2 = call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([3 x i8]* @int_format_string, i64 0, i64 0), i32* %int_store)
  %int_return = load i32* %int_store, align 4
  store i32 %int_return, i32* %0, align 4
  ret void
}

define void @_write_int(i32) {
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @int_format_string, i64 0, i64 0), i32 %0)
  ret void
}

define void @_write_string(i8*) {
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @string_format_string, i64 0, i64 0), i8* %0)
  ret void
}

define void @_write_bool(i1) {
  br i1 %0, label %2, label %3

; <label>:2                                       ; preds = %1
  call void @_write_string(i8* getelementptr inbounds ([5 x i8]* @true_string, i64 0, i64 0))
  br label %4

; <label>:3                                       ; preds = %1
  call void @_write_string(i8* getelementptr inbounds ([6 x i8]* @false_string, i64 0, i64 0))
  br label %4

; <label>:4                                       ; preds = %3, %2
  ret void
}

define i32 @"$main"() {
; <label>:0
  call void @_write_int(i32 2)
  call void @_write_string(i8* getelementptr inbounds ([2 x i8]* @0, i64 0, i64 0))
  br label %1

; <label>:1                                       ; preds = %0, %8
  %i_3.05 = phi i32 [ 3, %0 ], [ %loop_temp2, %8 ]
  %t_1 = add i32 %i_3.05, -1
  %2 = icmp sgt i32 2, %t_1
  br i1 %2, label %6, label %.lr.ph

.lr.ph:                                           ; preds = %1
  br label %4

; <label>:3                                       ; preds = %8
  ret i32 0

; <label>:4                                       ; preds = %.lr.ph, %4
  %j_4.04 = phi i32 [ 2, %.lr.ph ], [ %loop_temp, %4 ]
  %prime_5.03 = phi i1 [ true, %.lr.ph ], [ %.prime_5.0, %4 ]
  %t_4 = srem i32 %i_3.05, %j_4.04
  %not.t_5 = icmp ne i32 %t_4, 0
  %.prime_5.0 = and i1 %prime_5.03, %not.t_5
  %loop_temp = add i32 %j_4.04, 1
  %5 = icmp sgt i32 %loop_temp, %t_1
  br i1 %5, label %._crit_edge, label %4

._crit_edge:                                      ; preds = %4
  %split = phi i1 [ %.prime_5.0, %4 ]
  br label %6

; <label>:6                                       ; preds = %._crit_edge, %1
  %prime_5.0.lcssa = phi i1 [ %split, %._crit_edge ], [ true, %1 ]
  br i1 %prime_5.0.lcssa, label %7, label %8

; <label>:7                                       ; preds = %6
  call void @_write_int(i32 %i_3.05)
  call void @_write_string(i8* getelementptr inbounds ([2 x i8]* @0, i64 0, i64 0))
  br label %8

; <label>:8                                       ; preds = %6, %7
  %loop_temp2 = add i32 %i_3.05, 1
  %9 = icmp slt i32 %loop_temp2, 50001
  br i1 %9, label %1, label %3
}

define i32 @main() {
  %1 = call i32 @"$main"()
  ret i32 %1
}

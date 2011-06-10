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
  %int_store = alloca i32
  %2 = call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([3 x i8]* @int_format_string, i32 0, i32 0), i32* %int_store)
  %int_return = load i32* %int_store
  store i32 %int_return, i32* %0
  ret void
}

define void @_write_int(i32) {
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @int_format_string, i32 0, i32 0), i32 %0)
  ret void
}

define void @_write_string(i8*) {
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @string_format_string, i32 0, i32 0), i8* %0)
  ret void
}

define void @_write_bool(i1) {
  br i1 %0, label %2, label %3

; <label>:2                                       ; preds = %1
  call void @_write_string(i8* getelementptr inbounds ([5 x i8]* @true_string, i32 0, i32 0))
  br label %4

; <label>:3                                       ; preds = %1
  call void @_write_string(i8* getelementptr inbounds ([6 x i8]* @false_string, i32 0, i32 0))
  br label %4

; <label>:4                                       ; preds = %3, %2
  ret void
}

define i32 @"$main"() {
; <label>:0
  call void @_write_int(i32 2)
  call void @_write_string(i8* getelementptr inbounds ([2 x i8]* @0, i32 0, i32 0))
  br label %1

; <label>:1                                       ; preds = %12, %0
  %i_3.0 = phi i32 [ 3, %0 ], [ %loop_temp2, %12 ]
  %2 = icmp sle i32 %i_3.0, 50000
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %1
  %t_1 = sub i32 %i_3.0, 1
  br label %5

; <label>:4                                       ; preds = %1
  ret i32 0

; <label>:5                                       ; preds = %7, %3
  %prime_5.0 = phi i1 [ true, %3 ], [ %.prime_5.0, %7 ]
  %j_4.0 = phi i32 [ 2, %3 ], [ %loop_temp, %7 ]
  %6 = icmp sle i32 %j_4.0, %t_1
  br i1 %6, label %7, label %9

; <label>:7                                       ; preds = %5
  %t_4 = srem i32 %i_3.0, %j_4.0
  %t_5 = icmp eq i32 %t_4, 0
  %8 = icmp eq i1 %t_5, true
  %.prime_5.0 = select i1 %8, i1 false, i1 %prime_5.0
  %loop_temp = add i32 %j_4.0, 1
  br label %5

; <label>:9                                       ; preds = %5
  %10 = icmp eq i1 %prime_5.0, true
  br i1 %10, label %11, label %12

; <label>:11                                      ; preds = %9
  call void @_write_int(i32 %i_3.0)
  call void @_write_string(i8* getelementptr inbounds ([2 x i8]* @0, i32 0, i32 0))
  br label %12

; <label>:12                                      ; preds = %9, %11
  %loop_temp2 = add i32 %i_3.0, 1
  br label %1
}

define i32 @main() {
  %1 = call i32 @"$main"()
  ret i32 %1
}

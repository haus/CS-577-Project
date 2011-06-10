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
  %i_3 = alloca i32
  store i32 0, i32* %i_3
  %j_4 = alloca i32
  store i32 0, i32* %j_4
  %prime_5 = alloca i1
  store i1 false, i1* %prime_5
  call void @_write_int(i32 2)
  call void @_write_string(i8* getelementptr inbounds ([2 x i8]* @0, i32 0, i32 0))
  store i32 3, i32* %i_3
  br label %2

; <label>:1                                       ; preds = %5
  ret i32 0

; <label>:2                                       ; preds = %17, %0
  %loop_val = load i32* %i_3
  %3 = icmp sle i32 %loop_val, 1000000
  br i1 %3, label %4, label %5

; <label>:4                                       ; preds = %2
  store i1 true, i1* %prime_5
  %t_0 = load i32* %i_3
  %t_1 = sub i32 %t_0, 1
  store i32 2, i32* %j_4
  br label %6

; <label>:5                                       ; preds = %2
  br label %1

; <label>:6                                       ; preds = %14, %4
  %loop_val1 = load i32* %j_4
  %7 = icmp sle i32 %loop_val1, %t_1
  br i1 %7, label %8, label %10

; <label>:8                                       ; preds = %6
  %t_2 = load i32* %i_3
  %t_3 = load i32* %j_4
  %t_4 = srem i32 %t_2, %t_3
  %t_5 = icmp eq i32 %t_4, 0
  %9 = icmp eq i1 %t_5, true
  br i1 %9, label %12, label %13

; <label>:10                                      ; preds = %6
  %t_6 = load i1* %prime_5
  %11 = icmp eq i1 %t_6, true
  br i1 %11, label %15, label %16

; <label>:12                                      ; preds = %8
  store i32 2, i32* %j_4
  store i1 false, i1* %prime_5
  br label %14

; <label>:13                                      ; preds = %8
  br label %14

; <label>:14                                      ; preds = %13, %12
  %loop_temp = add i32 %loop_val1, 1
  store i32 %loop_temp, i32* %j_4
  br label %6

; <label>:15                                      ; preds = %10
  %t_7 = load i32* %i_3
  call void @_write_int(i32 %t_7)
  call void @_write_string(i8* getelementptr inbounds ([2 x i8]* @0, i32 0, i32 0))
  br label %17

; <label>:16                                      ; preds = %10
  br label %17

; <label>:17                                      ; preds = %16, %15
  %loop_temp2 = add i32 %loop_val, 1
  store i32 %loop_temp2, i32* %i_3
  br label %2
}

define i32 @main() {
  %1 = call i32 @"$main"()
  ret i32 %1
}

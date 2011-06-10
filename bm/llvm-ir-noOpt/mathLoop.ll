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
  %a_3 = alloca i32
  store i32 4, i32* %a_3
  %b_4 = alloca i32
  store i32 5, i32* %b_4
  %c_5 = alloca i32
  store i32 6, i32* %c_5
  %d_6 = alloca i32
  store i32 0, i32* %d_6
  %e_7 = alloca i32
  store i32 0, i32* %e_7
  %i_8 = alloca i32
  store i32 0, i32* %i_8
  store i32 0, i32* %i_8
  br label %2

; <label>:1                                       ; preds = %5
  ret i32 0

; <label>:2                                       ; preds = %4, %0
  %loop_val = load i32* %i_8
  %3 = icmp sle i32 %loop_val, 100
  br i1 %3, label %4, label %5

; <label>:4                                       ; preds = %2
  %t_0 = load i32* %d_6
  %t_1 = load i32* %a_3
  %t_2 = add i32 %t_0, %t_1
  %t_3 = load i32* %b_4
  %t_4 = add i32 %t_2, %t_3
  store i32 %t_4, i32* %d_6
  %t_5 = load i32* %d_6
  %t_6 = load i32* %c_5
  %t_7 = add i32 %t_5, %t_6
  store i32 %t_7, i32* %d_6
  %t_8 = load i32* %d_6
  call void @_write_int(i32 %t_8)
  call void @_write_string(i8* getelementptr inbounds ([2 x i8]* @0, i32 0, i32 0))
  %t_9 = load i32* %d_6
  store i32 %t_9, i32* %e_7
  %loop_temp = add i32 %loop_val, 1
  store i32 %loop_temp, i32* %i_8
  br label %2

; <label>:5                                       ; preds = %2
  %t_10 = load i32* %e_7
  call void @_write_int(i32 %t_10)
  call void @_write_string(i8* getelementptr inbounds ([2 x i8]* @0, i32 0, i32 0))
  br label %1
}

define i32 @main() {
  %1 = call i32 @"$main"()
  ret i32 %1
}

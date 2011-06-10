; ModuleID = 'fabl'

@int_format_string = internal constant [3 x i8] c"%d\00"
@string_format_string = internal constant [3 x i8] c"%s\00"
@true_string = internal constant [5 x i8] c"true\00"
@false_string = internal constant [6 x i8] c"false\00"
@__nil__ = internal global i32 0

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
  store i32 5, i32* %a_3
  %b_4 = alloca i32
  store i32 12, i32* %b_4
  %t_0 = load i32* %a_3
  %t_1 = load i32* %a_3
  %t_2 = icmp eq i32 %t_0, %t_1
  %c_5 = alloca i1
  store i1 %t_2, i1* %c_5
  %t_3 = load i32* %a_3
  %t_4 = load i32* %a_3
  %t_5 = icmp ne i32 %t_3, %t_4
  %1 = icmp eq i1 %t_5, true
  br i1 %1, label %3, label %5

; <label>:2                                       ; preds = %7
  ret i32 0

; <label>:3                                       ; preds = %0
  %t_6 = load i32* %b_4
  %t_7 = load i32* %a_3
  %t_8 = icmp eq i32 %t_6, %t_7
  %4 = icmp eq i1 %t_8, true
  br i1 %4, label %8, label %9

; <label>:5                                       ; preds = %0
  %t_12 = load i32* %b_4
  %t_13 = load i32* %a_3
  %t_14 = icmp eq i32 %t_12, %t_13
  %6 = icmp eq i1 %t_14, true
  br i1 %6, label %11, label %12

; <label>:7                                       ; preds = %13, %10
  %t_19 = load i32* %b_4
  %d_6 = alloca i32
  store i32 %t_19, i32* %d_6
  br label %2

; <label>:8                                       ; preds = %3
  %t_9 = load i32* %a_3
  store i32 %t_9, i32* %b_4
  br label %10

; <label>:9                                       ; preds = %3
  %t_10 = load i32* %b_4
  %t_11 = add i32 %t_10, 5
  store i32 %t_11, i32* %b_4
  br label %10

; <label>:10                                      ; preds = %9, %8
  br label %7

; <label>:11                                      ; preds = %5
  %t_15 = load i32* %a_3
  %t_16 = sub i32 0, %t_15
  store i32 %t_16, i32* %b_4
  br label %13

; <label>:12                                      ; preds = %5
  %t_17 = load i32* %b_4
  %t_18 = add i32 %t_17, 10
  store i32 %t_18, i32* %b_4
  br label %13

; <label>:13                                      ; preds = %12, %11
  br label %7
}

define i32 @main() {
  %1 = call i32 @"$main"()
  ret i32 %1
}

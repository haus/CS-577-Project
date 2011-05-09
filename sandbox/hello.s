; ModuleID = 'hello.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [22 x i8] c"Hello, Portland, %d!\0A\00"

define i32 @foo(i32 %n) nounwind ssp {
  %1 = alloca i32, align 4
  %m = alloca i32, align 4
  %l = alloca i32, align 4
  store i32 %n, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = sub nsw i32 %2, 5
  store i32 %3, i32* %m, align 4
  %4 = load i32* %1, align 4
  %5 = add nsw i32 %4, 5
  store i32 %5, i32* %l, align 4
  %6 = load i32* %m, align 4
  %7 = load i32* %l, align 4
  %8 = mul nsw i32 %6, %7
  ret i32 %8
}

define i32 @main() nounwind ssp {
  %1 = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 0, i32* %1
  store i32 3, i32* %i, align 4
  store i32 42, i32* %j, align 4
  store i32 15, i32* %k, align 4
  %2 = load i32* %i, align 4
  %3 = load i32* %j, align 4
  %4 = mul nsw i32 %2, %3
  %5 = load i32* %k, align 4
  %6 = mul nsw i32 %4, %5
  %7 = call i32 @foo(i32 %6)
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str, i32 0, i32 0), i32 %7)
  ret i32 0
}

declare i32 @printf(i8*, ...)

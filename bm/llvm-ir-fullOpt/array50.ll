; ModuleID = 'fabl'

%0 = type { i32, [0 x i32] }

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
  %1 = call i8* @malloc(i32 208)
  %array_loc_tmp_bitcast = bitcast i8* %1 to %0*
  %2 = bitcast i8* %1 to i32*
  store i32 51, i32* %2, align 4
  br label %3

; <label>:3                                       ; preds = %0, %3
  %counter.0553 = phi i32 [ 0, %0 ], [ %new_count202, %3 ]
  %array_index.0552 = phi i32 [ 0, %0 ], [ %new_index, %3 ]
  %4 = sext i32 %array_index.0552 to i64
  %5 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %4
  store i32 39991, i32* %5, align 4
  %new_index = add i32 %array_index.0552, 1
  %new_count202 = add i32 %counter.0553, 1
  %6 = icmp sgt i32 %new_count202, 0
  br i1 %6, label %7, label %3

; <label>:7                                       ; preds = %3
  %array_index.0.lcssa = phi i32 [ %new_index, %3 ]
  br label %8

; <label>:8                                       ; preds = %7, %8
  %array_index.1551 = phi i32 [ %array_index.0.lcssa, %7 ], [ %new_index205, %8 ]
  %storemerge550 = phi i32 [ 0, %7 ], [ %new_count206, %8 ]
  %9 = sext i32 %array_index.1551 to i64
  %10 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %9
  store i32 27933, i32* %10, align 4
  %new_index205 = add i32 %array_index.1551, 1
  %new_count206 = add i32 %storemerge550, 1
  %11 = icmp sgt i32 %new_count206, 0
  br i1 %11, label %12, label %8

; <label>:12                                      ; preds = %8
  %array_index.1.lcssa = phi i32 [ %new_index205, %8 ]
  br label %13

; <label>:13                                      ; preds = %12, %13
  %array_index.2549 = phi i32 [ %array_index.1.lcssa, %12 ], [ %new_index209, %13 ]
  %storemerge403548 = phi i32 [ 0, %12 ], [ %new_count210, %13 ]
  %14 = sext i32 %array_index.2549 to i64
  %15 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %14
  store i32 31225, i32* %15, align 4
  %new_index209 = add i32 %array_index.2549, 1
  %new_count210 = add i32 %storemerge403548, 1
  %16 = icmp sgt i32 %new_count210, 0
  br i1 %16, label %17, label %13

; <label>:17                                      ; preds = %13
  %array_index.2.lcssa = phi i32 [ %new_index209, %13 ]
  br label %18

; <label>:18                                      ; preds = %17, %18
  %array_index.3547 = phi i32 [ %array_index.2.lcssa, %17 ], [ %new_index213, %18 ]
  %storemerge404546 = phi i32 [ 0, %17 ], [ %new_count214, %18 ]
  %19 = sext i32 %array_index.3547 to i64
  %20 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %19
  store i32 6848, i32* %20, align 4
  %new_index213 = add i32 %array_index.3547, 1
  %new_count214 = add i32 %storemerge404546, 1
  %21 = icmp sgt i32 %new_count214, 0
  br i1 %21, label %22, label %18

; <label>:22                                      ; preds = %18
  %array_index.3.lcssa = phi i32 [ %new_index213, %18 ]
  br label %23

; <label>:23                                      ; preds = %22, %23
  %array_index.4545 = phi i32 [ %array_index.3.lcssa, %22 ], [ %new_index217, %23 ]
  %storemerge405544 = phi i32 [ 0, %22 ], [ %new_count218, %23 ]
  %24 = sext i32 %array_index.4545 to i64
  %25 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %24
  store i32 21032, i32* %25, align 4
  %new_index217 = add i32 %array_index.4545, 1
  %new_count218 = add i32 %storemerge405544, 1
  %26 = icmp sgt i32 %new_count218, 0
  br i1 %26, label %27, label %23

; <label>:27                                      ; preds = %23
  %array_index.4.lcssa = phi i32 [ %new_index217, %23 ]
  br label %28

; <label>:28                                      ; preds = %27, %28
  %array_index.5543 = phi i32 [ %array_index.4.lcssa, %27 ], [ %new_index221, %28 ]
  %storemerge406542 = phi i32 [ 0, %27 ], [ %new_count222, %28 ]
  %29 = sext i32 %array_index.5543 to i64
  %30 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %29
  store i32 45442, i32* %30, align 4
  %new_index221 = add i32 %array_index.5543, 1
  %new_count222 = add i32 %storemerge406542, 1
  %31 = icmp sgt i32 %new_count222, 0
  br i1 %31, label %32, label %28

; <label>:32                                      ; preds = %28
  %array_index.5.lcssa = phi i32 [ %new_index221, %28 ]
  br label %33

; <label>:33                                      ; preds = %32, %33
  %array_index.6541 = phi i32 [ %array_index.5.lcssa, %32 ], [ %new_index225, %33 ]
  %storemerge407540 = phi i32 [ 0, %32 ], [ %new_count226, %33 ]
  %34 = sext i32 %array_index.6541 to i64
  %35 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %34
  store i32 20652, i32* %35, align 4
  %new_index225 = add i32 %array_index.6541, 1
  %new_count226 = add i32 %storemerge407540, 1
  %36 = icmp sgt i32 %new_count226, 0
  br i1 %36, label %37, label %33

; <label>:37                                      ; preds = %33
  %array_index.6.lcssa = phi i32 [ %new_index225, %33 ]
  br label %38

; <label>:38                                      ; preds = %37, %38
  %array_index.7539 = phi i32 [ %array_index.6.lcssa, %37 ], [ %new_index229, %38 ]
  %storemerge408538 = phi i32 [ 0, %37 ], [ %new_count230, %38 ]
  %39 = sext i32 %array_index.7539 to i64
  %40 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %39
  store i32 29205, i32* %40, align 4
  %new_index229 = add i32 %array_index.7539, 1
  %new_count230 = add i32 %storemerge408538, 1
  %41 = icmp sgt i32 %new_count230, 0
  br i1 %41, label %42, label %38

; <label>:42                                      ; preds = %38
  %array_index.7.lcssa = phi i32 [ %new_index229, %38 ]
  br label %43

; <label>:43                                      ; preds = %42, %43
  %array_index.8537 = phi i32 [ %array_index.7.lcssa, %42 ], [ %new_index233, %43 ]
  %storemerge409536 = phi i32 [ 0, %42 ], [ %new_count234, %43 ]
  %44 = sext i32 %array_index.8537 to i64
  %45 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %44
  store i32 1455, i32* %45, align 4
  %new_index233 = add i32 %array_index.8537, 1
  %new_count234 = add i32 %storemerge409536, 1
  %46 = icmp sgt i32 %new_count234, 0
  br i1 %46, label %47, label %43

; <label>:47                                      ; preds = %43
  %array_index.8.lcssa = phi i32 [ %new_index233, %43 ]
  br label %48

; <label>:48                                      ; preds = %47, %48
  %array_index.9535 = phi i32 [ %array_index.8.lcssa, %47 ], [ %new_index237, %48 ]
  %storemerge410534 = phi i32 [ 0, %47 ], [ %new_count238, %48 ]
  %49 = sext i32 %array_index.9535 to i64
  %50 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %49
  store i32 17903, i32* %50, align 4
  %new_index237 = add i32 %array_index.9535, 1
  %new_count238 = add i32 %storemerge410534, 1
  %51 = icmp sgt i32 %new_count238, 0
  br i1 %51, label %52, label %48

; <label>:52                                      ; preds = %48
  %array_index.9.lcssa = phi i32 [ %new_index237, %48 ]
  br label %53

; <label>:53                                      ; preds = %52, %53
  %array_index.10533 = phi i32 [ %array_index.9.lcssa, %52 ], [ %new_index241, %53 ]
  %storemerge411532 = phi i32 [ 0, %52 ], [ %new_count242, %53 ]
  %54 = sext i32 %array_index.10533 to i64
  %55 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %54
  store i32 20514, i32* %55, align 4
  %new_index241 = add i32 %array_index.10533, 1
  %new_count242 = add i32 %storemerge411532, 1
  %56 = icmp sgt i32 %new_count242, 0
  br i1 %56, label %57, label %53

; <label>:57                                      ; preds = %53
  %array_index.10.lcssa = phi i32 [ %new_index241, %53 ]
  br label %58

; <label>:58                                      ; preds = %57, %58
  %array_index.11531 = phi i32 [ %array_index.10.lcssa, %57 ], [ %new_index245, %58 ]
  %storemerge412530 = phi i32 [ 0, %57 ], [ %new_count246, %58 ]
  %59 = sext i32 %array_index.11531 to i64
  %60 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %59
  store i32 20731, i32* %60, align 4
  %new_index245 = add i32 %array_index.11531, 1
  %new_count246 = add i32 %storemerge412530, 1
  %61 = icmp sgt i32 %new_count246, 0
  br i1 %61, label %62, label %58

; <label>:62                                      ; preds = %58
  %array_index.11.lcssa = phi i32 [ %new_index245, %58 ]
  br label %63

; <label>:63                                      ; preds = %62, %63
  %array_index.12529 = phi i32 [ %array_index.11.lcssa, %62 ], [ %new_index249, %63 ]
  %storemerge413528 = phi i32 [ 0, %62 ], [ %new_count250, %63 ]
  %64 = sext i32 %array_index.12529 to i64
  %65 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %64
  store i32 35699, i32* %65, align 4
  %new_index249 = add i32 %array_index.12529, 1
  %new_count250 = add i32 %storemerge413528, 1
  %66 = icmp sgt i32 %new_count250, 0
  br i1 %66, label %67, label %63

; <label>:67                                      ; preds = %63
  %array_index.12.lcssa = phi i32 [ %new_index249, %63 ]
  br label %68

; <label>:68                                      ; preds = %67, %68
  %array_index.13527 = phi i32 [ %array_index.12.lcssa, %67 ], [ %new_index253, %68 ]
  %storemerge414526 = phi i32 [ 0, %67 ], [ %new_count254, %68 ]
  %69 = sext i32 %array_index.13527 to i64
  %70 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %69
  store i32 27932, i32* %70, align 4
  %new_index253 = add i32 %array_index.13527, 1
  %new_count254 = add i32 %storemerge414526, 1
  %71 = icmp sgt i32 %new_count254, 0
  br i1 %71, label %72, label %68

; <label>:72                                      ; preds = %68
  %array_index.13.lcssa = phi i32 [ %new_index253, %68 ]
  br label %73

; <label>:73                                      ; preds = %72, %73
  %array_index.14525 = phi i32 [ %array_index.13.lcssa, %72 ], [ %new_index257, %73 ]
  %storemerge415524 = phi i32 [ 0, %72 ], [ %new_count258, %73 ]
  %74 = sext i32 %array_index.14525 to i64
  %75 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %74
  store i32 9453, i32* %75, align 4
  %new_index257 = add i32 %array_index.14525, 1
  %new_count258 = add i32 %storemerge415524, 1
  %76 = icmp sgt i32 %new_count258, 0
  br i1 %76, label %77, label %73

; <label>:77                                      ; preds = %73
  %array_index.14.lcssa = phi i32 [ %new_index257, %73 ]
  br label %78

; <label>:78                                      ; preds = %77, %78
  %array_index.15523 = phi i32 [ %array_index.14.lcssa, %77 ], [ %new_index261, %78 ]
  %storemerge416522 = phi i32 [ 0, %77 ], [ %new_count262, %78 ]
  %79 = sext i32 %array_index.15523 to i64
  %80 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %79
  store i32 18706, i32* %80, align 4
  %new_index261 = add i32 %array_index.15523, 1
  %new_count262 = add i32 %storemerge416522, 1
  %81 = icmp sgt i32 %new_count262, 0
  br i1 %81, label %82, label %78

; <label>:82                                      ; preds = %78
  %array_index.15.lcssa = phi i32 [ %new_index261, %78 ]
  br label %83

; <label>:83                                      ; preds = %82, %83
  %array_index.16521 = phi i32 [ %array_index.15.lcssa, %82 ], [ %new_index265, %83 ]
  %storemerge417520 = phi i32 [ 0, %82 ], [ %new_count266, %83 ]
  %84 = sext i32 %array_index.16521 to i64
  %85 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %84
  store i32 11342, i32* %85, align 4
  %new_index265 = add i32 %array_index.16521, 1
  %new_count266 = add i32 %storemerge417520, 1
  %86 = icmp sgt i32 %new_count266, 0
  br i1 %86, label %87, label %83

; <label>:87                                      ; preds = %83
  %array_index.16.lcssa = phi i32 [ %new_index265, %83 ]
  br label %88

; <label>:88                                      ; preds = %87, %88
  %array_index.17519 = phi i32 [ %array_index.16.lcssa, %87 ], [ %new_index269, %88 ]
  %storemerge418518 = phi i32 [ 0, %87 ], [ %new_count270, %88 ]
  %89 = sext i32 %array_index.17519 to i64
  %90 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %89
  store i32 2170, i32* %90, align 4
  %new_index269 = add i32 %array_index.17519, 1
  %new_count270 = add i32 %storemerge418518, 1
  %91 = icmp sgt i32 %new_count270, 0
  br i1 %91, label %92, label %88

; <label>:92                                      ; preds = %88
  %array_index.17.lcssa = phi i32 [ %new_index269, %88 ]
  br label %93

; <label>:93                                      ; preds = %92, %93
  %array_index.18517 = phi i32 [ %array_index.17.lcssa, %92 ], [ %new_index273, %93 ]
  %storemerge419516 = phi i32 [ 0, %92 ], [ %new_count274, %93 ]
  %94 = sext i32 %array_index.18517 to i64
  %95 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %94
  store i32 9727, i32* %95, align 4
  %new_index273 = add i32 %array_index.18517, 1
  %new_count274 = add i32 %storemerge419516, 1
  %96 = icmp sgt i32 %new_count274, 0
  br i1 %96, label %97, label %93

; <label>:97                                      ; preds = %93
  %array_index.18.lcssa = phi i32 [ %new_index273, %93 ]
  br label %98

; <label>:98                                      ; preds = %97, %98
  %array_index.19515 = phi i32 [ %array_index.18.lcssa, %97 ], [ %new_index277, %98 ]
  %storemerge420514 = phi i32 [ 0, %97 ], [ %new_count278, %98 ]
  %99 = sext i32 %array_index.19515 to i64
  %100 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %99
  store i32 9161, i32* %100, align 4
  %new_index277 = add i32 %array_index.19515, 1
  %new_count278 = add i32 %storemerge420514, 1
  %101 = icmp sgt i32 %new_count278, 0
  br i1 %101, label %102, label %98

; <label>:102                                     ; preds = %98
  %array_index.19.lcssa = phi i32 [ %new_index277, %98 ]
  br label %103

; <label>:103                                     ; preds = %102, %103
  %array_index.20513 = phi i32 [ %array_index.19.lcssa, %102 ], [ %new_index281, %103 ]
  %storemerge421512 = phi i32 [ 0, %102 ], [ %new_count282, %103 ]
  %104 = sext i32 %array_index.20513 to i64
  %105 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %104
  store i32 28697, i32* %105, align 4
  %new_index281 = add i32 %array_index.20513, 1
  %new_count282 = add i32 %storemerge421512, 1
  %106 = icmp sgt i32 %new_count282, 0
  br i1 %106, label %107, label %103

; <label>:107                                     ; preds = %103
  %array_index.20.lcssa = phi i32 [ %new_index281, %103 ]
  br label %108

; <label>:108                                     ; preds = %107, %108
  %array_index.21511 = phi i32 [ %array_index.20.lcssa, %107 ], [ %new_index285, %108 ]
  %storemerge422510 = phi i32 [ 0, %107 ], [ %new_count286, %108 ]
  %109 = sext i32 %array_index.21511 to i64
  %110 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %109
  store i32 6568, i32* %110, align 4
  %new_index285 = add i32 %array_index.21511, 1
  %new_count286 = add i32 %storemerge422510, 1
  %111 = icmp sgt i32 %new_count286, 0
  br i1 %111, label %112, label %108

; <label>:112                                     ; preds = %108
  %array_index.21.lcssa = phi i32 [ %new_index285, %108 ]
  br label %113

; <label>:113                                     ; preds = %112, %113
  %array_index.22509 = phi i32 [ %array_index.21.lcssa, %112 ], [ %new_index289, %113 ]
  %storemerge423508 = phi i32 [ 0, %112 ], [ %new_count290, %113 ]
  %114 = sext i32 %array_index.22509 to i64
  %115 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %114
  store i32 1405, i32* %115, align 4
  %new_index289 = add i32 %array_index.22509, 1
  %new_count290 = add i32 %storemerge423508, 1
  %116 = icmp sgt i32 %new_count290, 0
  br i1 %116, label %117, label %113

; <label>:117                                     ; preds = %113
  %array_index.22.lcssa = phi i32 [ %new_index289, %113 ]
  br label %118

; <label>:118                                     ; preds = %117, %118
  %array_index.23507 = phi i32 [ %array_index.22.lcssa, %117 ], [ %new_index293, %118 ]
  %storemerge424506 = phi i32 [ 0, %117 ], [ %new_count294, %118 ]
  %119 = sext i32 %array_index.23507 to i64
  %120 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %119
  store i32 18340, i32* %120, align 4
  %new_index293 = add i32 %array_index.23507, 1
  %new_count294 = add i32 %storemerge424506, 1
  %121 = icmp sgt i32 %new_count294, 0
  br i1 %121, label %122, label %118

; <label>:122                                     ; preds = %118
  %array_index.23.lcssa = phi i32 [ %new_index293, %118 ]
  br label %123

; <label>:123                                     ; preds = %122, %123
  %array_index.24505 = phi i32 [ %array_index.23.lcssa, %122 ], [ %new_index297, %123 ]
  %storemerge425504 = phi i32 [ 0, %122 ], [ %new_count298, %123 ]
  %124 = sext i32 %array_index.24505 to i64
  %125 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %124
  store i32 39524, i32* %125, align 4
  %new_index297 = add i32 %array_index.24505, 1
  %new_count298 = add i32 %storemerge425504, 1
  %126 = icmp sgt i32 %new_count298, 0
  br i1 %126, label %127, label %123

; <label>:127                                     ; preds = %123
  %array_index.24.lcssa = phi i32 [ %new_index297, %123 ]
  br label %128

; <label>:128                                     ; preds = %127, %128
  %array_index.25503 = phi i32 [ %array_index.24.lcssa, %127 ], [ %new_index301, %128 ]
  %storemerge426502 = phi i32 [ 0, %127 ], [ %new_count302, %128 ]
  %129 = sext i32 %array_index.25503 to i64
  %130 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %129
  store i32 24037, i32* %130, align 4
  %new_index301 = add i32 %array_index.25503, 1
  %new_count302 = add i32 %storemerge426502, 1
  %131 = icmp sgt i32 %new_count302, 0
  br i1 %131, label %132, label %128

; <label>:132                                     ; preds = %128
  %array_index.25.lcssa = phi i32 [ %new_index301, %128 ]
  br label %133

; <label>:133                                     ; preds = %132, %133
  %array_index.26501 = phi i32 [ %array_index.25.lcssa, %132 ], [ %new_index305, %133 ]
  %storemerge427500 = phi i32 [ 0, %132 ], [ %new_count306, %133 ]
  %134 = sext i32 %array_index.26501 to i64
  %135 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %134
  store i32 29567, i32* %135, align 4
  %new_index305 = add i32 %array_index.26501, 1
  %new_count306 = add i32 %storemerge427500, 1
  %136 = icmp sgt i32 %new_count306, 0
  br i1 %136, label %137, label %133

; <label>:137                                     ; preds = %133
  %array_index.26.lcssa = phi i32 [ %new_index305, %133 ]
  br label %138

; <label>:138                                     ; preds = %137, %138
  %array_index.27499 = phi i32 [ %array_index.26.lcssa, %137 ], [ %new_index309, %138 ]
  %storemerge428498 = phi i32 [ 0, %137 ], [ %new_count310, %138 ]
  %139 = sext i32 %array_index.27499 to i64
  %140 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %139
  store i32 35800, i32* %140, align 4
  %new_index309 = add i32 %array_index.27499, 1
  %new_count310 = add i32 %storemerge428498, 1
  %141 = icmp sgt i32 %new_count310, 0
  br i1 %141, label %142, label %138

; <label>:142                                     ; preds = %138
  %array_index.27.lcssa = phi i32 [ %new_index309, %138 ]
  br label %143

; <label>:143                                     ; preds = %142, %143
  %array_index.28497 = phi i32 [ %array_index.27.lcssa, %142 ], [ %new_index313, %143 ]
  %storemerge429496 = phi i32 [ 0, %142 ], [ %new_count314, %143 ]
  %144 = sext i32 %array_index.28497 to i64
  %145 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %144
  store i32 36559, i32* %145, align 4
  %new_index313 = add i32 %array_index.28497, 1
  %new_count314 = add i32 %storemerge429496, 1
  %146 = icmp sgt i32 %new_count314, 0
  br i1 %146, label %147, label %143

; <label>:147                                     ; preds = %143
  %array_index.28.lcssa = phi i32 [ %new_index313, %143 ]
  br label %148

; <label>:148                                     ; preds = %147, %148
  %array_index.29495 = phi i32 [ %array_index.28.lcssa, %147 ], [ %new_index317, %148 ]
  %storemerge430494 = phi i32 [ 0, %147 ], [ %new_count318, %148 ]
  %149 = sext i32 %array_index.29495 to i64
  %150 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %149
  store i32 6944, i32* %150, align 4
  %new_index317 = add i32 %array_index.29495, 1
  %new_count318 = add i32 %storemerge430494, 1
  %151 = icmp sgt i32 %new_count318, 0
  br i1 %151, label %152, label %148

; <label>:152                                     ; preds = %148
  %array_index.29.lcssa = phi i32 [ %new_index317, %148 ]
  br label %153

; <label>:153                                     ; preds = %152, %153
  %array_index.30493 = phi i32 [ %array_index.29.lcssa, %152 ], [ %new_index321, %153 ]
  %storemerge431492 = phi i32 [ 0, %152 ], [ %new_count322, %153 ]
  %154 = sext i32 %array_index.30493 to i64
  %155 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %154
  store i32 33607, i32* %155, align 4
  %new_index321 = add i32 %array_index.30493, 1
  %new_count322 = add i32 %storemerge431492, 1
  %156 = icmp sgt i32 %new_count322, 0
  br i1 %156, label %157, label %153

; <label>:157                                     ; preds = %153
  %array_index.30.lcssa = phi i32 [ %new_index321, %153 ]
  br label %158

; <label>:158                                     ; preds = %157, %158
  %array_index.31491 = phi i32 [ %array_index.30.lcssa, %157 ], [ %new_index325, %158 ]
  %storemerge432490 = phi i32 [ 0, %157 ], [ %new_count326, %158 ]
  %159 = sext i32 %array_index.31491 to i64
  %160 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %159
  store i32 2179, i32* %160, align 4
  %new_index325 = add i32 %array_index.31491, 1
  %new_count326 = add i32 %storemerge432490, 1
  %161 = icmp sgt i32 %new_count326, 0
  br i1 %161, label %162, label %158

; <label>:162                                     ; preds = %158
  %array_index.31.lcssa = phi i32 [ %new_index325, %158 ]
  br label %163

; <label>:163                                     ; preds = %162, %163
  %array_index.32489 = phi i32 [ %array_index.31.lcssa, %162 ], [ %new_index329, %163 ]
  %storemerge433488 = phi i32 [ 0, %162 ], [ %new_count330, %163 ]
  %164 = sext i32 %array_index.32489 to i64
  %165 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %164
  store i32 32247, i32* %165, align 4
  %new_index329 = add i32 %array_index.32489, 1
  %new_count330 = add i32 %storemerge433488, 1
  %166 = icmp sgt i32 %new_count330, 0
  br i1 %166, label %167, label %163

; <label>:167                                     ; preds = %163
  %array_index.32.lcssa = phi i32 [ %new_index329, %163 ]
  br label %168

; <label>:168                                     ; preds = %167, %168
  %array_index.33487 = phi i32 [ %array_index.32.lcssa, %167 ], [ %new_index333, %168 ]
  %storemerge434486 = phi i32 [ 0, %167 ], [ %new_count334, %168 ]
  %169 = sext i32 %array_index.33487 to i64
  %170 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %169
  store i32 34476, i32* %170, align 4
  %new_index333 = add i32 %array_index.33487, 1
  %new_count334 = add i32 %storemerge434486, 1
  %171 = icmp sgt i32 %new_count334, 0
  br i1 %171, label %172, label %168

; <label>:172                                     ; preds = %168
  %array_index.33.lcssa = phi i32 [ %new_index333, %168 ]
  br label %173

; <label>:173                                     ; preds = %172, %173
  %array_index.34485 = phi i32 [ %array_index.33.lcssa, %172 ], [ %new_index337, %173 ]
  %storemerge435484 = phi i32 [ 0, %172 ], [ %new_count338, %173 ]
  %174 = sext i32 %array_index.34485 to i64
  %175 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %174
  store i32 28843, i32* %175, align 4
  %new_index337 = add i32 %array_index.34485, 1
  %new_count338 = add i32 %storemerge435484, 1
  %176 = icmp sgt i32 %new_count338, 0
  br i1 %176, label %177, label %173

; <label>:177                                     ; preds = %173
  %array_index.34.lcssa = phi i32 [ %new_index337, %173 ]
  br label %178

; <label>:178                                     ; preds = %177, %178
  %array_index.35483 = phi i32 [ %array_index.34.lcssa, %177 ], [ %new_index341, %178 ]
  %storemerge436482 = phi i32 [ 0, %177 ], [ %new_count342, %178 ]
  %179 = sext i32 %array_index.35483 to i64
  %180 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %179
  store i32 11114, i32* %180, align 4
  %new_index341 = add i32 %array_index.35483, 1
  %new_count342 = add i32 %storemerge436482, 1
  %181 = icmp sgt i32 %new_count342, 0
  br i1 %181, label %182, label %178

; <label>:182                                     ; preds = %178
  %array_index.35.lcssa = phi i32 [ %new_index341, %178 ]
  br label %183

; <label>:183                                     ; preds = %182, %183
  %array_index.36481 = phi i32 [ %array_index.35.lcssa, %182 ], [ %new_index345, %183 ]
  %storemerge437480 = phi i32 [ 0, %182 ], [ %new_count346, %183 ]
  %184 = sext i32 %array_index.36481 to i64
  %185 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %184
  store i32 17840, i32* %185, align 4
  %new_index345 = add i32 %array_index.36481, 1
  %new_count346 = add i32 %storemerge437480, 1
  %186 = icmp sgt i32 %new_count346, 0
  br i1 %186, label %187, label %183

; <label>:187                                     ; preds = %183
  %array_index.36.lcssa = phi i32 [ %new_index345, %183 ]
  br label %188

; <label>:188                                     ; preds = %187, %188
  %array_index.37479 = phi i32 [ %array_index.36.lcssa, %187 ], [ %new_index349, %188 ]
  %storemerge438478 = phi i32 [ 0, %187 ], [ %new_count350, %188 ]
  %189 = sext i32 %array_index.37479 to i64
  %190 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %189
  store i32 13071, i32* %190, align 4
  %new_index349 = add i32 %array_index.37479, 1
  %new_count350 = add i32 %storemerge438478, 1
  %191 = icmp sgt i32 %new_count350, 0
  br i1 %191, label %192, label %188

; <label>:192                                     ; preds = %188
  %array_index.37.lcssa = phi i32 [ %new_index349, %188 ]
  br label %193

; <label>:193                                     ; preds = %192, %193
  %array_index.38477 = phi i32 [ %array_index.37.lcssa, %192 ], [ %new_index353, %193 ]
  %storemerge439476 = phi i32 [ 0, %192 ], [ %new_count354, %193 ]
  %194 = sext i32 %array_index.38477 to i64
  %195 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %194
  store i32 13185, i32* %195, align 4
  %new_index353 = add i32 %array_index.38477, 1
  %new_count354 = add i32 %storemerge439476, 1
  %196 = icmp sgt i32 %new_count354, 0
  br i1 %196, label %197, label %193

; <label>:197                                     ; preds = %193
  %array_index.38.lcssa = phi i32 [ %new_index353, %193 ]
  br label %198

; <label>:198                                     ; preds = %197, %198
  %array_index.39475 = phi i32 [ %array_index.38.lcssa, %197 ], [ %new_index357, %198 ]
  %storemerge440474 = phi i32 [ 0, %197 ], [ %new_count358, %198 ]
  %199 = sext i32 %array_index.39475 to i64
  %200 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %199
  store i32 15386, i32* %200, align 4
  %new_index357 = add i32 %array_index.39475, 1
  %new_count358 = add i32 %storemerge440474, 1
  %201 = icmp sgt i32 %new_count358, 0
  br i1 %201, label %202, label %198

; <label>:202                                     ; preds = %198
  %array_index.39.lcssa = phi i32 [ %new_index357, %198 ]
  br label %203

; <label>:203                                     ; preds = %202, %203
  %array_index.40473 = phi i32 [ %array_index.39.lcssa, %202 ], [ %new_index361, %203 ]
  %storemerge441472 = phi i32 [ 0, %202 ], [ %new_count362, %203 ]
  %204 = sext i32 %array_index.40473 to i64
  %205 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %204
  store i32 35723, i32* %205, align 4
  %new_index361 = add i32 %array_index.40473, 1
  %new_count362 = add i32 %storemerge441472, 1
  %206 = icmp sgt i32 %new_count362, 0
  br i1 %206, label %207, label %203

; <label>:207                                     ; preds = %203
  %array_index.40.lcssa = phi i32 [ %new_index361, %203 ]
  br label %208

; <label>:208                                     ; preds = %207, %208
  %array_index.41471 = phi i32 [ %array_index.40.lcssa, %207 ], [ %new_index365, %208 ]
  %storemerge442470 = phi i32 [ 0, %207 ], [ %new_count366, %208 ]
  %209 = sext i32 %array_index.41471 to i64
  %210 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %209
  store i32 7481, i32* %210, align 4
  %new_index365 = add i32 %array_index.41471, 1
  %new_count366 = add i32 %storemerge442470, 1
  %211 = icmp sgt i32 %new_count366, 0
  br i1 %211, label %212, label %208

; <label>:212                                     ; preds = %208
  %array_index.41.lcssa = phi i32 [ %new_index365, %208 ]
  br label %213

; <label>:213                                     ; preds = %212, %213
  %array_index.42469 = phi i32 [ %array_index.41.lcssa, %212 ], [ %new_index369, %213 ]
  %storemerge443468 = phi i32 [ 0, %212 ], [ %new_count370, %213 ]
  %214 = sext i32 %array_index.42469 to i64
  %215 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %214
  store i32 48726, i32* %215, align 4
  %new_index369 = add i32 %array_index.42469, 1
  %new_count370 = add i32 %storemerge443468, 1
  %216 = icmp sgt i32 %new_count370, 0
  br i1 %216, label %217, label %213

; <label>:217                                     ; preds = %213
  %array_index.42.lcssa = phi i32 [ %new_index369, %213 ]
  br label %218

; <label>:218                                     ; preds = %217, %218
  %array_index.43467 = phi i32 [ %array_index.42.lcssa, %217 ], [ %new_index373, %218 ]
  %storemerge444466 = phi i32 [ 0, %217 ], [ %new_count374, %218 ]
  %219 = sext i32 %array_index.43467 to i64
  %220 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %219
  store i32 13823, i32* %220, align 4
  %new_index373 = add i32 %array_index.43467, 1
  %new_count374 = add i32 %storemerge444466, 1
  %221 = icmp sgt i32 %new_count374, 0
  br i1 %221, label %222, label %218

; <label>:222                                     ; preds = %218
  %array_index.43.lcssa = phi i32 [ %new_index373, %218 ]
  br label %223

; <label>:223                                     ; preds = %222, %223
  %array_index.44465 = phi i32 [ %array_index.43.lcssa, %222 ], [ %new_index377, %223 ]
  %storemerge445464 = phi i32 [ 0, %222 ], [ %new_count378, %223 ]
  %224 = sext i32 %array_index.44465 to i64
  %225 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %224
  store i32 43989, i32* %225, align 4
  %new_index377 = add i32 %array_index.44465, 1
  %new_count378 = add i32 %storemerge445464, 1
  %226 = icmp sgt i32 %new_count378, 0
  br i1 %226, label %227, label %223

; <label>:227                                     ; preds = %223
  %array_index.44.lcssa = phi i32 [ %new_index377, %223 ]
  br label %228

; <label>:228                                     ; preds = %227, %228
  %array_index.45463 = phi i32 [ %array_index.44.lcssa, %227 ], [ %new_index381, %228 ]
  %storemerge446462 = phi i32 [ 0, %227 ], [ %new_count382, %228 ]
  %229 = sext i32 %array_index.45463 to i64
  %230 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %229
  store i32 13490, i32* %230, align 4
  %new_index381 = add i32 %array_index.45463, 1
  %new_count382 = add i32 %storemerge446462, 1
  %231 = icmp sgt i32 %new_count382, 0
  br i1 %231, label %232, label %228

; <label>:232                                     ; preds = %228
  %array_index.45.lcssa = phi i32 [ %new_index381, %228 ]
  br label %233

; <label>:233                                     ; preds = %232, %233
  %array_index.46461 = phi i32 [ %array_index.45.lcssa, %232 ], [ %new_index385, %233 ]
  %storemerge447460 = phi i32 [ 0, %232 ], [ %new_count386, %233 ]
  %234 = sext i32 %array_index.46461 to i64
  %235 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %234
  store i32 4954, i32* %235, align 4
  %new_index385 = add i32 %array_index.46461, 1
  %new_count386 = add i32 %storemerge447460, 1
  %236 = icmp sgt i32 %new_count386, 0
  br i1 %236, label %237, label %233

; <label>:237                                     ; preds = %233
  %array_index.46.lcssa = phi i32 [ %new_index385, %233 ]
  br label %238

; <label>:238                                     ; preds = %237, %238
  %array_index.47459 = phi i32 [ %array_index.46.lcssa, %237 ], [ %new_index389, %238 ]
  %storemerge448458 = phi i32 [ 0, %237 ], [ %new_count390, %238 ]
  %239 = sext i32 %array_index.47459 to i64
  %240 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %239
  store i32 37571, i32* %240, align 4
  %new_index389 = add i32 %array_index.47459, 1
  %new_count390 = add i32 %storemerge448458, 1
  %241 = icmp sgt i32 %new_count390, 0
  br i1 %241, label %242, label %238

; <label>:242                                     ; preds = %238
  %array_index.47.lcssa = phi i32 [ %new_index389, %238 ]
  br label %243

; <label>:243                                     ; preds = %242, %243
  %array_index.48457 = phi i32 [ %array_index.47.lcssa, %242 ], [ %new_index393, %243 ]
  %storemerge449456 = phi i32 [ 0, %242 ], [ %new_count394, %243 ]
  %244 = sext i32 %array_index.48457 to i64
  %245 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %244
  store i32 27500, i32* %245, align 4
  %new_index393 = add i32 %array_index.48457, 1
  %new_count394 = add i32 %storemerge449456, 1
  %246 = icmp sgt i32 %new_count394, 0
  br i1 %246, label %247, label %243

; <label>:247                                     ; preds = %243
  %array_index.48.lcssa = phi i32 [ %new_index393, %243 ]
  br label %248

; <label>:248                                     ; preds = %247, %248
  %array_index.49455 = phi i32 [ %array_index.48.lcssa, %247 ], [ %new_index397, %248 ]
  %storemerge450454 = phi i32 [ 0, %247 ], [ %new_count398, %248 ]
  %249 = sext i32 %array_index.49455 to i64
  %250 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %249
  store i32 47772, i32* %250, align 4
  %new_index397 = add i32 %array_index.49455, 1
  %new_count398 = add i32 %storemerge450454, 1
  %251 = icmp sgt i32 %new_count398, 0
  br i1 %251, label %252, label %248

; <label>:252                                     ; preds = %248
  %array_index.49.lcssa = phi i32 [ %new_index397, %248 ]
  br label %253

; <label>:253                                     ; preds = %252, %253
  %array_index.50453 = phi i32 [ %array_index.49.lcssa, %252 ], [ %new_index401, %253 ]
  %storemerge451452 = phi i32 [ 0, %252 ], [ %new_count402, %253 ]
  %254 = sext i32 %array_index.50453 to i64
  %255 = getelementptr %0* %array_loc_tmp_bitcast, i64 0, i32 1, i64 %254
  store i32 34332, i32* %255, align 4
  %new_index401 = add i32 %array_index.50453, 1
  %new_count402 = add i32 %storemerge451452, 1
  %256 = icmp sgt i32 %new_count402, 0
  br i1 %256, label %257, label %253

; <label>:257                                     ; preds = %253
  ret i32 0
}

define i32 @main() {
  %1 = call i32 @"$main"()
  ret i32 %1
}

	.section	__TEXT,__text,regular,pure_instructions
	.globl	__read_int
	.align	4, 0x90
__read_int:                             ## @_read_int
Leh_func_begin0:
## BB#0:
	pushq	%rbx
Ltmp0:
	subq	$16, %rsp
Ltmp1:
	movq	%rdi, %rbx
	leaq	_int_format_string(%rip), %rdi
	leaq	12(%rsp), %rsi
	xorb	%al, %al
	callq	_scanf
	movl	12(%rsp), %eax
	movl	%eax, (%rbx)
	addq	$16, %rsp
	popq	%rbx
	ret
Leh_func_end0:

	.globl	__write_int
	.align	4, 0x90
__write_int:                            ## @_write_int
Leh_func_begin1:
## BB#0:
	pushq	%rax
Ltmp2:
	movl	%edi, %esi
	leaq	_int_format_string(%rip), %rdi
	xorb	%al, %al
	callq	_printf
	popq	%rax
	ret
Leh_func_end1:

	.globl	__write_string
	.align	4, 0x90
__write_string:                         ## @_write_string
Leh_func_begin2:
## BB#0:
	pushq	%rax
Ltmp3:
	movq	%rdi, %rsi
	leaq	_string_format_string(%rip), %rdi
	xorb	%al, %al
	callq	_printf
	popq	%rax
	ret
Leh_func_end2:

	.globl	__write_bool
	.align	4, 0x90
__write_bool:                           ## @_write_bool
Leh_func_begin3:
## BB#0:
	pushq	%rax
Ltmp4:
	testb	$1, %dil
	je	LBB3_2
## BB#1:
	leaq	_true_string(%rip), %rdi
	jmp	LBB3_3
LBB3_2:
	leaq	_false_string(%rip), %rdi
LBB3_3:
	callq	__write_string
	popq	%rax
	ret
Leh_func_end3:

	.globl	_$main
	.align	4, 0x90
_$main:                                 ## @"$main"
Leh_func_begin4:
## BB#0:
	pushq	%rbp
Ltmp5:
	movq	%rsp, %rbp
Ltmp6:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
Ltmp7:
	movl	$208, %edi
	callq	_malloc
	movl	$51, (%rax)
	xorl	%ecx, %ecx
	.align	4, 0x90
LBB4_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	$39991, 4(%rax,%rcx,4)  ## imm = 0x9C37
	incq	%rcx
	testl	%ecx, %ecx
	jle	LBB4_1
## BB#2:
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_3:                                 ## =>This Inner Loop Header: Depth=1
	movl	$27933, (%rdx,%rsi,4)   ## imm = 0x6D1D
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_3
## BB#4:
	leal	(%rcx,%rsi), %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_5:                                 ## =>This Inner Loop Header: Depth=1
	movl	$31225, (%rdx,%rsi,4)   ## imm = 0x79F9
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_5
## BB#6:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_7:                                 ## =>This Inner Loop Header: Depth=1
	movl	$6848, (%rdx,%rsi,4)    ## imm = 0x1AC0
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_7
## BB#8:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_9:                                 ## =>This Inner Loop Header: Depth=1
	movl	$21032, (%rdx,%rsi,4)   ## imm = 0x5228
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_9
## BB#10:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_11:                                ## =>This Inner Loop Header: Depth=1
	movl	$45442, (%rdx,%rsi,4)   ## imm = 0xB182
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_11
## BB#12:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_13:                                ## =>This Inner Loop Header: Depth=1
	movl	$20652, (%rdx,%rsi,4)   ## imm = 0x50AC
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_13
## BB#14:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_15:                                ## =>This Inner Loop Header: Depth=1
	movl	$29205, (%rdx,%rsi,4)   ## imm = 0x7215
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_15
## BB#16:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_17:                                ## =>This Inner Loop Header: Depth=1
	movl	$1455, (%rdx,%rsi,4)    ## imm = 0x5AF
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_17
## BB#18:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_19:                                ## =>This Inner Loop Header: Depth=1
	movl	$17903, (%rdx,%rsi,4)   ## imm = 0x45EF
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_19
## BB#20:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_21:                                ## =>This Inner Loop Header: Depth=1
	movl	$20514, (%rdx,%rsi,4)   ## imm = 0x5022
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_21
## BB#22:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_23:                                ## =>This Inner Loop Header: Depth=1
	movl	$20731, (%rdx,%rsi,4)   ## imm = 0x50FB
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_23
## BB#24:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_25:                                ## =>This Inner Loop Header: Depth=1
	movl	$35699, (%rdx,%rsi,4)   ## imm = 0x8B73
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_25
## BB#26:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_27:                                ## =>This Inner Loop Header: Depth=1
	movl	$27932, (%rdx,%rsi,4)   ## imm = 0x6D1C
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_27
## BB#28:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_29:                                ## =>This Inner Loop Header: Depth=1
	movl	$9453, (%rdx,%rsi,4)    ## imm = 0x24ED
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_29
## BB#30:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_31:                                ## =>This Inner Loop Header: Depth=1
	movl	$18706, (%rdx,%rsi,4)   ## imm = 0x4912
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_31
## BB#32:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_33:                                ## =>This Inner Loop Header: Depth=1
	movl	$11342, (%rdx,%rsi,4)   ## imm = 0x2C4E
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_33
## BB#34:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_35:                                ## =>This Inner Loop Header: Depth=1
	movl	$2170, (%rdx,%rsi,4)    ## imm = 0x87A
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_35
## BB#36:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_37:                                ## =>This Inner Loop Header: Depth=1
	movl	$9727, (%rdx,%rsi,4)    ## imm = 0x25FF
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_37
## BB#38:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_39:                                ## =>This Inner Loop Header: Depth=1
	movl	$9161, (%rdx,%rsi,4)    ## imm = 0x23C9
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_39
## BB#40:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_41:                                ## =>This Inner Loop Header: Depth=1
	movl	$28697, (%rdx,%rsi,4)   ## imm = 0x7019
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_41
## BB#42:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_43:                                ## =>This Inner Loop Header: Depth=1
	movl	$6568, (%rdx,%rsi,4)    ## imm = 0x19A8
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_43
## BB#44:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_45:                                ## =>This Inner Loop Header: Depth=1
	movl	$1405, (%rdx,%rsi,4)    ## imm = 0x57D
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_45
## BB#46:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_47:                                ## =>This Inner Loop Header: Depth=1
	movl	$18340, (%rdx,%rsi,4)   ## imm = 0x47A4
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_47
## BB#48:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_49:                                ## =>This Inner Loop Header: Depth=1
	movl	$39524, (%rdx,%rsi,4)   ## imm = 0x9A64
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_49
## BB#50:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_51:                                ## =>This Inner Loop Header: Depth=1
	movl	$24037, (%rdx,%rsi,4)   ## imm = 0x5DE5
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_51
## BB#52:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_53:                                ## =>This Inner Loop Header: Depth=1
	movl	$29567, (%rdx,%rsi,4)   ## imm = 0x737F
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_53
## BB#54:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_55:                                ## =>This Inner Loop Header: Depth=1
	movl	$35800, (%rdx,%rsi,4)   ## imm = 0x8BD8
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_55
## BB#56:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_57:                                ## =>This Inner Loop Header: Depth=1
	movl	$36559, (%rdx,%rsi,4)   ## imm = 0x8ECF
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_57
## BB#58:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_59:                                ## =>This Inner Loop Header: Depth=1
	movl	$6944, (%rdx,%rsi,4)    ## imm = 0x1B20
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_59
## BB#60:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_61:                                ## =>This Inner Loop Header: Depth=1
	movl	$33607, (%rdx,%rsi,4)   ## imm = 0x8347
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_61
## BB#62:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_63:                                ## =>This Inner Loop Header: Depth=1
	movl	$2179, (%rdx,%rsi,4)    ## imm = 0x883
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_63
## BB#64:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_65:                                ## =>This Inner Loop Header: Depth=1
	movl	$32247, (%rdx,%rsi,4)   ## imm = 0x7DF7
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_65
## BB#66:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_67:                                ## =>This Inner Loop Header: Depth=1
	movl	$34476, (%rdx,%rsi,4)   ## imm = 0x86AC
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_67
## BB#68:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_69:                                ## =>This Inner Loop Header: Depth=1
	movl	$28843, (%rdx,%rsi,4)   ## imm = 0x70AB
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_69
## BB#70:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_71:                                ## =>This Inner Loop Header: Depth=1
	movl	$11114, (%rdx,%rsi,4)   ## imm = 0x2B6A
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_71
## BB#72:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_73:                                ## =>This Inner Loop Header: Depth=1
	movl	$17840, (%rdx,%rsi,4)   ## imm = 0x45B0
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_73
## BB#74:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_75:                                ## =>This Inner Loop Header: Depth=1
	movl	$13071, (%rdx,%rsi,4)   ## imm = 0x330F
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_75
## BB#76:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_77:                                ## =>This Inner Loop Header: Depth=1
	movl	$13185, (%rdx,%rsi,4)   ## imm = 0x3381
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_77
## BB#78:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_79:                                ## =>This Inner Loop Header: Depth=1
	movl	$15386, (%rdx,%rsi,4)   ## imm = 0x3C1A
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_79
## BB#80:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_81:                                ## =>This Inner Loop Header: Depth=1
	movl	$35723, (%rdx,%rsi,4)   ## imm = 0x8B8B
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_81
## BB#82:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_83:                                ## =>This Inner Loop Header: Depth=1
	movl	$7481, (%rdx,%rsi,4)    ## imm = 0x1D39
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_83
## BB#84:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_85:                                ## =>This Inner Loop Header: Depth=1
	movl	$48726, (%rdx,%rsi,4)   ## imm = 0xBE56
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_85
## BB#86:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_87:                                ## =>This Inner Loop Header: Depth=1
	movl	$13823, (%rdx,%rsi,4)   ## imm = 0x35FF
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_87
## BB#88:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_89:                                ## =>This Inner Loop Header: Depth=1
	movl	$43989, (%rdx,%rsi,4)   ## imm = 0xABD5
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_89
## BB#90:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_91:                                ## =>This Inner Loop Header: Depth=1
	movl	$13490, (%rdx,%rsi,4)   ## imm = 0x34B2
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_91
## BB#92:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_93:                                ## =>This Inner Loop Header: Depth=1
	movl	$4954, (%rdx,%rsi,4)    ## imm = 0x135A
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_93
## BB#94:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_95:                                ## =>This Inner Loop Header: Depth=1
	movl	$37571, (%rdx,%rsi,4)   ## imm = 0x92C3
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_95
## BB#96:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_97:                                ## =>This Inner Loop Header: Depth=1
	movl	$27500, (%rdx,%rsi,4)   ## imm = 0x6B6C
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_97
## BB#98:
	addl	%esi, %ecx
	movslq	%ecx, %rdx
	leaq	4(%rax,%rdx,4), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB4_99:                                ## =>This Inner Loop Header: Depth=1
	movl	$47772, (%rdx,%rsi,4)   ## imm = 0xBA9C
	incq	%rsi
	testl	%esi, %esi
	jle	LBB4_99
## BB#100:
	addl	%esi, %ecx
	movslq	%ecx, %rcx
	leaq	4(%rax,%rcx,4), %rcx
	xorl	%edx, %edx
	.align	4, 0x90
LBB4_101:                               ## =>This Inner Loop Header: Depth=1
	movl	$34332, (%rcx,%rdx,4)   ## imm = 0x861C
	incq	%rdx
	testl	%edx, %edx
	jle	LBB4_101
## BB#102:
	movq	%rsp, %rcx
	leaq	-16(%rcx), %rdx
	movq	%rdx, -56(%rbp)         ## 8-byte Spill
	movq	%rdx, %rsp
	movq	%rax, -16(%rcx)
	movb	$1, %al
	movq	%rsp, %rcx
	leaq	-16(%rcx), %rdx
	movq	%rdx, -48(%rbp)         ## 8-byte Spill
	movq	%rdx, %rsp
	movl	$0, -16(%rcx)
	movq	%rsp, %rcx
	leaq	-16(%rcx), %rdx
	movq	%rdx, -72(%rbp)         ## 8-byte Spill
	movq	%rdx, %rsp
	movl	$0, -16(%rcx)
	movq	%rsp, %rcx
	leaq	-16(%rcx), %rdx
	movq	%rdx, -80(%rbp)         ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%al, %al
	movb	$1, -16(%rcx)
	jne	LBB4_109
LBB4_103:
	movq	-48(%rbp), %rax         ## 8-byte Reload
	movl	$0, (%rax)
	xorl	%ebx, %ebx
	leaq	___unnamed_1(%rip), %r14
	leaq	___unnamed_2(%rip), %r15
	.align	4, 0x90
LBB4_104:                               ## =>This Inner Loop Header: Depth=1
	movq	-56(%rbp), %rax         ## 8-byte Reload
	movq	(%rax), %r12
	movq	-48(%rbp), %rax         ## 8-byte Reload
	movslq	(%rax), %r13
	cmpl	(%r12), %r13d
	jb	LBB4_106
## BB#105:                              ##   in Loop: Header=BB4_104 Depth=1
	movq	%r15, %rdi
	callq	__write_string
	movl	$-1, %edi
	callq	_exit
LBB4_106:                               ##   in Loop: Header=BB4_104 Depth=1
	movl	4(%r12,%r13,4), %edi
	callq	__write_int
	movq	%r14, %rdi
	callq	__write_string
	incl	%ebx
	movq	-48(%rbp), %rax         ## 8-byte Reload
	movl	%ebx, (%rax)
	cmpl	$50, %ebx
	jl	LBB4_104
## BB#107:
	xorl	%eax, %eax
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	ret
	.align	4, 0x90
LBB4_108:                               ## %.loopexit
                                        ##   in Loop: Header=BB4_109 Depth=1
	movq	-80(%rbp), %rax         ## 8-byte Reload
	movb	(%rax), %al
	cmpb	$1, %al
	jne	LBB4_103
LBB4_109:                               ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB4_110 Depth 2
	movq	-80(%rbp), %rax         ## 8-byte Reload
	movb	$0, (%rax)
	movq	-48(%rbp), %rax         ## 8-byte Reload
	movl	$1, (%rax)
	movl	$1, -60(%rbp)           ## 4-byte Folded Spill
	movl	$2, %ebx
	.align	4, 0x90
LBB4_110:                               ##   Parent Loop BB4_109 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	-56(%rbp), %r14         ## 8-byte Reload
	movq	(%r14), %r14
	movq	-48(%rbp), %r15         ## 8-byte Reload
	movl	(%r15), %r15d
	decl	%r15d
	cmpl	(%r14), %r15d
	jb	LBB4_112
## BB#111:                              ##   in Loop: Header=BB4_110 Depth=2
	leaq	___unnamed_2(%rip), %rax
	movq	%rax, %rdi
	callq	__write_string
	movl	$-1, %edi
	callq	_exit
LBB4_112:                               ##   in Loop: Header=BB4_110 Depth=2
	movslq	%r15d, %r15
	movl	4(%r14,%r15,4), %r14d
	movq	-56(%rbp), %r15         ## 8-byte Reload
	movq	(%r15), %r15
	movq	-48(%rbp), %rax         ## 8-byte Reload
	movslq	(%rax), %r12
	cmpl	(%r15), %r12d
	jb	LBB4_114
## BB#113:                              ##   in Loop: Header=BB4_110 Depth=2
	leaq	___unnamed_2(%rip), %rax
	movq	%rax, %rdi
	callq	__write_string
	movl	$-1, %edi
	callq	_exit
LBB4_114:                               ##   in Loop: Header=BB4_110 Depth=2
	cmpl	4(%r15,%r12,4), %r14d
	jle	LBB4_124
## BB#115:                              ##   in Loop: Header=BB4_110 Depth=2
	movq	-80(%rbp), %r14         ## 8-byte Reload
	movb	$1, (%r14)
	movq	-56(%rbp), %r14         ## 8-byte Reload
	movq	(%r14), %r14
	movq	-48(%rbp), %r15         ## 8-byte Reload
	movslq	(%r15), %r15
	cmpl	(%r14), %r15d
	jb	LBB4_117
## BB#116:                              ##   in Loop: Header=BB4_110 Depth=2
	leaq	___unnamed_2(%rip), %rax
	movq	%rax, %rdi
	callq	__write_string
	movl	$-1, %edi
	callq	_exit
LBB4_117:                               ##   in Loop: Header=BB4_110 Depth=2
	movl	4(%r14,%r15,4), %eax
	movq	-72(%rbp), %r14         ## 8-byte Reload
	movl	%eax, (%r14)
	movq	-56(%rbp), %r14         ## 8-byte Reload
	movq	(%r14), %r14
	movq	-48(%rbp), %r15         ## 8-byte Reload
	movslq	(%r15), %r15
	cmpl	(%r14), %r15d
	jb	LBB4_119
## BB#118:                              ##   in Loop: Header=BB4_110 Depth=2
	leaq	___unnamed_2(%rip), %rax
	movq	%rax, %rdi
	callq	__write_string
	movl	$-1, %edi
	callq	_exit
LBB4_119:                               ##   in Loop: Header=BB4_110 Depth=2
	movq	-56(%rbp), %rax         ## 8-byte Reload
	movq	(%rax), %r12
	movq	-48(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %r13d
	decl	%r13d
	cmpl	(%r12), %r13d
	jb	LBB4_121
## BB#120:                              ##   in Loop: Header=BB4_110 Depth=2
	leaq	___unnamed_2(%rip), %rax
	movq	%rax, %rdi
	callq	__write_string
	movl	$-1, %edi
	callq	_exit
LBB4_121:                               ##   in Loop: Header=BB4_110 Depth=2
	movslq	%r13d, %rax
	movl	4(%r12,%rax,4), %eax
	movl	%eax, 4(%r14,%r15,4)
	movq	-56(%rbp), %r14         ## 8-byte Reload
	movq	(%r14), %r14
	movq	-48(%rbp), %r15         ## 8-byte Reload
	movl	(%r15), %r15d
	decl	%r15d
	cmpl	(%r14), %r15d
	jb	LBB4_123
## BB#122:                              ##   in Loop: Header=BB4_110 Depth=2
	leaq	___unnamed_2(%rip), %rax
	movq	%rax, %rdi
	callq	__write_string
	movl	$-1, %edi
	callq	_exit
LBB4_123:                               ##   in Loop: Header=BB4_110 Depth=2
	movq	-72(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %eax
	movslq	%r15d, %r15
	movl	%eax, 4(%r14,%r15,4)
LBB4_124:                               ##   in Loop: Header=BB4_110 Depth=2
	movq	-48(%rbp), %r14         ## 8-byte Reload
	movl	%ebx, (%r14)
	incl	%ebx
	movl	-60(%rbp), %eax         ## 4-byte Reload
	incl	%eax
	movl	%eax, -60(%rbp)         ## 4-byte Spill
	cmpl	$50, %eax
	jge	LBB4_108
	jmp	LBB4_110
Leh_func_end4:

	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
Leh_func_begin5:
## BB#0:
	pushq	%rax
Ltmp8:
	callq	_$main
	popq	%rdx
	ret
Leh_func_end5:

	.section	__TEXT,__const
_int_format_string:                     ## @int_format_string
	.asciz	 "%d"

_string_format_string:                  ## @string_format_string
	.asciz	 "%s"

_true_string:                           ## @true_string
	.asciz	 "true"

_false_string:                          ## @false_string
	.asciz	 "false"

.zerofill __DATA,__bss,___nil__,4,2     ## @__nil__
                                        ## @__nil__
	.align	4                       ## @0
___unnamed_2:
	.asciz	 "Invalid array index!"

___unnamed_1:                           ## @1
	.asciz	 "\n"

	.section	__TEXT,__eh_frame,coalesced,no_toc+strip_static_syms+live_support
EH_frame0:
Lsection_eh_frame0:
Leh_frame_common0:
Lset0 = Leh_frame_common_end0-Leh_frame_common_begin0 ## Length of Common Information Entry
	.long	Lset0
Leh_frame_common_begin0:
	.long	0                       ## CIE Identifier Tag
	.byte	1                       ## DW_CIE_VERSION
	.asciz	 "zR"                   ## CIE Augmentation
	.byte	1                       ## CIE Code Alignment Factor
	.byte	120                     ## CIE Data Alignment Factor
	.byte	16                      ## CIE Return Address Column
	.byte	1                       ## Augmentation Size
	.byte	16                      ## FDE Encoding = pcrel
	.byte	12                      ## DW_CFA_def_cfa
	.byte	7                       ## Register
	.byte	8                       ## Offset
	.byte	144                     ## DW_CFA_offset + Reg (16)
	.byte	1                       ## Offset
	.align	3
Leh_frame_common_end0:
	.globl	__read_int.eh
__read_int.eh:
Lset1 = Leh_frame_end0-Leh_frame_begin0 ## Length of Frame Information Entry
	.long	Lset1
Leh_frame_begin0:
Lset2 = Leh_frame_begin0-Leh_frame_common0 ## FDE CIE offset
	.long	Lset2
Ltmp9:                                  ## FDE initial location
Ltmp10 = Leh_func_begin0-Ltmp9
	.quad	Ltmp10
Lset3 = Leh_func_end0-Leh_func_begin0   ## FDE address range
	.quad	Lset3
	.byte	0                       ## Augmentation size
	.byte	4                       ## DW_CFA_advance_loc4
Lset4 = Ltmp0-Leh_func_begin0
	.long	Lset4
	.byte	14                      ## DW_CFA_def_cfa_offset
	.byte	16                      ## Offset
	.byte	4                       ## DW_CFA_advance_loc4
Lset5 = Ltmp1-Ltmp0
	.long	Lset5
	.byte	14                      ## DW_CFA_def_cfa_offset
	.byte	32                      ## Offset
	.byte	131                     ## DW_CFA_offset + Reg (3)
	.byte	2                       ## Offset
	.align	3
Leh_frame_end0:

	.globl	__write_int.eh
__write_int.eh:
Lset6 = Leh_frame_end1-Leh_frame_begin1 ## Length of Frame Information Entry
	.long	Lset6
Leh_frame_begin1:
Lset7 = Leh_frame_begin1-Leh_frame_common0 ## FDE CIE offset
	.long	Lset7
Ltmp11:                                 ## FDE initial location
Ltmp12 = Leh_func_begin1-Ltmp11
	.quad	Ltmp12
Lset8 = Leh_func_end1-Leh_func_begin1   ## FDE address range
	.quad	Lset8
	.byte	0                       ## Augmentation size
	.byte	4                       ## DW_CFA_advance_loc4
Lset9 = Ltmp2-Leh_func_begin1
	.long	Lset9
	.byte	14                      ## DW_CFA_def_cfa_offset
	.byte	16                      ## Offset
	.align	3
Leh_frame_end1:

	.globl	__write_string.eh
__write_string.eh:
Lset10 = Leh_frame_end2-Leh_frame_begin2 ## Length of Frame Information Entry
	.long	Lset10
Leh_frame_begin2:
Lset11 = Leh_frame_begin2-Leh_frame_common0 ## FDE CIE offset
	.long	Lset11
Ltmp13:                                 ## FDE initial location
Ltmp14 = Leh_func_begin2-Ltmp13
	.quad	Ltmp14
Lset12 = Leh_func_end2-Leh_func_begin2  ## FDE address range
	.quad	Lset12
	.byte	0                       ## Augmentation size
	.byte	4                       ## DW_CFA_advance_loc4
Lset13 = Ltmp3-Leh_func_begin2
	.long	Lset13
	.byte	14                      ## DW_CFA_def_cfa_offset
	.byte	16                      ## Offset
	.align	3
Leh_frame_end2:

	.globl	__write_bool.eh
__write_bool.eh:
Lset14 = Leh_frame_end3-Leh_frame_begin3 ## Length of Frame Information Entry
	.long	Lset14
Leh_frame_begin3:
Lset15 = Leh_frame_begin3-Leh_frame_common0 ## FDE CIE offset
	.long	Lset15
Ltmp15:                                 ## FDE initial location
Ltmp16 = Leh_func_begin3-Ltmp15
	.quad	Ltmp16
Lset16 = Leh_func_end3-Leh_func_begin3  ## FDE address range
	.quad	Lset16
	.byte	0                       ## Augmentation size
	.byte	4                       ## DW_CFA_advance_loc4
Lset17 = Ltmp4-Leh_func_begin3
	.long	Lset17
	.byte	14                      ## DW_CFA_def_cfa_offset
	.byte	16                      ## Offset
	.align	3
Leh_frame_end3:

	.globl	_$main.eh
_$main.eh:
Lset18 = Leh_frame_end4-Leh_frame_begin4 ## Length of Frame Information Entry
	.long	Lset18
Leh_frame_begin4:
Lset19 = Leh_frame_begin4-Leh_frame_common0 ## FDE CIE offset
	.long	Lset19
Ltmp17:                                 ## FDE initial location
Ltmp18 = Leh_func_begin4-Ltmp17
	.quad	Ltmp18
Lset20 = Leh_func_end4-Leh_func_begin4  ## FDE address range
	.quad	Lset20
	.byte	0                       ## Augmentation size
	.byte	4                       ## DW_CFA_advance_loc4
Lset21 = Ltmp5-Leh_func_begin4
	.long	Lset21
	.byte	14                      ## DW_CFA_def_cfa_offset
	.byte	16                      ## Offset
	.byte	134                     ## DW_CFA_offset + Reg (6)
	.byte	2                       ## Offset
	.byte	4                       ## DW_CFA_advance_loc4
Lset22 = Ltmp6-Ltmp5
	.long	Lset22
	.byte	13                      ## DW_CFA_def_cfa_register
	.byte	6                       ## Register
	.byte	4                       ## DW_CFA_advance_loc4
Lset23 = Ltmp7-Ltmp6
	.long	Lset23
	.byte	131                     ## DW_CFA_offset + Reg (3)
	.byte	7                       ## Offset
	.byte	140                     ## DW_CFA_offset + Reg (12)
	.byte	6                       ## Offset
	.byte	141                     ## DW_CFA_offset + Reg (13)
	.byte	5                       ## Offset
	.byte	142                     ## DW_CFA_offset + Reg (14)
	.byte	4                       ## Offset
	.byte	143                     ## DW_CFA_offset + Reg (15)
	.byte	3                       ## Offset
	.align	3
Leh_frame_end4:

	.globl	_main.eh
_main.eh:
Lset24 = Leh_frame_end5-Leh_frame_begin5 ## Length of Frame Information Entry
	.long	Lset24
Leh_frame_begin5:
Lset25 = Leh_frame_begin5-Leh_frame_common0 ## FDE CIE offset
	.long	Lset25
Ltmp19:                                 ## FDE initial location
Ltmp20 = Leh_func_begin5-Ltmp19
	.quad	Ltmp20
Lset26 = Leh_func_end5-Leh_func_begin5  ## FDE address range
	.quad	Lset26
	.byte	0                       ## Augmentation size
	.byte	4                       ## DW_CFA_advance_loc4
Lset27 = Ltmp8-Leh_func_begin5
	.long	Lset27
	.byte	14                      ## DW_CFA_def_cfa_offset
	.byte	16                      ## Offset
	.align	3
Leh_frame_end5:


.subsections_via_symbols

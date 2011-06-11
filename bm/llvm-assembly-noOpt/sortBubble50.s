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
	subq	$376, %rsp              ## imm = 0x178
Ltmp7:
	movl	$0, -44(%rbp)
	movl	$1, -48(%rbp)
	movb	$1, %al
	testb	%al, %al
	jne	LBB4_2
## BB#1:
	movl	$0, -48(%rbp)
LBB4_2:
	movl	-48(%rbp), %ecx
	addl	%ecx, -44(%rbp)
	movq	%rsp, %rcx
	leaq	-16(%rcx), %rbx
	movq	%rbx, %rsp
	movl	$1, -16(%rcx)
	testb	%al, %al
	jne	LBB4_4
## BB#3:
	movl	$0, (%rbx)
LBB4_4:
	movl	(%rbx), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %r14
	movq	%r14, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_6
## BB#5:
	movl	$0, (%r14)
LBB4_6:
	movl	(%r14), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %r15
	movq	%r15, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_8
## BB#7:
	movl	$0, (%r15)
LBB4_8:
	movl	(%r15), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %r12
	movq	%r12, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_10
## BB#9:
	movl	$0, (%r12)
LBB4_10:
	movl	(%r12), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %r13
	movq	%r13, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_12
## BB#11:
	movl	$0, (%r13)
LBB4_12:
	movl	(%r13), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -56(%rbp)         ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_14
## BB#13:
	movq	-56(%rbp), %rax         ## 8-byte Reload
	movl	$0, (%rax)
LBB4_14:
	movq	-56(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -240(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_16
## BB#15:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_16:
	movq	-240(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -64(%rbp)         ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_18
## BB#17:
	movq	-64(%rbp), %rax         ## 8-byte Reload
	movl	$0, (%rax)
LBB4_18:
	movq	-64(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -248(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_20
## BB#19:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_20:
	movq	-248(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -72(%rbp)         ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_22
## BB#21:
	movq	-72(%rbp), %rax         ## 8-byte Reload
	movl	$0, (%rax)
LBB4_22:
	movq	-72(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -256(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_24
## BB#23:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_24:
	movq	-256(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -80(%rbp)         ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_26
## BB#25:
	movq	-80(%rbp), %rax         ## 8-byte Reload
	movl	$0, (%rax)
LBB4_26:
	movq	-80(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -264(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_28
## BB#27:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_28:
	movq	-264(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -88(%rbp)         ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_30
## BB#29:
	movq	-88(%rbp), %rax         ## 8-byte Reload
	movl	$0, (%rax)
LBB4_30:
	movq	-88(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -272(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_32
## BB#31:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_32:
	movq	-272(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -96(%rbp)         ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_34
## BB#33:
	movq	-96(%rbp), %rax         ## 8-byte Reload
	movl	$0, (%rax)
LBB4_34:
	movq	-96(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -280(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_36
## BB#35:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_36:
	movq	-280(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -104(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_38
## BB#37:
	movq	-104(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_38:
	movq	-104(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -288(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_40
## BB#39:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_40:
	movq	-288(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -112(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_42
## BB#41:
	movq	-112(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_42:
	movq	-112(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -296(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_44
## BB#43:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_44:
	movq	-296(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -120(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_46
## BB#45:
	movq	-120(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_46:
	movq	-120(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -304(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_48
## BB#47:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_48:
	movq	-304(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -128(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_50
## BB#49:
	movq	-128(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_50:
	movq	-128(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -312(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_52
## BB#51:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_52:
	movq	-312(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -136(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_54
## BB#53:
	movq	-136(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_54:
	movq	-136(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -320(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_56
## BB#55:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_56:
	movq	-320(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -144(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_58
## BB#57:
	movq	-144(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_58:
	movq	-144(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -328(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_60
## BB#59:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_60:
	movq	-328(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -152(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_62
## BB#61:
	movq	-152(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_62:
	movq	-152(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -336(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_64
## BB#63:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_64:
	movq	-336(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -160(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_66
## BB#65:
	movq	-160(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_66:
	movq	-160(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -344(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_68
## BB#67:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_68:
	movq	-344(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -168(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_70
## BB#69:
	movq	-168(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_70:
	movq	-168(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -352(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_72
## BB#71:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_72:
	movq	-352(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -176(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_74
## BB#73:
	movq	-176(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_74:
	movq	-176(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -360(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_76
## BB#75:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_76:
	movq	-360(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -184(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_78
## BB#77:
	movq	-184(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_78:
	movq	-184(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -368(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_80
## BB#79:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_80:
	movq	-368(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -192(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_82
## BB#81:
	movq	-192(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_82:
	movq	-192(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -376(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_84
## BB#83:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_84:
	movq	-376(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -200(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_86
## BB#85:
	movq	-200(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_86:
	movq	-200(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -384(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_88
## BB#87:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_88:
	movq	-384(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -208(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_90
## BB#89:
	movq	-208(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_90:
	movq	-208(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -392(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_92
## BB#91:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_92:
	movq	-392(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -216(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_94
## BB#93:
	movq	-216(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_94:
	movq	-216(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -400(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_96
## BB#95:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_96:
	movq	-400(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -224(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_98
## BB#97:
	movq	-224(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_98:
	movq	-224(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, -408(%rbp)        ## 8-byte Spill
	movq	%rdx, %rsp
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_100
## BB#99:
	movq	%rdx, %rax
	movl	$0, (%rax)
LBB4_100:
	movq	-408(%rbp), %rax        ## 8-byte Reload
	movl	(%rax), %eax
	addl	%eax, -44(%rbp)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -232(%rbp)        ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, %cl
	testb	%cl, %cl
	movl	$1, -16(%rax)
	jne	LBB4_102
## BB#101:
	movq	-232(%rbp), %rax        ## 8-byte Reload
	movl	$0, (%rax)
LBB4_102:
	movl	-44(%rbp), %eax
	movq	-232(%rbp), %rcx        ## 8-byte Reload
	addl	(%rcx), %eax
	movl	%eax, -44(%rbp)
	leal	4(,%rax,4), %edi
	callq	_malloc
	movq	%rsp, %rcx
	leaq	-16(%rcx), %rdx
	movq	%rdx, %rsp
	movq	%rax, -16(%rcx)
	movl	-44(%rbp), %ecx
	movq	%rax, %rdx
	movl	%ecx, (%rax)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, %rsp
	movl	$0, -16(%rax)
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_103
	.align	4, 0x90
LBB4_104:                               ##   in Loop: Header=BB4_103 Depth=1
	movslq	(%rcx), %rdi
	movl	$39991, 4(%rdx,%rdi,4)  ## imm = 0x9C37
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_103:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	cmpl	-48(%rbp), %eax
	jl	LBB4_104
## BB#105:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_106
	.align	4, 0x90
LBB4_107:                               ##   in Loop: Header=BB4_106 Depth=1
	movslq	(%rcx), %rdi
	movl	$27933, 4(%rdx,%rdi,4)  ## imm = 0x6D1D
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_106:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	cmpl	(%rbx), %eax
	jl	LBB4_107
## BB#108:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_109
	.align	4, 0x90
LBB4_110:                               ##   in Loop: Header=BB4_109 Depth=1
	movslq	(%rcx), %rdi
	movl	$31225, 4(%rdx,%rdi,4)  ## imm = 0x79F9
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_109:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	cmpl	(%r14), %eax
	jl	LBB4_110
## BB#111:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_112
	.align	4, 0x90
LBB4_113:                               ##   in Loop: Header=BB4_112 Depth=1
	movslq	(%rcx), %rdi
	movl	$6848, 4(%rdx,%rdi,4)   ## imm = 0x1AC0
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_112:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	cmpl	(%r15), %eax
	jl	LBB4_113
## BB#114:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_115
	.align	4, 0x90
LBB4_116:                               ##   in Loop: Header=BB4_115 Depth=1
	movslq	(%rcx), %rdi
	movl	$21032, 4(%rdx,%rdi,4)  ## imm = 0x5228
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_115:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	cmpl	(%r12), %eax
	jl	LBB4_116
## BB#117:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_118
	.align	4, 0x90
LBB4_119:                               ##   in Loop: Header=BB4_118 Depth=1
	movslq	(%rcx), %rdi
	movl	$45442, 4(%rdx,%rdi,4)  ## imm = 0xB182
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_118:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	cmpl	(%r13), %eax
	jl	LBB4_119
## BB#120:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_121
	.align	4, 0x90
LBB4_122:                               ##   in Loop: Header=BB4_121 Depth=1
	movslq	(%rcx), %rdi
	movl	$20652, 4(%rdx,%rdi,4)  ## imm = 0x50AC
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_121:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-56(%rbp), %rdi         ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_122
## BB#123:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_124
	.align	4, 0x90
LBB4_125:                               ##   in Loop: Header=BB4_124 Depth=1
	movslq	(%rcx), %rdi
	movl	$29205, 4(%rdx,%rdi,4)  ## imm = 0x7215
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_124:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-240(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_125
## BB#126:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_127
	.align	4, 0x90
LBB4_128:                               ##   in Loop: Header=BB4_127 Depth=1
	movslq	(%rcx), %rdi
	movl	$1455, 4(%rdx,%rdi,4)   ## imm = 0x5AF
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_127:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-64(%rbp), %rdi         ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_128
## BB#129:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_130
	.align	4, 0x90
LBB4_131:                               ##   in Loop: Header=BB4_130 Depth=1
	movslq	(%rcx), %rdi
	movl	$17903, 4(%rdx,%rdi,4)  ## imm = 0x45EF
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_130:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-248(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_131
## BB#132:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_133
	.align	4, 0x90
LBB4_134:                               ##   in Loop: Header=BB4_133 Depth=1
	movslq	(%rcx), %rdi
	movl	$20514, 4(%rdx,%rdi,4)  ## imm = 0x5022
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_133:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-72(%rbp), %rdi         ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_134
## BB#135:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_136
	.align	4, 0x90
LBB4_137:                               ##   in Loop: Header=BB4_136 Depth=1
	movslq	(%rcx), %rdi
	movl	$20731, 4(%rdx,%rdi,4)  ## imm = 0x50FB
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_136:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-256(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_137
## BB#138:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_139
	.align	4, 0x90
LBB4_140:                               ##   in Loop: Header=BB4_139 Depth=1
	movslq	(%rcx), %rdi
	movl	$35699, 4(%rdx,%rdi,4)  ## imm = 0x8B73
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_139:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-80(%rbp), %rdi         ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_140
## BB#141:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_142
	.align	4, 0x90
LBB4_143:                               ##   in Loop: Header=BB4_142 Depth=1
	movslq	(%rcx), %rdi
	movl	$27932, 4(%rdx,%rdi,4)  ## imm = 0x6D1C
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_142:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-264(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_143
## BB#144:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_145
	.align	4, 0x90
LBB4_146:                               ##   in Loop: Header=BB4_145 Depth=1
	movslq	(%rcx), %rdi
	movl	$9453, 4(%rdx,%rdi,4)   ## imm = 0x24ED
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_145:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-88(%rbp), %rdi         ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_146
## BB#147:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_148
	.align	4, 0x90
LBB4_149:                               ##   in Loop: Header=BB4_148 Depth=1
	movslq	(%rcx), %rdi
	movl	$18706, 4(%rdx,%rdi,4)  ## imm = 0x4912
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_148:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-272(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_149
## BB#150:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_151
	.align	4, 0x90
LBB4_152:                               ##   in Loop: Header=BB4_151 Depth=1
	movslq	(%rcx), %rdi
	movl	$11342, 4(%rdx,%rdi,4)  ## imm = 0x2C4E
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_151:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-96(%rbp), %rdi         ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_152
## BB#153:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_154
	.align	4, 0x90
LBB4_155:                               ##   in Loop: Header=BB4_154 Depth=1
	movslq	(%rcx), %rdi
	movl	$2170, 4(%rdx,%rdi,4)   ## imm = 0x87A
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_154:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-280(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_155
## BB#156:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_157
	.align	4, 0x90
LBB4_158:                               ##   in Loop: Header=BB4_157 Depth=1
	movslq	(%rcx), %rdi
	movl	$9727, 4(%rdx,%rdi,4)   ## imm = 0x25FF
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_157:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-104(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_158
## BB#159:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_160
	.align	4, 0x90
LBB4_161:                               ##   in Loop: Header=BB4_160 Depth=1
	movslq	(%rcx), %rdi
	movl	$9161, 4(%rdx,%rdi,4)   ## imm = 0x23C9
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_160:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-288(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_161
## BB#162:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_163
	.align	4, 0x90
LBB4_164:                               ##   in Loop: Header=BB4_163 Depth=1
	movslq	(%rcx), %rdi
	movl	$28697, 4(%rdx,%rdi,4)  ## imm = 0x7019
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_163:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-112(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_164
## BB#165:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_166
	.align	4, 0x90
LBB4_167:                               ##   in Loop: Header=BB4_166 Depth=1
	movslq	(%rcx), %rdi
	movl	$6568, 4(%rdx,%rdi,4)   ## imm = 0x19A8
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_166:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-296(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_167
## BB#168:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_169
	.align	4, 0x90
LBB4_170:                               ##   in Loop: Header=BB4_169 Depth=1
	movslq	(%rcx), %rdi
	movl	$1405, 4(%rdx,%rdi,4)   ## imm = 0x57D
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_169:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-120(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_170
## BB#171:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_172
	.align	4, 0x90
LBB4_173:                               ##   in Loop: Header=BB4_172 Depth=1
	movslq	(%rcx), %rdi
	movl	$18340, 4(%rdx,%rdi,4)  ## imm = 0x47A4
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_172:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-304(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_173
## BB#174:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_175
	.align	4, 0x90
LBB4_176:                               ##   in Loop: Header=BB4_175 Depth=1
	movslq	(%rcx), %rdi
	movl	$39524, 4(%rdx,%rdi,4)  ## imm = 0x9A64
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_175:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-128(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_176
## BB#177:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_178
	.align	4, 0x90
LBB4_179:                               ##   in Loop: Header=BB4_178 Depth=1
	movslq	(%rcx), %rdi
	movl	$24037, 4(%rdx,%rdi,4)  ## imm = 0x5DE5
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_178:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-312(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_179
## BB#180:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_181
	.align	4, 0x90
LBB4_182:                               ##   in Loop: Header=BB4_181 Depth=1
	movslq	(%rcx), %rdi
	movl	$29567, 4(%rdx,%rdi,4)  ## imm = 0x737F
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_181:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-136(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_182
## BB#183:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_184
	.align	4, 0x90
LBB4_185:                               ##   in Loop: Header=BB4_184 Depth=1
	movslq	(%rcx), %rdi
	movl	$35800, 4(%rdx,%rdi,4)  ## imm = 0x8BD8
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_184:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-320(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_185
## BB#186:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_187
	.align	4, 0x90
LBB4_188:                               ##   in Loop: Header=BB4_187 Depth=1
	movslq	(%rcx), %rdi
	movl	$36559, 4(%rdx,%rdi,4)  ## imm = 0x8ECF
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_187:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-144(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_188
## BB#189:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_190
	.align	4, 0x90
LBB4_191:                               ##   in Loop: Header=BB4_190 Depth=1
	movslq	(%rcx), %rdi
	movl	$6944, 4(%rdx,%rdi,4)   ## imm = 0x1B20
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_190:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-328(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_191
## BB#192:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_193
	.align	4, 0x90
LBB4_194:                               ##   in Loop: Header=BB4_193 Depth=1
	movslq	(%rcx), %rdi
	movl	$33607, 4(%rdx,%rdi,4)  ## imm = 0x8347
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_193:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-152(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_194
## BB#195:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_196
	.align	4, 0x90
LBB4_197:                               ##   in Loop: Header=BB4_196 Depth=1
	movslq	(%rcx), %rdi
	movl	$2179, 4(%rdx,%rdi,4)   ## imm = 0x883
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_196:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-336(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_197
## BB#198:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_199
	.align	4, 0x90
LBB4_200:                               ##   in Loop: Header=BB4_199 Depth=1
	movslq	(%rcx), %rdi
	movl	$32247, 4(%rdx,%rdi,4)  ## imm = 0x7DF7
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_199:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-160(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_200
## BB#201:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_202
	.align	4, 0x90
LBB4_203:                               ##   in Loop: Header=BB4_202 Depth=1
	movslq	(%rcx), %rdi
	movl	$34476, 4(%rdx,%rdi,4)  ## imm = 0x86AC
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_202:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-344(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_203
## BB#204:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_205
	.align	4, 0x90
LBB4_206:                               ##   in Loop: Header=BB4_205 Depth=1
	movslq	(%rcx), %rdi
	movl	$28843, 4(%rdx,%rdi,4)  ## imm = 0x70AB
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_205:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-168(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_206
## BB#207:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_208
	.align	4, 0x90
LBB4_209:                               ##   in Loop: Header=BB4_208 Depth=1
	movslq	(%rcx), %rdi
	movl	$11114, 4(%rdx,%rdi,4)  ## imm = 0x2B6A
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_208:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-352(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_209
## BB#210:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_211
	.align	4, 0x90
LBB4_212:                               ##   in Loop: Header=BB4_211 Depth=1
	movslq	(%rcx), %rdi
	movl	$17840, 4(%rdx,%rdi,4)  ## imm = 0x45B0
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_211:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-176(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_212
## BB#213:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_214
	.align	4, 0x90
LBB4_215:                               ##   in Loop: Header=BB4_214 Depth=1
	movslq	(%rcx), %rdi
	movl	$13071, 4(%rdx,%rdi,4)  ## imm = 0x330F
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_214:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-360(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_215
## BB#216:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_217
	.align	4, 0x90
LBB4_218:                               ##   in Loop: Header=BB4_217 Depth=1
	movslq	(%rcx), %rdi
	movl	$13185, 4(%rdx,%rdi,4)  ## imm = 0x3381
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_217:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-184(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_218
## BB#219:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_220
	.align	4, 0x90
LBB4_221:                               ##   in Loop: Header=BB4_220 Depth=1
	movslq	(%rcx), %rdi
	movl	$15386, 4(%rdx,%rdi,4)  ## imm = 0x3C1A
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_220:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-368(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_221
## BB#222:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_223
	.align	4, 0x90
LBB4_224:                               ##   in Loop: Header=BB4_223 Depth=1
	movslq	(%rcx), %rdi
	movl	$35723, 4(%rdx,%rdi,4)  ## imm = 0x8B8B
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_223:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-192(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_224
## BB#225:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_226
	.align	4, 0x90
LBB4_227:                               ##   in Loop: Header=BB4_226 Depth=1
	movslq	(%rcx), %rdi
	movl	$7481, 4(%rdx,%rdi,4)   ## imm = 0x1D39
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_226:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-376(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_227
## BB#228:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_229
	.align	4, 0x90
LBB4_230:                               ##   in Loop: Header=BB4_229 Depth=1
	movslq	(%rcx), %rdi
	movl	$48726, 4(%rdx,%rdi,4)  ## imm = 0xBE56
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_229:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-200(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_230
## BB#231:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_232
	.align	4, 0x90
LBB4_233:                               ##   in Loop: Header=BB4_232 Depth=1
	movslq	(%rcx), %rdi
	movl	$13823, 4(%rdx,%rdi,4)  ## imm = 0x35FF
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_232:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-384(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_233
## BB#234:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_235
	.align	4, 0x90
LBB4_236:                               ##   in Loop: Header=BB4_235 Depth=1
	movslq	(%rcx), %rdi
	movl	$43989, 4(%rdx,%rdi,4)  ## imm = 0xABD5
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_235:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-208(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_236
## BB#237:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_238
	.align	4, 0x90
LBB4_239:                               ##   in Loop: Header=BB4_238 Depth=1
	movslq	(%rcx), %rdi
	movl	$13490, 4(%rdx,%rdi,4)  ## imm = 0x34B2
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_238:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-392(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_239
## BB#240:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_241
	.align	4, 0x90
LBB4_242:                               ##   in Loop: Header=BB4_241 Depth=1
	movslq	(%rcx), %rdi
	movl	$4954, 4(%rdx,%rdi,4)   ## imm = 0x135A
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_241:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-216(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_242
## BB#243:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_244
	.align	4, 0x90
LBB4_245:                               ##   in Loop: Header=BB4_244 Depth=1
	movslq	(%rcx), %rdi
	movl	$37571, 4(%rdx,%rdi,4)  ## imm = 0x92C3
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_244:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-400(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_245
## BB#246:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_247
	.align	4, 0x90
LBB4_248:                               ##   in Loop: Header=BB4_247 Depth=1
	movslq	(%rcx), %rdi
	movl	$27500, 4(%rdx,%rdi,4)  ## imm = 0x6B6C
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_247:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-224(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_248
## BB#249:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_250
	.align	4, 0x90
LBB4_251:                               ##   in Loop: Header=BB4_250 Depth=1
	movslq	(%rcx), %rdi
	movl	$47772, 4(%rdx,%rdi,4)  ## imm = 0xBA9C
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_250:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-408(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_251
## BB#252:
	movq	%rsp, %rax
	leaq	-16(%rax), %rsi
	movq	%rsi, %rsp
	movl	$0, -16(%rax)
	jmp	LBB4_253
	.align	4, 0x90
LBB4_254:                               ##   in Loop: Header=BB4_253 Depth=1
	movslq	(%rcx), %rdi
	movl	$34332, 4(%rdx,%rdi,4)  ## imm = 0x861C
	incl	%edi
	movl	%edi, (%rcx)
	incl	%eax
	movl	%eax, (%rsi)
LBB4_253:                               ## =>This Inner Loop Header: Depth=1
	movl	(%rsi), %eax
	movq	-232(%rbp), %rdi        ## 8-byte Reload
	cmpl	(%rdi), %eax
	jl	LBB4_254
## BB#255:
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -64(%rbp)         ## 8-byte Spill
	movq	%rcx, %rsp
	movq	%rdx, -16(%rax)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -56(%rbp)         ## 8-byte Spill
	movq	%rcx, %rsp
	movl	$0, -16(%rax)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, %rsp
	movl	$0, -16(%rax)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -72(%rbp)         ## 8-byte Spill
	movq	%rcx, %rsp
	movl	$0, -16(%rax)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -80(%rbp)         ## 8-byte Spill
	movq	%rcx, %rsp
	movb	$1, -16(%rax)
	.align	4, 0x90
LBB4_256:                               ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB4_258 Depth 2
	movq	-80(%rbp), %rax         ## 8-byte Reload
	movb	(%rax), %al
	cmpb	$1, %al
	jne	LBB4_274
## BB#257:                              ##   in Loop: Header=BB4_256 Depth=1
	movq	-80(%rbp), %rax         ## 8-byte Reload
	movb	$0, (%rax)
	movq	-56(%rbp), %rax         ## 8-byte Reload
	movl	$1, (%rax)
	.align	4, 0x90
LBB4_258:                               ##   Parent Loop BB4_256 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	-56(%rbp), %rbx         ## 8-byte Reload
	movl	(%rbx), %ebx
	cmpl	$49, %ebx
	jg	LBB4_256
## BB#259:                              ##   in Loop: Header=BB4_258 Depth=2
	movq	-64(%rbp), %r14         ## 8-byte Reload
	movq	(%r14), %r14
	movq	-56(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %r15d
	decl	%r15d
	cmpl	(%r14), %r15d
	jb	LBB4_261
## BB#260:                              ##   in Loop: Header=BB4_258 Depth=2
	leaq	___unnamed_1(%rip), %rax
	movq	%rax, %rdi
	callq	__write_string
	movl	$-1, %edi
	callq	_exit
LBB4_261:                               ##   in Loop: Header=BB4_258 Depth=2
	movslq	%r15d, %rax
	movl	4(%r14,%rax,4), %r14d
	movq	-64(%rbp), %rax         ## 8-byte Reload
	movq	(%rax), %r15
	movq	-56(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %r12d
	cmpl	(%r15), %r12d
	jb	LBB4_263
## BB#262:                              ##   in Loop: Header=BB4_258 Depth=2
	leaq	___unnamed_1(%rip), %rax
	movq	%rax, %rdi
	callq	__write_string
	movl	$-1, %edi
	callq	_exit
LBB4_263:                               ##   in Loop: Header=BB4_258 Depth=2
	movslq	%r12d, %rax
	cmpl	4(%r15,%rax,4), %r14d
	jle	LBB4_273
## BB#264:                              ##   in Loop: Header=BB4_258 Depth=2
	movq	-80(%rbp), %r14         ## 8-byte Reload
	movb	$1, (%r14)
	movq	-64(%rbp), %r14         ## 8-byte Reload
	movq	(%r14), %r14
	movq	-56(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %r15d
	cmpl	(%r14), %r15d
	jb	LBB4_266
## BB#265:                              ##   in Loop: Header=BB4_258 Depth=2
	leaq	___unnamed_1(%rip), %rax
	movq	%rax, %rdi
	callq	__write_string
	movl	$-1, %edi
	callq	_exit
LBB4_266:                               ##   in Loop: Header=BB4_258 Depth=2
	movslq	%r15d, %rax
	movl	4(%r14,%rax,4), %eax
	movq	-72(%rbp), %r14         ## 8-byte Reload
	movl	%eax, (%r14)
	movq	-64(%rbp), %r14         ## 8-byte Reload
	movq	(%r14), %r14
	movq	-56(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %r15d
	cmpl	(%r14), %r15d
	jb	LBB4_268
## BB#267:                              ##   in Loop: Header=BB4_258 Depth=2
	leaq	___unnamed_1(%rip), %rax
	movq	%rax, %rdi
	callq	__write_string
	movl	$-1, %edi
	callq	_exit
LBB4_268:                               ##   in Loop: Header=BB4_258 Depth=2
	movq	-64(%rbp), %rax         ## 8-byte Reload
	movq	(%rax), %r12
	movq	-56(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %r13d
	decl	%r13d
	cmpl	(%r12), %r13d
	jb	LBB4_270
## BB#269:                              ##   in Loop: Header=BB4_258 Depth=2
	leaq	___unnamed_1(%rip), %rax
	movq	%rax, %rdi
	callq	__write_string
	movl	$-1, %edi
	callq	_exit
LBB4_270:                               ##   in Loop: Header=BB4_258 Depth=2
	movslq	%r13d, %rax
	movl	4(%r12,%rax,4), %eax
	movslq	%r15d, %rcx
	movl	%eax, 4(%r14,%rcx,4)
	movq	-64(%rbp), %r14         ## 8-byte Reload
	movq	(%r14), %r14
	movq	-56(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %r15d
	decl	%r15d
	cmpl	(%r14), %r15d
	jb	LBB4_272
## BB#271:                              ##   in Loop: Header=BB4_258 Depth=2
	leaq	___unnamed_1(%rip), %rax
	movq	%rax, %rdi
	callq	__write_string
	movl	$-1, %edi
	callq	_exit
LBB4_272:                               ##   in Loop: Header=BB4_258 Depth=2
	movq	-72(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %eax
	movslq	%r15d, %rcx
	movl	%eax, 4(%r14,%rcx,4)
LBB4_273:                               ##   in Loop: Header=BB4_258 Depth=2
	incl	%ebx
	movq	-56(%rbp), %r14         ## 8-byte Reload
	movl	%ebx, (%r14)
	jmp	LBB4_258
LBB4_274:
	movq	-56(%rbp), %rax         ## 8-byte Reload
	movl	$0, (%rax)
	leaq	___unnamed_2(%rip), %rbx
	leaq	___unnamed_1(%rip), %r14
	jmp	LBB4_275
	.align	4, 0x90
LBB4_276:                               ##   in Loop: Header=BB4_275 Depth=1
	movq	-64(%rbp), %rax         ## 8-byte Reload
	movq	(%rax), %r12
	movq	-56(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %r13d
	cmpl	(%r12), %r13d
	jb	LBB4_278
## BB#277:                              ##   in Loop: Header=BB4_275 Depth=1
	movq	%r14, %rdi
	callq	__write_string
	movl	$-1, %edi
	callq	_exit
LBB4_278:                               ##   in Loop: Header=BB4_275 Depth=1
	movslq	%r13d, %rax
	movl	4(%r12,%rax,4), %edi
	callq	__write_int
	movq	%rbx, %rdi
	callq	__write_string
	incl	%r15d
	movq	-56(%rbp), %rax         ## 8-byte Reload
	movl	%r15d, (%rax)
LBB4_275:                               ## =>This Inner Loop Header: Depth=1
	movq	-56(%rbp), %rax         ## 8-byte Reload
	movl	(%rax), %r15d
	cmpl	$49, %r15d
	jle	LBB4_276
## BB#279:
	xorl	%eax, %eax
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	ret
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
___unnamed_1:
	.asciz	 "Invalid array index!"

___unnamed_2:                           ## @1
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

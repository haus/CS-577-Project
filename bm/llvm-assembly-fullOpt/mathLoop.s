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
	pushq	%r15
Ltmp5:
	pushq	%r14
Ltmp6:
	pushq	%rbx
Ltmp7:
Ltmp8:
	xorl	%ebx, %ebx
	leaq	___unnamed_1(%rip), %r14
	movl	%ebx, %r15d
	.align	4, 0x90
LBB4_1:                                 ## =>This Inner Loop Header: Depth=1
	addl	$15, %r15d
	movl	%r15d, %edi
	callq	__write_int
	movq	%r14, %rdi
	callq	__write_string
	incl	%ebx
	cmpl	$101, %ebx
	jl	LBB4_1
## BB#2:
	movl	%r15d, %edi
	callq	__write_int
	leaq	___unnamed_1(%rip), %rdi
	callq	__write_string
	xorl	%eax, %eax
	popq	%rbx
	popq	%r14
	popq	%r15
	ret
Leh_func_end4:

	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
Leh_func_begin5:
## BB#0:
	pushq	%rax
Ltmp9:
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
___unnamed_1:                           ## @0
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
Ltmp10:                                 ## FDE initial location
Ltmp11 = Leh_func_begin0-Ltmp10
	.quad	Ltmp11
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
Ltmp12:                                 ## FDE initial location
Ltmp13 = Leh_func_begin1-Ltmp12
	.quad	Ltmp13
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
Ltmp14:                                 ## FDE initial location
Ltmp15 = Leh_func_begin2-Ltmp14
	.quad	Ltmp15
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
Ltmp16:                                 ## FDE initial location
Ltmp17 = Leh_func_begin3-Ltmp16
	.quad	Ltmp17
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
Ltmp18:                                 ## FDE initial location
Ltmp19 = Leh_func_begin4-Ltmp18
	.quad	Ltmp19
Lset20 = Leh_func_end4-Leh_func_begin4  ## FDE address range
	.quad	Lset20
	.byte	0                       ## Augmentation size
	.byte	4                       ## DW_CFA_advance_loc4
Lset21 = Ltmp5-Leh_func_begin4
	.long	Lset21
	.byte	14                      ## DW_CFA_def_cfa_offset
	.byte	16                      ## Offset
	.byte	4                       ## DW_CFA_advance_loc4
Lset22 = Ltmp6-Ltmp5
	.long	Lset22
	.byte	14                      ## DW_CFA_def_cfa_offset
	.byte	24                      ## Offset
	.byte	4                       ## DW_CFA_advance_loc4
Lset23 = Ltmp7-Ltmp6
	.long	Lset23
	.byte	14                      ## DW_CFA_def_cfa_offset
	.byte	32                      ## Offset
	.byte	4                       ## DW_CFA_advance_loc4
Lset24 = Ltmp8-Ltmp7
	.long	Lset24
	.byte	131                     ## DW_CFA_offset + Reg (3)
	.byte	4                       ## Offset
	.byte	142                     ## DW_CFA_offset + Reg (14)
	.byte	3                       ## Offset
	.byte	143                     ## DW_CFA_offset + Reg (15)
	.byte	2                       ## Offset
	.align	3
Leh_frame_end4:

	.globl	_main.eh
_main.eh:
Lset25 = Leh_frame_end5-Leh_frame_begin5 ## Length of Frame Information Entry
	.long	Lset25
Leh_frame_begin5:
Lset26 = Leh_frame_begin5-Leh_frame_common0 ## FDE CIE offset
	.long	Lset26
Ltmp20:                                 ## FDE initial location
Ltmp21 = Leh_func_begin5-Ltmp20
	.quad	Ltmp21
Lset27 = Leh_func_end5-Leh_func_begin5  ## FDE address range
	.quad	Lset27
	.byte	0                       ## Augmentation size
	.byte	4                       ## DW_CFA_advance_loc4
Lset28 = Ltmp9-Leh_func_begin5
	.long	Lset28
	.byte	14                      ## DW_CFA_def_cfa_offset
	.byte	16                      ## Offset
	.align	3
Leh_frame_end5:


.subsections_via_symbols

.text
# Allocation map
# $T0	%rdx
# $RET	%rax
# $T1	%rdx
# a_3	%rax
# $T2	%rax
# $T3	%rax
# b_4	%rcx
	.p2align 4,0x90
.globl __$MAIN
__$MAIN:
	subq $0,%rsp
    # L0
L0_0:
    # movI 5,a_3
	movl $5,%eax
    # movI 12,b_4
	movl $12,%ecx
    # cmpI a_3,a_3
	cmpl %eax,%eax
    # je L3
	je L0_3
    # jmp L2
	jmp L0_2
    # L2
L0_2:
    # movB false,$T0
	movb $0,%dl
    # jmp L4
	jmp L0_4
    # L3
L0_3:
    # movB true,$T0
	movb $1,%dl
    # L4
L0_4:
    # movB $T0,c_5
    # cmpI a_3,a_3
	cmpl %eax,%eax
    # jne L5
	jne L0_5
    # jmp L6
	jmp L0_6
    # L5
L0_5:
    # cmpI b_4,a_3
	cmpl %eax,%ecx
    # je L8
	je L0_8
    # jmp L9
	jmp L0_9
    # L8
L0_8:
    # movI a_3,b_4
	movl %eax,%ecx
    # jmp L10
	jmp L0_10
    # L9
L0_9:
    # addI b_4,5,$T1
	movl %ecx,%edx
	addl $5,%edx
    # movI $T1,b_4
	movl %edx,%ecx
    # L10
L0_10:
    # jmp L7
	jmp L0_7
    # L6
L0_6:
    # cmpI b_4,a_3
	cmpl %eax,%ecx
    # je L11
	je L0_11
    # jmp L12
	jmp L0_12
    # L11
L0_11:
    # subI 0,a_3,$T2
	movl $0,%r10d
	subl %eax,%r10d
	movl %r10d,%eax
    # movI $T2,b_4
	movl %eax,%ecx
    # jmp L13
	jmp L0_13
    # L12
L0_12:
    # addI b_4,10,$T3
	movl %ecx,%eax
	addl $10,%eax
    # movI $T3,b_4
	movl %eax,%ecx
    # L13
L0_13:
    # L7
L0_7:
    # movI b_4,d_6
    # L1
L0_1:
    # movI 0,$RET
	movl $0,%eax
    # L14
L0_14:
	addq $0,%rsp
	ret

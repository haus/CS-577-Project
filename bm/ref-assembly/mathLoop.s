.text
# Allocation map
# $T0	%rax
# $A{0}0	%rsi
# $RET	%rax
# $T1	%rax
# a_3	%rbx
# $T2	%rax
# $A{2}0	%rsi
# e_7	%r14
# c_5	%r12
# d_6	%r13
# i_8	%r15
# b_4	%rbp
	.p2align 4,0x90
.globl __$MAIN
__$MAIN:
	pushq %rbx
	pushq %rbp
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $0,%rsp
    # L0
L0_0:
    # movI 4,a_3
	movl $4,%ebx
    # movI 5,b_4
	movl $5,%ebp
    # movI 6,c_5
	movl $6,%r12d
    # movI 0,d_6
	movl $0,%r13d
    # movI 0,e_7
	movl $0,%r14d
    # movI 0,i_8
    # movI 0,i_8
	movl $0,%r15d
    # L2
L0_2:
    # cmpI i_8,100
	cmpl $100,%r15d
    # jg L3
	jg L0_3
    # addI d_6,a_3,$T0
	movl %r13d,%eax
	addl %ebx,%eax
    # addI $T0,b_4,$T1
	addl %ebp,%eax
    # movI $T1,d_6
	movl %eax,%r13d
    # addI d_6,c_5,$T2
	movl %r13d,%eax
	addl %r12d,%eax
    # movI $T2,d_6
	movl %eax,%r13d
    # movI d_6,$A{0}0
	movl %r13d,%esi
    # calls{0} <1,false> "write_int"
	pushq %rdi
	call _write_int
	popq %rdi
    # calls{1} <0,false> "write_newline"
	pushq %rdi
	call _write_newline
	popq %rdi
    # movI d_6,e_7
	movl %r13d,%r14d
    # addI i_8,1,i_8
	addl $1,%r15d
    # jmp L2
	jmp L0_2
    # L3
L0_3:
    # movI e_7,$A{2}0
	movl %r14d,%esi
    # calls{2} <1,false> "write_int"
	pushq %rdi
	call _write_int
	popq %rdi
    # calls{3} <0,false> "write_newline"
	pushq %rdi
	call _write_newline
	popq %rdi
    # L1
L0_1:
    # movI 0,$RET
	movl $0,%eax
    # L4
L0_4:
	addq $0,%rsp
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbp
	popq %rbx
	ret

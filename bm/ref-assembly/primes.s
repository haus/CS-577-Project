.text
# Allocation map
# $T0	%rcx
# $A{0}0	%rsi
# $RET	%rax
# $T1	%rsi
# $T2	%rsi
# $A{2}0	%rsi
# i_3	%rbx
# j_4	%rdx
# prime_5	%rax
	.p2align 4,0x90
.globl __$MAIN
__$MAIN:
	pushq %rbx
	subq $8,%rsp
    # L0
L0_0:
    # movI 0,i_3
    # movI 0,j_4
    # movB false,prime_5
    # movI 2,$A{0}0
	movl $2,%esi
    # calls{0} <1,false> "write_int"
	pushq %rdi
	call _write_int
	popq %rdi
    # calls{1} <0,false> "write_newline"
	pushq %rdi
	call _write_newline
	popq %rdi
    # movI 3,i_3
	movl $3,%ebx
    # L2
L0_2:
    # cmpI i_3,50000
	cmpl $50000,%ebx
    # jg L3
	jg L0_3
    # movB true,prime_5
	movb $1,%al
    # subI i_3,1,$T0
	movl %ebx,%ecx
	subl $1,%ecx
    # movI 2,j_4
	movl $2,%edx
    # L4
L0_4:
    # cmpI j_4,$T0
	cmpl %ecx,%edx
    # jg L5
	jg L0_5
    # modI i_3,j_4,$T1
	movl %ebx,%r10d
	movl %edx,%r11d
	pushq %rax
	pushq %rdx
	movl %r10d,%eax
	cltd
	idivl %r11d
	movl %edx,%r10d
	popq %rdx
	popq %rax
	movl %r10d,%esi
    # cmpI $T1,0
	cmpl $0,%esi
    # je L6
	je L0_6
    # jmp L7
	jmp L0_7
    # L6
L0_6:
    # subI i_3,1,$T2
	movl %ebx,%esi
	subl $1,%esi
    # movI $T2,j_4
	movl %esi,%edx
    # movB false,prime_5
	movb $0,%al
    # jmp L8
	jmp L0_8
    # L7
L0_7:
    # L8
L0_8:
    # addI j_4,1,j_4
	addl $1,%edx
    # jmp L4
	jmp L0_4
    # L5
L0_5:
    # cmpB prime_5,false
	cmpb $0,%al
    # je L10
	je L0_10
    # jmp L9
	jmp L0_9
    # L9
L0_9:
    # movI i_3,$A{2}0
	movl %ebx,%esi
    # calls{2} <1,false> "write_int"
	pushq %rdi
	call _write_int
	popq %rdi
    # calls{3} <0,false> "write_newline"
	pushq %rdi
	call _write_newline
	popq %rdi
    # jmp L11
	jmp L0_11
    # L10
L0_10:
    # L11
L0_11:
    # addI i_3,1,i_3
	addl $1,%ebx
    # jmp L2
	jmp L0_2
    # L3
L0_3:
    # L1
L0_1:
    # movI 0,$RET
	movl $0,%eax
    # L12
L0_12:
	addq $8,%rsp
	popq %rbx
	ret

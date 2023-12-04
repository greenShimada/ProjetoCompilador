.text
	move $t529697948, $a0
	li $t0,11
	move $s1,$t0
	li $t1,5
	move $s2,$t1
WHILE5:
	li $t2,1
	bgt $s1,$s2,L1
	li $t2,0
L1:
	beq $t2, 0, END_WHILE5
	li $t3,10
	li $t4,1
	blt $s2,$t3,L2
	li $t4,0
L2:
	beq $t4,0,END_IF2
	add $t5,$s2,$s2
	move $s2,$t5
END_IF2:
	j WHILE5
END_WHILE5:
	jal FUNC3
	li $v0, 10
	syscall
	move $s3, $a0
FUNC3:
	li $v0, 1
	move $a0,$s2
	syscall
	li $v0,11
	li $a0,'\n'
	syscall
jr $ra

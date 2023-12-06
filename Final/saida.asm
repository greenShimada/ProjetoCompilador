.text
	li $t0,10
	move $s1,$t0
	li $t1,5
	move $s2,$t1
	li $t2,2
	move $s3,$t2
	move $a0, $s2
	move $a1, $s1
	jal FUNC4
	move $a2, $s2
	jal FUNC5
	li $v0, 10
	syscall
FUNC4:
	move $s7, $a0
	move $s6, $a1
	li $v0, 1
	move $a0,$s6
	syscall
	li $v0,11
	li $a0,'\n'
	syscall
	li $v0, 1
	move $a0,$s7
	syscall
	li $v0,11
	li $a0,'\n'
	syscall
jr $ra
FUNC5:
	move $s6, $a0
	li $v0, 1
	move $a0,$s6
	syscall
jr $ra

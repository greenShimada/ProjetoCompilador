.text
	li $t0,4
	move $s1,$t0
	li $t0,8
	move $s2,$t0
	move $a0, $s2
	jal FUNC3
	li $v0, 1
	move $a0,$s1
	syscall
	li $v0, 10
	syscall
FUNC3:
	move $s1, $a0
	li $v0, 1
	move $a0,$s1
	syscall
	li $v0,11
	li $a0,'\n'
	syscall
jr $ra

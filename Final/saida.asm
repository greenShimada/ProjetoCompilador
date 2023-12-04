.text
	li $t0,11
	move $s1,$t0
	move $a0, $s1
	jal FUNC3
	li $v0, 10
	syscall
FUNC3:
	move $s4, $a0
	li $v0, 1
	move $a0,$s4
	syscall
	li $v0,11
	li $a0,'\n'
	syscall
jr $ra

.text
	li $t0,10
	move $s1,$t0
	li $t1,5
	move $s2,$t1
	move $a0, $s2
	move $a1, $s1
	jal FUNC4
	li $v0, 10
	syscall
FUNC4:
	move $s6, $a1
	move $s5, $a0
	li $v0, 1
	move $a0,$s5
	syscall
	li $v0,11
	li $a0,'\n'
	syscall
	li $v0, 1
	move $a0,$s6
	syscall
	li $v0,11
	li $a0,'\n'
	syscall
jr $ra

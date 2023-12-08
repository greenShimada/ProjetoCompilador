.text
	li $t0,4
	move $s1,$t0
	move $a0, $s1
	jal FUNC2
	li $v0, 1
	move $a0,$s1
	syscall
	li $v0,11
	li $a0,'\n'
	syscall
	li $v0, 10
	syscall
FUNC2:
	move $s1, $a0
	li $t0,10
	add $t1,$s1,$t0
	move $s1,$t1
	li $v0, 1
	move $a0,$s1
	syscall
	li $v0,11
	li $a0,'\n'
	syscall
jr $ra

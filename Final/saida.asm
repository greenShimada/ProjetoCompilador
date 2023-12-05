.text
	li $t0,10
	move $s1,$t0
	li $t1,5
	move $s2,$t1
	li $t2,8
	move $s3,$t2
	move $a0, $s3
	move $a1, $s2
	move $a2, $s1
	jal FUNC4
	li $v0, 10
	syscall
FUNC4:
	move $s5, $a0
	li $v0, 1
	move $a0,$s5
	syscall
	li $v0, 1
	move $a0,$s6
	syscall
jr $ra

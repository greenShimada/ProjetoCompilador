.text
        li $t0,10              #a = 10
        move $s1,$t0           
        li $t1,5	       #b = 5
        move $s2,$t1
L11:    li $t2,1
        bgt $s1,$s2,L1	       #a > b				
        li $t2,0
L1:     beq $t2, 0, L3
        sub $t3,$s1,$s2        #a = a - b;
        move $s1,$t3           
j L11
L3:
        li $v0, 1
        move $a0,$s1
        syscall
        li $v0,11
        li $a0,'\n'
        syscall
.text
    g:  .word 15
    h:  .word 36
    i:  .word 12
    k:  .word 19
    f:  .word 0

.globl main
    main:
        lw $t0, g
        lw $t1, h
        lw $t2, i
        lw $t3, k

        add $t4, $t0, $t1   # $t4 = g + h
        add $t5, $t2, $t3   # $t5 = i + k
        sub $t6, $t4, $t5   # $t6 = f

        sw $t6, f

        li $v0, 10
        syscall

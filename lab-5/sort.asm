.data
    Arr: .word 246, 57, 48, 98, 34, 197, 12, 207, 182, 89, 143, 124, 118, 252, 243, 230
    SortedMsg: .asciiz "Array ordenado: "
    Comma: .asciiz ", "

.text
.globl main
    sort:
        addi $sp, $sp, -4
        sw $ra, 0($sp)

        addi $sp, $sp, -4
        sw $s3, 0($sp)

        addi $sp, $sp, -4
        sw $s2, 0($sp)

        addi $sp, $sp, -4
        sw $s1, 0($sp)

        addi $sp, $sp, -4
        sw $s0, 0($sp)

        add $s2, $a0, $zero

        add $s3, $a1, $zero

        add $s0, $zero, $zero

    for_1st:
        slt $t0, $s0, $s3
        beq $t0, $zero, exit1

        addi $s1, $s0, -1

    for_2nd:
        slti $t0, $s1, 0
        bne $t0, $zero, exit2

        sll $t1, $s1, 2

        add $t2, $s2, $t1

        lw $t3, 0($t2)

        lw $t4, 4($t2)

        slt $t0, $t4, $t3
        beq $t0, $zero, exit2

        add $a0, $s2, $zero

        add $a1, $s1, $zero

        jal swap

        addi $s1, $s1, -1

        j for_2nd

    exit2:
        addi $s0, $s0, 1
        j for_1st

    exit1:
        lw $s0, 0($sp)
        addi $sp, $sp, 4

        lw $s1, 0($sp)
        addi $sp, $sp, 4

        lw $s2, 0($sp)
        addi $sp, $sp, 4

        lw $s3, 0($sp)
        addi $sp, $sp, 4

        lw $ra, 0($sp)
        addi $sp, $sp, 4

        jr $ra

    swap:
        sll $t1, $a1, 2

        add $t1, $a0, $t1

        lw $t0, 0($t1)

        lw $t2, 4($t1)

        sw $t2, 0($t1)

        sw $t0, 4($t1)

        jr $ra

    main:
        la $a0, Arr
        addi $a1, $zero, 16
        jal sort

        li $v0, 4
        la $a0, SortedMsg
        syscall

        la $t0, Arr

        la $t2, Arr
        addi $t2, $t2, 64

    print_loop:
        lw $t1, 0($t0)
        li $v0, 1
        move $a0, $t1
        syscall

        addi $t0, $t0, 4
        li $v0, 4
        la $a0, Comma
        syscall

        bge $t0, $t2, end_print
        j print_loop

    end_print:
        li $v0, 10
        syscall

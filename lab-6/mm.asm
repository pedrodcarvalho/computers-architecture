.data
    X: .float 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0
    Y: .float 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0
    Z: .space 64
    newLine: .asciiz "\n"
    space: .asciiz " "
    print_array_prompt: .asciiz "Matrix:"

.text
.globl main
    main:
        addi $sp, $sp, -16
        sw $ra, 0($sp)
        sw $s0, 4($sp)
        sw $s1, 8($sp)
        sw $s2, 12($sp)

        la $a0, X
        jal print_matrix

        jal print_new_line

        la $a0, Y
        jal print_matrix

        la $a0, X
        la $a1, Y
        la $a2, Z

        jal matrix_mult

        jal print_new_line
        jal print_new_line

        la $a0, Z
        jal print_matrix

        li $v0, 10
        syscall

        lw $s2, 12($sp)
        lw $s1, 8($sp)
        lw $s0, 4($sp)
        lw $ra, 0($sp)
        addi $sp, $sp, 16
        jr $ra

    matrix_mult:
        addi $sp, $sp, -32
        sw $ra, 0($sp)
        sw $s0, 4($sp)
        sw $s1, 8($sp)
        sw $s2, 12($sp)
        sw $s3, 16($sp)
        sw $s4, 20($sp)
        sw $s5, 24($sp)
        sw $s6, 28($sp)

        or $s0, $s0, $a0
        or $s1, $s1, $a1
        or $s2, $s2, $a2
        ori $s3, $s3, 0
        ori $s4, $s4, 0
        ori $s5, $s5, 0
        ori $s6, $s6, 4

    matrix_mult_loop1:
        li $s4, 0

    matrix_mult_loop2:
        li $s5, 0
        li.s $f6, 0.0

    matrix_mult_loop3:
        mult $s3, $s6
        mflo $t0
        add $t1, $t0, $s5
        sll $t1, $t1, 2
        add $t2, $t1, $s0
        l.s $f0, 0($t2)

        mult $s5, $s6
        mflo $t0
        add $t1, $t0, $s4
        sll $t1, $t1, 2
        add $t2, $t1, $s1
        l.s $f2, 0($t2)

        mul.s $f4, $f0, $f2
        add.s $f6, $f6, $f4

        addi $s5, $s5, 1
        bne $s5, $s6, matrix_mult_loop3

        mult $s3, $s6
        mflo $t0
        add $t1, $t0, $s4
        sll $t1, $t1, 2
        add $t2, $t1, $s2
        s.s $f6, 0($t2)

        addi $s4, $s4, 1
        bne $s4, $s6, matrix_mult_loop2

        addi $s3, $s3, 1
        bne $s3, $s6, matrix_mult_loop1

        lw $s6, 28($sp)
        lw $s5, 24($sp)
        lw $s4, 20($sp)
        lw $s3, 16($sp)
        lw $s2, 12($sp)
        lw $s1, 8($sp)
        lw $s0, 4($sp)
        lw $ra, 0($sp)
        addi $sp, $sp, 32
        jr $ra

    print_matrix:
        addi $sp, $sp, -12
        sw $ra, 0($sp)
        sw $s0, 4($sp)
        sw $s1, 8($sp)
        sw $s2, 12($sp)

        or $s0, $a0, $zero

        la $a0, print_array_prompt
        li $v0, 4
        syscall

        jal print_new_line

        li $s1, 0
        li $s2, 15

    print_matrix_loop:
        sll $t0, $s1, 2
        add $t1, $t0, $s0
        l.s $f12, 0($t1)

        li $v0, 2
        syscall

        jal print_space

        li $t0, 4
        addi $s1, $s1, 1
        div $s1, $t0
        mfhi $t0
        bne $t0, $zero, skip_new_line
        jal print_new_line

    skip_new_line:
        bne $s1, $s2, print_matrix_loop

        lw $s2, 12($sp)
        lw $s1, 8($sp)
        lw $s0, 4($sp)
        lw $ra, 0($sp)
        addi $sp, $sp, 12
        jr $ra

    print_new_line:
        addi $sp, $sp, -4
        sw $ra, 0($sp)

        la $a0, newLine
        li $v0, 4
        syscall

        lw $ra, 0($sp)
        addi $sp, $sp, 4
        jr $ra

    print_space:
        addi $sp, $sp, -4
        sw $ra, 0($sp)

        la $a0, space
        li $v0, 4
        syscall

        lw $ra, 0($sp)
        addi $sp, $sp, 4
        jr $ra

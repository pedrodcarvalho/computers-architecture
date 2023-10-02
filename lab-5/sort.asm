.data
    vector: .word 246, 57, 48, 98, 34, 197, 12, 207, 182, 89, 143, 124, 118, 252, 243, 230
    prompt: .asciiz "Array ordenado: "

.text
.globl main
    main:
        la $s7, vector

        li $s0, 0
        li $s6, 15

        li $s1, 0

        li $t3, 0
        li $t4, 16

        li $v0, 4,
        la $a0, prompt
        syscall

    loop:
        sll $t7, $s1, 2
        add $t7, $s7, $t7

        lw $t0, 0($t7)
        lw $t1, 4($t7)

        slt $t2, $t0, $t1
        bne $t2, $zero, iterate

        sw $t1, 0($t7)
        sw $t0, 4($t7)

    iterate:
        addi $s1, $s1, 1
        sub $s5, $s6, $s0

        bne  $s1, $s5, loop
        addi $s0, $s0, 1
        li $s1, 0

        bne  $s0, $s6, loop

    print:
        beq $t3, $t4, end

        lw $t5, 0($s7)

        li $v0, 1
        move $a0, $t5
        syscall

        li $a0, 32
        li $v0, 11
        syscall

        addi $s7, $s7, 4
        addi $t3, $t3, 1

        j print

    end:
        li $v0, 10
        syscall

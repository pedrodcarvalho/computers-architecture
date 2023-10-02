.data
    prompt: .asciiz "Digite um número inteiro positivo: "

.text
.globl main
    fact:
        addi $sp, $sp, -8
        sw $ra, 4($sp)
        sw $a0, 0($sp)

        li $t0, 1
        beq $a0, $t0, fact_end

        addi $a0, $a0, -1
        jal fact
        lw $a0, 0($sp)

    fact_end:
        lw $a1, 0($sp)
        lw $ra, 4($sp)
        addi $sp, $sp, 8

        beq $a1, $t0, fact_return_one
        mul $v0, $a1, $v0
        jr $ra

    fact_return_one:
        li $v0, 1
        jr $ra

    main:
        li $v0, 4
        la $a0, prompt
        syscall

        li $v0, 5
        syscall

        move $a0, $v0
        jal fact

        move $a0, $v0
        li $v0, 1
        syscall

        li $v0, 10
        syscall

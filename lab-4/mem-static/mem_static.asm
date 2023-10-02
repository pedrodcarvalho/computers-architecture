.data
    prompt:     .asciiz "Digite o índice: "
    vetor:      .word 1, 1, 2, 3, 5, 8, 13, 21, 35, 56, 91
    tamanho:    .word 15

.text
    main:
        lw $t1, tamanho

    loop:
        li $v0, 4
        la $a0, prompt
        syscall

        li $v0, 5
        syscall
        move $t2, $v0

        bgez $t2, valid_index
        j end_program

    valid_index:
        bge $t2, $t1, end_program

        la $t3, vetor
        sll $t4, $t2, 2
        add $t3, $t3, $t4
        lw $t5, 0($t3)

        li $v0, 1
        move $a0, $t5
        syscall

        j loop

    end_program:
        li $v0, 10
        syscall

.text
    V:  .space 400

.globl main
    main:
        li $t0, 0
        la $t1, V

    loop:
        li $t2, 100
        bge $t0, $t2, end_loop

        sll $t3, $t0, 1
        add $t3, $t3, $t0

        sw $t3, 0($t1)

        addi $t0, $t0, 1
        addi $t1, $t1, 4

        j loop

    end_loop:
        li $v0, 10
        syscall

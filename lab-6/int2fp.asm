.data
    prompt: .asciiz "Digite um número inteiro sem sinal: "
    result: .asciiz "O número em ponto flutuante é: "

.text
.globl main
    main:
        li $v0, 4
        la $a0, prompt
        syscall

        li $v0, 5
        syscall
        move $t0, $v0

        sll $t1, $t0, 8
        srl $t0, $t0, 24

        or $t0, $t0, $t1

        mtc1 $t0, $f4
        li.s $f2, 65536.0
        cvt.s.w $f4, $f4
        div.s $f4, $f4, $f2

        li $v0, 4
        la $a0, result
        syscall

        li $v0, 2
        mov.s $f12, $f4
        syscall

        li $v0, 10
        syscall

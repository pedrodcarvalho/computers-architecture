.data
    hello_string: .asciiz "Hello World!\n"

.text
    main:
        li $v0, 4
        la $a0, hello_string
        syscall
        li $v0, 10
        syscall

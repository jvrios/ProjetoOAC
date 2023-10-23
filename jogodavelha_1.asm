.data
coluna: .asciiz "|"
linha: .asciiz "---+---+---\n"
newline: .asciiz "\n"
O: .asciiz " O "
X: .asciiz " X "
espaco: .asciiz "   "
return1: .word 0		#recebe 0(espaco) 1 (X) ou 2 (O)
return2: .word 0		#recebe 0(espaco) 1 (X) ou 2 (O)
return3: .word 0		#recebe 0(espaco) 1 (X) ou 2 (O)
return4: .word 0		#recebe 0(espaco) 1 (X) ou 2 (O)
return5: .word 0		#recebe 0(espaco) 1 (X) ou 2 (O)
return6: .word 0		#recebe 0(espaco) 1 (X) ou 2 (O)
return7: .word 0		#recebe 0(espaco) 1 (X) ou 2 (O)
return8: .word 0		#recebe 0(espaco) 1 (X) ou 2 (O)
return9: .word 0		#recebe 0(espaco) 1 (X) ou 2 (O)
turno: .word 0
invalido: .asciiz "Movimento inválido\n"
player_prompt: .asciiz "Entre com um numero (1-9): "
vitoria1_prompt: .asciiz "Vitoria jogador 1 :p"
vitoria2_prompt: .asciiz "Vitoria jogador 2 :p"
empate_prompt: .asciiz "Empate :("
.text
    
 main:
    li $t4, 1
    lw $t0, turno
    move $t0, $t4
pos1:
    lw $a0, turno

    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall
    lw $t0, return1
    li $t1, 1
    beq $t0, $t1, printOne1

    li $t2, 2
    beq $t0, $t2, printTwo1

    j printEspaco1

    printOne1:
        jal is_one
        j continuar1

    printTwo1:
        jal is_two
        j continuar1

    printEspaco1:
        la $a0, espaco
        li $v0, 4
        syscall

    continuar1:
pos2:
    la $a0, coluna
    li $v0, 4
    syscall
    lw $t0, return2

    li $t1, 1
    beq $t0, $t1, printOne2

    li $t2, 2
    beq $t0, $t2, printTwo2

    j printEspaco2

    printOne2:
        jal is_one
        j continuar2

    printTwo2:
        jal is_two
        j continuar2

    printEspaco2:
        la $a0, espaco
        li $v0, 4
        syscall

    continuar2:

pos3:
    la $a0, coluna
    li $v0, 4
    syscall
    lw $t0, return3
    li $t1, 1
    beq $t0, $t1, printOne3

    li $t2, 2
    beq $t0, $t2, printTwo3

    j printEspaco3

    printOne3:
        jal is_one
        j continuar3

    printTwo3:
        jal is_two
        j continuar3

    printEspaco3:
        la $a0, espaco
        li $v0, 4
        syscall

    continuar3:
pos4:
    la $a0, newline
    li $v0, 4
    syscall
    la $a0, linha
    syscall
    lw $t0, return4
    li $t1, 1
    beq $t0, $t1, printOne4

    li $t2, 2
    beq $t0, $t2, printTwo4

    j printEspaco4

    printOne4:
        jal is_one
        j continuar4

    printTwo4:
        jal is_two
        j continuar4

    printEspaco4:
        la $a0, espaco
        li $v0, 4
        syscall

    continuar4:
pos5:
    la $a0, coluna
    li $v0, 4
    syscall
    lw $t0, return5
    li $t1, 1
    beq $t0, $t1, printOne5

    li $t2, 2
    beq $t0, $t2, printTwo5

    j printEspaco5

    printOne5:
        jal is_one
        j continuar5

    printTwo5:
        jal is_two
        j continuar5

    printEspaco5:
        la $a0, espaco
        li $v0, 4
        syscall

    continuar5:
pos6:
    la $a0, coluna
    li $v0, 4
    syscall
    lw $t0, return6
    li $t1, 1
    beq $t0, $t1, printOne6

    li $t2, 2
    beq $t0, $t2, printTwo6

    j printEspaco6

    printOne6:
        jal is_one
        j continuar6

    printTwo6:
        jal is_two
        j continuar6

    printEspaco6:
        la $a0, espaco
        li $v0, 4
        syscall

    continuar6:
pos7:
    la $a0, newline
    li $v0, 4
    syscall
    la $a0, linha
    syscall
    lw $t0, return7
    li $t1, 1
    beq $t0, $t1, printOne7

    li $t2, 2
    beq $t0, $t2, printTwo7

    j printEspaco7

    printOne7:
        jal is_one
        j continuar7

    printTwo7:
        jal is_two
        j continuar7

    printEspaco7:
        la $a0, espaco
        li $v0, 4
        syscall

    continuar7:
pos8:
    la $a0, coluna
    li $v0, 4
    syscall
    lw $t0, return8
    li $t1, 1
    beq $t0, $t1, printOne8

    li $t2, 2
    beq $t0, $t2, printTwo8

    j printEspaco8

    printOne8:
        jal is_one
        j continuar8

    printTwo8:
        jal is_two
        j continuar8

    printEspaco8:
        la $a0, espaco
        li $v0, 4
        syscall

    continuar8:
pos9:
    la $a0, coluna
    li $v0, 4
    syscall
    lw $t0, return9

    li $t1, 1
    beq $t0, $t1, printOne9

    li $t2, 2
    beq $t0, $t2, printTwo9

    j printEspaco9

    printOne9:
        jal is_one
        j continuar9

    printTwo9:
        jal is_two
        j continuar9

    printEspaco9:
        la $a0, espaco
        li $v0, 4
        syscall

    continuar9:

jal verificarVitoria

game_loop:

    la $a0, newline
    li $v0, 4
    syscall
    # Prompt for player input
    li $v0, 4
    la $a0, player_prompt
    syscall

    # Read player input (expecting an integer between 1 and 9)
    li $v0, 5
    syscall
    move $t4, $v0  # $t4 now holds the player's input (1-9)
    li $t5, 1
    blt $t4, $t5, mov_invalido
    li $t5, 9
    bgt $t4, $t5, mov_invalido
    li $t5, 1        # Load the value 1 into $t5
    beq $t4, $t5, r1  # Branch to "is_equal" if $t4 == $t5
    li $t5, 2        # Load the value 1 into $t5
    beq $t4, $t5, r2  # Branch to "is_equal" if $t4 == $t5
    li $t5, 3        # Load the value 1 into $t5
    beq $t4, $t5, r3  # Branch to "is_equal" if $t4 == $t5
    li $t5, 4        # Load the value 1 into $t5
    beq $t4, $t5, r4  # Branch to "is_equal" if $t4 == $t5
    li $t5, 5        # Load the value 1 into $t5
    beq $t4, $t5, r5  # Branch to "is_equal" if $t4 == $t5
    li $t5, 6        # Load the value 1 into $t5
    beq $t4, $t5, r6  # Branch to "is_equal" if $t4 == $t5
    li $t5, 7        # Load the value 1 into $t5
    beq $t4, $t5, r7  # Branch to "is_equal" if $t4 == $t5
    li $t5, 8        # Load the value 1 into $t5
    beq $t4, $t5, r8  # Branch to "is_equal" if $t4 == $t5
    li $t5, 9        # Load the value 1 into $t5
    beq $t4, $t5, r9  # Branch to "is_equal" if $t4 == $t5

   

r1:
    lw $t7, return1
    bnez $t7, mov_invalido

    lw $t5, turno

    andi $t1, $t5, 1 #$t1 will be 2 if it's odd, 1 if it's even

    li $t0, 1
    add $t1, $t1, $t0
    sw $t1, return1 
    lw $t0, turno
    # Increment the value of "turn" by 1
    addi $t0, $t0, 1
    sw $t0, turno
    j pos1
r2:
    lw $t7, return2
    bnez $t7, mov_invalido
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even
    li $t0, 1
    add $t1, $t1, $t0 
    sw $t1, return2 
    lw $t0, turno
    # Increment the value of "turn" by 1
    addi $t0, $t0, 1
    sw $t0, turno
    j pos1
r3:
    lw $t7, return3
    bnez $t7, mov_invalido
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even
    li $t0, 1
    add $t1, $t1, $t0
    sw $t1, return3 
    lw $t0, turno
    # Increment the value of "turn" by 1
    addi $t0, $t0, 1
    sw $t0, turno
    j pos1
r4:
    lw $t7, return4
    bnez $t7, mov_invalido
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even
    li $t0, 1
    add $t1, $t1, $t0
    sw $t1, return4 
    lw $t0, turno
    # Increment the value of "turn" by 1
    addi $t0, $t0, 1
    sw $t0, turno
    j pos1
r5:
    lw $t7, return5
    bnez $t7, mov_invalido
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even
    li $t0, 1
    add $t1, $t1, $t0
    sw $t1, return5 
    lw $t0, turno
    # Increment the value of "turn" by 1
    addi $t0, $t0, 1
    sw $t0, turno
    j pos1   
r6:
    lw $t7, return6
    bnez $t7, mov_invalido
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even
    li $t0, 1
    add $t1, $t1, $t0
    sw $t1, return6 
    lw $t0, turno
    # Increment the value of "turn" by 1
    addi $t0, $t0, 1
    sw $t0, turno
    j pos1
r7:
    lw $t7, return7
    bnez $t7, mov_invalido
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even
    li $t0, 1
    add $t1, $t1, $t0
    sw $t1, return7 
    lw $t0, turno
    # Increment the value of "turn" by 1
    addi $t0, $t0, 1
    sw $t0, turno
    j pos1
r8:
    lw $t7, return8
    bnez $t7, mov_invalido
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even
    li $t0, 1
    add $t1, $t1, $t0
    sw $t1, return8 
    lw $t0, turno
    # Increment the value of "turn" by 1
    addi $t0, $t0, 1
    sw $t0, turno
    j pos1
r9:
    lw $t7, return9
    bnez $t7, mov_invalido
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even
    li $t0, 1
    add $t1, $t1, $t0
    sw $t1, return9 
    lw $t0, turno
    # Increment the value of "turn" by 1
    addi $t0, $t0, 1
    sw $t0, turno
    j pos1
is_one:
    la $a0, X
    li $v0, 4
    syscall
    jr $ra
is_two:
    la $a0, O
    li $v0, 4
    syscall
    jr $ra
mov_invalido:
    la $a0, invalido
    li $v0, 4
    syscall
    j game_loop

verificarVitoria:

    # Verificação jogador 1
    jal caso1O
    jal caso1X
    jal caso2O
    jal caso2X
    jal caso3O
    jal caso3X
    jal caso4O
    jal caso4X
    jal caso5O
    jal caso5X
    jal caso6O
    jal caso6X
    jal caso7O
    jal caso7X
    jal caso8O
    jal caso8X
    jal empate

    # erificar X
    caso1O:
        c1l1:
            lw $t7, return1
            beq $t7, 1, c2l1
            jr $ra
        c2l1:
            lw $t7, return2
            beq $t7, 1, c3l1
            jr $ra
        c3l1:
            lw $t7, return3
            beq $t7, 1, vitoria1
            jr $ra
    caso1X:
        c1l1_2:
            lw $t7, return1
            beq $t7, 2, c2l1_2
            jr $ra
        c2l1_2:
            lw $t7, return2
            beq $t7, 2, c3l1_2
            jr $ra
        c3l1_2:
            lw $t7, return3
            beq $t7, 2, vitoria2
            jr $ra
    caso2O:
        c1l1_3:
            lw $t7, return1
            beq $t7, 1, c1l2_3
            jr $ra
        c1l2_3:
            lw $t7, return4
            beq $t7, 1, c1l3_3
            jr $ra
        c1l3_3:
            lw $t7, return7
            beq $t7, 1, vitoria2
            jr $ra
    caso2X:
        c1l1_4:
            lw $t7, return1
            beq $t7, 2, c1l2_4
            jr $ra
        c1l2_4:
            lw $t7, return4
            beq $t7, 2, c1l3_4
            jr $ra
        c1l3_4:
            lw $t7, return7
            beq $t7, 2, vitoria2
            jr $ra
    caso3O:
        c1l1_5:
            lw $t7, return1
            beq $t7, 1, c2l2_5
            jr $ra
        c2l2_5:
            lw $t7, return5
            beq $t7, 1, c3l3_5
            jr $ra
        c3l3_5:
            lw $t7, return9
            beq $t7, 1, vitoria1
            jr $ra
    caso3X:
        c1l1_6:
            lw $t7, return1
            beq $t7, 2, c2l2_6
            jr $ra
        c2l2_6:
            lw $t7, return5
            beq $t7, 2, c3l3_6
            jr $ra
        c3l3_6:
            lw $t7, return9
            beq $t7, 2, vitoria2
            jr $ra
    caso4O:
        c2l1_7:
            lw $t7, return2
            beq $t7, 1, c2l2_7
            jr $ra
        c2l2_7:
            lw $t7, return5
            beq $t7, 1, c3l2_7
            jr $ra
        c3l2_7:
            lw $t7, return8
            beq $t7, 1, vitoria1
            jr $ra
    caso4X:
        c2l1_8:
            lw $t7, return2
            beq $t7, 2, c2l2_8
            jr $ra
        c2l2_8:
            lw $t7, return5
            beq $t7, 2, c3l2_8
            jr $ra
        c3l2_8:
            lw $t7, return8
            beq $t7, 2, vitoria2
            jr $ra
    caso5O:
        c3l1_9:
            lw $t7, return3
            beq $t7, 1, c3l2_9
            jr $ra
        c3l2_9:
            lw $t7, return6
            beq $t7, 1, c3l3_9
            jr $ra
        c3l3_9:
            lw $t7, return9
            beq $t7, 1, vitoria1
            jr $ra
    caso5X:
        c3l1_0:
            lw $t7, return3
            beq $t7, 2, c3l2_0
            jr $ra
        c3l2_0:
            lw $t7, return6
            beq $t7, 2, c3l3_0
            jr $ra
        c3l3_0:
            lw $t7, return9
            beq $t7, 2, vitoria2
            jr $ra
    caso6O:
        c3l1_11:
            lw $t7, return3
            beq $t7, 1,  c2l2_11
            jr $ra
        c2l2_11:
            lw $t7, return5
            beq $t7, 1, c1l3_11
            jr $ra
        c1l3_11:
            lw $t7, return7
            beq $t7, 1, vitoria1
            jr $ra
    caso6X:
        c3l1_22:
            lw $t7, return3
            beq $t7, 2, c2l2_22
            jr $ra
        c2l2_22:
            lw $t7, return5
            beq $t7, 2, c1l3_22
            jr $ra
        c1l3_22:
            lw $t7, return7
            beq $t7, 2, vitoria2
            jr $ra
    caso7O:
        c1l2_33:
            lw $t7, return4
            beq $t7, 1, c2l2_33
            jr $ra
        c2l2_33:
            lw $t7, return5
            beq $t7, 1, c3l2_33
            jr $ra
        c3l2_33:
            lw $t7, return6
            beq $t7, 1, vitoria1
            jr $ra
    caso7X:
        c1l2_44:
            lw $t7, return4
            beq $t7, 2, c2l2_44
            jr $ra
        c2l2_44:
            lw $t7, return5
            beq $t7, 2, c3l2_44
            jr $ra
        c3l2_44:
            lw $t7, return6
            beq $t7, 2, vitoria2
            jr $ra
    caso8O:
        c1l3_55:
            lw $t7, return7
            beq $t7, 1, c2l3_55
            jr $ra
        c2l3_55:
            lw $t7, return8
            beq $t7, 1, c3l3_55
            jr $ra
        c3l3_55:
            lw $t7, return9
            beq $t7, 1, vitoria1
            jr $ra
    caso8X:
        c1l3_66:
            lw $t7, return7
            beq $t7, 2, c2l3_66
            jr $ra
        c2l3_66:
            lw $t7, return8
            beq $t7, 2, c3l3_66
            jr $ra
        c3l3_66:
            lw $t7, return9
            beq $t7, 2, vitoria2
            jr $ra


    vitoria1:
    la $a0, vitoria1_prompt
    li $v0, 4
    syscall
    j exit
    vitoria2:
    la $a0, vitoria2_prompt
    li $v0, 4
    syscall
    j exit

empate:
    jal casoe
    j game_loop

    casoe:
        e1:
            lw $t7, return1
            beq $t7, 1, e2
            beq $t7, 2, e2
            jr $ra
        e2:
            lw $t7, return2
            beq $t7, 1, e3
            beq $t7, 2, e3
            jr $ra
        e3:
            lw $t7, return3
            beq $t7, 1, e4
            beq $t7, 2, e4
            jr $ra
        e4:
            lw $t7, return4
            beq $t7, 1, e5
            beq $t7, 2, e5
            jr $ra
        e5:
            lw $t7, return5
            beq $t7, 1, e6
            beq $t7, 2, e6
            jr $ra
        e6:
            lw $t7, return6
            beq $t7, 1, e7
            beq $t7, 2, e7
            jr $ra
        e7:
            lw $t7, return7
            beq $t7, 1, e8
            beq $t7, 2, e8
            jr $ra
        e8:
            lw $t7, return8
            beq $t7, 1, e9
            beq $t7, 2, e9
            jr $ra
        e9:
            lw $t7, return9
            beq $t7, 1, efinal
            beq $t7, 2, efinal
            jr $ra
    efinal:
        la $a0, empate_prompt
        li $v0, 4
        syscall
        j exit
exit:
  li    $v0, 10                       # Finalizar aplicacao
  syscall
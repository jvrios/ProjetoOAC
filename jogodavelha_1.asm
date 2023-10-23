.data
coluna: .asciiz "|"
linha: .asciiz "---+---+---\n"
newline: .asciiz "\n"
X: .asciiz " X "
O: .asciiz " O "
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
board: .space 9        # 3x3 board
turno: .word 0
player1: .asciiz "Player 1's turn\n"
player2: .asciiz "Player 2's turn\n"
invalido: .asciiz "Movimento inválido\n"
player_prompt: .asciiz "Enter a number (1-9): "
.text
main:
    j pos1
    
pos1:
    lw $t0, return1
    li $t1, 1
    beq $t0, $t1, is_one
    li $t2, 2
    beq $t0, $t2, is_two

    # If the input value is neither 1 nor 2, print " "
    la $a0, espaco
    li $v0, 4
    syscall
    j pos2
pos2:
    la $a0, coluna
    li $v0, 4
    syscall
    lw $t0, return2
    li $t1, 1
    beq $t0, $t1, is_one
    li $t2, 2
    beq $t0, $t2, is_two

    la $a0, espaco
    li $v0, 4
    syscall
    j pos3
pos3:
    la $a0, coluna
    li $v0, 4
    syscall
    lw $t0, return3
    li $t1, 1
    beq $t0, $t1, is_one
    li $t2, 2
    beq $t0, $t2, is_two

    la $a0, espaco
    li $v0, 4
    syscall
    j pos4
pos4:
    la $a0, newline
    li $v0, 4
    syscall
    la $a0, linha
    syscall
    lw $t0, return4
    li $t1, 1
    beq $t0, $t1, is_one
    li $t2, 2
    beq $t0, $t2, is_two

    la $a0, espaco
    li $v0, 4
    syscall
    j pos5
pos5:
    la $a0, coluna
    li $v0, 4
    syscall
    lw $t0, return5
    li $t1, 1
    beq $t0, $t1, is_one
    li $t2, 2
    beq $t0, $t2, is_two

    la $a0, espaco
    li $v0, 4
    syscall
    j pos6
pos6:
    la $a0, coluna
    li $v0, 4
    syscall
    lw $t0, return6
    li $t1, 1
    beq $t0, $t1, is_one
    li $t2, 2
    beq $t0, $t2, is_two

    la $a0, espaco
    li $v0, 4
    syscall
    j pos7
pos7:
    la $a0, newline
    li $v0, 4
    syscall
    la $a0, linha
    syscall
    lw $t0, return7
    li $t1, 1
    beq $t0, $t1, is_one
    li $t2, 2
    beq $t0, $t2, is_two

    la $a0, espaco
    li $v0, 4
    syscall
    j pos8
pos8:
    la $a0, coluna
    li $v0, 4
    syscall
    lw $t0, return8
    li $t1, 1
    beq $t0, $t1, is_one
    li $t2, 2
    beq $t0, $t2, is_two

    la $a0, espaco
    li $v0, 4
    syscall
    j pos9
pos9:
    la $a0, coluna
    li $v0, 4
    syscall
    lw $t0, return9

    li $t1, 1
    beq $t0, $t1, is_one
    li $t2, 2
    beq $t0, $t2, is_two

    la $a0, espaco
    li $v0, 4
    syscall
    j game_loop

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
    li $t5, 1        # Load the value 1 into $t5
    beq $t4, $t5, pos2  # Branch to "is_equal" if $t4 == $t5
    li $t5, 2        # Load the value 1 into $t5
    beq $t4, $t5, pos3  # Branch to "is_equal" if $t4 == $t5
    li $t5, 3        # Load the value 1 into $t5
    beq $t4, $t5, pos4  # Branch to "is_equal" if $t4 == $t5
    li $t5, 4        # Load the value 1 into $t5
    beq $t4, $t5, pos5  # Branch to "is_equal" if $t4 == $t5
    li $t5, 5        # Load the value 1 into $t5
    beq $t4, $t5, pos6  # Branch to "is_equal" if $t4 == $t5
    li $t5, 6        # Load the value 1 into $t5
    beq $t4, $t5, pos7  # Branch to "is_equal" if $t4 == $t5
    li $t5, 7        # Load the value 1 into $t5
    beq $t4, $t5, pos8  # Branch to "is_equal" if $t4 == $t5
    li $t5, 8        # Load the value 1 into $t5
    beq $t4, $t5, pos9  # Branch to "is_equal" if $t4 == $t5
    li $t5, 9        # Load the value 1 into $t5
    beq $t4, $t5, game_loop  # Branch to "is_equal" if $t4 == $t5
is_two:
    la $a0, O
    li $v0, 4
    syscall
    li $t5, 1        # Load the value 1 into $t5
    beq $t4, $t5, pos2  # Branch to "is_equal" if $t4 == $t5
    li $t5, 2        # Load the value 1 into $t5
    beq $t4, $t5, pos3  # Branch to "is_equal" if $t4 == $t5
    li $t5, 3        # Load the value 1 into $t5
    beq $t4, $t5, pos4  # Branch to "is_equal" if $t4 == $t5
    li $t5, 4        # Load the value 1 into $t5
    beq $t4, $t5, pos5  # Branch to "is_equal" if $t4 == $t5
    li $t5, 5        # Load the value 1 into $t5
    beq $t4, $t5, pos6  # Branch to "is_equal" if $t4 == $t5
    li $t5, 6        # Load the value 1 into $t5
    beq $t4, $t5, pos7  # Branch to "is_equal" if $t4 == $t5
    li $t5, 7        # Load the value 1 into $t5
    beq $t4, $t5, pos8  # Branch to "is_equal" if $t4 == $t5
    li $t5, 8        # Load the value 1 into $t5
    beq $t4, $t5, pos9  # Branch to "is_equal" if $t4 == $t5
    li $t5, 9        # Load the value 1 into $t5
    beq $t4, $t5, game_loop  # Branch to "is_equal" if $t4 == $t5
mov_invalido:
    la $a0, invalido
    li $v0, 4
    syscall
    j game_loop

.data
coluna: .asciiz "| "
linha: .asciiz "---+---+---\n"
newline: .asciiz "\n"
X: .asciiz " X "
O: .asciiz " O "
espaco: .asciiz " "
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
.text
main:
    # Initialize the board with empty spaces
    li $t0, 0
    la $t1, board
    li $t2, 9
    li $t3, 32      # ASCII code for space (' ')

init_board_loop:
    sb $t3, 0($t1)
    addi $t1, $t1, 1
    addi $t0, $t0, 1
    bne $t0, $t2, init_board_loop
    
pos1:
    lw $t0, return1
     # Check if the input value is 0
    li $t1, 1
    beq $t0, $t1, is_zero
    li $t2, 2
    beq $t0, $t2, is_one

    # If the input value is neither 0 nor 1, print " "
    la $a0, espaco
    li $v0, 4
    la $a0, coluna
    syscall
    j pos2
pos2:
    lw $t0, return2

        li $t1, 1
    beq $t0, $t1, is_zero
    li $t2, 2
    beq $t0, $t2, is_one

    la $a0, espaco
    li $v0, 4
    la $a0, coluna
    syscall
    j pos3
pos3:
    lw $t0, return3

    li $t1, 1
    beq $t0, $t1, is_zero
    li $t2, 2
    beq $t0, $t2, is_one

    la $a0, espaco
    li $v0, 4
    la $a0, newline
    syscall
    la $a0, linha
    syscall
    j pos4
pos4:
    lw $t0, return4

    li $t1, 1
    beq $t0, $t1, is_zero
    li $t2, 2
    beq $t0, $t2, is_one


    la $a0, espaco
    li $v0, 4
    la $a0, coluna
    syscall
    j pos5
pos5:
    lw $t0, return5

    li $t1, 1
    beq $t0, $t1, is_zero
    li $t2, 2
    beq $t0, $t2, is_one

    la $a0, espaco
    li $v0, 4
    la $a0, coluna
    syscall
    j pos6
pos6:
    lw $t0, return6

    li $t1, 1
    beq $t0, $t1, is_zero
    li $t2, 2
    beq $t0, $t2, is_one

    la $a0, espaco
    li $v0, 4
    la $a0, newline
    syscall
    la $a0, linha
    syscall
    j pos7
pos7:
    lw $t0, return7

    li $t1, 1
    beq $t0, $t1, is_zero
    li $t2, 2
    beq $t0, $t2, is_one

    la $a0, espaco
    li $v0, 4
    la $a0, coluna
    syscall
    j pos8
pos8:
    lw $t0, return8

    li $t1, 1
    beq $t0, $t1, is_zero
    li $t2, 2
    beq $t0, $t2, is_one

    la $a0, espaco
    li $v0, 4
    la $a0, coluna
    syscall
    j pos9
pos9:
    lw $t0, return9

    li $t1, 1
    beq $t0, $t1, is_zero
    li $t2, 2
    beq $t0, $t2, is_one

    la $a0, espaco
    li $v0, 4
    la $a0, newline
    syscall
    j game_loop

game_loop:
    # Player input
    li $v0, 5
    syscall
    move $t4, $v0  # $t4 now holds the player's input (1-9)
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

    # Update the board based on player input
    li $t0, 49       # ASCII code for '1'
    sub $t4, $t4, $t0  # Adjust the input to 0-8
    lw $t5, turno
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even

    lw $t0, turno
    # Increment the value of "turn" by 1
    addi $t0, $t0, 1
    sw $t0, turno
    j main

r1:
    lw $t7, return1
    bnez $t7, mov_invalido
    lw $t5, turno
    andi $t1, $t5, 1 #$t1 will be 2 if it's odd, 1 if it's even
    li $t0, 1
    add $t1, $t1, $t0
    sw $t1, return1 
    jr $ra
r2:
    lw $t7, return2
    bnez $t7, mov_invalido
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even
    li $t0, 1
    add $t1, $t1, $t0 
    sw $t1, return2 
    jr $ra
r3:
    lw $t7, return3
    bnez $t7, mov_invalido
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even
    li $t0, 1
    add $t1, $t1, $t0
    sw $t1, return3 
    jr $ra
r4:
    lw $t7, return4
    bnez $t7, mov_invalido
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even
    li $t0, 1
    add $t1, $t1, $t0
    sw $t1, return4 
    jr $ra
r5:
    lw $t7, return5
    bnez $t7, mov_invalido
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even
    li $t0, 1
    add $t1, $t1, $t0
    sw $t1, return5 
    jr $ra   
r6:
    lw $t7, return6
    bnez $t7, mov_invalido
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even
    li $t0, 1
    add $t1, $t1, $t0
    sw $t1, return6 
    jr $ra
r7:
    lw $t7, return7
    bnez $t7, mov_invalido
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even
    li $t0, 1
    add $t1, $t1, $t0
    sw $t1, return7 
    jr $ra
r8:
    lw $t7, return8
    bnez $t7, mov_invalido
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even
    li $t0, 1
    add $t1, $t1, $t0
    sw $t1, return8 
    jr $ra
r9:
    lw $t7, return9
    bnez $t7, mov_invalido
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even
    li $t0, 1
    add $t1, $t1, $t0
    sw $t1, return9 
    jr $ra
is_zero:
    la $a0, X
    li $v0, 4
    syscall
    jr $ra
is_one:
    la $a0, O
    li $v0, 4
    syscall
    jr $ra
mov_invalido:
    la $a0, invalido
    li $v0, 4
    syscall
    j game_loop

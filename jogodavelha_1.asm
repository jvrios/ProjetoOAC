.data
coluna: .asciiz "| "
linha: .asciiz "---+---+---\n"
newline: .asciiz "\n"
X: .asciiz " X "
O: .asciiz " O "
espaco: .asciiz " "
return: .word 0		#recebe 0(espaco) 1 (X) ou 2 (O)
board: .space 9        # 3x3 board
turno: .word 0
player1: .asciiz "Player 1's turn\n"
player2: .asciiz "Player 2's turn\n"
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
     #receber $t1
     # Check if the input value is 0
    li $t1, 0
    beq $t0, $t1, espaco
    # Check if the input value is 1
    li $t1, 1
    beq $t0, $t1, X

    # If the input value is neither 0 nor 1, print "O"
    la $a0, O
    li $v0, 4
    la $a0, coluna
    syscall
    j pos2
pos2:
     #receber $t1
     # Check if the input value is 0
    li $t1, 0
    beq $t0, $t1, espaco
    # Check if the input value is 1
    li $t1, 1
    beq $t0, $t1, X

    # If the input value is neither 0 nor 1, print "O"
    la $a0, O
    li $v0, 4
    la $a0, coluna
    syscall
    j pos3
pos3:
     #receber $t1
     # Check if the input value is 0
    li $t1, 0
    beq $t0, $t1, espaco
    # Check if the input value is 1
    li $t1, 1
    beq $t0, $t1, X

    # If the input value is neither 0 nor 1, print "O"
    la $a0, O
    li $v0, 4
    li $v0, 4
    la $a0, newline
    syscall
    la $a0, linha
    syscall
    
    j pos4
pos4:
     #receber $t1
     # Check if the input value is 0
    li $t1, 0
    beq $t0, $t1, espaco
    # Check if the input value is 1
    li $t1, 1
    beq $t0, $t1, X

    # If the input value is neither 0 nor 1, print "O"
    la $a0, O
    li $v0, 4
    la $a0, coluna
    syscall
    j pos5
pos5:
     #receber $t1
     # Check if the input value is 0
    li $t1, 0
    beq $t0, $t1, espaco
    # Check if the input value is 1
    li $t1, 1
    beq $t0, $t1, X

    # If the input value is neither 0 nor 1, print "O"
    la $a0, O
    li $v0, 4
    la $a0, coluna
    syscall
    j pos6
pos6:
     #receber $t1
     # Check if the input value is 0
    li $t1, 0
    beq $t0, $t1, espaco
    # Check if the input value is 1
    li $t1, 1
    beq $t0, $t1, X
    li $v0, 4
    la $a0, newline
    syscall
    # If the input value is neither 0 nor 1, print "O"
    la $a0, O
    li $v0, 4
    la $a0, linha
    syscall
    j pos7
pos7:
     #receber $t1
     # Check if the input value is 0
    li $t1, 0
    beq $t0, $t1, espaco
    # Check if the input value is 1
    li $t1, 1
    beq $t0, $t1, X

    # If the input value is neither 0 nor 1, print "O"
    la $a0, O
    li $v0, 4
    la $a0, coluna
    syscall
    j pos8
pos8:
     #receber $t1
     # Check if the input value is 0
    li $t1, 0
    beq $t0, $t1, espaco
    # Check if the input value is 1
    li $t1, 1
    beq $t0, $t1, X

    # If the input value is neither 0 nor 1, print "O"
    la $a0, O
    li $v0, 4
    la $a0, coluna
    syscall
    j pos9
pos9:
     #receber $t1
     # Check if the input value is 0
    li $t1, 0
    beq $t0, $t1, espaco
    # Check if the input value is 1
    li $t1, 1
    beq $t0, $t1, X

    # If the input value is neither 0 nor 1, print "O"
    la $a0, O
    li $v0, 4
    la $a0, newline
    syscall
    j game_loop

game_loop:
    # Player input
    li $v0, 5
    syscall
    move $t4, $v0  # $t4 now holds the player's input (1-9)

    # Update the board based on player input
    li $t0, 49       # ASCII code for '1'
    sub $t4, $t4, $t0  # Adjust the input to 0-8
    lw $t5, turno
    andi $t1, $t5, 1 #$t1 will be 1 if it's odd, 0 if it's even

    li $t0, 1
    beqz $t1, player1_move

    # else

    j player2_move

player1_move:
    
    lw $t0, turno
    # Increment the value of "turn" by 1
    addi $t0, $t0, 1
    sw $t0, turno
    j main

player2_move:
    
    lw $t0, turno
    # Increment the value of "turn" by 1
    addi $t0, $t0, 1
    sw $t0, turno
    j main
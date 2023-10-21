#posiçao que tem q ue digitar no jogo da velha
# 1|2|3
# 4|5|6
# 7|8|9

.text

#contador
ori $a3,$0,9
ori $a2,$0,0
main:

ori $t1,$0,1


li $v0,4
la $a0,menu
syscall

li $v0,5
syscall
move $t0,$v0
beq $t0,$t1, inicio1
beq $t0,$0, fim

inicio1:
jal print 
nop
inicio:
#jogador 1 digita a posicçao que deseja



lui $s0, 0x1001
ori $s4,$0,4

li $v0,4
la $a0,jog
syscall

li $v0,5
syscall

move $t0,$v0
#multiplica a posicao desejada por 4 pra colocar na memoria
mult $t0,$s4
mflo $t4

add $s0,$s0,$t4
addi $s0,$s0,-4

jal jog1
nop

addi $a2,$a2,1
beq $a2,$a3,empate
jal print
nop
sw $t0,0($s0)



#jogador 2
lui $s0, 0x1001
ori $s4,$0,4


li $v0,4
la $a0,jog2
syscall
addi $a2,$a2,1
beq $a2,$a3,empate

li $v0,5
syscall

move $t0,$v0
mult $t0,$s4
mflo $t4

add $s0,$s0,$t4
addi $s0,$s0,-4

jal joga2
nop
addi $s5,$s5,1
jal print
nop



j inicio
nop

#X jog1
jog1:
ori $t0,$0,88
sw $t0,0($s0)

move $t9,$ra
addi $sp,$sp,-4 
sw $t9,($sp) 

jal conferir
nop


lw $t9,($sp) # Copia o item para $t0
addi $sp,$sp,4 
move $ra,$t9


jr $ra
nop

#O jog
joga2:
ori $t0,$0,79
sw $t0,0($s0)


move $t9,$ra
addi $sp,$sp,-4 
sw $t9,($sp) 

jal conferir
nop


lw $t9,($sp) # Copia o item para $t0
addi $sp,$sp,4 
move $ra,$t9

jr $ra
nop


######## conferindo se o jogador ganhou
conferir:
move $s1,$t0

lui $s0,0x1001
lw $t0,0($s0)
lw $t1,4($s0)
lw $t2,8($s0)
lw $t3,12($s0)
lw $t4,16($s0)
lw $t5,20($s0)
lw $t6,24($s0)
lw $t7,28($s0)
lw $t8,32($s0)

######## vai conferindo se o jogador ganhou
beq $t0,$s1,lin1
j pula
nop
lin1:
beq $t1,$s1,lin2
nop
j pula
nop
lin2:
beq $t2,$s1,fim
pula:
###########

#####################################################################

beq $t4,$s1,lin4
j pula4
nop
lin4:
beq $t5,$s1,lin5
nop

j pula4
nop
lin5:
beq $t3,$s1,fim
pula4:
###########

#############################################################
beq $t6,$s1,lin6
j pula6
nop
lin6:
beq $t7,$s1,lin7
nop

j pula6
nop
lin7:
beq $t8,$s1,fim
pula6:
###########

#######################################################################################conferindo colunS
beq $t0,$s1,col1
j pula8
nop
col1:
beq $t3,$s1,col2
nop
j pula8
nop
col2:
beq $t6,$s1,fim
pula8:
########
beq $t1,$s1,col3
j pula9
nop
col3:
beq $t4,$s1,col4
nop
j pula9
nop
col4:
beq $t7,$s1,fim
pula9:
#######
beq $t2,$s1,col5
j pula10
nop
col5:
beq $t5,$s1,col6
nop
j pula10
nop
col6:
beq $t8,$s1,fim
pula10:
###########################conferindo diagonal
beq $t0,$s1,diag1
j pula11
nop
diag1:
beq $t4,$s1,diag2
nop
j pula11
nop
diag2:
beq $t8,$s1,fim
pula11:
#######
beq $t2,$s1,diag3
j pula12
nop
diag3:
beq $t4,$s1,diag4
nop
j pula12
nop
diag4:
beq $t6,$s1,fim
pula12:


jr $ra
nop

#funcao empate
empate:
li $v0,4
la $a0,empate1
syscall


jal print 
nop

li $v0,10 
syscall


#funcao fim
fim:
ori $s6,$0,79
ori $s7,$0,88
beq  $s1,$s7 gan1
beq  $s1,$s6 gan2
gan1:

li $v0,4
la $a0,gan
syscall
j f
gan2:
li $v0,4
la $a0,gann
syscall
f:

jal print
nop


li $v0,10 
syscall


######################################################################################

#printa o jogo da velha
print:

ori $s1,$0,88
ori $s2,$0,79
ori $s3,$0,45

lui $s0,0x1001
lw $t0,0($s0)
lw $t1,4($s0)
lw $t2,8($s0)
lw $t3,12($s0)
lw $t4,16($s0)
lw $t5,20($s0)
lw $t6,24($s0)
lw $t7,28($s0)
lw $t8,32($s0)

###############
beq $t0,$s1,op1
nop
beq $t0,$s2,op2
nop
beq $t0,$s3,op3
nop
op1:
li $v0,4
la $a0,X
syscall

j prox
nop
op2:
li $v0,4
la $a0,O
syscall
j prox
nop
op3:
li $v0,4
la $a0,traco
syscall

prox:
li $v0,4
la $a0,barra
syscall
#################
beq $t1,$s1,op4
nop
beq $t1,$s2,op5
nop
beq $t1,$s3,op6
nop
op4:
li $v0,4
la $a0,X
syscall

j prox1
nop
op5:
li $v0,4
la $a0,O
syscall
j prox1
nop
op6:
li $v0,4
la $a0,traco
syscall

prox1:
li $v0,4
la $a0,barra
syscall
###############
beq $t2,$s1,op7
nop
beq $t2,$s2,op8
nop
beq $t2,$s3,op9
nop
op7:
li $v0,4
la $a0,X
syscall

j prox2
nop
op8:
li $v0,4
la $a0,O
syscall
j prox2
nop
op9:
li $v0,4
la $a0,traco
syscall

prox2:
li $v0,4
la $a0,barran
syscall
###############
beq $t3,$s1,op10
nop
beq $t3,$s2,op11
nop
beq $t3,$s3,op12
nop
op10:
li $v0,4
la $a0,X
syscall

j prox3
nop
op11:
li $v0,4
la $a0,O
syscall
j prox3
nop
op12:
li $v0,4
la $a0,traco
syscall

prox3:
li $v0,4
la $a0,barra
syscall
##################

beq $t4,$s1,op13
nop
beq $t4,$s2,op14
nop
beq $t4,$s3,op15
nop
op13:
li $v0,4
la $a0,X
syscall

j prox4
nop
op14:
li $v0,4
la $a0,O
syscall
j prox4
nop
op15:
li $v0,4
la $a0,traco
syscall

prox4:
li $v0,4
la $a0,barra
syscall

##################

beq $t5,$s1,op16
nop
beq $t5,$s2,op17
nop
beq $t5,$s3,op18
nop
op16:
li $v0,4
la $a0,X
syscall

j prox5
nop
op17:
li $v0,4
la $a0,O
syscall
j prox5
nop
op18:
li $v0,4
la $a0,traco
syscall

prox5:
li $v0,4
la $a0,barran
syscall

#############


beq $t6,$s1,op19
nop
beq $t6,$s2,op20
nop
beq $t6,$s3,op21
nop
op19:
li $v0,4
la $a0,X
syscall

j prox6
nop
op20:
li $v0,4
la $a0,O
syscall
j prox6
nop
op21:
li $v0,4
la $a0,traco
syscall

prox6:
li $v0,4
la $a0,barra
syscall

#############


beq $t7,$s1,op22
nop
beq $t7,$s2,op23
nop
beq $t7,$s3,op24
nop
op22:
li $v0,4
la $a0,X
syscall

j prox7
nop
op23:
li $v0,4
la $a0,O
syscall
j prox7
nop
op24:
li $v0,4
la $a0,traco
syscall

prox7:
li $v0,4
la $a0,barra
syscall

#############

beq $t8,$s1,op25
nop
beq $t8,$s2,op26
nop
beq $t8,$s3,op27
nop
op25:
li $v0,4
la $a0,X
syscall

j prox8
nop
op26:
li $v0,4
la $a0,O
syscall
j prox8
nop
op27:
li $v0,4
la $a0,traco
syscall

prox8:
li $v0,4
la $a0,barran
syscall



jr $ra
nop

.data
velha: .word 45,45,45,45,45,45,45,45,45
buffel: .space 128
jog: .asciiz "jogador 1 digita a posicao:\n" 
jog2: .asciiz "jogador 2 digita a posicao:\n" 

gan: .asciiz "jogador 1 ganhou\n"
gann: .asciiz "jogador 2 ganhou\n"
barra: .asciiz "|"
barran: .asciiz "\n"
X: .asciiz "X"
O: .asciiz "O"
traco: .asciiz "-"
empate1: .asciiz "empate \n"


menu: .asciiz "1-iniciar jogo \n0-fim \n" 
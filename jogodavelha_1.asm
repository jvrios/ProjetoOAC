.data
    turno:                 .word 0
    array:                 .word -15, -15, -15, -15, -15, -15, -15, -15, -15
    linha:                 .asciiz  "   |   |   \n"  # index 1, 5, 9 sao modificados 
    separador:             .asciiz  "---+---+---\n"
    player1:               .byte  'x'
    player2:               .byte  'o'
    vazio:                 .byte  ' '
    insira_linha:          .asciiz  "\n\nInsira a linha:"
    insira_coluna:         .asciiz  "Insira a coluna:"
    print_jogodor1_ganhou: .asciiz  "\nX (xis) ganhou!\n"
    print_jogodor2_ganhou: .asciiz  "\nO (bolinha) ganhou!\n"
    print_empate:          .asciiz  "Empatou!\n"
    print_jogada_invalida: .asciiz  "\nJogada invalida! Jogue novamente...\n"
    modo_jogo:             .word 0    # Variável para controlar o modo de jogo (0 ou 1)
    prompt: 		   .asciiz "Digite 0 para jogar sozinho ou 1 para jogar com dupla: "
    result: 		   .space 4
    invalido: 		   .asciiz "Opção inválida. Tente novamente." # Defina a string para tratamento de entrada inválida
    seed:   .space 4         # Espaço para armazenar a semente
.text
    main:
    inicio:
    li $v0, 4
    la $a0, prompt
    syscall

    # Leia a entrada do usuário
    li $v0, 5
    syscall
    move $t0, $v0 # Coloque o valor de entrada em $t0

    # Define o modo de jogo com base na entrada
    beq $t0, 0, set_singleplayer
    beq $t0, 1, set_multiplayer
    j acaoInvalida

    set_singleplayer:
    sw $zero, modo_jogo # Define o modo de jogo como 0 (singleplayer)
    j inicio_singleplayer

    set_multiplayer:
    sw $at, modo_jogo # Define o modo de jogo como 1 (multiplayer)
    j inicio_multiplayer
    
    inicio_multiplayer:
    j exit
    
    inicio_singleplayer:
    jal print_jogo
    jal loop_singleplayer

    loop_singleplayer:
    lw $t0, turno     # Carrega o valor do turno
    lw $t3, turno     # Carrega o valor do turno em outro registrador
    addi $t3, $t3, 1  # Adiciona 1 ao número de turno (incremento)
    sw $t3, turno     # Atualiza o turno
    andi $t0, $t0, 1  # Verifica se o turno é par ou ímpar (turno % 2)
    beqz $t0, turno_humano # Se o turno for par (0), vá para o turno do jogador humano
    j turno_computador  # Se o turno for ímpar (1), vá para o turno da máquina


    turno_humano:
    jal print_jogo
    jal jogada_humano        # Função que permite ao jogador humano fazer uma jogada
    lw $t0, turno     # Carrega o valor do turno
    addi $t0, $t0, 1  # Adiciona 1 ao número de turno
    sw $t0, turno     # Atualiza o turno
    j verifica_singleplayer

    turno_computador:
    jal print_jogo
    jal jogada_computador # Função que realiza a jogada da máquina
    lw $t0, turno     # Carrega o valor do turno
    addi $t0, $t0, 1  # Adiciona 1 ao número de turno
    sw $t0, turno     # Atualiza o turno
    j verifica_singleplayer
    
    jogada_humano:
        la $a0, insira_linha
        li $v0, 4
        syscall
        li $v0, 5
        syscall       # Leitura
        move $s1, $v0 # linha
        la $a0, insira_coluna
        li $v0, 4
        syscall
        li $v0, 5
        syscall       # Leitura
        move $s2, $v0 # coluna

        li   $t3, 3        # t3 = 3 (tamanho_da_linha)
        mult $s1, $t3      # linha * 3 (offset_da_linha)
        mflo $s3           # s3 = offset_da_linha
        add  $s4, $s3, $s2 # s4 = offset_da_linha + coluna (posicao_vetor)
        la   $t0, array    # t0 = carrega endereco de array[0]
        li   $t5, 4        # t1 = 4 (tamanho da word no array)
        mult $s4, $t5      # 4 * posicao_vetor
        mflo $s1           # s1 = 4 * posicao_vetor
        add  $t1, $t0, $s1 # t1 = endereco array[0] + posicao calculada em s1 
        lw   $t3, turno    # t3 = turno
        li   $t2, 2        # t2 = 2
        div  $t3, $t2      # turno / 2
        mfhi $t2           # t2 = turno % 2
        li   $t6, 1        # t6 = 1
        add  $t3, $t3, $t6 # t3 += 1
        li   $t5, 0 # jogador1
        j verifica_jogada
    
    print_jogo:
        la $s2, array # i  = *array
        la $s0, linha # s0 = *linha
        li $s1, 1     # s1 = index
    desenho:
        lw   $t1, ($s2)         # t1 = array[i]
        bltz $t1, desenha_vazio # vazio     if t1 <  0
        bgtz $t1, desenha_o     # desenha_o if t1 >  0
        bgez $t1, desenha_x     # desenha_x if t1 >= 0
    desenha_o:
        lb  $t2, player2  # caracter = 'o'
        j next
    desenha_x:
        lb  $t2, player1  # caracter = 'x'
        j next
    desenha_vazio:
        lb  $t2, vazio    # caracter = ' '
        j next
    next:
        add $t1, $s0, $s1          # t1 = *linha[index]
        sb  $t2, ($t1)             # linha[index] = caracter
        addi $s2, $s2, 4           # i++
        addi $s1, $s1, 4           # index += 4
        li   $t1, 13               # t1 = 13 (index 13 nao existe em linha)
        beq  $t1, $s1, print_linha # reset linha if s1 == 13 
        j desenho
    print_linha:
        la   $a0, linha                    # a0 = *linha
        li   $v0, 4                        # print
        syscall                            # string
        li   $s1, 1                        # index = 1 
        li   $t2, 36                       # array.length
        la   $t3, array                    # t3  = *array
        add  $t2, $t2, $t3                 # endereco array + 36 (9 words)
        beq  $s2, $t2, exit_print_desenho  # exit_print_desenho if i == fim do array
        la   $a0, separador                # a0 = *separador
        li   $v0, 4                        # print
        syscall                            # string
        j desenho
    exit_print_desenho:
        jr $ra
    jogada_computador:
    # Gere valores aleatórios para linha e coluna
    li $v0, 42        # Código do serviço para gerar números aleatórios
    li $a1, 3         # Valor máximo para a geração (0, 1, 2)
    syscall
    move $s1, $v0     # Armazene o valor aleatório gerado em $s1 (linha)

    li $v0, 42        # Código do serviço para gerar números aleatórios
    li $a1, 3         # Valor máximo para a geração (0, 1, 2)
    syscall
    move $s2, $v0     # Armazene o valor aleatório gerado em $s2 (coluna)

    li   $t3, 3        # t3 = 3 (tamanho_da_linha)
    mult $s1, $t3      # linha * 3 (offset_da_linha)
    mflo $s3           # s3 = offset_da_linha
    add  $s4, $s3, $s2 # s4 = offset_da_linha + coluna (posicao_vetor)
    la   $t0, array    # t0 = carrega endereço de array[0]
    li   $t5, 4        # t5 = 4 (tamanho da word no array)
    mult $s4, $t5      # 4 * posicao_vetor
    mflo $s1           # s1 = 4 * posicao_vetor
    add  $t1, $t0, $s1 # t1 = endereço array[0] + posicao calculada em s1 
    lw   $t3, turno    # t3 = turno
    li   $t2, 2        # t2 = 2
    div  $t3, $t2      # turno / 2
    mfhi $t2           # t2 = turno % 2
    li   $t6, 1        # t6 = 1
    add  $t3, $t3, $t6 # t3 += 1
    li   $t5, 1
    j verifica_jogada_computador

   
    verifica_jogada_computador:
        lw   $t6, ($t1)       
        bgez $t6, jogada_invalida_computador # Branch on greater than or equal to zero(0 ou 1 já na posição)
        j store_jogada
    
    verifica_jogada:
        lw   $t6, ($t1)       
        bgez $t6, jogada_invalida # Branch on greater than or equal to zero(0 ou 1 já na posição)
        j store_jogada

    jogada_invalida_computador:
        j jogada_computador
    
    jogada_invalida:
        la  $a0, print_jogada_invalida
        li  $v0, 4
        syscall
        j jogada_humano

    store_jogada:
        sw   $t3, turno    # turno++
        sw   $t5, ($t1)
        jr   $ra
    
    verifica_singleplayer:
    la  $s5, array
    lw  $s0, 4($s5)      # 012      x1x
    lw  $s1, 16($s5)     # 345      x1x
    lw  $s2, 24($s5)     # 678      1x1 1+4+6+7 = 4 || 0
    lw  $s3, 32($s5)
    jal soma_empate
    lw  $s0, 4($s5)      # 012      x1x
    lw  $s1, 12($s5)     # 345      11x
    lw  $s2, 16($s5)     # 678      xx1 1+3+4+8 = 4 || 0
    lw  $s3, 32($s5)
    jal soma_empate
    lw  $s0, 4($s5)      # 012      x1x
    lw  $s1, 16($s5)     # 345      x11
    lw  $s2, 20($s5)     # 678      1xx 1+4+5+6 = 4 || 0
    lw  $s3, 24($s5)
    jal soma_empate
    lw  $s0, 0($s5)      # 012      1xx
    lw  $s1, 16($s5)     # 345      x11
    lw  $s2, 20($s5)     # 678      x1x 0+4+5+7 = 4 || 0
    lw  $s3, 28($s5)
    jal soma_empate
    lw  $s0, 8($s5)      # 012      xx1
    lw  $s1, 12($s5)     # 345      11x
    lw  $s2, 16($s5)     # 678      x1x 2+3+4+7 = 4 || 0
    lw  $s3, 28($s5)
    jal soma_empate
    lw  $s0, 0($s5)      # 012      1x1
    lw  $s1, 8($s5)      # 345      x1x
    lw  $s2, 16($s5)     # 678      x1x 0+2+4+7 = 4 || 0
    lw  $s3, 28($s5)
    jal soma_empate
    lw  $s0, 0($s5)      # 012      1xx
    lw  $s1, 16($s5)     # 345      x11
    lw  $s2, 20($s5)     # 678      1xx 0+4+5+6 = 4 || 0
    lw  $s3, 24($s5)
    jal soma_empate
    lw  $s0, 8($s5)      # 012      xx1
    lw  $s1, 12($s5)     # 345      11x
    lw  $s2, 16($s5)     # 678      xx1 2+3+4+8 = 4 || 0
    lw  $s3, 32($s5)
    jal soma_empate

    # Now check for a tie (all spaces filled)
    li  $t2, 9
    lw  $s0, 4($s5)      # Load the first element of the array
    lw  $s4, 0($s5)      # Load the second element of the array
    sub $t2, $t2, $s0    # Subtract the first element from 9
    sub $t2, $t2, $s4    # Subtract the second element from the result
    beqz $t2, empate     # If the result is zero, it's a tie
    j loop_singleplayer
    

    soma_ganha:
        add $t1, $s0, $s1
        add $t1, $t1, $s2
        li  $t2, 3
        beq $t1, $t2,   jogador2_ganhou
        beq $t1, $zero, jogador1_ganhou
        jr  $ra
    soma_empate:
        add $t1, $s0, $s1
        add $t1, $t1, $s2
        add $t1, $t1, $s3
        li  $t2, 4
        beq $t2, $t1, empate
        jr  $ra

    jogador1_ganhou:
        jal print_jogo
        la  $a0, print_jogodor1_ganhou
        li  $v0, 4
        syscall
        j   exit
    jogador2_ganhou:
        jal print_jogo
        la  $a0, print_jogodor2_ganhou
        li  $v0, 4
        syscall
        j   exit
    empate:
        la $a0, print_empate
        li $v0, 4
        syscall
        j exit

    acaoInvalida:
    # Trate a entrada inválida
    li $v0, 4
    la $a0, invalido
    syscall
    exit:
        li  $v0, 10
        syscall

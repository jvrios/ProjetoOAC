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

.text
    main:
    inicio:
        jal print_jogo
        jal jogada
        j   verifica

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

    jogada:
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
        beq  $t2, $zero, jogada_player_1 # se turno par jogador1 se impar jogador2 
        li   $t5, 1 # jogador2
        j verifica_jogada
    jogada_player_1:
        li   $t5, 0 # jogador1
    verifica_jogada:
        lw   $t6, ($t1)       
        bgez $t6, jogada_invalida # Branch on greater than or equal to zero(0 ou 1 já na posição)
        j store_jogada

    jogada_invalida:
        la  $a0, print_jogada_invalida
        li  $v0, 4
        syscall
        j jogada

    store_jogada:
        sw   $t3, turno    # turno++
        sw   $t5, ($t1)
        jr   $ra

     verifica:
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

        lw  $s0, 0($s5)      # 012      111 
        lw  $s1, 4($s5)      # 345      xxx 
        lw  $s2, 8($s5)      # 678      xxx (0 + 1 + 2) = 3 || 0
        jal soma_ganha
        lw  $s0, 12($s5)     # 012      xxx 
        lw  $s1, 16($s5)     # 345      111 
        lw  $s2, 20($s5)     # 678      xxx (3 + 4 + 5) = 3 || 0
        jal soma_ganha
        lw  $s0, 24($s5)     # 012      xxx 
        lw  $s1, 28($s5)     # 345      xxx 
        lw  $s2, 32($s5)     # 678      111 (6 + 7 + 8) = 3 || 0
        jal soma_ganha
        lw  $s0, 0($s5)       # 012     1xx
        lw  $s1, 12($s5)      # 345     1xx
        lw  $s2, 24($s5)      # 678     1xx (0 + 3 + 6) = 3 || 0
        jal soma_ganha
        lw  $s0, 4($s5)       # 012     x1x
        lw  $s1, 16($s5)      # 345     x1x
        lw  $s2, 28($s5)      # 678     x1x (1 + 4 + 7) = 3 || 0
        jal soma_ganha
        lw  $s0, 8($s5)       # 012     xx1 
        lw  $s1, 20($s5)      # 345     xx1 
        lw  $s2, 32($s5)      # 678     xx1 (2 + 5 + 8) = 3 || 0
        jal soma_ganha
        lw  $s0, 0($s5)       # 012     1xx
        lw  $s1, 16($s5)      # 345     x1x
        lw  $s2, 32($s5)      # 678     xx1 (0 + 4 + 8) = 3 || 0
        jal soma_ganha
        lw  $s0, 8($s5)       # 012     xx1
        lw  $s1, 16($s5)      # 345     x1x
        lw  $s2, 24($s5)      # 678     1xx (2 + 4 + 6) = 3 || 0
        jal soma_ganha

        j   inicio            # se não empatou nem ganhou continua o jogo

    soma_ganha:
        add $t1, $s0, $s1
        add $t1, $t1, $s2
        li  $t2, 3
        beq $t1, $t2,   jogodor2_ganhou
        beq $t1, $zero, jogodor1_ganhou
        jr  $ra
    soma_empate:
        add $t1, $s0, $s1
        add $t1, $t1, $s2
        add $t1, $t1, $s3
        li  $t2, 4
        beq $t2, $t1, empate
        jr  $ra

    jogodor1_ganhou:
        jal print_jogo
        la  $a0, print_jogodor1_ganhou
        li  $v0, 4
        syscall
        j   exit
    jogodor2_ganhou:
        jal print_jogo
        la  $a0, print_jogodor2_ganhou
        li  $v0, 4
        syscall
        j   exit
    empate:
        jal print_jogo
        la $a0, print_empate
        li $v0, 4
        syscall
        j exit

    exit:
        li  $v0, 10
        syscall

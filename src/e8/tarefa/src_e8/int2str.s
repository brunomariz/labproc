	.text
	.globl	int2str

teste:
    @ Inicializar parametros
    LDR r0, =826 @ dividendo 
    @ LDR r0, =832 @ dividendo 
    LDR r1, =pontstr @ string
    
    BL int2str
    B fim   

int2str:
    @ Transforma inteiro em string

    @ Salva contexto
    STMFD sp!, {fp, ip, lr}

    @ Inicializa contador
    MOV r7, #0

    @ While r0 != 0
    while_int2str:
    CMP      r0, #0
    BNE      while_int2str_not_zero
    @ Adiciona 0 ao fim da string
    RSB r6, r7, #2
    STRB r5, [r1, r6]
    LDMFD  sp!, {fp, ip, lr}
    MOV    pc, lr
    
    while_int2str_not_zero:
    @ Divide o parametro por 10 e pega proximo numero
    STMFD sp!, {r1, r7}
    MOV r1, #10
    BL divisao
    LDMFD sp!, {r1, r7}

    @ Guarda proximo digito como char
    ADD r5, r5, #0x30
    RSB r6, r7, #2
    STRB r5, [r1, r6]

    @ Atualiza dividendo com o quociente anterior
    MOV r0, r3

    @ Incrementa contador
    ADD r7, r7, #1

    BAL      while_int2str





divisao:
    STMFD sp!, {fp, ip, lr}
    MOV r3, #0x0 @ quociente
    @ Inicializar resto com dividendo
    MOV r5, r0 @ resto 
    @ Salva divisor original
    MOV r7, r1

    @ Mover bits do divisor para a esquerda
	BL mover_bits_divisor

    @ Comparar dividendo divisor
    if_compara_dividendo_divisor:
    CMP r5, r1
    BGE cabe
    nao_cabe:
    @ Concatena 0 ao fim do quociente
    MOV r3, r3, LSL #1
    B desloca_divisor
    cabe:
    @ Subtrai divisor do dividendo
    SUB r5, r5, r1
    @ Concatena 1 ao fim do quociente
    MOV r3, r3, LSL #1
    ADD r3, r3, #1
    desloca_divisor:
    MOV r1, r1, LSR #1
    until_compara_divisor_com_original:
    CMP r1, r7
    BGE if_compara_dividendo_divisor

    @ fim da funcao
    LDMFD sp!, {fp, ip, lr} 
    MOV pc, lr

mover_bits_divisor:
    @ Checa se primeiro bit do r1 eh 1 
	TST     r1, #0x40000000
    BEQ    a_mbd @ se for 0, faz o salto
	MOV	    pc, lr @ se for 1, volta para o programa
a_mbd:
    MOV r1, r1, LSL #1  @ desloca bits do r1 para a esquerda
    B mover_bits_divisor

@ Fim do programa
fim:
MOV	r0, #0x18
LDR	r0, =0x20026
SWI	0x0


.data
    pontstr: .ascii ""




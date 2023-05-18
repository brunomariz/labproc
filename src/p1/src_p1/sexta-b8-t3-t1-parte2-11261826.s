@ 1a1b
	.text
	.globl	main
main:
    @ Inicializar parametros
    LDR r0, =dados
    @ LDR r1, [r0, #0] @ dividendo 

    @ Inicializar parametros
    LDR r0, =3
    LDR r8, =dados
    MOV r9, #0 @ i
    MOV r10, #0 @ resultado
    LDR r11, =resposta

loop_1:
    LDR r1, [r8, r9, LSL #2] @ dividendo = dados[i]
    @ Checa se dividendo = 0
    CMP r1, #0
    BEQ fim
    B pronto
    @ Checa se divisao e inteira
    CMP r5, #0
    MOVEQ r10, #1
    MOVNE r10, #0
    @ Guarda resultado em resposta[i]
    STR r10, [r11, r9, LSL #2]
    @ i++
    ADD r9, r9, #1

pronto:
    LDR r2, =1234 @ divisor
    MOV r3, #0x0 @ quociente
    @ Inicializar resto com dividendo
    MOV r5, r1 @ resto 
    @ Salva divisor original
    MOV r7, r2

    @ Mover bits do divisor para a esquerda
	BL mover_bits_divisor

    @ Comparar dividendo divisor
    if_compara_dividendo_divisor:
    CMP r5, r2
    BGE cabe
    nao_cabe:
    @ Concatena 0 ao fim do quociente
    LSL r3, #1
    B desloca_divisor
    cabe:
    @ Subtrai divisor do dividendo
    SUB r5, r5, r2
    @ Concatena 1 ao fim do quociente
    LSL r3, #1
    ADD r3, #1
    desloca_divisor:
    LSR r2, #1
    until_compara_divisor_com_original:
    CMP r2, r7
    BGE if_compara_dividendo_divisor

    B loop_1

    @ Fim do programa
    fim:
    MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0


mover_bits_divisor:
    @ Checa se primeiro bit do r2 eh 1 
	TST     r2, #0x40000000
    BEQ    a_mbd @ se for 0, faz o salto
	MOV	    pc, lr @ se for 1, volta para o programa
a_mbd:
    LSL r2, #1  @ desloca bits do r2 para a esquerda
    B mover_bits_divisor


.data
dados: .word 0x1, 0x2, 3, 4, 5, 6, 7, 0x8, 0x9, 0

resposta: .space 88 @abre espaço de 88 bytes para armazenar a resposta


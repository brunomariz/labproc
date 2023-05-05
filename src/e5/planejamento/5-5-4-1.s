@ 5-5-4 1
.text
.global main
main:
    @ r1: input X
    @ r2: output Z
    @ r3: aux
    @ r4: counter
    @ r5: constante 1
    LDR r1, =0xb0b04f7d
    MOV r2, #0
    MOV r3, #0
    MOV r4, #0
    MOV r5, #1
pronto:
    MOV r3, r1
le_proximo_bit:
    @ Checa se 'acabou' (input = 0)
    CMP r3, #0
    BEQ fim
    @ Le bit 1
    LSLS r3, r3, #1
    @ Incrementa contador
    ADD r4, r4, #1
    @ Se bit era 0, volta para inicio
    BCC le_proximo_bit

primeiro_1:
    @ Le bit 2 (Primeiro 1)
    LSLS r3, r3, #1
    @ Incrementa contador
    ADD r4, r4, #1
    @ Se bit era 1, volta para mesmo estado
    BCS primeiro_1

primeiro_0:
    @ Le bit 3 (Primeiro 0)
    LSLS r3, r3, #1
    @ Incrementa contador
    ADD r4, r4, #1
    @ Se bit era 0, volta para inicio
    BCC le_proximo_bit

segundo_1:
    @ Le bit 4 (Segundo 1)
    LSLS r3, r3, #1
    @ Incrementa contador
    ADD r4, r4, #1
    @ Se bit era 0, volta para estado anterior
    BCC primeiro_0

sequencia_reconhecida:
    @ Sequencia reconhecida - Adiciona 1 na saida
    ADD r2, r2, r5, ROR r4
    @ Volta para inicio
    BNE le_proximo_bit


fim:
    MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

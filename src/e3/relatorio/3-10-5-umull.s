@ 3.10.5
	.text
	.globl	main
main:
    @ Define argumentos
    MOV r0, #2
    RSB r0, r0, #0 @ troca sinal de r0
    MOV r1, #4
    RSB r1, r1, #0 @ troca sinal de r1
    @ Inicializa contador de argumentos negativos
    MOV r3, #0

    BL multiplica_long

	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

multiplica_long:
    @ Contar argumentos negativos e troca sinal caso forem negativos
    CMP r0, #0
    ADDLT r3, r3, #1
    RSBLT r0, r0, #0 @ troca sinal de r0 se for negativo
    CMP r1, #0
    ADDLT r3, r3, #1
    RSBLT r1, r1, #0 @ troca sinal de r0 se for negativo
    UMULL r5, r6, r0, r1 @ multiplica os numeros
    CMP r3, #1 @ checa se apenas um operando era negativo
    @ Caso apenas um operando for negativo, trocar o sinal do resultado
    RSBEQS r5, r5, #0
    RSCEQ r6, r6, #0

	MOV	pc, lr

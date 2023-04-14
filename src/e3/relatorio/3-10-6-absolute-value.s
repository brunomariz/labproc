@ 3.10.6
	.text
	.globl	main
main:
    @ Execucao da funcao para valor positivo
	MOV	r0, #10
	BL	valor_absoluto

    @ Execucao da funcao para valor negativo
    MOV r0, #10
    RSB r0, r0, #0
    BL valor_absoluto

	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

valor_absoluto:
    @ Subtrai valor de 0 e atualiza flags, e salva resultado em r1
    SUBS r1, r0, #0
    @ Caso subtracao tenha sido negativa,
    @ troca o sinal do valor em r1
    RSBLT r1, r0, #0
	MOV	pc, lr

	@ 7-5-3
	@ 7seg = P[16:10]	set for output
	@ leds = P[7:4]		set for output
	@ dip  = P[3:0]		clear for input

	@ IOPMOD  = 0x3FF5000
	@ IOPDATA = 0x3FF5008

	.text
	.globl main

main:
	@ setando I/O
	BL	setup

	@ carregando dado
	LDR	r0, dado

	@ verificando limites
	CMP	r0, #0
	MOVLT	r0, #0			@ apagar 7seg se fora de limites
	CMP	r0, #15
	MOVGT	r0, #0			@ apagar 7seg se fora de limites

	@ limpando 7seg
	STMFD	sp!, {r0}		@ salvar estado
	BL	limparSaida		@ chamada de funcao
	LDMFD	sp!, {r0}		@ restituir estado

	@ printando em 7seg
	STMFD	sp!, {r0}		@ passagem de parametro por stack
	BL	printSevenSeg		@ chamada de funcao

fim:	SWI	0x0


setup:
	@ usa r0-r1
	@ recebe nada
	@ retorna nada

	LDR	r0, =0x3FF5000		@ IOPMOD
	LDR	r1, =0x1FCF0		@ set 7seg, set leds, clear dip
	STR	r1, [r0]		@ 7seg=out, leds=out, dip=in

	MOV	pc, lr

limparSaida:
	@ usa r0-r1
	@ recebe nada
	@ retorna nada

	LDR	r0, =0x3FF5008	@ IOPDATA
	LDR	r1, [r0]
	MOV	r1, r1, LSL #28
	MOV	r1, r1, LSR #28
	STR	r1, [r0]

	MOV	pc, lr

printSevenSeg:
	@ usa r0, r1, r2, r3, r4
	@ recebe valor a ser impresso
	@ retorna nada

	@ obter valor a ser impresso
	LDMFD	sp!, {r0}

	@ codificar o valor a ser impresso (ja esta alinhado com IOPDATA)
	LDR	r1, =sevenSegVals
	LDR	r2, [r1, r0, LSL #2]

	@ ler IOPDATA
	LDR	r3, =0x3FF5008
	LDR	r4, [r3]

	@ escrever campo sevenSeg com novo valor
	ADD	r4, r4, r2

	@ imprimir
	STR	r4, [r3]

	MOV	pc, lr
sevenSegVals:
	.word 0xFC00, 0x1800, 0x16C00, 0x13C00, 0x19800, 0x1B400, 0x1F400, 0x1C00
	.word 0x1FC00, 0x19C00, 0x1DC00, 0x1F000, 0x1E400, 0x17800, 0x1E400, 0x1C400

dado:		.word 0xa


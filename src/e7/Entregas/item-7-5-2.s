@ 7seg = P[16:10]	set for output
@ leds = P[7:4]		set for output
@ dip  = P[3:0]		clear for input

@ IOPMOD  = 0x3FF5000
@ IOPDATA = 0x3FF5008

	.text
	.globl main
main:
	BL	setup
	
	LDR	r0, dado
	
	@ checa limite hex
	CMP	r0, #0
	MOVLT	r0, #0		@ se menor, valor a ser escrito eh zero
	CMP	r0, #15
	MOVGT	r0, #0		@ se maior, valor a ser escrito eh zero
	
	STMFD	sp!, {r0}	@ salva estado da main
	BL	limparSaida
	LDMFD	sp!, {r0}	@ restaura estado da main

	STMFD	sp!, {r0}	@ passagem de parametro
	BL	printLED	
	
fim:	SWI	0x0
	
setup:
	@ usa r0-r1
	@ recebe nada
	@ retorna nada
	
	LDR	r0, =0x3FF5000	@ IOPMOD
	LDR	r1, =0xF0	@ set leds
	STR	r1, [r0]	@ leds = out

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
		
printLED:
	@ usa r0-r2
	@ recebe valor a ser printado
	@ retorna nada
	
	LDMFD	sp!, {r0}	@ r0 = valor a ser printado
	
	@ alinha com IOPDATA
	MOV	r0, r0, LSL #4

	LDR	r1, =0x3FF5008	@ IOPDATA
	LDR	r2, [r1]
	ADD	r2, r2, r0
	STR	r2, [r1]
	
	MOV	pc, lr

dado:
	.word 7

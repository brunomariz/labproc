@ Exercicio 7.5.3

@ 7seg = P[16:10]	set for output
@ leds = P[7:4]		set for output
@ dip  = P[3:0]		clear for input

@ IOPMOD  = 0x3FF5000
@ IOPDATA = 0x3FF5008

	.text
	.global main

main:
	LDR		r0, =0x3FF5000	@ IOPMOD
	LDR		r1, =0x1FC00	@ Define o display de 7 segmentos como output
	STR		r1, [r0]
	
	LDR		r0, =dados
	LDR		r2, [r0]
	
	LDR		r0, =0x3FF5008 	@ IOPDATA
	
	CMP		r2, #0
	BLT		fim
	CMP		r2, #15
	BGT		fim
	
	MOV		r2, r2, LSL #10
	STR		r2, [r0]
	MOV		r2, r2, LSR #10

fim:
	MOV	    r0, #0x18
	LDR	    r1, =0x20026
	SWI	    0x0
	
dados:		.word 10

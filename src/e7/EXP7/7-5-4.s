@ Exercicio 7.5.4

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
	
	LDR		r0, =0x3FF5008 	@ IOPDATA
	
	LDR		r1, =dados
	LDR		r3, =N
	LDR		r3, [r3]
	ADD		r3, r1, r3, LSL #2
	
	BL		loop

fim:
	MOV	    r0, #0x18
	LDR	    r1, =0x20026
	SWI	    0x0

loop:
	CMP		r1, r3
	MOVGE	pc, lr

	LDR		r2, [r1]
	ADD		r1, r1, #4

	CMP		r2, #0
	BLT		loop
	CMP		r2, #15
	BGT		loop
	
	MOV		r2, r2, LSL #10
	STR		r2, [r0]
	MOV		r2, r2, LSR #10
	
	B		loop

delay:
	STMFD 	sp!, {r0, lr}
	LDR		r0, =0xFFFFF
	BL		delay_loop
	LDMFD 	sp!, {r0, lr}
	MOV		pc, lr
	
delay_loop:
	CMP		r0, #0
	MOVEQ	pc, lr
	SUB		r0, r0, #1
	B		delay_loop

N:			.word 4
dados:		.word 1, 2, 3, 4

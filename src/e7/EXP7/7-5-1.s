@ Exercicio 7.5.1

@ 7seg = P[16:10]	set for output
@ leds = P[7:4]		set for output
@ dip  = P[3:0]		clear for input

@ IOPMOD  = 0x3FF5000
@ IOPDATA = 0x3FF5008

	.text
	.global main

main:
	LDR		r0, =0x3FF5000	    @ IOPMOD
	LDR		r1, =0xF0		    @ Define leds como output
	STR		r1, [r0]
	
	B		ascending
    B       descending
    BAL     fim

fim:
	MOV	    r0, #0x18
	LDR	    r1, =0x20026
	SWI	    0x0

ascending:
	LDR		r0, =0x3FF5008 	    @ IOPDATA
	MOV		r1, #0
	 
ascending_loop:
	MOV		r1, r1, LSL #4
	STR		r1, [r0]
	MOV		r1, r1, LSR #4
	BL		delay
	ADD		r1, r1, #1
	CMP		r1, #16
	MOVGE	r1, #0
	B		ascending_loop
	
descending:
	LDR		r0, =0x3FF5008 	    @ IOPDATA
	MOV		r1, #15

descending_loop:
	MOV		r1, r1, LSL #4
	STR		r1, [r0]
	MOV		r1, r1, LSR #4
	BL		delay
	SUB		r1, r1, #1
	CMP		r1, #-1
	MOVLE	r1, #15
	B		descending_loop

delay:
	STMFD 	sp!, {r0, lr}
	LDR		r0, =0xFFFFF
	BL		delay_loop
	LDMFD 	sp!, {r0, lr}
	MOV		pc, lr
	
delay_loop:
	CMP		r0, #0
	MOVEQ	pc, lr              @ Retorna da subrotina caso o r0 tenha chegado em 0
	SUB		r0, r0, #1          @ Decrementa o r0 até o valor de 0 para aplicar o delay
	B		delay_loop

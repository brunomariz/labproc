@ 7seg = P[16:10]	set for output
@ leds = P[7:4]		set for output
@ dip  = P[3:0]		clear for input

@ IOPMOD  = 0x3FF5000
@ IOPDATA = 0x3FF500

	.text
	.global main

main:
	LDR	r0, =0x3FF5000	@ IOPMOD
	LDR	r1, =0xF0		@ Seta leds como output
	STR	r1, [r0]

	B	descending

fim:
	SWI	0x0

descending:
	LDR	r0, =0x3FF5008 	@ IOPDATA
	MOV	r1, #15

descending_loop:
	MOV		r1, r1, LSL #4
	STR	r1, [r0]
	MOV	r1, r1, LSR #4
	BL	delay
	SUB	r1, r1, #1
	CMP	r1, #-1
	MOVLE	r1, #15
	B	descending_loop

delay:
	STMFD 	sp!, {r0, lr}
	LDR	r0, =0xFFFFF
	BL	delay_loop
	LDMFD 	sp!, {r0, lr}
	MOV	pc, lr

delay_loop:
	CMP	r0, #0
	MOVEQ	pc, lr
	SUB	r0, r0, #1
	B	delay_loop

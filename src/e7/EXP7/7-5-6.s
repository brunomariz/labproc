@ Exercicio 7.5.6

@ 7seg = P[16:10]	set for output
@ leds = P[7:4]		set for output
@ dip  = P[3:0]		clear for input

@ IOPMOD  = 0x3FF5000
@ IOPDATA = 0x3FF5008

	.text
	.global main
	
main:
	LDR		r0, =0x3FF5000	@ IOPMOD
	LDR		r1, =0xF0		@ Seta leds como output, dip como input
	STR		r1, [r0]
	
	LDR		r0, =0x3FF5008 	@ IOPDATA
	
	B		loop

fim:
	MOV	    r0, #0x18
	LDR	    r1, =0x20026
	SWI	    0x0

loop:
	LDR		r1, [r0]
	
	MOV		r1, r1, LSL #28
	MOV		r1, r1, LSR #28
	MOV		r1, r1, LSL #4
	
	STR		r1, [r0]
	
	B		loop

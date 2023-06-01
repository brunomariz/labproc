@ 7seg = P[16:10]	set for output
@ leds = P[7:4]		set for output
@ dip  = P[3:0]		clear for input

@ IOPMOD  = 0x3FF5000
@ IOPDATA = 0x3FF5008

	.text
	.global main
	
main:
	LDR		r0, =0x3FF5000	@ IOPMOD
	LDR		r1, =0x1FC00	@ Seta leds como output, dip como input
	STR		r1, [r0]
	
	LDR		r0, =0x3FF5008 	@ IOPDATA
	
	LDR		r1, [r0]
	MOV		r1, r1, LSL #26
	MOV		r1, r1, LSR #26
	MOV		r1, r1, LSL #10
	
	STR		r1, [r0]

fim:
	SWI		0x0
	

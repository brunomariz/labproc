	.text
	.globl	main 
main:
	MOV	r6, #0
	ADDS 	r6, r6, r6

	MOV 	r1, #0x03
	MOV 	r2, #0xF0000000
	MOV	r1, r1, LSL #1
	MOVS	r2, r2, LSL #1
	
	ADC	r6, r6, r6
	ADD 	r1, r1, r6
	
	BL 	fim
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0
fim:
	MOV	pc, lr


	.text
	.globl	main 
main:
	MOV 	r1, #0x03
	MOV 	r2, #0x05
	MOV	r1, r1, LSR #1
	MOV	r2, r2, RRX
	
	BL 	fim
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0
fim:
	MOV	pc, lr


	.text
	.globl	main 
main:
	MOV 	r4, #0x1
	MOV 	r4, r4, LSL #14
	BL 	fim
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0
fim:
	MOV	pc, lr


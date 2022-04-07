	.text
	.globl	main 
main:
	MOV 	r2, #0x01
	MOV 	r3, #0x20

	MOV 	r4, #0x01
	MOV 	r5, #0x50

	SUBS 	r1, r2, r4
	SUBEQS	r1, r3, r5
	
	BL 	fim
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0
fim:
	MOV	pc, lr


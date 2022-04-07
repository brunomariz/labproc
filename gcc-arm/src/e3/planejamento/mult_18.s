	.text
	.globl	main 
main:
	MOV 	r4, #0x1
	RSB 	r3, r4, r4, LSL #2	
	ADD 	r4, r3, r3, LSL #2	
	ADD 	r4, r4, r3
	BL 	fim
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0
fim:
	MOV	pc, lr


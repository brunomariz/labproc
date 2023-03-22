	.text
	.globl	main 
main:
	MOV 	r4, #0x4
	MOV 	r3, r4, LSL #3 		
	RSB 	r2, r4, r4, ROR #30
	ADD 	r4, r3, r2	
	BL 	fim
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0
fim:
	MOV	pc, lr


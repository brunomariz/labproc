	.text
	.globl	main 
main:
	MOV 	r4, #0x4
	MOV 	r3, r4, LSL #7 		
before:	
	ADD 	r4, r3, r4, LSL #2	
after:
	BL 	fim
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0
fim:
	MOV	pc, lr


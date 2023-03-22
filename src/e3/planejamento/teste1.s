	.text
	.globl	main 
main:
	ADD r0,r1, #0xc5, ROR 10
	SUB r11, r12, r3, LSL #31
	BL 	fim
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0
fim:
	MOV	pc, lr


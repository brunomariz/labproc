@ ex 3.10.4
	.text
	.globl	main
main:
	LDR	r1, =0xF631024C
	LDR	r2, =0x17539ABD
	BL	firstfunc
	MOV	r0, #0x18
	SWI	0x0
firstfunc:
    EOR r1, r1, r2
    EOR r2, r1, r2
    EOR r1, r1, r2
	MOV	pc, lr

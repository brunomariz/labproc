	.text
	.globl	main 
main:
	LDR	r1, =6
	MOV 	r0, #0x24
	BL	firstfunc	

	BL 	fim
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

firstfunc:
	STR	r1, [r0]
	LDRSB r1,[r6],r3,ASR #4
	MOV	pc, lr
	
fim:
	MOV	pc, lr


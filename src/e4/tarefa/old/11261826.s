	.text
	.globl	main 


main:
	array:	.space 400
	LDR	r0, =26			@ 2 digitos finais do NUSP

pronto:
	LDR	r1, =0			@ f(n)
	LDR	r5, =0			@ iterator
	LDR	r6, =0			@ aux
	BL	firstfunc	

	BL 	fim
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

fibonacci:
	

	MOV	pc, lr
	
fim:
	MOV	pc, lr


@ r1 = a
@ r2 = b
@ r3 = c
@ r4 = d
@ r5 = arguments address

	.text
	.global main

main:
	LDR		r5, =dados
	LDMIA	r5, {r2-r4}

	BL		func1

fim:
	SWI		0x0

func1:
	MUL		r1, r2, r3
	ADD		r1, r1, r4

	MOV		pc, lr

dados:		.word 1, 4, 5
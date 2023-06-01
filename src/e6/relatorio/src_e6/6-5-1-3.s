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

	STMFD 	sp!, {r2-r4} @ Push onto a full descending stack

	BL		func1

fim:
	SWI		0x0

func1:
	LDMFD 	sp!, {r2-r4} @ Pop from a full descending stack

	STMFD 	sp!, {lr} @ Push onto a full descending stack
	BL		func2
	LDMFD 	sp!, {lr} @ Pop from a full descending stack

	MOV		pc, lr

func2:
	MUL		r1, r2, r3
	ADD		r1, r1, r4

	MOV		pc, lr

dados:		.word 1, 4, 5
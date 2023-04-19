
	.text
	.globl	main

array_a:  .word 0x10,0x20,0x30,0x40,0x50,0x60,0x70,0x80 
array_b: .word 0,0,0,0,0,0,0,0 

main:
    MOV r4, #0 @ dados temporarios
    ADR r0, array_a @ carrega endereco do array a
    ADR r1, array_b  @ carrega endereco do array b
	BL	transfer @ transfere valores de b para a segundo enunciado

	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

transfer:
	MOV	pc, lr



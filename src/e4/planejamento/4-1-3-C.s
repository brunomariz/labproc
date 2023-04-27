	.data
array_a: .word 0,0,0,0,0,0,0,0 
array_b:  .word 0x10,0x20,0x30,0x40,0x50,0x60,0x70,0x80 

	.text
	.globl	main


main:
    MOV r4, #0 @ dados temporarios
	MOV r5, #0 @ i
	MOV r6, #0 @ 7-i
    LDR r0, =array_b @ carrega endereco do array b
    LDR r1, =array_a  @ carrega endereco do array a
	BL	transfer @ transfere valores de b para a segundo enunciado

	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

transfer:
	RSB r6, r5, #7 @ r6 = 7 - i
	LDR r4, [r0, r5, LSL #2] @ r4 = b[i]
	STR r4, [r1, r6, LSL #2] @ a[7 - i] = r4
	ADD r5, r5, #1
	CMP r5, #8
	BLT transfer
	MOV	pc, lr

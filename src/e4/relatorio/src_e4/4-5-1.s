@ 4.5.1
.text
.global main
main:
    @ r0: x
    @ r1: y
    @ r2: array
    @ r3: indice
    @ r4: tmp
    @ x = array[5] + y
    MOV r3, #5
pre_indexado:
    MOV r0, #0
    ADR r2, array
    MOV r1, #0xc
    @ Carregando com o modo pos-indexado
    ADD r4, r2, r3, LSL #2
    LDR r0, [r4]
    ADD r0, r0, r1
pos_indexado:
    MOV r0, #0
    ADR r2, array
    MOV r1, #0xc
    @ Carregando com o modo pre-indexado
    LDR r0, [r2, r3, LSL #2]
    ADD r0, r0, r1

fim:
    MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

array:
    .word 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa

@ 4.5.4
.text
.global main
main:
    @ r1: a
    @ r2: s
    @ r3: i/p
    @ r4: zero
    @ r5: &array[s]

    LDR r1, =a
    MOV r2, #0x10
    MOV r4, #0

    BL init_indices
    BL init_pointers
    B fim

init_indices:
    @ i = 0
    MOV r3, #0
check_i_lt_s:
    CMP r3, r2
    @ retorna da funcao
    MOVGE pc, lr 
    STRB r4, [r1, r3]
    @ i++
    ADD r3, r3, #1
    B check_i_lt_s

init_pointers:
    @ p = &array[0]
    LDR r3, =array
    @ r5 = &array[s]
    ADD r5, r3, r2
check_p_lt_array_s:
    CMP r3, r5
    MOVGE pc, lr
    STRB r4, [r3], #1
    B check_p_lt_array_s

fim:
    MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

.data
a:  .byte 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa

array: .byte 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14

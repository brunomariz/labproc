@ 4.5.3
.text
.global main
main:
    @ r1: a
    @ r2: b
    @ r3: i
    @ r4: c
    @ r5: tmp

    LDR r1, =a
    LDR r2, =b
    MOV r3, #0
    MOV r4, #0x4000

pronto:
check_i_le_10:
    CMP r3, #10
    BGT fim
    @ r5 = b[i]
    LDR r5, [r2, r3, LSL #2]
    @ r5 = b[i] + c
    ADD r5, r5, r4
    @ a[i] = r5
    STR r5, [r1, r3, LSL #2]
    @ i++
    ADD r3, r3, #1
    B check_i_le_10

fim:
    MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

.data
a:  .space 44
b:
    .word 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa

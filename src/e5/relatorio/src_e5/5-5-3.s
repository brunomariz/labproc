@ 5-5-3 Max value
.text
.global main
main:
    @ r1: array
    @ r2: i
    @ r3: array[i]
    @ r4: current max
    @ r5: len(array)
    LDR     r1, =array 
    MOV     r2, #0
    MOV     r5, #14
    MOV     r4, #0
pronto:
    LDR     r3, [r1, r2, LSL #2] @ r3 = array[i]
    CMP     r3, r4
    MOVHI   r4, r3 @ se r3 > r4, r4 = r3
    ADD     r2, r2, #1 @ i++
    CMP     r2, r5
    BLT     pronto @ se i < len(array), volta

fim:
    MOV 	r0, #0x18
	LDR 	r1, =0x20026
	SWI 	0x0

.data
array: .word 0xa, 0xf, 0x1, 0x2, 0x3, 0x9, 0x8, 0x7, 0x5, 0x6, 0xb, 0xe, 0xc, 0xd

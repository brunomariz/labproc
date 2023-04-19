	.text
	.globl	main 
main:
	@ setup variables
	LDR	r0, =0 		@ b 
	LDR	r1, =20		@ a
	LDR	r5, =0		@ i
	LDR	r4, =0		@ aux
	LDR	r6, =1		@ data
	LDR	r9, =0		@ debugging
	LDR	r8, =8		@ loop limit
	MOV	r8, r8, LSL #3	

	BL	populate

	LDR	r5, =0 			@ reset counter
	BL	transfer

	BL 	fim
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

populate:
	STR 	r6, [r0, r5]		
	LDR	r9, [r0, r5]		@ debug
	ADD	r5, r5, #8		@ increment counter
	ADD	r6, r6, #1
	CMP	r5, r8
	BLT	populate

	MOV	pc, lr

transfer:
	RSB 	r4, r5, #56		@ calculate 7 - i
	LDR	r6, [r0, r4] 		@ load b[7-i] value
	
	STR	r6, [r1, r5]		@ store value to a[i]
	ADD 	r9, r1, r5	
	
	ADD 	r5, r5, #8
	CMP	r5, r8
	BLT	transfer

	MOV	pc, lr
fim:
	MOV	pc, lr


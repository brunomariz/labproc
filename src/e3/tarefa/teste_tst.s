	.text
	.globl	main
main:
	MOV	    r0, #0x40000000
	TST     r0, #0x80000000
    BLNE    firstfunc

    LSL     r0, #1
	TST     r0, #0x80000000
    BLNE    firstfunc

	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

firstfunc:
	ADD	r0, r0, r1
	MOV	pc, lr

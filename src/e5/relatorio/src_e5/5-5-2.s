@ 5-5-2 Factorial
.text
.global main
main:

    @ r6: n
    @ r4: n copy

factorial: 
    MOV r6,#0xA @ load 10 into r6
    MOV r4,r6 @ copy n into a temp register
loop:
    SUBS r4, r4, #1 @ decrement next multiplier
    MULNE r3, r6, r4 @ perform multiply
    MOVNE r6, r3 @ save off product for another loop
    BNE loop @ go again if not complete
fim:
    MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

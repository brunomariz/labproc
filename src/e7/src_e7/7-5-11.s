@ 7seg = P[16:10]	set for output
@ leds = P[7:4]		set for output
@ dip  = P[3:0]		clear for input

@ IOPMOD  = 0x3FF5000
@ IOPDATA = 0x3FF5008

@ r8 = IOPDATA
@ r1 = count
@ r2 = start
@ r3 = next

	.text
	.global main
	
main:
    MOV     r0, #15
pronto:
	LDR		r8, =0x3FF5000	@ IOPMOD
	LDR		r1, =0x1FC00	@ Seta 7 segment como output, dip4 como input
	STR		r1, [r8]
	
	LDR		r8, =0x3FF5008 	@ IOPDATA
	LDR		r2, [r8]
	MOV		r2, r2, LSL #28
	MOV		r2, r2, LSR #28
	MOV		r2, r2, LSR #3
	
	MOV		r1, #0
	
	BL		loop
	
fim:
	SWI		0x0

loop:
	LDR		r3, [r8]
	MOV		r3, r3, LSL #28
	MOV		r3, r3, LSR #28
	MOV		r3, r3, LSR #3
	
	CMP		r2, r3
	ADDNE	r1, r1, #1
	MOVNE	r2, r3
	
	STMFD   sp!, {lr}
	BL      delay
	LDMFD   sp!, {lr}
	
	STMFD   sp!, {r8, lr}
	MOV     r8, r1
	BL      printSevenSeg
	LDMFD   sp!, {r8, lr}
	
	CMP		r1, r0
	MOVGE	pc, lr
	
	B		loop
	

printSevenSeg:
    STMFD   sp!, {r1, r2}
	@ codificar o valor a ser impresso (ja esta alinhado com IOPDATA)
	LDR	r1, =sevenSegVals
	LDR	r2, [r1, r8, LSL #2]
 
    LDR		r1, =0x3FF5008 	@ IOPDATA
    MOV     r2, r2, LSL #10
STR	    r2, [r1]

    LDMFD   sp!, {r1, r2}

	MOV	pc, lr
sevenSegVals:
	.word 0b1011111, 0b0000110, 0b0111011, 0b0101111, 0b1100110, 0b1101101, 0b1111101, 0b0000111, 0b1111111
	.word 0b1100111, 0b1110111, 0b1111100, 0b1011001, 0b0111110, 0b1111001, 0b1110001

delay:
        STMFD   sp!, {r8, lr}
        LDR             r8, =0xFFFFF
        BL              delay_loop
        LDMFD   sp!, {r8, lr}
        MOV             pc, lr

delay_loop:
        CMP             r8, #0
        MOVEQ   pc, lr
        SUB             r8, r8, #1
        B               delay_loop

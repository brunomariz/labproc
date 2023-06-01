@ 7-5-7
@ 7seg = P[16:10]	set for output
@ leds = P[7:4]		set for output
@ dip  = P[3:0]		clear for input

@ IOPMOD  = 0x3FF5000
@ IOPDATA = 0x3FF5008

	.text
	.globl main
main:
	@ setando I/O
	BL	setup
	
	@ leitura de dip
	BL	lerDIP
	LDMFD	sp!, {r0}		@ r0 = valor lido

	@ store na memoria
	LDR	r1, =gaveta		@ r1 = &gaveta[0]
	STR	r0, [r1]

fim:	SWI	0x0
		
setup:
	@ usa r0-r1
	@ recebe nada
	@ retorna nada
	
	LDR	r0, =0x3FF5000		@ IOPMOD
	LDR	r1, =0x1FCF0		@ set 7seg, set leds, clear dip
	STR	r1, [r0]		@ 7seg=out, leds=out, dip=in

	MOV	pc, lr

lerDIP: 
	@ usa r0-r1
	@ recebe nada
	@ retorna valor de DIP

	LDR	r0, =0x3FF5008		@ IOPDATA
	LDR	r1, [r0]
	MOV	r1, r1, LSL #28
	MOV	r1, r1, LSR #28
	
	@ return
	STMFD	sp!, {r1}
	MOV	pc, lr

gaveta: 
	.word 999


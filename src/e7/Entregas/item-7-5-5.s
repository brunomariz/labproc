	@ 7-5-5
	@ 7seg = P[16:10]	set for output
	@ leds = P[7:4]		set for output
	@ dip  = P[3:0]		clear for input

	@ IOPMOD  = 0x3FF5000
	@ IOPDATA = 0x3FF5008

	.text
	.global main

main:
	LDR	r0, =0x3FF5000		@ IOPMOD
	LDR	r1, =0b11110000		@ set IOPMOD[7:4], clear IOPMOD[3:0]
	STR	r1, [r0]		@ led = saida, DIP = entrada

	LDR	r0, =0x3FF5008		@ IOPDATA

loop:
	LDR	r1, [r0]		@ ler IOPDATA

	@ obter campos do DIP
	MOV	r2, r1, LSL #28
	MOV	r2, r2, LSR #28

	@ alinhar campos do DIP com campo dos leds
	MOV	r2, r2, LSL #4

	@ zerar campo dos leds sem alterar DIP
	MOV	r1, r1, LSL #28
	MOV	r1, r1, LSR #28

	@ atribuir campos DIP ao campo dos leds
	ADD	r1, r1, r2

	@ output
	STR	r1, [r0]

	B loop

fim:	SWI 0x0


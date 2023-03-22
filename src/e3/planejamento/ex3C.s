	.text
	.globl	main 
loop:
        ;<subtrair divisor dos bits a esquerda do dividendo e guardar em r6, setando flags>
	BLT	else 		
	BGE	then
	LSR	r2, #1
	

	BL 	fim
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0
fim:
	MOV	pc, lr

then:
	SUB r1, r1, r6
	LSL r3, #1

else:
	LSL r3, #1

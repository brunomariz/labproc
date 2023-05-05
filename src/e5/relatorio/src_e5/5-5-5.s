@ 5-5-5 parity
.text
.global main
main:
    @ r0: input
    @ r1: result
    @ r2: input copy
    @ r3: counter

    LDR r0, =0x5af00033
    MOV r2, r0
    MOV r3, #0

check_input_0:
    CMP r2, #0
    BEQ input_eq_0

    @ Desloca bits do input para direita uma casa
    LSRS r2, r2, #1
    @ Se bit deslocado era 1 (Carry Set), soma no contador
    ADDCS r3, r3, #1
    BAL check_input_0

input_eq_0:
    @ Quando a copia do input for zero, o contador tera o numero de 1s
    @ Desloca contador para a direita para checar se o bit menos significativo eh 1
    LSRS r3, r3, #1
    @ Caso seja 1, retorna 1 (impar)
    MOVCS r1, #1
    @ Caso seja 0, retorna 0 (par)
    MOVCC r1, #0

fim:
    MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

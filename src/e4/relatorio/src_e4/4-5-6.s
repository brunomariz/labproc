@ 4-5-6 Nth Fibonacci
.text
.global main
main:
    @ r0: n, f(n)
    @ r1: a
    @ r2: a[i]
    @ r3: a[i-1], tmp
    @ r4: a[i-2], tmp
    @ r5: indice
    @ r6: tmp
    MOV r0, #12
pronto:
    @ i = 2
    MOV r5, #2
    @ Inicializar a[0] e a[1] com 0 e 1
    MOV r3, #1
    MOV r4, #0
check_i_gt_n:
    CMP r5, r0
    BGT fim
    @ r2 = a[i-1] + a[i-2]
    ADD r2, r3, r4
    @ Atualizar valores
    @ r4 = a[i-1]
    MOV r4, r3
    @ r3 = a[i]
    MOV r3, r2
    @ i++
    ADD r5, r5, #1 
    B check_i_gt_n

fim:
    @ r0 = f(n)
    MOV r0, r2

    MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

.data
ultimo: .word 0
@ Array com sequencia de fibonacci
a:
    .space 400

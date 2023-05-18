@ 6-5-2
	.text
	.globl	main


main:
    LDR r0, =len_array
    LDR r1, [r0] @ tamanho do array / numero de pares + 1
    SUB r1, r1, #0x1 @ r1 = n = len(array)-1 
    LDR r2, =array
    @ LDR r3, =stack1
    @ LDR r4, =stack2
    BL bubble_sort
    B fim

bubble_sort:
    @ r1: n
    @ r2: array
    @ r3: stack1
    @ r4: stack2
    @ r5, r6: itens do array sendo comparados
    @ r7: i
    @ r8: aux

    @ Checa se n>0 (se nao acabaram os pares)
    check_n:
    CMP r1, #0
    BLE fim
    
    @ for i = 0
    MOV r7, #0 
    @ r5 = array[i]
    LDR r5, [r2, r7, LSL #2]
    l_trocas:
    @ i < n 
    CMP r7, r1
    BGE exit_trocas
    @ r8 = i + 1
    ADD r8, r7, #1
    @ r6 = array[i+1]
    LDR r6, [r2, r8, LSL #2]
    CMP r5, r6
    @ array[i] = r6
    STRGT r6, [r2, r7, LSL #2]
    @ array[i+1] = r5
    STRGT r5, [r2, r8, LSL #2]
    @ r5 = array[i+1] (para proximo loop)
    MOVLT r5, r6
    @ i++
    ADD r7, r7, #1 
    BAL l_trocas
    exit_trocas:

    @ n = n - 1
    SUB r1, r1, #1
    BAL check_n


fim:
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

	.data
len_array: .word 0xa
array:     .word 5,4,2,1,0,3,7,6,9,8
stack1: .space 40
stack2: .space 40

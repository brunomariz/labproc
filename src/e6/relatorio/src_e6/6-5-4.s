@ 6.5.4 More stacks

    .text
	.globl	main

main:
    MOV r1, #10             @ Inicializa r1 com o valor 10 (valor a ser empilhado)
    MOV r0, #2              @ Inicializa r0 para indicar o tipo
    SUB sp, sp, #4          @ Decrementa o ponteiro de pilha (sp) em 4 bytes

    CMP r0, #1              @ Verifica se é do tipo byte (r0 = 1)
    BEQ push_byte           @ Se é byte, chama a subrotina "push_byte"

    CMP r0, #2              @ Verifica se é do tipo half-word (r0 = 2)
    BEQ push_half           @ Se é half-word, chama a subrotina "push_half"

    CMP r0, #4              @ Verifica se é do tipo word (r0 = 4)
    BEQ push_word           @ Se é half-word, chama a subrotina "push_word"

    BAL fim          

push_byte:
    STRB r1, [sp]           @ Armazena o byte (r1) na pilha
    MOV pc, lr              @ Retorna da subrotina

push_half:
    STRH r1, [sp]           @ Armazena a half-word (r1) na pilha
    MOV pc, lr              @ Retorna da subrotina

push_word:
    STR r1, [sp]            @ Armazena a word (r1) na pilha
    MOV pc, lr              @ Retorna da subrotina

fim: 
    MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0

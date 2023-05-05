@ Escreva o código em Assembly que faça:

@   for (i=0; i<8; i++) {
@       a[i] = b[7-i];
@   }

    .text
    .globl main   
    
main:

    @   r0  =   i
    @   r1  =   endereço inicial de a
    @   r2  =   endereço inicial de b
    @   r3  =   registrador temporário para transferência
    @   r4  =   endereços de leitura e escrita

    MOV r0, #0
    LDR r1, =0x00       @ loading the address of a[0]
    LDR r2, =0x20       @ loading the address of b[0]
    BL ciclo
    SWI	0x0

ciclo:
    MOV r4, r2
    ADD r4, r4, #28
    SUB r4, r4, r0, LSL #2
    LDR r3, [r4]
    MOV r4, r1
    ADD r4, r4, r0, LSL #2
    STR r3, [r4]
    ADD r0, r0, #1
    CMP r0, #8
    BLT ciclo
    MOV pc, lr


.global _start
.text
_start:
    b _Reset @posição 0x00 - Reset
    ldr pc, _undefined_instruction @posição 0x04 - Intrução não-definida
    ldr pc, _software_interrupt @posição 0x08 - Interrupção de Software
    ldr pc, _prefetch_abort @posição 0x0C - Prefetch Abort
    ldr pc, _data_abort @posição 0x10 - Data Abort
    ldr pc, _not_used @posição 0x14 - Não utilizado
    ldr pc, _irq @posição 0x18 - Interrupção (IRQ)
    ldr pc, _fiq @posição 0x1C - Interrupção(FIQ)

_undefined_instruction: .word undefined_instruction
_software_interrupt: .word software_interrupt
_prefetch_abort: .word prefetch_abort
_data_abort: .word data_abort
_not_used: .word not_used
_irq: .word irq
_fiq: .word fiq
_taskB: .word taskB
_taskC: .word taskC

INTPND: .word 0x10140000 @Interrupt status register
INTSEL: .word 0x1014000C @interrupt select register( 0 = irq, 1 = fiq)
INTEN: .word 0x10140010 @interrupt enable register
TIMER0L: .word 0x101E2000 @Timer 0 load register
TIMER0V: .word 0x101E2004 @Timer 0 value registers
TIMER0C: .word 0x101E2008 @timer 0 control register

_Reset:
    LDR sp, =supervisor_stack_top          @ carregamento do stack de supervisor

    MRS r0, cpsr                           @ r0 guarda o modo atual
    MSR cpsr_ctl, #0b11010010              @ mudando o modo para IRQ
    LDR sp, =irq_stack_top                 @ carregamento do stack de IRQ 
    MSR cpsr, r0                           @ volta para o modo anterior

    bl timer_init                          @ inicializacao do timer0

    MRS r0, cpsr                           @ valor de cpsr para taskB
    LDR r1, _taskB                         @ valor de pc para taskB
    SUB r2, sp, #0x300                     @ valor de sp para taskB
    LDR r3, =linhaB                        @ valores inicializados da taskB serao guardados na linhaB (pilha B)
    STR r1, [r3, #52]                      @ guarda pc          
    STR r0, [r3, #56]                      @ guarda cpsr
    STR r2, [r3, #60]                      @ guarda sp
                                           @ como pedido no enunciado, apenas SP, PC e CPSR sao inicializados, pois ainda nao temos lr como retorno

    MRS r0, cpsr                           @ valor de cpsr para taskC
    LDR r1, _taskC                         @ valor de pc para taskC
    SUB r2, sp, #0x600                     @ valor de sp para taskC
    LDR r3, =linhaC                        @ valores inicializados da taskC serao guardados na linhaB (pilha C)
    STR r1, [r3, #52]                      @ guarda pc          
    STR r0, [r3, #56]                      @ guarda cpsr
    STR r2, [r3, #60]                      @ guarda sp
                                           @ como pedido no enunciado, apenas SP, PC e CPSR sao inicializados, pois ainda nao temos lr como retorno
                    
    b taskA                                @ comecamos com a taskA

undefined_instruction:
    b .
software_interrupt:
    b do_software_interrupt @ vai para o handler de interrupções de software
prefetch_abort:
    b .
data_abort:
    b .
not_used:
    b .
irq:
    b do_irq_interrupt @vai para o handler de interrupções IRQ
fiq:
    b .

do_software_interrupt: @Rotina de Interrupçãode software
    add r1, r2, r3 @r1 = r2 + r3
    mov pc, r14 @volta p/ o endereço armazenado em r14

do_irq_interrupt: @ Rotina de interrupções IRQ
    SUB lr, lr, #4                      @ correcao do lr em IRQs


    STMFD sp!, {r10-r11}             
    
    LDR r11, =nproc                     @ carregamos o endereco de nproc em r11
    LDR r10, [r11]                      @ carregamos o valor de nproc em r10
    
    CMP r10, #0                         @ verificacao se nproc eh 0

    STREQ r0, linhaA                    @ se nproc for 0, acessamos a pilha linhaA, salvando r0 na primeira posicao de linhaA
    ADREQ r0, linhaA                    @ r0 agora guarda o endereco de linhaA
    
    CMP r10, #1                         @ verificacao se nproc eh 1

    STREQ r0, linhaB                    @ se nproc for 1, fazemos a mesma coisa, mas agora com a pilha linhaB
    ADREQ r0, linhaB

    CMP r10, #2                         @ verificacao se nproc eh 2

    STREQ r0, linhaC                    @ se nproc for 2, fazemos a mesma coisa, mas agora com a pilha linhaC
    ADREQ r0, linhaC
    
    LDMFD sp!, {r10-r11}
    
    
    ADD r0, r0, #4                      @ correcao do endereco da pilha pois ja salvamos r0 anteriormente
    STMIA r0!, {r1-r12, lr}             @ salvamos os registradores ate r12 e o lr do task atual

    MRS r1, spsr                        @ salvamos o modo atual (IRQ)
    STMIA r0!, {r1}                     @ carregamos na pilha 
    
    MRS r1, cpsr                        
    MSR cpsr_ctl, #0b11010011           @ mudamos para o modo supervisor
    STMIA r0!, {sp, lr}                 @ carregamos na pilha os valores de sp e lr do supervisor
    MSR cpsr, r1                        @ voltamos para o modo anterior



    LDR r0, INTPND                      @ Carrega o registrador de status de interrupção
    LDR r0, [r0]                        @ pegamos o valor do status
    TST r0, #0x0010                     @ verifica se é uma interupção de timer
    BLNE timer_irq                      @ vai para a subrotina de chaveamento e tratamento do timer
    
    


    ADR r11, nproc                      @ pegamos o endereco de nproc novamente, que idealmente ja tem que ter sido chaveado
    LDR r10, [r11]                      @ valor do nproc

    CMP r10, #0                         @ verificamos se nproc eh 0(A) ou 1(B) ou 2(C)

    LDREQ r0, =linhaA                   @ se nproc for igual a 0, carregamos o endereco de linhaA em r0

    CMP r10, #1                         @ verificamos se nproc eh 0(A) ou 1(B) ou 2(C)

    LDREQ r0, =linhaB                   @  se nproc for igual a 1, carregamos o endereco de linhaB em r0

    CMP r10, #2                         @ verificamos se nproc eh 0(A) ou 1(B) ou 2(C)

    LDREQ r0, =linhaC                   @  se nproc for igual a 1, carregamos o endereco de linhaB em r0

    ADD r0, r0, #68                     @ corrigimos o endereco para agora decrementarmos na restauracao, uma vez que foi incremental no carregamento

    MRS   r1, cpsr                      @ salvamos o modo atual
    MSR   cpsr_ctl, #0b11010011         @ trocamos para o modo supervisor
    LDMDB r0!, {sp, lr}                 @ restaura sp e lr
    vesp_saida:
    MSR   cpsr, r1                      @ volta para o modo original (IRQ)

    LDMDB r0!, {r1}                     @ restaumos o valor de spsr
    MSR   spsr, r1                      @ restaura spsr      
    vespsr_saida:

    LDMDB r0, {r0 - r12, pc}^           @ restaura r0-r12 e pc

    
timer_irq: 
    STMFD sp!, {r10-r11, lr}
    BL handler_timer                    @ vai para o rotina de tratamento da interupção de timer
    
    ADR r11, nproc                      @ r11 = endereco de nproc
    LDR r10, [r11]                      @ r10 = valor de nproc

    CMP r10, #0

    MOVEQ r10, #1                       @ se o task atual for 0, trocamos o nproc para 1

    CMP r10, #1

    MOVEQ r10, #2                       @ se o task atual for 1, trocamos o nproc para 2

    CMP r10, #2

    MOVEQ r10, #0                       @ se o task atual for 2, trocamos o nproc para 0
    
    STR r10, [r11]                      @ Chaveamento de um processo para o outro

    LDMFD sp!, {r10-r11, lr}
    MOV pc, lr
    
timer_init:
    @ Enable timer0 interrupt
    LDR r0, INTEN
    LDR r1,=0x10 @bit 4 for timer 0 interrupt enable
    STR r1,[r0]

    @ Set timer value
    LDR r0, TIMER0L
    LDR r1, =0xf @setting timer value
    STR r1,[r0]

    @ Enable timer0 counting
    LDR r0, TIMER0C
    MOV r1, #0xE0 @enable timer module
    STR r1, [r0]

    @ Enable processor interrupt in CPSR
    mrs r0, cpsr
    bic r0,r0,#0x80
    msr cpsr_c,r0 @enabling interrupts in the cpsr

    mov pc, lr

linhaA:
    .space 68

linhaB:
    .space 68

linhaC:
    .space 68

nproc:
    .word 0x0

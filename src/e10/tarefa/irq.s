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

INTPND: .word 0x10140000 @Interrupt status register
INTSEL: .word 0x1014000C @interrupt select register( 0 = irq, 1 = fiq)
INTEN: .word 0x10140010 @interrupt enable register
TIMER0L: .word 0x101E2000 @Timer 0 load register
TIMER0V: .word 0x101E2004 @Timer 0 value registers
TIMER0C: .word 0x101E2008 @timer 0 control register

_Reset:

    LDR sp, =supervisor_stack_top

    @ Inicializacao das stacks
    MRS r0, cpsr    @ salvando o modo corrente em R0
   MSR cpsr_ctl, #0b11010010 @ alterando o modo para irq - o SP eh automaticamente chaveado ao chavear o modo
    LDR sp, =irq_stack_top @ a pilha de irq eh setada
   MSR cpsr, r0 @ volta para o modo anterior


    bl timer_init @ initialize interrupts and timer 0

    @ Inicializar linhaB com sp (r13), pc (r15) e cpsr
    @ Obtem endereco de linhaB em r0
    LDR r0, =linhaB

    @ Salva sp em linhaB
    MOV r1, sp
    SUB r1, r1, #0x300
    STR r1, [r0, #60]
    @ Salva pc em linhaB
    LDR r1, _taskB
    STR r1, [r0, #52]
    @ Salva cpsr em linhaB
    MRS r1, cpsr
    STR r1, [r0, #56]

    b taskA
    b .

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

do_irq_interrupt: @Rotina de interrupções IRQ
    @ Corrige o lr
    SUB lr, lr, #4

    @ Verifica qual task esta ativa
    STMFD sp!, {r0, r1}
    LDR r0, =nproc
    LDR r1, [r0]
    CMP r1, #0
    LDMFD sp!, {r0, r1}

    @ Guarda o contexto da task correspondente

    @ Guardando contexto da taskA
    @ Guarda o r0 em linhaA
    STREQ r0, linhaA
    @ Utiliza o r0 para o endereco de linhaA
    LDREQ r0, =linhaA
    @ Guardando contexto da taskB
    @ Guarda o r0 em linhaB
    STRNE r0, linhaB
    @ Utiliza o r0 para o endereco de linhaB
    LDREQ r0, =linhaB

    @ Pula 4 bytes correspondentes ao r0 salvo
    ADD r0, r0, #4
    @ Empilha o resto dos registradores
    STMEA r0!, {r1 - r12, lr}

    MRS r1, cpsr @ salva modo atual
    STMEA r0!, {r1}
    
    MSR cpsr, #0b11010011 @ muda para modo supervisor
    
    @ Salva cpsr, sp e lr do supervisor
    STMEA r0!, {sp, lr}
    
    MSR cpsr, r1 @ Retorna para modo IRQ


    LDR r0, INTPND @Carrega o registrador de status de interrupção
    LDR r0, [r0]
    TST r0, #0x0010 @verifica se é uma interupção de timer
    BLNE handler_timer @vai para o rotina de tratamento da interupção de timer
    vesaida:
    @ Verifica qual task esta ativa
    LDR r0, =nproc
    LDR r1, [r0]
    CMP r1, #0
    @ Troca para outra task
    MOVEQ r1, #1
    MOVNE r1, #0
    STR r1, [r0] @ nproc = r1
    @ Carrega endereco do contexto da proxima task
    LDREQ r0, =linhaB
    LDRNE r0, =linhaA
    @ Muda para modo supervisor
    MSR cpsr, #0b11010011 @ muda para modo supervisor
    ADD r0, r0, #68
    LDMEA r0!, {sp, lr}
    LDMEA r0!, {r1}
    MSR cpsr, r1
    @ Carrega o contexto salvo da proxima task
    LDMEA r0, {r0 - r12, pc}^ @retorna

timer_init:
    @ Enable timer0 interrupt
    LDR r0, INTEN
    LDR r1,=0x10 @bit 4 for timer 0 interrupt enable
    STR r1,[r0]

    @ Set timer value
    LDR r0, TIMER0L
    LDR r1, =0xfffff @setting timer value
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


linhaA: .space 68
linhaB: .space 68
nproc: .word 0

@ ex 3.10.2 - 3
    .text
    .globl main

main:
    LDR r2, =0xFFFFFFFF
    LDR r3, =0x00000010
    BL firstfunc 
    BL secondfunc


    MOV r0, #0x18 
    LDR r1, =0x20026 
    SWI 0x123456 
firstfunc:
    SMULL r4, r8, r2, r3
    MOV pc, lr 
secondfunc:
    UMULL r4, r8, r2, r3
    MOV pc, lr 

    .end

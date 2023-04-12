# PCS3432 - Laboratório de Processadores

##### Planejamento - E3

Bruno Mariz - 11261826

---

## 3.1.2 B - Respondam as seguintes perguntas

### 1. O que há de errado nas seguintes instruções:

#### a. ADD r3,r7, #1023

A instrução acima está incorreta pois o último operando de instruções de processamento de dados pode ser:

- um inteiro de 8 bits rotacionado para a direita por um número par de posições, que não é o caso da instrução acima, cujo inteiro precisa de 10 bits para ser representado, e não está rotacionado
- um registrador opcionalmente rotacionado ou com shift por uma constante de 5 bits ou outro registrador, o que também não é o caso

#### b. SUB r11, r12, r3, LSL #32

A instrução acima está incorreta pois o último operando de instruções de processamento de dados pode ser:

- um inteiro de 8 bits rotacionado para a direita por um número par de posições, que não é o caso da instrução acima.
- um registrador opcionalmente rotacionado ou com shift por uma constante de 5 bits ou outro registrador, o que não ocorre pois a constante do shift possui 6 bits, o que resultaria apenas em zero após o deslocamento do LSL.

### 2. Sem usar a instrucao MUL, de identifique as instruções para multiplicar o registrador R4 por:

#### a. 132

```assembly
MOV 	r4, #0x4
MOV 	r3, r4, LSL #7
ADD 	r6, r3, r4, LSL #2
```

Ao fim do programa, o registrador r6 irá 4 \* r4, nesse caso, 528.

#### b. 255

```assembly
RSB 	r6, r4, r4, LSL #8
```

Essa instrução irá subtrair o primeiro operando do segundo após o deslocamento, resultando em r4 \* 2^8 - r4, ou r4 \* 256 - r4, ou r4 \* 255.

#### c. 18

#### d. 16384

Dicas (apenas para pensar em como resolver os itens a,b,c, e d acima):

como vc. faria para multiplicar um valor por 4? Dica: use o MOV com o deslocamento. r1 = 4*r0
como você faria para multiplicar um valor por 5? Dica: use ADD com deslocamento - r1 = r0+4*r0
como vc. faria para multiplicar um valor por 3? r1 = r0\*4 - r0; veja a diferença entre SUB e RSB
como vc. faria para multiplicar um numero por 15? Multiplica por 3 e depois por 5.

### 3. Escreva uma rotina que compara 2 valores de 64-bits usando somente 2 instruções. (dica: a segunda instrução é condicionalmente executada, baseada no resultado da primeira comparação).

No cap. 5 da apostila existe uma tabela com todas as condições possíveis. Exemplo de instrução condicional: ADDEQ R0,R1,R2 = execute a soma se a flag Z no CPSR == 1. Alguns alunos reclamaram ser necessário consultar o cap. 5, mas não se consegue fazer o cap. 3 sem uma pequena introdução as instruções condicionais.

## 3.1.3 C - prepare a solução de 3.10.7 (individualmente no seu computador)

Rascunhe a solução do exercício de divisão 3.10.7; ou seja, como é o algoritmo da divisão. Coloque o algoritmo em código ARM (não é necessário testar). A operação de divisão deve ser feita com shift como faz o Professor do Ensino Fundamental e não o algoritmo ineficiente e simples que subtrai um número do outro.

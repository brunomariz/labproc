# PCS3432 - Laboratório de Processadores

##### Relatório - E4

| Bancada B8      |          |
| --------------- | -------- |
| Bruno Mariz     | 11261826 |
| Roberta Andrade | 11260832 |

---

### 4.5.1 Assignments with operands in memory

###### Assume an array of 25 words. A compiler associates variables x and y with registers r0 and r1, respectively. Assume that the base address for the array is located in r2.

###### Translate this C statement/assignment using the post-indexed form:

> x = array[5] + y

Código utilizado no exercício:

```assembly

```

###### Now try writing it using the pre-indexed form

Ao executar o código acima, foi possível observar o valor esperado no registrador r0 (x = array[5]+y, ou r0 = 6+12 = 18) tanto utilizando o modo pós indexado quanto utilizando o modo pré indexado, como é possível observar nas imagens a seguir:

![](img/4-5-1-pos.png)
![](img/4-5-1-pre.png)

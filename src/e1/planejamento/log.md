###### 1.4 - Hello

Compilando programa

```shell
$ arm-elf-gcc -Wall -g -o hello hello.c
```

Depurando programa

```shell
$ arm-elf-gdb hello
```

```
(gdb) b main
(gdb) c
The program is not being run.
(gdb) target sim
(gdb) load
(gdb) r
Starting program: /home/student/src/e1/planejamento/hello

Breakpoint 1, main () at hello.c:6
warning: Source file is more recent than executable.

6           return 0;
(gdb) c
Continuing.
hello

Program exited normally.
(gdb) info registers
r0             0x0      0
r1             0x20026  131110
r2             0x0      0
r3             0x0      0
r4             0x18     24
r5             0x20026  131110
r6             0x0      0
r7             0x0      0
r8             0x1034c  66380
r9             0x10174  65908
---Type <return> to continue, or q <return> to quit---
r10            0x0      0
r11            0x1ffff4 2097140
r12            0x1fffa4 2097060
sp             0x1fffcc 2097100
lr             0x8388   33672
pc             0x917c   37244
fps            0x0      0
cpsr           0x60000013       1610612755
(gdb) p $pc
$1 = 37244
(gdb) p/d $pc
$2 = 37244
(gdb) p/x $r0
$3 = 0x0
(gdb) p/x $cpsr
$4 = 0x60000013
```

###### 1.5 ? -

```
student:~/src/e1/planejamento$ arm-elf-gcc -Wall -g -o a.out item-2-2.s
student:~/src/e1/planejamento$ arm-elf-gdb a.out
(gdb) target sim
Connected to the simulator.
(gdb) load
(gdb) b main
Breakpoint 1 at 0x8218: file item-2-2.s, line 4.
(gdb) r
Starting program: /home/student/src/e1/planejamento/a.out

Breakpoint 1, main () at item-2-2.s:4
4               MOV     r0, #15
Current language:  auto; currently asm
(gdb) c
Continuing.
^C
Program received signal SIGINT, Interrupt.
main () at item-2-2.s:9
9               SWI     0x0
(gdb)
```

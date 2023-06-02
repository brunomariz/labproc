#include <stdio.h>

extern int int2str(int a, char *string);
void impstr(char *pont);

int main()
{
    __asm__("pronto: nop\n\t");

    char strNUSP[100];

    int NUSP = 826;
    int2str(NUSP, strNUSP);
    impstr(strNUSP);
    return 0;
}

void impstr(char *pont)
{
    __asm__("inic_imprime: nop\n\t");
    if (pont[0] != 0)
    {
        // imprime caracter *pont
        printf("%c\n", pont[0]);
        impstr(pont + 1);
    }
    __asm__("fim_imprime: nop\n\t");
    return;
}

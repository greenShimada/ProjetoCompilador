#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "anaLex.h"
#include "pilha.h"
#include "anaSint.h"

FILE *fp;
Token token;

int main()
{
    char arquivo[300];
    printf("Insira o arquivo cujo queira executar >> ");
    scanf("%s", arquivo);
    fp = fopen(arquivo, "r");
    int c = 0;
    while (c = getc(fp), c != EOF)
    {
        ungetc(c, fp);
        token = anaLex(fp);
        Inicio(token, fp);
        if (token.value != ';')
            erro();
        else
            printf("\nResultado = %d\n", topo());
    }
    fclose(fp);
    return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "header.h"

FILE *fp;
Token token;

void E();
void T();
void E_linha();
void T_linha();
void F();
void erro();

void erro()
{
    printf("Erro sintatico\n");
    exit(1);
}

void reconhecer(int type)
{
    printf("\n tipo de token = %d\n", token.type);
    if (type == token.type)
        token = analisadorLex(fp);
    else
        erro();
}

int main()
{
    fp = fopen("teste.txt", "r");
    int c = 0;
    while (c = getc(fp), c != EOF)
    {
        ungetc(c, fp);
        token = analisadorLex(fp);
        Inicio();
        if (token.value != ';')
            erro();
        else
            printf("Sucesso!!\n");
    }
    fclose(fp);
    return 0;
}

void Inicio(){
    if (token.type == END_LINE)
        reconhecer(token.type);
    E();
}
void E()
{
    T();
    E_linha();
}

void T()
{
    F();
    T_linha();
}

void E_linha()
{
    if (token.type == OPERATOR_BASIC)
    {
        reconhecer(OPERATOR_BASIC);
        T();
        E_linha();
    }
}

void T_linha()
{
    if (token.type == OPERATOR)
    {
        reconhecer(OPERATOR);
        F();
        T_linha();
    }
}
void F()
{
    if (token.type != NUMBER){
        if (token.type == OPEN_PARANTHESIS)
            reconhecer(OPEN_PARANTHESIS);
        
        E();
        if (token.type == CLOSE_PARANTHESIS)
            reconhecer(CLOSE_PARANTHESIS);
    }
    else if (token.type == NUMBER){
        reconhecer(NUMBER);
    }
    else erro();
}

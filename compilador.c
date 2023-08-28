#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "header.h"
#include "pilha.h"
FILE *fp;
Token token;

void E();
void T();
void E_linha();
void T_linha();
void F();
void erro();

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
        token = analisadorLex(fp);
        Inicio();
        if (token.value != ';')
            erro();
        else
            printf("\nResultado = %d\n", topo());
    }
    fclose(fp);
    return 0;
}

void erro()
{
    printf("Erro sintatico\n");
    exit(1);
}

void reconhecer(int type)
{
    if (type == token.type)
        token = analisadorLex(fp);
    else
        erro();
}

void Inicio()
{
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
        char opAux = token.value;
        reconhecer(OPERATOR_BASIC);
        T();
        executaCalculo(opAux);
        E_linha();
    }
}

void T_linha()
{
    if (token.type == OPERATOR)
    {
        char opAux = token.value;
        reconhecer(OPERATOR);
        F();
        executaCalculo(opAux);
        T_linha();
    }
}

void F()
{
    if (token.type != NUMBER)
    {
        if (token.type == OPEN_PARANTHESIS)
            reconhecer(OPEN_PARANTHESIS);

        E();
        if (token.type == CLOSE_PARANTHESIS)
            reconhecer(CLOSE_PARANTHESIS);
    }
    else if (token.type == NUMBER)
    {
        printf("%d ", token.tokenVal);
        push(token.tokenVal);
        reconhecer(NUMBER);
    }
    else
        erro();
}

void executaCalculo(char operator)
{
    int a, b;
    a = pop();
    b = pop();
    printf("%c ", operator);
    switch (operator)
    {
    case '+':
        push(a + b);
        break;
    case '-':
        push(a - b);
        break;
    case '*':
        push(a * b);
        break;
    case '/':
        push(a / b);
        break;
    }
}

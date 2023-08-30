#ifndef ANASINT_HEADER_H
#define ANASINT_HEADER_H
#include "header.h"

Token token;
FILE *fp;

void E();
void T();
void E_linha();
void T_linha();
void F();
void erro();
void executaCalculo(char operator);

void erro()
{
    printf("Erro sintatico\n");
    exit(1);
}

void reconhecer(int type)
{
    if (type == token.type)
        token = anaLex(fp);
    else
        erro();
}

void Inicio(Token tok, FILE *fpointer)
{
    fp = fpointer;
    token = tok;
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
        push(b - a);
        break;
    case '*':
        push(a * b);
        break;
    case '/':
        push(b / a);
        break;
    }
}

#endif
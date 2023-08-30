#include <stdio.h>
#include <ctype.h>
#include "header.h"

#define NUM 256
static int line = 1;

Token anaLex(FILE *fp);
Token construtorToken(TokenType type, char value);

Token anaLex(FILE *fp)
{
    int tokenval = 0;
    char ch = getc(fp);
    if (ch == '\n')
    {
        Token tokenToReturn;
        tokenToReturn = construtorToken(END_LINE, ch);
        line++;
        return tokenToReturn;
    }

    while (isspace(ch) && ch != '\n')
        ch = getc(fp);

    if (ch == '+' || ch == '-')
        return construtorToken(OPERATOR_BASIC, ch);

    if (ch == '*' || ch == '/')
        return construtorToken(OPERATOR, ch);

    if (ch == ';')
        return construtorToken(END_CMD, ch);

    if (ch == '(')
        return construtorToken(OPEN_PARANTHESIS, ch);

    if (ch == ')')
        return construtorToken(CLOSE_PARANTHESIS, ch);

    if (isdigit(ch))
    {
        tokenval = ch - '0';
        ch = getc(fp);
        while (isdigit(ch))
        {
            tokenval *= 10 + ch - '0';
            ch = getc(fp);
        }
        ungetc(ch, fp);

        Token tokenDigit;
        tokenDigit.line = line;
        tokenDigit.type = NUMBER;
        tokenDigit.tokenVal = tokenval;

        return tokenDigit;
    }

    printf("erro lexico na linha %d\n\n", line);
}

Token construtorToken(TokenType type, char value)
{
    Token token;
    token.type = type;
    token.value = value;
    token.line = line;

    return token;
}
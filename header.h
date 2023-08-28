#ifndef ANALEX_H_INCLUDED
#define ANALEX_H_INCLUDED

typedef enum
{
    NUMBER, 
    OPERATOR_BASIC,
    OPERATOR,
    INVALID,
    END_CMD,    
    END_LINE,
    OPEN_PARANTHESIS,
    CLOSE_PARANTHESIS
} TokenType;

typedef struct 
{
   TokenType type;
   int tokenVal;
   char value;
   int line;
} Token;

Token analisadorLex(FILE *fp);
Token construtorToken(TokenType type, char value);

#endif
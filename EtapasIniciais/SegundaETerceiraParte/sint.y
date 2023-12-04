%union {
  struct no {
    int place;
	char *code;
  } node;
  int place;
}
%{ 
#include "analex.c" 
#include "codigos.h"
%}
%token <place> NUM 
%token <place> ID 
%token FUNCTION
%token PROCEDURE
%token RETURN
%token ENDIF
%token PRINT
%token PRINTLN
%token READ
%token CHAR
%token NOT
%token AND
%token OR 
%token EQ
%token LE
%token GE
%token NE
%token IF
%token WHILE
%token ELSE
%token DO
%token INT
%left AND OR
%left '>' '<' NE EQ GE LE
%left '+' '-'
%left '*' '/'

%start Prog
%%
Prog : Function_Statement Prog {printf("Entrou no programa \n");}
	| Function_Statement
	;
	
	
Statement_Seq :
	Statement Statement_Seq
	|
	;
	
Args:
	  Args ',' Exp
	| Exp
	|
	;
	
ArgList: 
	Tipo ID ',' ArgList
	| Tipo ID
	|
	;

Statement: 
		Atribuicao
	| 	Declaracao
	|	If_Statement
	| 	While_Statement
	|   Do_While_Statement
	|   ID '(' Args ')' ';'
	|   PRINT '(' Exp ')' ';'
	|	PRINTLN '(' Exp ')' ';' 
	{
		/*Println($3);*/
	}
	|	READ INT
	|	Procedure_Statement
	|	RETURN Exp ';'
	;

Function_Statement: FUNCTION Tipo ID '(' ArgList ')' '{' Statement_Seq '}'
	;
	
Procedure_Statement: PROCEDURE ID '(' ArgList ')' Compound_Statement
	;

Atribuicao : Tipo ID '=' Exp ';' 
{ 
	/*printf("%s", $$.code);*/
}
	| ID '=' '"' Exp '"' ';'
	| ID '=' Exp ';'
	;

Declaracao: Tipo ID ';'
	| Tipo ID '['Exp']' ';'
	| Tipo ID '['Exp']' ',' Declaracao
	| Tipo ID ',' Declaracao
	;

Compound_Statement :
	  Statement
	| '{' Statement_Seq '}'
	;
	
If_Statement:
	  IF '(' Exp ')' Compound_Statement Else_Part ENDIF
	;
		
Else_Part:
	  ELSE Compound_Statement
	|
	;
		
While_Statement:
	  WHILE '(' Exp ')' Compound_Statement  
	;

Do_While_Statement:
	  DO Compound_Statement WHILE '(' Exp ')' ';'   
	;
			
Exp : Exp '+' Exp  
	{ 
		/* 
		$$ = newTemp();
		ExpAri("add",$$,$1,$3); 
		*/
	}
	| Exp '-' Exp  
	| Exp '*' Exp  
	| Exp '/' Exp  
	| Exp '>' Exp  
	| Exp '<' Exp 
	| Exp GE Exp  
	| Exp LE Exp   
	| Exp EQ Exp   
	| Exp NE Exp   
	| Exp AND Exp  
	| Exp OR Exp   
	| '(' Exp ')'  
	| NUM		  
	{  
		printf("Leu um número");
		/*$$.place = newTemp(); 
		Li(&$$,$1);*/ 
	} 
	| ID      	  {  }
	;   

Tipo : INT
	| CHAR
	;

%%  
int main(int argc, char **argv) {   
  freopen("saida.asm","w",stdout);	
  printf(".text\n");
  yyin = fopen(argv[1],"r");
  yyparse();
    
} 



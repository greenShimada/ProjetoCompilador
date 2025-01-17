%union {
  struct no {
    int place;
	char *code;
  } node;
  int place;
}
%{ 
#include "analex.c" 
#include "codigo.h"
%}
%token <place> NUM 
%token <place> ID 
%token AND
%token OR 
%token NOT
%token EQ
%token LE
%token GE
%token NE
%token IF
%token WHILE
%token ELSE
%token DO
%token INT
%token READ
%token PRINTLN
%token PRINT
%token CHAR
%token VOID
%left AND OR
%left '>' '<' NE EQ GE LE
%left '+' '-'
%left '*' '/'

%type <node> Exp Atribuicao Compound_Statement Statement Statement_Seq If_Statement
%type <node> While_Statement Do_While_Statement Prog Funcao Args Ldeclps

%start Prog
%%
Prog : 
	Funcao 
	| Funcao Prog
	;
	
Funcao:
    Tipo_f ID '(' Ldeclps ')' '{' Decls Statement_Seq '}'  { Function(&$$, $2, $4, $8); printf("%s", $$.code); }
   ;

Ldeclps :
	Tipo ID ',' Ldeclps { MoveMoreParameter(&$$, $2, &$4); }
	| Tipo ID   { MoveParameter(&$$, $2); }
	| {$$ = $$;}
	;
     
Tipo_f :
	VOID
	| Tipo
	|
	;

Decls :
	Decl Decls
	|
	;
	
Decl :
	Tipo Vars ';'
	;
	
Vars:
	ID ',' Vars 
	| ID        
	;

Tipo :
	INT
	| CHAR
	;
	
Statement_Seq:
	Statement				   { create_cod(&$$.code); 
								 insert_cod(&$$.code,$1.code);
							   }
	| Statement_Seq Statement  { create_cod(&$$.code); 
								 insert_cod(&$$.code,$1.code); 
								 insert_cod(&$$.code,$2.code);	
						       }
    
	
Args:
	  Exp ',' Args { SetMoreParameter(&$$, $1, &$3); }
	| Exp { SetParameter(&$$, $1); }
	| { $$ = $$;}
	;
		
Statement: 
		Atribuicao
	|	If_Statement 
	| 	While_Statement
	|   Do_While_Statement
	|   ID '(' Args ')' ';' { CallFunction(&$$, $1, $3); }
	|	PRINT '(' Exp ')' ';' { Print(&$$, $3); }
	|   PRINTLN '(' Exp ')' ';' { Println(&$$,$3); }
	|   ID '=' READ '(' ')' ';' { Read(&$$,$1);  }
	;
	
Atribuicao : ID '=' Exp ';'  { Atrib(&$$,$1,$3); }
	;

Compound_Statement :
	  Statement
	| '{' Statement_Seq '}' {$$ = $2;}
	;
	
If_Statement:
	  IF '(' Exp ')' Compound_Statement { If(&$$,$3,$5); }
	| IF '(' Exp ')' Compound_Statement ELSE Compound_Statement  { IfElse(&$$,$3,$5,$7); }
	;
		
While_Statement:
	  WHILE '(' Exp ')' Compound_Statement  { While(&$$, $3, $5); }
	;

Do_While_Statement:
	  DO Compound_Statement WHILE '(' Exp ')' ';'   { DoWhile(&$$, $2, $5); }
	;
			
Exp : Exp '+' Exp  { ExpAri("add",&$$,$1,$3); }
	| Exp '-' Exp  { ExpAri("sub",&$$,$1,$3); }
	| Exp '*' Exp  { ExpAri("mul",&$$,$1,$3); }
	| Exp '/' Exp  { Div(&$$,$1,$3); }
	| Exp '>' Exp  { ExpRel("bgt",&$$,$1,$3); } 
	| Exp '<' Exp  { ExpRel("blt",&$$,$1,$3); }
	| Exp GE Exp   { ExpRel("bge",&$$,$1,$3); }
	| Exp LE Exp   { ExpRel("ble",&$$,$1,$3); }
	| Exp EQ Exp   { ExpRel("beq",&$$,$1,$3); }
	| Exp NE Exp   { ExpRel("bne",&$$,$1,$3); }
	| Exp AND Exp  { ExpRel("and",&$$,$1,$3); }
	| Exp OR Exp   { ExpRel("or",&$$,$1,$3); }
	| '(' Exp ')'  { $$ = $2; }
	| NUM	  {  Li(&$$,$1); } 				 		   
	| ID      {  create_cod(&$$.code); $$.place = $1; }     
	;   
	
%%  
int main(int argc, char **argv) {   
  freopen("saida.asm","w",stdout);	
  printf(".text\n");
  yyin = fopen(argv[1],"r");
  yyparse();
    
} 
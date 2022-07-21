%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include<ctype.h>
    void yyerror(const char *s);
    FILE *out1;
    int yylex();
    extern FILE *yyout, *yyin;
    int mark=0;
    int linenum=1;
    extern int line;
%}
  
%token DOT IF ELSE WHILE TRUE FALSE INT STR EQ NE ASSIGN ADD SUBTRACT MULTIPLY DIVIDE SEMI LP RP COMMA LCB RCB RET NOT AND OR LS RS
%union{
	int a;
	char *s;
}
%token <s> ID
%token <a> NUMBER
%%

program: var_dec program
       | func_dec program           
       | func_def program           
       | var_dec
       | func_dec                   
       | func_def                   
       | func_call 
       | DOT                        {return 0;}                
var_dec: INT ID SEMI                {yyout=fopen("Parser.txt","a"); fprintf(yyout,"\nvar_int: %s",$2);}
       | STR ID SEMI                {yyout=fopen("Parser.txt","a"); fprintf(yyout,"\nvar_str: %s",$2);}
       | INT ID ASSIGN logic_expr SEMI  {yyout=fopen("Parser.txt","a"); fprintf(yyout,"\nvar_int: %s = ",$2); }
func_dec: INT ID LP arg_list RP SEMI    {yyout=fopen("Parser.txt","a"); fprintf(yyout,"\nFunction Declaration: %s ",$2); }
        | STR ID LP arg_list RP SEMI    {yyout=fopen("Parser.txt","a"); fprintf(yyout,"\nFunction Declaration: %s ",$2); }
        | %empty
func_def: INT ID LP arg_list RP LCB func_body RCB   {yyout=fopen("Parser.txt","a"); fprintf(yyout,"\nFunction Declaration: %s ",$2); }
        | STR ID LP arg_list RP LCB func_body RCB   {yyout=fopen("Parser.txt","a"); fprintf(yyout,"\nFunction Declaration: %s ",$2); } 
arg_list: arg_list COMMA arg        
        | arg                       
        | %empty
arg: INT ID             {yyout=fopen("Parser.txt","a"); fprintf(yyout,"func_arg_int-%s ",$2); }
   | STR ID             {yyout=fopen("Parser.txt","a"); fprintf(yyout,"func_arg_str-%s ",$2); }
func_body: stmt_list
         | %empty
stmt_list: stmt_list stmt
         | stmt
         | %empty
stmt: simple
    | compound
simple: assign_expr
    | func_call             
    | RET logic_expr SEMI   {yyout=fopen("Parser.txt","a"); fprintf(yyout,"\nRETURN "); }
    | var_dec
compound: IF_STMT           {yyout=fopen("Parser.txt","a"); fprintf(yyout,"\nIF_STMT\n"); }
        | WHILE_STMT        {yyout=fopen("Parser.txt","a"); fprintf(yyout,"\nWHILE_STMT\n"); }
func_call: ID LP in_list RP SEMI    {yyout=fopen("Parser.txt","a"); fprintf(yyout,"\nFunction Call: %s ",$1); }
in_list: in_list COMMA logic_expr
       | logic_expr
       | %empty
IF_STMT: matched            
       | unmatched
matched: IF LP logic_expr RP LCB matched RCB ELSE LCB matched RCB  {yyout=fopen("Parser.txt","a"); fprintf(yyout,"\nELSE\n"); }
       | simple
       | WHILE_STMT
unmatched: IF LP logic_expr RP LCB IF_STMT RCB
         | IF LP logic_expr RP LCB matched RCB ELSE LCB unmatched RCB   {yyout=fopen("Parser.txt","a"); fprintf(yyout,"\nELSE\n"); fclose(yyout);}
WHILE_STMT: WHILE LP logic_expr RP LCB stmt_list RCB
logic_expr: logic_expr EQ logic_expr      {yyout=fopen("Parser.txt","a"); fprintf(yyout,":== "); }
          | logic_expr NE logic_expr      {yyout=fopen("Parser.txt","a"); fprintf(yyout,":!= "); }
          | logic_expr AND logic_expr     {yyout=fopen("Parser.txt","a"); fprintf(yyout,"AND "); }
          | logic_expr OR logic_expr      {yyout=fopen("Parser.txt","a"); fprintf(yyout,"OR "); }
          | NOT LP logic_expr RP          {yyout=fopen("Parser.txt","a"); fprintf(yyout,"NOT "); }
          | expr
          | TRUE                          {yyout=fopen("Parser.txt","a"); fprintf(yyout,"Bool-true "); }
          | FALSE                         {yyout=fopen("Parser.txt","a"); fprintf(yyout,"Bool-false ");}

assign_expr: ID ASSIGN logic_expr SEMI
expr: expr ADD term        {yyout=fopen("Parser.txt","a"); fprintf(yyout,"ADD "); }
    | expr SUBTRACT term   {yyout=fopen("Parser.txt","a"); fprintf(yyout,"SUBTRACT "); }
    | term                 
term: term MULTIPLY factor {yyout=fopen("Parser.txt","a"); fprintf(yyout,"MULTIPLY "); } 
    | term DIVIDE factor   {yyout=fopen("Parser.txt","a"); fprintf(yyout,"DIVIDE "); }
    | factor
factor: LP expr RP
      | ID                  {yyout=fopen("Parser.txt","a"); fprintf(yyout,"var: %s ",$1); }
      | NUMBER              {yyout=fopen("Parser.txt","a"); fprintf(yyout,"const-%d ",$1); }
      | ID LS logic_expr RS   {yyout=fopen("Parser.txt","a"); fprintf(yyout,"var: %s [] ",$1); }

%%
void yyerror(const char *s)
{
   yyout=fopen("Parser.txt","a"); 
   fprintf(yyout,"\nSyntax Error in line: %d",line);
   mark=1;
  // yyparse();
}


int main(int argc, char *argv[])
{
	yyin=fopen(argv[1],"r");
	out1=fopen("Lexer.txt","w");
	yyout=fopen("Parser.txt","w");
	yyparse();
	if(mark==0)
	{
		printf("Valid\n");
	}
}

%{
    int line=1;
    extern FILE *out1;
    #include"cucu.tab.h"
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    void error(char *s);
%}
%option yylineno

%%
"if"	            {out1=fopen("Lexer.txt","a"); fprintf(out1,"CONTROL STMT: if\n"); fclose(out1); return IF;}
"else"	            {out1=fopen("Lexer.txt","a"); fprintf(out1,"CONTROL STMT: else\n"); fclose(out1); return ELSE;}
"while"            {out1=fopen("Lexer.txt","a"); fprintf(out1,"CONTROL STMT: while\n"); fclose(out1); return WHILE;}  
"true"             {out1=fopen("Lexer.txt","a"); fprintf(out1,"BOOL: true\n"); fclose(out1); return TRUE;}
"false"            {out1=fopen("Lexer.txt","a"); fprintf(out1,"BOOL: false\n"); fclose(out1); return FALSE;}
"-"                {out1=fopen("Lexer.txt","a"); fprintf(out1,"SUBTRACT: -\n"); fclose(out1); return SUBTRACT;}
[0-9]+             {out1=fopen("Lexer.txt","a"); yylval.a = atoi(yytext); fprintf(out1,"NUMBER: %s\n",yytext); fclose(out1); 
                   return NUMBER;}
"int"              {out1=fopen("Lexer.txt","a"); fprintf(out1,"DATATYPE: int\n"); fclose(out1); return INT;}
"char *"           {out1=fopen("Lexer.txt","a"); fprintf(out1,"DATATYPE: char *\n"); fclose(out1); return STR;}
"return"           {out1=fopen("Lexer.txt","a"); fprintf(out1,"RETURN: return\n"); fclose(out1); return RET;}
[a-zA-Z]([a-zA-Z]|[0-9]|_)* {out1=fopen("Lexer.txt","a"); fprintf(out1,"IDENTIFIER: %s\n",yytext); yylval.s=strdup(yytext); fclose(out1); return ID;}
"=="               {out1=fopen("Lexer.txt","a"); fprintf(out1,"RELATIONAL: ==\n"); fclose(out1); return EQ;}
"!="               {out1=fopen("Lexer.txt","a"); fprintf(out1,"RELATIONAL: !=\n"); fclose(out1); return NE;}
"!"                {out1=fopen("Lexer.txt","a"); fprintf(out1,"BOOLEAN: NOT\n"); fclose(out1); return NOT;}
"&"                {out1=fopen("Lexer.txt","a"); fprintf(out1,"BOOLEAN: AND\n"); fclose(out1); return AND;} 
"|"                {out1=fopen("Lexer.txt","a"); fprintf(out1,"BOOLEAN: OR\n"); fclose(out1); return OR;}
"="                {out1=fopen("Lexer.txt","a"); fprintf(out1,"ASSIGN: =\n"); fclose(out1); return ASSIGN;}
"+"                {out1=fopen("Lexer.txt","a"); fprintf(out1,"ADD: +\n"); fclose(out1); return ADD;}
"/"                {out1=fopen("Lexer.txt","a"); fprintf(out1,"DIVIDE: /\n"); fclose(out1); return DIVIDE;}
"*"                {out1=fopen("Lexer.txt","a"); fprintf(out1,"MULTIPLY: *\n"); fclose(out1); return MULTIPLY;}
";"                {out1=fopen("Lexer.txt","a"); fprintf(out1,"SEM-COLON: ;\n"); fclose(out1); return SEMI;}
"("                {out1=fopen("Lexer.txt","a"); fprintf(out1,"LEFT_PARA: (\n"); fclose(out1); return LP;}
")"                {out1=fopen("Lexer.txt","a"); fprintf(out1,"RIGHT_PARA: )\n"); fclose(out1); return RP;}
"{"                {out1=fopen("Lexer.txt","a"); fprintf(out1,"LEFT_CURLY_BRACES: {\n"); fclose(out1); return LCB;}   
"}"                {out1=fopen("Lexer.txt","a"); fprintf(out1,"RIGHT_CURLY_BRACES: }\n"); fclose(out1); return RCB;}
"["                {out1=fopen("Lexer.txt","a"); fprintf(out1,"LEFT_SQUARE: [\n"); fclose(out1); return LS;}
"]"                {out1=fopen("Lexer.txt","a"); fprintf(out1,"RIGHT_SQUARE: ]\n"); fclose(out1); return RS;}
","                {out1=fopen("Lexer.txt","a"); fprintf(out1,"PUNCTUATION: ,\n"); fclose(out1); return COMMA;}
"\n"               {line++;}
"."                {return DOT;}
\/\/.*             {;}
\/\*(.*\n)*.*\*\/  {;} 
[ \t]*             {;}
.	           {error(yytext); return yytext[0];}
%%

int yywrap()
{
	return 0;
}
void error(char *s)
{
	out1=fopen("Lexer.txt","a");
	fprintf(out1,"Line %d: Invalid Token: %s\n",line,s);
	fclose(out1);
}

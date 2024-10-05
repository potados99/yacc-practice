%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
%}

%union {
    double dval;  // double형 값을 저장할 수 있도록 수정합니다.
}

%token <dval> NUMBER  // NUMBER 토큰이 double형 값임을 정의합니다.
%token PLUS MINUS MUL DIV LBRACE RBRACE // 이런 토큰도 있음을 의미합니다.

%type <dval> start expr term factor   // 각 비단말 기호들도 float형으로 처리합니다.

%%
start  : expr               { printf("%lf\n", $1); }
       ;

expr   : expr PLUS term     { $$ = $1 + $3; }
       | expr MINUS term    { $$ = $1 - $3; }
       | term               { $$ = $1; } 
       ;

term   : term MUL factor    { $$ = $1 * $3; }
       | term DIV factor    { $$ = $1 / $3; }
       | factor
       ;

factor : LBRACE expr RBRACE { $$ = $2; }  
       | PLUS factor        { $$ = +$2; }
       | MINUS factor       { $$ = -$2; }
       | NUMBER             { $$ = $1; }
       ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

int main() {
    printf("간단한 계산기입니다. 지원하는 입력: 숫자, +, -, *, /, (, ).\n");
    yyparse();
    return 0;
}

